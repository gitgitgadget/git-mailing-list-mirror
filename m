From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Adapting scripts to work in current (not top) directory
Date: Fri, 13 May 2005 15:53:59 +0200
Message-ID: <20050513135359.GA28138@pasky.ji.cz>
References: <200505121758.10971.snake@penza-gsm.ru> <20050512201215.GI324@pasky.ji.cz> <200505131459.08891.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 15:48:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWaV4-0002ua-RH
	for gcvg-git@gmane.org; Fri, 13 May 2005 15:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVEMNyd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 09:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbVEMNyZ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 09:54:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45293 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262370AbVEMNyE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 09:54:04 -0400
Received: (qmail 11645 invoked by uid 2001); 13 May 2005 13:53:59 -0000
To: Alexey Nezhdanov <snake@penza-gsm.ru>
Content-Disposition: inline
In-Reply-To: <200505131459.08891.snake@penza-gsm.ru>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, May 13, 2005 at 12:59:08PM CEST, I got a letter
> I have opted for current directory and not root. Explanation is later this 
> mail. New variant:

Yes, that's fine.

> =========================
> --- /home/snake/scm/cogito/cg-Xlib      2005-05-12 08:47:29.000000000 +0400
> +++ cg-Xlib     2005-05-13 13:40:58.000000000 +0400
> @@ -8,7 +8,17 @@
>  
>  _cg_cmd=${0##*/}
>  
> -_git=${GIT_DIR:-.git}
> +repopath=`pwd`
> +while ((1)) ; do {
> +  [ -d "$repopath/.git" ] && break
> +  [ "$repopath" == "/" ] && {
> +    repopath=`pwd`;
> +    break;
> +  };
> +  repopath=`dirname $repopath`
> +}; done
> +
> +_git=${GIT_DIR:-$repopath/.git}
>  _git_objects=${GIT_OBJECT_DIRECTORY:-$_git/objects}

Looks basically fine.

> =========================
> Here is a problem:
> Because of git backend only some of the commands should be enabled to work 
> from current directory. F.e. cg-init should not scan upper directories for 
> ".git" but should instead stick to current directory. In the script above 
> this workarounded as choosing current directory instead of root but this will 
> broke if we trying to initialise repo in a subdirectory of another repo.

I'd set some flag like $reposubdir if .git was found in some of the
parent directories. Then test that in the relevant commands.

> So I have analysed list of cogito commands to find out which ones should be 
> adopted to use "find repo" behaivoir:
> 
> "+" means "definitely yes"
> "-" means "definitely no"
> "?" means "not sure"
> "." means "not matter"
> 
> + cg-add
> ? cg-admin-lsobj

Sure.

> - cg-admin-uncommit
> ? cg-branch-add
> ? cg-branch-ls

Sure (both).

> - cg-cancel
> - cg-clone
> - cg-commit

This one should, committing only the subdirectory content.

> + cg-diff
> - cg-export

Perhaps it could export just the subdirectory?

> . cg-help
> - cg-init
> + cg-log
> + cg-ls

(Listing the appropriate subdir.)

> - cg-merge
> + cg-mkpatch
> ? cg-patch

This one should, using the appropriate -p level.

> - cg-pull
> - cg-restore

This one should, restoring only the subdirectory.

> + cg-rm
> - cg-seek
> + cg-status
> - cg-tag
> ? cg-tag-ls

Why not...

> - cg-update
> . cg-version

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
