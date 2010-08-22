From: Daniel Pfeiffer <occitan@t-online.de>
Subject: Compiling git with makepp patch
Date: Mon, 23 Aug 2010 00:31:27 +0200
Message-ID: <4C71A53F.2020108@t-online.de>
References: <84FD9808A65CDF4C959FDB41FC3D134CBCF306D6@MSSRVS4.atlas.de>
Reply-To: occitan@esperanto.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090000080709000902060705"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 23 00:31:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnJ51-0006hV-6Q
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 00:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306Ab0HVWbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 18:31:39 -0400
Received: from mailout02.t-online.de ([194.25.134.17]:45333 "EHLO
	mailout02.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab0HVWbi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 18:31:38 -0400
Received: from fwd08.aul.t-online.de (fwd08.aul.t-online.de )
	by mailout02.t-online.de with smtp 
	id 1OnJ4m-0001Fl-7v; Mon, 23 Aug 2010 00:31:40 +0200
Received: from [192.168.0.10] (SyBsleZDwh9fmfY+MofBxRcgmOvjZ2D-7AB3PqaaiUtzvsvIY3u9XM7-4UifYX6wtQ@[84.177.190.250]) by fwd08.aul.t-online.de
	with esmtp id 1OnJ4c-21eWau0; Mon, 23 Aug 2010 00:31:30 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.4) Gecko/20100608 Mnenhy/0.8.3 Thunderbird/3.1
In-Reply-To: <84FD9808A65CDF4C959FDB41FC3D134CBCF306D6@MSSRVS4.atlas.de>
X-ID: SyBsleZDwh9fmfY+MofBxRcgmOvjZ2D-7AB3PqaaiUtzvsvIY3u9XM7-4UifYX6wtQ
X-TOI-MSGID: 1d1defe0-31da-4e02-8d0a-08ef112950d0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154197>

This is a multi-part message in MIME format.
--------------090000080709000902060705
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

  Hi,

getting ready for the release of makepp version 2.0, I'm testing it for 
building various popular open source software.

Git has been giving our promise of Gnu make compatibility a hard time.  I have 
just checked in a series of small fixes, many which were needed to compile 
Git.  This includes things like:

    * accepting an action-prefix of +
    * implementing the cosmetic --no-print-directory directory option, which
      in your usage is essential
    * smarter MAKEFLAGS handling, because you unset it several times, but we
      have more options, some must reach the submake
    * allow special variables like $@ outside of rules — this used to be an error

There are however two things which I can hardly hope to fix:

GIT-VERSION-FILE: FORCE
      @$(SHELL_PATH) ./GIT-VERSION-GEN
-include GIT-VERSION-FILE
.PHONY: FORCE

I don't know why you depend on a phony that has no rule — I also had to make 
that possible.  The file needs to be built immediately so that it can be 
included, before reading the rest of the makefile.  But the dependency is only 
known to be phony after running the rule.  Here you have a hen-egg problem, 
where I have no clue how Gnu make can cope (this is the one case where it 
requires .PHONY).  Anyway, makepp needs the phony declaration before.

The other thing caused me quite a headache before I understood:

PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'

I suppose you added the comment for Emacs' syntax highlighting, to have an 
even number of unescaped quotes.  The problem is makepp parses this line just 
like Emacs, so it doesn't find the comment, adding in the #' at the point of 
use, which completely screws the sed command.  (You might want to apply my fix 
to a few other makefiles, which have SQ variables, albeit without the syntax 
highlighting workaround, so they are only visually defect.)

coralament / best Grötens / liebe Grüße / best regards / elkorajn salutojn
Daniel Pfeiffer

-- 
lerne / learn / apprends / lär dig / ucz się    Esperanto:
                     http://lernu.net   /http://ikurso.net


--------------090000080709000902060705
Content-Type: text/x-diff;
 name="git-makepp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="git-makepp.patch"

diff -wrup git-2010-08-21/git-gui/Makefile git-2010-08-21a/git-gui/Makefile
--- git-2010-08-21/git-gui/Makefile	2010-08-20 21:55:41.000000000 +0200
+++ git-2010-08-21a/git-gui/Makefile	2010-08-21 20:59:10.272785510 +0200
@@ -7,6 +7,7 @@ all::
 # TCL_PATH must be vaild for this to work.
 #
 
+.PHONY: FORCE
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
@@ -340,4 +341,3 @@ ifdef GITGUI_WINDOWS_WRAPPER
 endif
 
 .PHONY: all install uninstall dist-version clean
-.PHONY: FORCE
diff -wrup git-2010-08-21/gitweb/Makefile git-2010-08-21a/gitweb/Makefile
--- git-2010-08-21/gitweb/Makefile	2010-08-20 21:55:41.000000000 +0200
+++ git-2010-08-21a/gitweb/Makefile	2010-08-21 21:09:47.499919056 +0200
@@ -52,12 +52,15 @@ SHELL_PATH ?= $(SHELL)
 PERL_PATH  ?= /usr/bin/perl
 
 # Shell quote;
-bindir_SQ = $(subst ','\'',$(bindir))#'
-gitwebdir_SQ = $(subst ','\'',$(gitwebdir))#'
-gitwebstaticdir_SQ = $(subst ','\'',$(gitwebdir)/static)#'
-SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))#'
-PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'
-DESTDIR_SQ    = $(subst ','\'',$(DESTDIR))#'
+Q='
+# ' This comment is only to appease IDEs like Emacs.
+# The comment is on a new line, else makepp would see it as a quoted hash.
+bindir_SQ = $(subst $Q,'\'',$(bindir))
+gitwebdir_SQ = $(subst $Q,'\'',$(gitwebdir))
+gitwebstaticdir_SQ = $(subst $Q,'\'',$(gitwebdir)/static)
+SHELL_PATH_SQ = $(subst $Q,'\'',$(SHELL_PATH))
+PERL_PATH_SQ  = $(subst $Q,'\'',$(PERL_PATH))
+DESTDIR_SQ    = $(subst $Q,'\'',$(DESTDIR))
 
 # Quiet generation (unless V=1)
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
diff -wrup git-2010-08-21/Makefile git-2010-08-21a/Makefile
--- git-2010-08-21/Makefile	2010-08-20 21:55:41.000000000 +0200
+++ git-2010-08-21a/Makefile	2010-08-21 21:02:07.676932693 +0200
@@ -236,6 +236,7 @@ all::
 #
 # Define NATIVE_CRLF if your platform uses CRLF for line endings.
 
+.PHONY: FORCE
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
@@ -2217,7 +2218,7 @@ endif
 
 .PHONY: all install clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-.PHONY: FORCE TAGS tags cscope
+.PHONY: TAGS tags cscope
 
 ### Check documentation
 #


--------------090000080709000902060705--
