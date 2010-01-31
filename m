From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] Do not install shell libraries executable
Date: Sun, 31 Jan 2010 02:34:59 -0600
Message-ID: <20100131083459.GA18561@progeny.tock>
References: <20100129102518.GA5875@coredump.intra.peff.net>
 <20100129103723.GC6025@coredump.intra.peff.net>
 <20100129145025.GA22703@progeny.tock>
 <7vhbq2g3a9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 09:35:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbVGl-0003ox-7u
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 09:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163Ab0AaIex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 03:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752907Ab0AaIew
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 03:34:52 -0500
Received: from mail-iw0-f173.google.com ([209.85.223.173]:53794 "EHLO
	mail-iw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471Ab0AaIev (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 03:34:51 -0500
Received: by iwn3 with SMTP id 3so3332749iwn.23
        for <git@vger.kernel.org>; Sun, 31 Jan 2010 00:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=BgJdxlrmWgOZdDHUyL8z70aseph70IpaWs5sVJZ22jw=;
        b=u1Yaa28cTz7gvcvT07x5fQDDbUX8jEFk3Vq1w23ARmgZ79W0a3hKfl+pkpjm3vWS0D
         N+Mv9dT0eb1Qwcwb1OEWZcCQDf1QSTMk49VO5deP5M0T/zT2CwSA1FS0i5ICAbKVx/hy
         xt0uK/x2pdDfp/8PBVjlYZgRI2k9y9LFDXvno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RH65LlDKuMcZl3MUuTwfojM7TeoqSshZlRkPE2irZ0V6YYE3devFGSh2i9Z47+NiQ1
         4I9iSRX0ucvW0qx125KdTqp2CVZNcAm/a4rlm+hX2uIvBP4Be4GsA1Z/lFsEmkIpNu+k
         VgJcHgxzK0xhy3ScUy5/epiNtf4qFi0EWYGdc=
Received: by 10.231.146.8 with SMTP id f8mr4580840ibv.58.1264926890600;
        Sun, 31 Jan 2010 00:34:50 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm4032665iwn.12.2010.01.31.00.34.49
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 00:34:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vhbq2g3a9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138536>

Some scripts are expected to be sourced instead of executed on
their own.  Avoid some confusion by not marking them executable.

The executable bit was confusing the valgrind support of our test
scripts, which assumed that any executable without a #!-line
should be intercepted and run through valgrind.  So during
valgrind-enabled tests, any script sourcing these files actually
sourced the valgrind interception script instead.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> Can't you do something about this repetition from existing $(SCRIPT_SH)
> munging?

Sorry about that.

Last time I also missed git-parse-remote, so while at it, I am taking
the opportunity to add that to SCRIPT_LIB_SH, too.

Good night,
Jonathan

 Makefile            |   39 +++++++++++++++++++++++++--------------
 1 files changed, 25 insertions(+), 14 deletions(-)
 mode change 100755 => 100644 git-parse-remote.sh
 mode change 100755 => 100644 git-sh-setup.sh

diff --git a/Makefile b/Makefile
index fd7f51e..ce42d93 100644
--- a/Makefile
+++ b/Makefile
@@ -342,6 +342,7 @@ LIB_OBJS =
 PROGRAMS =
 SCRIPT_PERL =
 SCRIPT_SH =
+SCRIPT_LIB_SH =
 TEST_PROGRAMS =
 
 SCRIPT_SH += git-am.sh
@@ -353,20 +354,21 @@ SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
-SCRIPT_SH += git-mergetool--lib.sh
 SCRIPT_SH += git-notes.sh
-SCRIPT_SH += git-parse-remote.sh
 SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase--interactive.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-repack.sh
 SCRIPT_SH += git-request-pull.sh
-SCRIPT_SH += git-sh-setup.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
+SCRIPT_LIB_SH += git-mergetool--lib.sh
+SCRIPT_LIB_SH += git-parse-remote.sh
+SCRIPT_LIB_SH += git-sh-setup.sh
+
 SCRIPT_PERL += git-add--interactive.perl
 SCRIPT_PERL += git-difftool.perl
 SCRIPT_PERL += git-archimport.perl
@@ -1428,7 +1430,7 @@ export TAR INSTALL DESTDIR SHELL_PATH
 
 SHELL = $(SHELL_PATH)
 
-all:: shell_compatibility_test $(ALL_PROGRAMS) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
+all:: shell_compatibility_test $(ALL_PROGRAMS) $(SCRIPT_LIB_SH) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
 ifneq (,$X)
 	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
 endif
@@ -1477,17 +1479,25 @@ common-cmds.h: ./generate-cmdlist.sh command-list.txt
 common-cmds.h: $(wildcard Documentation/git-*.txt)
 	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
 
+define cmd_munge_script
+$(RM) $@ $@+ && \
+sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+    -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
+    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
+    -e $(BROKEN_PATH_FIX) \
+    $@.sh >$@+
+endef
+
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
-	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-	    -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
-	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
-	    -e $(BROKEN_PATH_FIX) \
-	    $@.sh >$@+ && \
+	$(QUIET_GEN)$(cmd_munge_script) && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
+$(patsubst %.sh,%,$(SCRIPT_LIB_SH)) : % : %.sh
+	$(QUIET_GEN)$(cmd_munge_script) && \
+	mv $@+ $@
+
 ifndef NO_PERL
 $(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
 
@@ -1792,6 +1802,7 @@ install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) -m 644 $(SCRIPT_LIB_SH) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-archive$X git-shell$X git-cvsserver '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 ifndef NO_PERL
@@ -1901,7 +1912,7 @@ distclean: clean
 clean:
 	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o \
 		$(LIB_FILE) $(XDIFF_LIB)
-	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
+	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB_SH) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags cscope*
 	$(RM) -r autom4te.cache
@@ -1930,7 +1941,7 @@ endif
 ### Check documentation
 #
 check-docs::
-	@(for v in $(ALL_PROGRAMS) $(BUILT_INS) git gitk; \
+	@(for v in $(ALL_PROGRAMS) $(SCRIPT_LIB_SH) $(BUILT_INS) git gitk; \
 	do \
 		case "$$v" in \
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
@@ -1975,7 +1986,7 @@ check-docs::
 		documented,gittutorial-2 | \
 		sentinel,not,matching,is,ok ) continue ;; \
 		esac; \
-		case " $(ALL_PROGRAMS) $(BUILT_INS) git gitk " in \
+		case " $(ALL_PROGRAMS) $(SCRIPT_LIB_SH) $(BUILT_INS) git gitk " in \
 		*" $$cmd "*)	;; \
 		*) echo "removed but $$how: $$cmd" ;; \
 		esac; \
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
old mode 100755
new mode 100644
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
old mode 100755
new mode 100644
-- 
1.7.0.rc1
