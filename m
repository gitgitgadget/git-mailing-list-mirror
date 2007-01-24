From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Commands requiring a work tree must not run in GIT_DIR
Date: Wed, 24 Jan 2007 03:44:10 -0800
Message-ID: <7vodoohcol.fsf@assigned-by-dhcp.cox.net>
References: <87r6trsu7n.wl@mail2.atmark-techno.com>
	<7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>
	<45B07875.9030506@fs.ei.tum.de>
	<81b0412b0701182357l3a6d44fel58da50c7895fb6b4@mail.gmail.com>
	<45B0C7E6.4020509@op5.se>
	<1169214414.18684.25.camel@localhost.localdomain>
	<Pine.LNX.4.63.0701191600020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vtzymhma2.fsf@assigned-by-dhcp.cox.net>
	<878xfuuhco.wl@mail2.atmark-techno.com>
	<Pine.LNX.4.63.0701231312170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 24 12:44:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9gYA-0005T9-T8
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 12:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbXAXLoO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 06:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbXAXLoN
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 06:44:13 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:63111 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbXAXLoM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 06:44:12 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070124114411.VPZN3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Wed, 24 Jan 2007 06:44:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id EzjE1W0051kojtg0000000; Wed, 24 Jan 2007 06:43:15 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37630>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This patch helps when you accidentally run something like git-clean
> in the git directory instead of the work tree.

I think "require_work_tree" reflects what we are trying to do
much better than NOT_BARE.  So maybe we should rename NOT_BARE
to REQUIRE_WORK_TREE.

Existing check function is_bare_repository() is sometimes used
to see if it is a bare repository regardless of where you are
(e.g. refs.c::log_ref_write()), so that function can stay as is,
but the combined check below (you seem to have a few instances
in your patch) can be made into a function require_work_tree().

> diff --git a/git.c b/git.c
> index 5133a07..2027d1c 100644
> --- a/git.c
> +++ b/git.c
> @@ -302,8 +302,9 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
>  			prefix = setup_git_directory();
>  		if (p->option & USE_PAGER)
>  			setup_pager();
> -		if ((p->option & NOT_BARE) && is_bare_repository())
> -			die("%s cannot be used in a bare git directory", cmd);
> +		if ((p->option & NOT_BARE) &&
> +				(is_bare_repository() || is_inside_git_dir()))
> +			die("%s must be run in a work tree", cmd);
>  		trace_argv_printf(argv, argc, "trace: built-in: git");
>  
>  		exit(p->fn(argc, argv, prefix));

Similar to the "conditionally require working tree" you did to
ls-files, "apply --index" and perhaps "apply --cached" (but this
is "perhaps" --- you _could_ have an index in a bare repository,
although it is debatable if there is a valid use case for it),
grep (grep_cache() but perhaps !cached for the same reason),
"read-tree -u", "rerere", "update-index" (except --index-info
and friends that feed object names directly without using
working tree), should require working tree.

On the script front, bisect should require working tree, but I
do not think anybody is stupid enough to start bisecting in a
bare repository ;-)
