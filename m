From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] t3404: use configured shell instead of /bin/sh
Date: Sun, 24 Feb 2008 14:40:45 -0500
Message-ID: <20080224194045.GA27606@coredump.intra.peff.net>
References: <7v63wf2yzt.fsf@gitster.siamese.dyndns.org> <200802232209.41428.johannes.sixt@telecom.at> <20080223211536.GA13280@coredump.intra.peff.net> <7vmypr1gmh.fsf@gitster.siamese.dyndns.org> <20080223223933.GA13683@coredump.intra.peff.net> <7vve4fz3y1.fsf@gitster.siamese.dyndns.org> <20080223224938.GA14231@coredump.intra.peff.net> <7vir0fz3ip.fsf@gitster.siamese.dyndns.org> <20080223231253.GA14320@coredump.intra.peff.net> <7vfxvjxlsv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Whit Armstrong <armstrong.whit@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 20:41:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTMiz-0000OP-Kt
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 20:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbYBXTks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 14:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbYBXTks
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 14:40:48 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4408 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbYBXTks (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 14:40:48 -0500
Received: (qmail 1352 invoked by uid 111); 24 Feb 2008 19:40:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 24 Feb 2008 14:40:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Feb 2008 14:40:45 -0500
Content-Disposition: inline
In-Reply-To: <7vfxvjxlsv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74956>

On Sat, Feb 23, 2008 at 04:03:44PM -0800, Junio C Hamano wrote:

> Sounds sane to me.

OK, here it is cleaned up a little (adding some missing quotation marks
and the proper gitignore) and with a commit message.

Possibly t/Makefile should also be getting this information to actually
run the test scripts. That would require either:
  - making the GIT-BUILD-OPTIONS both make and shell parseable, meaning
    changing SHELL_PATH='$(SHELL_PATH_SQ)' into SHELL_PATH=$(SHELL_PATH)
    and hoping nobody uses metacharacters
  - writing two separate files, one for shell and one for make
  - working some Makefile magic to set variables from the shell; this is
    not possible in ordinary make, but I suspect there are some GNU-isms
    we could use

-- >8 --
use build-time SHELL_PATH in test scripts

The top-level Makefile now creates a GIT-BUILD-OPTIONS file
which stores any options selected by the make process that
may be of use to further parts of the build process.
Specifically, we store the SHELL_PATH so that it can be used
by tests to construct shell scripts on the fly.

The format of the GIT-BUILD-OPTIONS file is Bourne shell,
and it is sourced by test-lib.sh; all tests can rely on just
having $SHELL_PATH correctly set in the environment.

The GIT-BUILD-OPTIONS file is written every time the
toplevel 'make' is invoked. Since the only users right now
are the test scripts, there's no drawback to updating its
timestamp. If something build-related depends on this, we
can do a trick similar to the one used by GIT-CFLAGS.

Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore                    |    1 +
 Makefile                      |    6 +++++-
 t/t3404-rebase-interactive.sh |    2 +-
 t/test-lib.sh                 |    2 ++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index 165b256..4ff2fec 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
+GIT-BUILD-OPTIONS
 GIT-CFLAGS
 GIT-GUI-VARS
 GIT-VERSION-FILE
diff --git a/Makefile b/Makefile
index d33a556..ba1aaf8 100644
--- a/Makefile
+++ b/Makefile
@@ -808,7 +808,7 @@ export TAR INSTALL DESTDIR SHELL_PATH
 
 ### Build rules
 
-all:: $(ALL_PROGRAMS) $(BUILT_INS) $(OTHER_PROGRAMS)
+all:: $(ALL_PROGRAMS) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
 ifneq (,$X)
 	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), $(RM) '$p';)
 endif
@@ -1010,6 +1010,9 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
 		echo "$$FLAGS" >GIT-CFLAGS; \
             fi
 
+GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
+	@echo SHELL_PATH='$(SHELL_PATH_SQ)' >$@
+
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
 TRACK_VARS = $(subst ','\'',-DTCLTK_PATH='$(TCLTK_PATH_SQ)')
@@ -1169,6 +1172,7 @@ endif
 
 .PHONY: all install clean strip
 .PHONY: .FORCE-GIT-VERSION-FILE TAGS tags cscope .FORCE-GIT-CFLAGS
+.PHONY: .FORCE-GIT-BUILD-OPTIONS
 
 ### Check documentation
 #
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 62e65d7..049aa37 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -61,7 +61,7 @@ test_expect_success 'setup' '
 	git tag I
 '
 
-echo "#!$SHELL" >fake-editor
+echo "#!$SHELL_PATH" >fake-editor.sh
 cat >> fake-editor.sh <<\EOF
 case "$1" in
 */COMMIT_EDITMSG)
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 83889c4..3c4e21f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -342,6 +342,8 @@ if ! test -x ../test-chmtime; then
 	exit 1
 fi
 
+. ../GIT-BUILD-OPTIONS
+
 # Test repository
 test=trash
 rm -fr "$test"
-- 
1.5.4.2.276.g0ede
