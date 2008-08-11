From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-submodule - Add 'foreach' subcommand
Date: Mon, 11 Aug 2008 12:23:45 +0200
Message-ID: <20080811102344.GG32184@machine.or.cz>
References: <7vsktczebg.fsf@gitster.siamese.dyndns.org> <1218409804-1556-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, johan@herland.net
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 12:24:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSUa1-0007VA-UU
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 12:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbYHKKXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 06:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbYHKKXs
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 06:23:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54273 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbYHKKXr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 06:23:47 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 0BF88393B31F; Mon, 11 Aug 2008 12:23:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1218409804-1556-1-git-send-email-mlevedahl@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91928>

  Hi,

On Sun, Aug 10, 2008 at 07:10:04PM -0400, Mark Levedahl wrote:
> submodule foreach <command-list> will execute the list of commands in
> each currently checked out submodule directory. The list of commands
> is arbitrary as long as it is acceptable to sh. The variables '$path'
> and '$sha1' are availble to the command-list, defining the submodule
> path relative to the superproject and the submodules's commitID as
> recorded in the superproject (this may be different than HEAD in the
> submodule).

  in principle, this looks pretty sensible.

> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index bf33b0c..1e7d352 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -14,6 +14,7 @@ SYNOPSIS
>  'git submodule' [--quiet] init [--] [<path>...]
>  'git submodule' [--quiet] update [--init] [--] [<path>...]
>  'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
> +'git submodule' foreach <command-list>
>  
>  
>  DESCRIPTION

  But as visible here, this is a little bit inconsistent. I think
foreach should be by default verbose about which submodules does it
recurse into - this is what you want in case of casual usage on
command-line. In case you want to have full control on the output within
a script, you can always pass the extra --quiet and it's less obnoxious
this way around.

  I also have a problem with the <command-list> - is this one argument?
Multiple arguments? The semantics is ill-defined. If it is supposed to
be a single argument, please drop the -list bit; silent DWIMmery of
using "$@" internally is acceptable, I guess. If it is supposed to be
multiple arguments, you need to

	(i) Specify that as <command>... instead

	(ii) Either have an eternal annoyance about insane behaviour
here, or use something better than eval "$@". Since

	git submodule foreach cp x\ y z

will simply _not_ work properly.

  So I think it's best to just drop the 'list' part. You're just
evaluating a shell expression passed in a parameter.

> @@ -123,6 +124,20 @@ summary::
>  	in the submodule between the given super project commit and the
>  	index or working tree (switched by --cached) are shown.
>  
> +foreach::
> +	Executes an arbitrary list of commands in each checked out submodule.

I think "evaluates" is a better word here, too.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
