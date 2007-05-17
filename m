From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Build even if tclsh is not available
Date: Wed, 16 May 2007 22:18:58 -0400
Message-ID: <20070517021858.GY3141@spearce.org>
References: <20070517020616.4722.33946.stgit@rover> <20070517021448.24022.8282.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 17 04:19:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoVaA-0002OW-N4
	for gcvg-git@gmane.org; Thu, 17 May 2007 04:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755741AbXEQCTH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 22:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756370AbXEQCTH
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 22:19:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44871 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755741AbXEQCTG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 22:19:06 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HoVZo-0007sg-Tb; Wed, 16 May 2007 22:18:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3FF9320FBAE; Wed, 16 May 2007 22:18:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070517021448.24022.8282.stgit@rover>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47484>

Petr Baudis <pasky@suse.cz> wrote:
> As of now, git fails to build with default config if tclsh is not
> available, thus requiring manual config tweaking just because of some
> optimizations done at build time; this is a needless hassle when building
> git on any kind of a server.
> 
> This patch makes git-gui's build process to handle this gracefully; unless
> TCL_PATH is explicitly set, if tclsh cannot be executed only a warning is
> printed and the build goes on. I have tested this only on that server with
> no tclsh, but hopefully it shouldn't break the build process with tclsh
> available either.
> 
> Version 2, sorry - the previous version of the patch had the install hunk
> missing. And apologies for the duplicate submission... :-)
> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---
> 
>  Makefile         |    8 +++++---
>  git-gui/Makefile |    4 ++--
>  2 files changed, 7 insertions(+), 5 deletions(-)

I have a couple of problems with the patch as-is.  The first is
of course that the patch needs to be split into two; one patch for
the git-gui subdirectory itself and one for git.git.

My other problem is 

>  ifeq ($(findstring $(MAKEFLAGS),s),s)
> @@ -92,7 +92,7 @@ install: all
>  	$(INSTALL) git-gui '$(DESTDIR_SQ)$(gitexecdir_SQ)'
>  	$(foreach p,$(GITGUI_BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
>  	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(libdir_SQ)'
> -	$(INSTALL) -m644 lib/tclIndex '$(DESTDIR_SQ)$(libdir_SQ)'
> +	[ ! -e lib/tclIndex ] || $(INSTALL) -m644 lib/tclIndex '$(DESTDIR_SQ)$(libdir_SQ)'
>  	$(foreach p,$(ALL_LIBFILES), $(INSTALL) -m644 $p '$(DESTDIR_SQ)$(libdir_SQ)' ;)

git-gui won't work if lib/tclIndex is missing or invalid.  So not
installing it means we should just disable git-gui entirely.

-- 
Shawn.
