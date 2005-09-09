From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/Patch] Tool rename fallout fix
Date: Thu, 08 Sep 2005 17:58:55 -0700
Message-ID: <7vll27rr8w.fsf@assigned-by-dhcp.cox.net>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 09 03:01:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDXEv-0001p7-NT
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 02:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbVIIA66 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 20:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbVIIA66
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 20:58:58 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:30851 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932520AbVIIA65 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2005 20:58:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050909005857.HJG7185.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Sep 2005 20:58:57 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8230>

Immediately after I updated the "master" branch with the tool
renames, I got a complaint from somebody telling me that the
things do not work anymore without 'make install'.

Strictly speaking, git has never worked fully without
installation because 'git' wrapper looked for things in the same
directory as it was in, which meant that 'git applymbox' would
not have worked anyway (it was coming from tools/applymbox until
recently), but on the other hand it certainly is nice if we can
run most of the things immediately after building but before
installing.

This patch attempts to remedy it.  What is helped the most is
that test scripts do not have to special case the scripts
anymore; obviously we do want to be able to run tests before
installing.  A downside is that your working tree after a build
has a lot more files than before.

As a side effect, you can specify non-standard path your Perl is
installed, and you can explicitly say "#!/usr/local/bin/bash".

Comments?


---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
git diff HEAD
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -142,6 +142,13 @@ ifeq ($(shell uname -s),SunOS)
 	PLATFORM_DEFINES += -DNO_GETDOMAINNAME=1
 endif
 
+ifndef SHELL_PATH
+	SHELL_PATH = /bin/sh
+endif
+ifndef PERL_PATH
+	PERL_PATH = /usr/bin/perl
+endif
+
 ifndef NO_OPENSSL
 	LIB_OBJS += epoch.o
 	OPENSSL_LIBSSL = -lssl
@@ -179,21 +186,32 @@ endif
 
 DEFINES += '-DSHA1_HEADER=$(SHA1_HEADER)'
 
-SCRIPTS = $(SCRIPT_SH) $(SCRIPT_PERL) gitk
+SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
+	  $(patsubst %.perl,%,$(SCRIPT_PERL)) gitk
 
 ### Build rules
 
-all: $(PROGRAMS) git.sh
+all: $(PROGRAMS) $(SCRIPTS)
 
 all:
 	$(MAKE) -C templates
 
-git.sh: git.sh.in Makefile
+git: git.sh Makefile
 	rm -f $@+ $@
-	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' <$@.in >$@+
+	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' <$@.sh >$@+
 	chmod +x $@+
 	mv $@+ $@
 
+$(filter-out git,$(patsubst %.sh,%,$(SCRIPT_SH))) : % : %.sh
+	rm -f $@
+	sed -e '1s|#!.*/sh|#!$(SHELL_PATH)|' $@.sh >$@
+	chmod +x $@
+
+$(patsubst %.perl,%,$(SCRIPT_PERL)) : % : %.perl
+	rm -f $@
+	sed -e '1s|#!.*perl|#!$(PERL_PATH)|' $@.perl >$@
+	chmod +x $@
+
 %.o: %.c
 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 %.o: %.S
@@ -250,19 +268,8 @@ check:
 
 install: $(PROGRAMS) $(SCRIPTS)
 	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
-	$(INSTALL) $(PROGRAMS) $(DESTDIR)$(bindir)
-	@for s in $(SCRIPTS); \
-	do \
-		case "$$s" in \
-		*.*) \
-			e=`expr "$$s" : '\(.*\)\.[^.]*$$'` ;; \
-		*) \
-			e="$$s" ;; \
-		esac && \
-		echo ": install $$s $(DESTDIR)$(bindir)/$$e" && \
-		$(INSTALL) $$s $(DESTDIR)$(bindir)/$$e || exit; \
-	done
-	$(INSTALL) git-revert.sh $(DESTDIR)$(bindir)/git-cherry-pick
+	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(DESTDIR)$(bindir)
+	$(INSTALL) git-revert $(DESTDIR)$(bindir)/git-cherry-pick
 	sh ./cmd-rename.sh $(DESTDIR)$(bindir)
 	$(MAKE) -C templates install
 
@@ -299,7 +306,8 @@ deb: dist
 
 clean:
 	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROGRAMS) $(LIB_FILE)
-	rm -f git-core.spec git.sh
+	rm -f $(filter-out gitk,$(SCRIPTS))
+	rm -f git-core.spec
 	rm -rf $(GIT_TARNAME)
 	rm -f $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	rm -f git-core_$(GIT_VERSION)-*.deb git-core_$(GIT_VERSION)-*.dsc
diff --git a/git.sh.in b/git.sh
similarity index 100%
rename from git.sh.in
rename to git.sh
diff --git a/t/t1005-read-tree-m-2way-emu23.sh b/t/t1005-read-tree-m-2way-emu23.sh
--- a/t/t1005-read-tree-m-2way-emu23.sh
+++ b/t/t1005-read-tree-m-2way-emu23.sh
@@ -25,7 +25,7 @@ In the test, these paths are used:
 read_tree_twoway () {
     git-read-tree --emu23 "$1" "$2" &&
     git-ls-files --stage &&
-    git-merge-index ../../git-merge-one-file.sh -a &&
+    git-merge-index git-merge-one-file -a &&
     git-ls-files --stage
 }
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -13,12 +13,12 @@ handled.  Specifically, that a bogus bra
 test_expect_success \
     'prepare an trivial repository' \
     'echo Hello > A &&
-     ../../git-update-index --add A &&
-     ../../git-commit.sh -m "Initial commit."'
+     git-update-index --add A &&
+     git-commit -m "Initial commit."'
 
 test_expect_failure \
     'git branch --help should return error code' \
-    '../../git-branch.sh --help'
+    'git-branch --help'
 
 test_expect_failure \
     'git branch --help should not have created a bogus branch' \
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -21,9 +21,9 @@ test_expect_success setup '
 	    parent=$commit || return 1
 	done &&
 	echo "$commit" >.git/HEAD &&
-	git-clone.sh -l ./. victim &&
+	git-clone -l ./. victim &&
 	cd victim &&
-	git-log.sh &&
+	git-log &&
 	cd .. &&
 	echo $zero >.git/HEAD &&
 	parent=$zero &&
@@ -35,7 +35,7 @@ test_expect_success setup '
 	done &&
 	echo "$commit" >.git/HEAD &&
 	echo Rebase &&
-	git-log.sh'
+	git-log'
 
 test_expect_success \
         'pushing rewound head should not barf but require --force' ' 
