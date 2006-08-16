From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] use appropriate typedefs
Date: Tue, 15 Aug 2006 23:40:45 -0700
Message-ID: <7vr6zh41zm.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608142305290.23445@chino.corp.google.com>
	<7vveou8myg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0608151000350.26891@chino.corp.google.com>
	<Pine.LNX.4.63.0608151037570.28175@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 08:41:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDF59-0001tg-0j
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 08:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWHPGks (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 02:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWHPGks
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 02:40:48 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:19629 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750849AbWHPGkr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 02:40:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060816064046.UJSF29796.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Aug 2006 02:40:46 -0400
To: David Rientjes <rientjes@google.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25501>

David Rientjes <rientjes@google.com> writes:

> On Tue, 15 Aug 2006, David Rientjes wrote:
>
> Please replace the original patch with the following.

> diff --git a/builtin-apply.c b/builtin-apply.c
> index 9cf477c..56c5394 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -2097,7 +2097,7 @@ static void create_one_file(char *path, 
>  	}
>  
>  	if (errno == EEXIST) {
> -		unsigned int nr = getpid();
> +		pid_t nr = getpid();
>  

(earlier)

>> Since mkpath() is vararg, doesn't this make it necessary to cast
>> its parameter several lines down?
>
> No, it is not necessary in the sense that any of these changes
> in this patch are necessary.  But since getpid() returns
> pid_t, every assignment should be cast as such.  pid_t can be
> typed as a short.

If pid_t is a short then wouldn't it be promoted to "unsigned
int" just fine, except for the failure case (but this is
getpid() we are dealing with here)?  More problematic is the
case where pid_t is wider than unsigned int, in which case we
can end up truncating the return value from getpid().

But for this particular case, I do not think it matters; the
code uses getpid() to seed the loop to obtain an unused
"~number" suffix; it could have used random(3) or time(2)
instead.  As long as:

	newpath = mkpath("%s~%u", path, nr);

does a reasonable thing, we are Ok.

I think, however, if you change the type of nr to pid_t, you
would need to cast it like this, because mkpath is defined to be
"char *mkpath(const char *, ...)":

	newpath = mkpath("%s~%u", path, (unsigned int) nr);

Or use whatever matching integral type and format letter pairs;
we seem to like "%lu" format and "(unsigned long)" in other
parts of our code.

> diff --git a/fetch-clone.c b/fetch-clone.c
> index 5e84c46..c5cf477 100644
> --- a/fetch-clone.c
> +++ b/fetch-clone.c
> @@ -44,9 +44,8 @@ static int finish_pack(const char *pack_
>  
>  	for (;;) {
>  		int status, code;
> -		int retval = waitpid(pid, &status, 0);
>  
> -		if (retval < 0) {
> +		if (waitpid(pid, &status, 0) < 0) {
>  			if (errno == EINTR)
>  				continue;
>  			error("waitpid failed (%s)", strerror(errno));

Makes sense -- if pid_t is wider than int we would be in
trouble.

> diff --git a/merge-index.c b/merge-index.c

Same.

> diff --git a/run-command.c b/run-command.c
> index ca67ee9..3bacc1b 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -25,15 +25,15 @@ int run_command_v_opt(int argc, const ch
>  	}
>  	for (;;) {
>  		int status, code;
> -		int retval = waitpid(pid, &status, 0);
> +		pid_t waiting = waitpid(pid, &status, 0);
>  
> -		if (retval < 0) {
> +		if (waiting < 0) {
>  			if (errno == EINTR)
>  				continue;

Same.

> -			error("waitpid failed (%s)", strerror(retval));
> +			error("waitpid failed (%s)", strerror(waiting));

Shouldn't this be "strerror(errno)"?  The original gets it wrong
already.

> diff --git a/unpack-trees.c b/unpack-trees.c
> index a20639b..e496d8c 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -278,7 +278,7 @@ static void unlink_entry(char *name)
>  	}
>  }
>  
> -static volatile int progress_update = 0;
> +static volatile sig_atomic_t progress_update = 0;
>  
>  static void progress_interval(int signum)
>  {

This matches the other one in builtin-pack-objects.c and makes
sense.

Thanks.
