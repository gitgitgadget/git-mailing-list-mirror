From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: add mingw specific startup wrapper
Date: Wed, 10 Oct 2007 02:22:18 -0400
Message-ID: <20071010062218.GP2137@spearce.org>
References: <20071010053728.GM2137@spearce.org> <11919958073204-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 08:22:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfUxk-0005Xa-VO
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 08:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbXJJGWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 02:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbXJJGWX
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 02:22:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35663 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbXJJGWW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 02:22:22 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IfUxY-0005r7-3o; Wed, 10 Oct 2007 02:22:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 14B9C20FBAE; Wed, 10 Oct 2007 02:22:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <11919958073204-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60467>

Steffen Prohaska <prohaska@zib.de> wrote:
> The wrapper adds the directory it is installed in to PATH.
> This is required for the git commands implemented in shell.
> git-gui fails to launch them if PATH is not modified.
> 
> The wrapper script also accepts an optional command line
> switch '--working-dir <dir>' and changes to <dir> before
> launching the actual git-gui. This is required to implement
> the "Git Gui Here" Explorer shell extension.
 
Nice.

> diff --git a/git-gui/Makefile b/git-gui/Makefile
> @@ -128,6 +128,7 @@ ifeq ($(uname_S),Darwin)
>  endif
>  ifneq (,$(findstring MINGW,$(uname_S)))
>  	NO_MSGFMT=1
> +	GITGUI_WINDOWS_WRAPPER := YesPlease
>  endif

I don't have this context in my Makefile so I can't apply this
additional line here.  Can someone package up the patch that
introduces the MINGW case above with a proper commit message,
so I can apply it in front of this patch?

>  install: all
> @@ -246,6 +257,9 @@ ifdef GITGUI_MACOSXAPP
>  	$(QUIET)$(INSTALL_A0)'Git Gui.app' $(INSTALL_A1) '$(DESTDIR_SQ)$(libdir_SQ)'
>  	$(QUIET)$(INSTALL_X0)git-gui.tcl $(INSTALL_X1) '$(DESTDIR_SQ)$(libdir_SQ)'
>  endif
> +ifdef GITGUI_WINDOWS_WRAPPER
> +	$(QUIET)$(INSTALL_X0)git-gui.tcl $(INSTALL_X1) '$(DESTDIR_SQ)$(libdir_SQ)'
> +endif
>  	$(QUIET)$(foreach p,$(ALL_LIBFILES), $(INSTALL_R0)$p $(INSTALL_R1) '$(DESTDIR_SQ)$(libdir_SQ)' &&) true
>  	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(msgsdir_SQ)' $(INSTALL_D1)
>  	$(QUIET)$(foreach p,$(ALL_MSGFILES), $(INSTALL_R0)$p $(INSTALL_R1) '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true

I think you missed the entry in the uninstall and clean targets.

> diff --git a/git-gui/windows/git-gui.sh b/git-gui/windows/git-gui.sh
> @@ -0,0 +1,16 @@
> +#!/bin/sh
> +# Tcl ignores the next line -*- tcl -*- \
> +exec wish "$0" -- "$@"
> +
> +if { $argc >=2 && [lindex $argv 0] == "--working-dir" } {
> +	cd [lindex $argv 1]
> +	set argv [lrange $argv 2 end]
> +	incr argc -2
> +}

Maybe we should just support this option directly in git-gui.
Today we also support doing something like this by setting the
GIT_DIR environment variable into a non-bare repository; see the
"# repository setup" block of git-gui.sh.

> +set gitguidir [file dirname [info script]]
> +regsub -all ";" $gitguidir "\\;" gitguidir
> +set env(PATH) "$gitguidir;$env(PATH)"
> +unset gitguidir
> +
> +source [file join [file dirname [info script]] git-gui.tcl]

Hmmph.  The install target was going into libdir but the above
source doesn't seem to read from there, its loading from the same
location as the git-gui wrapper script.  You msys guys probably
don't have $(libdir) == $(gitexecdir), do you?

-- 
Shawn.
