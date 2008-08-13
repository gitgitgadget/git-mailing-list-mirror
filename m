From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 3/3] git-daemon: rewrite kindergarden
Date: Wed, 13 Aug 2008 11:05:46 +0200
Message-ID: <20080813090546.GN32184@machine.or.cz>
References: <20080813084330.30845.89753.stgit@aristoteles.cuci.nl> <20080813084331.30845.21129.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Aug 13 11:07:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTCJg-0007bE-Fq
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 11:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbYHMJFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 05:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753779AbYHMJFt
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 05:05:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41599 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752380AbYHMJFt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 05:05:49 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id A6312393A36E; Wed, 13 Aug 2008 11:05:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080813084331.30845.21129.stgit@aristoteles.cuci.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92199>

On Wed, Aug 13, 2008 at 10:43:31AM +0200, Stephen R. van den Berg wrote:
> Get rid of the silly fixed array of children and make
> max-connections dynamic and configurable in the process.
> Fix the killing code to actually be smart instead of the
> pseudo-random mess.
> Avoid forking if too busy already.
> 
> Signed-off-by: Stephen R. van den Berg <srb@cuci.nl>

I would somehow mention the string '--max-connections' in the log
message; that is really useful when looking when some option was
introduced.

> diff --git a/daemon.c b/daemon.c
> index 19d620c..a7a735c 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -584,40 +584,37 @@ static int execute(struct sockaddr *addr)
>  	return -1;
>  }
>  
> +static int max_connections = 32;
>  
> -/*
> - * We count spawned/reaped separately, just to avoid any
> - * races when updating them from signals. The SIGCHLD handler
> - * will only update children_reaped, and the fork logic will
> - * only update children_spawned.
> - *
> - * MAX_CHILDREN should be a power-of-two to make the modulus
> - * operation cheap. It should also be at least twice
> - * the maximum number of connections we will ever allow.
> - */
> -#define MAX_CHILDREN 128
> -
> -static int max_connections = 25;
> -
> -/* These are updated by the signal handler */
> -static volatile unsigned int children_reaped;
> -static pid_t dead_child[MAX_CHILDREN];
> -
> -/* These are updated by the main loop */
> -static unsigned int children_spawned;
> -static unsigned int children_deleted;
> +static unsigned int live_children;
>  
>  static struct child {
> +	struct child*next;

struct child *next;

>  	pid_t pid;
> -	int addrlen;
>  	struct sockaddr_storage address;
> -} live_child[MAX_CHILDREN];
> +} *firstborn;
>  
> -static void add_child(int idx, pid_t pid, struct sockaddr *addr, int addrlen)
> +static void add_child(pid_t pid, struct sockaddr *addr, int addrlen)
>  {
> -	live_child[idx].pid = pid;
> -	live_child[idx].addrlen = addrlen;
> -	memcpy(&live_child[idx].address, addr, addrlen);
> +	struct child*newborn;

struct child *newborn;

> +	newborn = xcalloc(1, sizeof *newborn);
> +	if (newborn) {
> +		struct child **cradle, *blanket;
> +
> +		live_children++;
> +		newborn->pid = pid;
> +		memcpy(&newborn->address, addr, addrlen);
> +		for (cradle = &firstborn;
> +		     (blanket = *cradle);
> +		     cradle = &blanket->next)
> +			if (!memcmp(&blanket->address, &newborn->address,
> +				   sizeof newborn->address))
> +				break;
> +		newborn->next = blanket;
> +		*cradle = newborn;

So, I can always excuse myself by mentioning that it's early in the
morning (for me ;-) but what do you actually need the blanket for, in
this warm digital world?

The current for statement is *really* cryptic... What about:

+		struct child **cradle;
+
+		live_children++;
+		newborn->pid = pid;
+		memcpy(&newborn->address, addr, addrlen);
+		for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
+			if (!memcmp(&(*cradle)->address, &newborn->address,
+				   sizeof newborn->address))
+				break;
+		newborn->next = *cradle;
+		*cradle = newborn;

> +	}
> +	else
> +		logerror("Out of memory spawning new child");
>  }
>  
>  /*
> @@ -626,142 +623,78 @@ static void add_child(int idx, pid_t pid, struct sockaddr *addr, int addrlen)
>   * We move everything up by one, since the new "deleted" will
>   * be one higher.
>   */
> -static void remove_child(pid_t pid, unsigned deleted, unsigned spawned)
> +static void remove_child(pid_t pid)
>  {
> -	struct child n;
> +	struct child **cradle, *blanket;
>  
> +	for (cradle = &firstborn; (blanket = *cradle); cradle = &blanket->next)
> +		if (blanket->pid == pid) {
> +			*cradle = blanket->next;
> +			live_children--;
> +			free(blanket);
> +			break;
> +		}
>  }

Same here. You just need a temporary variable in the innermost block.

> +static void kill_some_child()
>  {
> +	const struct child *blanket;
>  
> +	if ((blanket = firstborn)) {
> +		const struct child *next;
>  
> +		for (; (next = blanket->next); blanket = next)
> +			if (!memcmp(&blanket->address, &next->address,
> +				   sizeof next->address)) {
> +				kill(blanket->pid, SIGTERM);
> +				break;
> +			}

I think using cradle instead of blanket in this for loop would be more
consistent, if perhaps somewhat more morbid.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
