From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Do not install shell libraries executable
Date: Fri, 29 Jan 2010 08:50:25 -0600
Message-ID: <20100129145025.GA22703@progeny.tock>
References: <20100129102518.GA5875@coredump.intra.peff.net>
 <20100129103723.GC6025@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 15:57:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NasHo-0007A4-IY
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 15:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887Ab0A2O5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 09:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755846Ab0A2O5X
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 09:57:23 -0500
Received: from mail-yx0-f193.google.com ([209.85.210.193]:38788 "EHLO
	mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574Ab0A2O5W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 09:57:22 -0500
Received: by yxe31 with SMTP id 31so1866138yxe.21
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 06:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PvsNVC6/o1ngcgKF+zF35yy1FOmqDT1WXgH97J0J/jI=;
        b=Jta4uQecIITiIvR38kkMUoyzg/CHVT+yVLjZBUJoGD4x26YGDZeS1nyyq2zJuIxNYG
         vdY8/yDrnqVLATUCkyGpY9I33y+ESsrr2DsWAqJiIHt3Pu70udDFp9R5la4VDGIPga61
         3ofbomNXxRUb8JXVpFqbYDvzwHHU3q4EFfupw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=G/aAJOP2aGGsKg3f+FtGMt1wYmwdxtshvK1efo0j8PKjEaSaaNGEt696qYePxnZU26
         o7gK/H8i9OKn/tPl0lzZLFE5N6lbXkAQgNuBXGgzuHhcAy25KSGlJvL0JXM7AURiosPu
         s4fi7pNMidGzTEshbSfbYhSabV6Q0fpQE2Xmk=
Received: by 10.101.27.10 with SMTP id e10mr1097263anj.54.1264776615514;
        Fri, 29 Jan 2010 06:50:15 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm63255iwn.5.2010.01.29.06.50.13
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 06:50:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100129103723.GC6025@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138320>

These scripts are expected to be sourced instead of executed on
their own.  Avoid some confusion by not marking them executable.

The executable bit was confusing the valgrind support of our test
scripts, which assumed that any executable without a #!-line
should be intercepted and run through valgrind.  So during
valgrind-enabled tests, any script sourcing this file actually
sourced the valgrind interception script instead.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jeff King wrote:

> This problem has been around since 21d0ba7 (difftool/mergetool: refactor
> commands to use git-mergetool--lib, 2009-04-08), released in v1.6.3. But
> since it is only about our internal tests, and even then only about
> running them with valgrind enabled, I don't know if it is worth a fix on
> 'maint'.

It was also confusing dpkg-shlibdeps, so I recently came up with
this fix.  Both fixes seem like good changes to me, and both
could be applied.  Your fix has the virtue of being shorter,
hence safer.

 Makefile        |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)
 mode change 100755 => 100644 git-sh-setup.sh

diff --git a/Makefile b/Makefile
index fd7f51e..70dcc40 100644
--- a/Makefile
+++ b/Makefile
@@ -342,6 +342,7 @@ LIB_OBJS =
 PROGRAMS =
 SCRIPT_PERL =
 SCRIPT_SH =
+SCRIPT_LIB_SH =
 TEST_PROGRAMS =
 
 SCRIPT_SH += git-am.sh
@@ -353,7 +354,6 @@ SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
-SCRIPT_SH += git-mergetool--lib.sh
 SCRIPT_SH += git-notes.sh
 SCRIPT_SH += git-parse-remote.sh
 SCRIPT_SH += git-pull.sh
@@ -362,11 +362,13 @@ SCRIPT_SH += git-rebase--interactive.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-repack.sh
 SCRIPT_SH += git-request-pull.sh
-SCRIPT_SH += git-sh-setup.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
+SCRIPT_LIB_SH += git-mergetool--lib.sh
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
@@ -1488,6 +1490,15 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	chmod +x $@+ && \
 	mv $@+ $@
 
+$(patsubst %.sh,%,$(SCRIPT_LIB_SH)) : % : %.sh
+	$(QUIET_GEN)$(RM) $@ $@+ && \
+	sed -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
+	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
+	    -e $(BROKEN_PATH_FIX) \
+	    $@.sh >$@+ && \
+	mv $@+ $@
+
 ifndef NO_PERL
 $(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
 
@@ -1792,6 +1803,7 @@ install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) -m 644 $(SCRIPT_LIB_SH) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-archive$X git-shell$X git-cvsserver '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 ifndef NO_PERL
@@ -1901,7 +1913,7 @@ distclean: clean
 clean:
 	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o \
 		$(LIB_FILE) $(XDIFF_LIB)
-	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
+	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB_SH) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags cscope*
 	$(RM) -r autom4te.cache
@@ -1930,7 +1942,7 @@ endif
 ### Check documentation
 #
 check-docs::
-	@(for v in $(ALL_PROGRAMS) $(BUILT_INS) git gitk; \
+	@(for v in $(ALL_PROGRAMS) $(SCRIPT_LIB_SH) $(BUILT_INS) git gitk; \
 	do \
 		case "$$v" in \
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
@@ -1975,7 +1987,7 @@ check-docs::
 		documented,gittutorial-2 | \
 		sentinel,not,matching,is,ok ) continue ;; \
 		esac; \
-		case " $(ALL_PROGRAMS) $(BUILT_INS) git gitk " in \
+		case " $(ALL_PROGRAMS) $(SCRIPT_LIB_SH) $(BUILT_INS) git gitk " in \
 		*" $$cmd "*)	;; \
 		*) echo "removed but $$how: $$cmd" ;; \
 		esac; \
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
old mode 100755
new mode 100644
-- 
1.7.0.rc0
