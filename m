From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] Clean up work-tree handling
Date: Fri, 27 Jul 2007 13:51:46 -0700
Message-ID: <7vk5sly3h9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
	<Pine.LNX.4.64.0707271956420.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 27 22:52:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEWnO-0001qh-4b
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 22:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764161AbXG0Uvt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 16:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764043AbXG0Uvt
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 16:51:49 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:45402 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763544AbXG0Uvr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 16:51:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727205147.GGIZ1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 27 Jul 2007 16:51:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ukrm1X00Y1kojtg0000000; Fri, 27 Jul 2007 16:51:47 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53965>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	Not only because of ohloh am I proud that in spite of removing
> 	more lines than I added, there were more comments added than
> 	removed...

> diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
> index 497903a..3f787a8 100644
> --- a/builtin-rev-parse.c
> +++ b/builtin-rev-parse.c
> @@ -320,15 +320,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				continue;
>  			}
>  			if (!strcmp(arg, "--show-cdup")) {
> -				const char *pfx = prefix;
> -				while (pfx) {
> -					pfx = strchr(pfx, '/');
> -					if (pfx) {
> -						pfx++;
> -						printf("../");
> -					}
> -				}
> -				putchar('\n');
> +				const char *work_tree = get_git_work_tree();
> +				if (work_tree)
> +					printf("%s\n", work_tree);
>  				continue;

This changes semantics, I think.

It used to be relative "up" path when no funny work-tree stuff
is used, but get_git_work_tree() now seems to return absolute,
hence this option as well.  If it introduces regression to
existing callers is up to what the caller does to the resulting
path, though.  If it only is used to prefix other things
(i.e. path="$(git rev-parse --show-cdup)$1"), the caller would
be safe, but if the caller counted number of ../ in the return
value to see how deep it is, or if the caller expected to see
empty string in order to see if the process is at the toplevel,
this change would become a regression.

> @@ -62,15 +66,8 @@ static void setup_git_env(void)
>  
>  int is_bare_repository(void)
>  {
> +	/* if core.bare is not 'false', let's see if there is a work tree */
> +	return is_bare_repository_cfg && !get_git_work_tree();
>  }

I thought about making core.bare a tertiary, true/false/depends,
but I think this makes more sense.
