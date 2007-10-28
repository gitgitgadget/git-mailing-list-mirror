From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] include $PATH in generating list of commands for
 "help -a"
Date: Sun, 28 Oct 2007 16:51:00 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710281642220.4362@racer.site>
References: <1193474215-6728-6-git-send-email-srp@srparish.net>
 <1193582654-12100-1-git-send-email-srp@srparish.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Scott R Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 17:52:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImBN1-0001kM-Lb
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 17:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbXJ1Qv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 12:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbXJ1Qv7
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 12:51:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:46849 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751290AbXJ1Qv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 12:51:59 -0400
Received: (qmail invoked by alias); 28 Oct 2007 16:51:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp056) with SMTP; 28 Oct 2007 17:51:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18is+Bp++wiy/ObtkN0EGTKxtE7GLEpyfGOQ/WCNC
	3BkOqtC7ey3d2F
X-X-Sender: gene099@racer.site
In-Reply-To: <1193582654-12100-1-git-send-email-srp@srparish.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62573>

Hi,

On Sun, 28 Oct 2007, Scott R Parish wrote:

> diff --git a/help.c b/help.c
> index 34ac5db..07cf67a 100644
> --- a/help.c
> +++ b/help.c
> @@ -37,24 +37,28 @@ static inline void mput_char(char c, unsigned int num)
>  		putchar(c);
>  }
>  
> -static struct cmdname {
> -	size_t len;
> -	char name[1];
> -} **cmdname;
> -static int cmdname_alloc, cmdname_cnt;
> -
> -static void add_cmdname(const char *name, int len)
> +static struct cmdnames {
> +	int alloc;
> +	int cnt;
> +	struct cmdname {
> +		size_t len;
> +		char name[1];
> +	} **names;
> +} main_cmds, other_cmds;
> +
> +static void add_cmdname(struct cmdnames *cmds, const char *name, int len)
>  {
>  	struct cmdname *ent;
> -	if (cmdname_alloc <= cmdname_cnt) {
> -		cmdname_alloc = cmdname_alloc + 200;
> -		cmdname = xrealloc(cmdname, cmdname_alloc * sizeof(*cmdname));
> +	if (cmds->alloc <= cmds->cnt) {
> +		cmds->alloc = cmds->alloc + 200;
> +		cmds->names = xrealloc(cmds->names,
> +				       cmds->alloc * sizeof(*cmds->names));

Looks like a candidate for ALLOC_GROW() ...

> @@ -64,7 +68,44 @@ static int cmdname_compare(const void *a_, const void *b_)
>  	return strcmp(a->name, b->name);
>  }
>  
> -static void pretty_print_string_list(struct cmdname **cmdname, int longest)
> +static void uniq(struct cmdnames *cmds)
> +{
> +	int i, j;
> +
> +	if (!cmds->cnt)
> +		return;
> +
> +	for (i = j = 1; i < cmds->cnt; i++) {
> +		if (strcmp(cmds->names[i]->name, cmds->names[i-1]->name)) {
> +			cmds->names[j++] = cmds->names[i];
> +		}
> +	}

Losing the curly brackets would make this look much nicer.

> +
> +	cmds->cnt = j;
> +}
> +
> +static void subtract_cmds(struct cmdnames *a, struct cmdnames *b) {

Maybe "exclude_cmds()", and choose more suggestive names for the 
parameters?

> -	DIR *dir = opendir(exec_path);
> +	DIR *dirp = opendir(dir);

I am not sure that a rename from "dir" to "dirp" is needed here.  It 
distracts a little from the real content of your patch.

Thanks,
Dscho
