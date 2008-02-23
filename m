From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] t3404: use configured shell instead of /bin/sh
Date: Sat, 23 Feb 2008 18:12:53 -0500
Message-ID: <20080223231253.GA14320@coredump.intra.peff.net>
References: <20080220235944.GA6278@coredump.intra.peff.net> <200802232113.40100.johannes.sixt@telecom.at> <7v63wf2yzt.fsf@gitster.siamese.dyndns.org> <200802232209.41428.johannes.sixt@telecom.at> <20080223211536.GA13280@coredump.intra.peff.net> <7vmypr1gmh.fsf@gitster.siamese.dyndns.org> <20080223223933.GA13683@coredump.intra.peff.net> <7vve4fz3y1.fsf@gitster.siamese.dyndns.org> <20080223224938.GA14231@coredump.intra.peff.net> <7vir0fz3ip.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Whit Armstrong <armstrong.whit@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 00:13:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT3Yi-00009G-O1
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbYBWXM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 18:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbYBWXM4
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 18:12:56 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3529 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbYBWXM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 18:12:56 -0500
Received: (qmail 11864 invoked by uid 111); 23 Feb 2008 23:12:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 23 Feb 2008 18:12:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Feb 2008 18:12:53 -0500
Content-Disposition: inline
In-Reply-To: <7vir0fz3ip.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74879>

On Sat, Feb 23, 2008 at 02:55:42PM -0800, Junio C Hamano wrote:

> I think the basic goal should be to come up with a way to make
> sure that "cd t/ && make" and "cd t/ && sh -x tXXXX-name.sh"
> would get an environment as close as possible to what happens
> when you run "make test" at the toplevel.

I was thinking of something like this:

---
diff --git a/Makefile b/Makefile
index d33a556..9046b43 100644
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
