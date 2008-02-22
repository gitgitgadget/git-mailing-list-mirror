From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui not working in a non-default Cygwin installation.
Date: Fri, 22 Feb 2008 01:46:42 -0500
Message-ID: <20080222064642.GD8410@spearce.org>
References: <fp5fdj$5fi$1@ger.gmane.org> <20080217080255.GQ24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jurko =?utf-8?Q?Gospodneti=C4=87?= <jurko.gospodnetic@docte.hr>
X-From: git-owner@vger.kernel.org Fri Feb 22 07:47:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSRgp-0003CI-BH
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 07:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbYBVGqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 01:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbYBVGqs
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 01:46:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45194 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbYBVGqr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 01:46:47 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JSRgC-0003Y0-2O; Fri, 22 Feb 2008 01:46:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6743C20FBAE; Fri, 22 Feb 2008 01:46:43 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080217080255.GQ24004@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74695>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Jurko Gospodneti <jurko.gospodnetic@docte.hr> wrote:
> > 
> >   One of these is that it seems that with the latest git release the 
> > git-gui script changed and started hardcoding some absolute paths in it 
> > during its build (git-gui/Makefile replaces @@GITGUI_SCRIPT@@ with a 
> > hardcoded path). However, this causes the prebuilt Cygwin package to not 
> > work in case Cygwin is not installed in its default location at 
> > C:\Cygwin (e.g. D:\Cygwin or C:\Program Files\Cygwin).
...
> I'll have to figure out on Cygwin if the $TCL_PATH I'm using is
> able to resolve Cygwin absolute paths or not, and then build the
> script accordingly.  Fun.
> 
> I'll try to work up a Makefile patch in the next few days and get
> it into a gitgui-0.9.3 maint release, which will probably roll up
> into git 1.5.4.3.

So it took me longer than "next few days" but there is now a
two patch series in my maint branch that resolves this issue.
If git-gui is built with a Tcl/Tk that understands Cygwin path
translations it keeps the library path in POSIX format, but if it
builds with a Tcl/Tk that is a native Win32 binary then it uses
cygpath to translate the path.

Although now that I think about it the relative path case should
be able to be enabled again in the native Win32 codepath, as we
only ran into problems with it on Cygwin.

Anyway, it will be in gitgui-0.9.3, which I expect will be bundled
into git 1.5.4.3, which Junio has stated may be next week.

--8<--
diff --git a/Makefile b/Makefile
index 081d755..01e0a46 100644
--- a/Makefile
+++ b/Makefile
@@ -92,8 +92,12 @@ ifndef V
 	REMOVE_F1 = && echo '   ' REMOVE `basename "$$dst"` && $(RM_RF) "$$dst"
 endif
 
-TCL_PATH   ?= tclsh
 TCLTK_PATH ?= wish
+ifeq (./,$(dir $(TCLTK_PATH)))
+	TCL_PATH ?= $(subst wish,tclsh,$(TCLTK_PATH))
+else
+	TCL_PATH ?= $(dir $(TCLTK_PATH))$(notdir $(subst wish,tclsh,$(TCLTK_PATH)))
+endif
 
 ifeq ($(uname_S),Darwin)
 	TKFRAMEWORK = /Library/Frameworks/Tk.framework/Resources/Wish.app
@@ -127,7 +131,17 @@ GITGUI_MACOSXAPP :=
 
 ifeq ($(uname_O),Cygwin)
 	GITGUI_SCRIPT := `cygpath --windows --absolute "$(GITGUI_SCRIPT)"`
-	gg_libdir_sed_in := $(shell cygpath --windows --absolute "$(gg_libdir)")
+
+	# Is this a Cygwin Tcl/Tk binary?  If so it knows how to do
+	# POSIX path translation just like cygpath does and we must
+	# keep libdir in POSIX format so Cygwin packages of git-gui
+	# work no matter where the user installs them.
+	#
+	ifeq ($(shell echo 'puts [file normalize /]' | '$(TCL_PATH_SQ)'),$(shell cygpath --mixed --absolute /))
+		gg_libdir_sed_in := $(gg_libdir)
+	else
+		gg_libdir_sed_in := $(shell cygpath --windows --absolute "$(gg_libdir)")
+	endif
 else
 	ifeq ($(exedir),$(gg_libdir))
 		GITGUI_RELATIVE := 1

-- 
Shawn.
