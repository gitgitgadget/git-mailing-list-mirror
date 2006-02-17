From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/5] Optionally work without python
Date: Fri, 17 Feb 2006 15:24:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602171523510.24274@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Feb 17 15:24:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA6Wz-0000Yt-Q2
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 15:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWBQOYT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 09:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWBQOYT
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 09:24:19 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:35990 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751436AbWBQOYS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 09:24:18 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 209FC146B76; Fri, 17 Feb 2006 15:24:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 1461F9E0;
	Fri, 17 Feb 2006 15:24:17 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E4E1B146B76; Fri, 17 Feb 2006 15:24:16 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16349>


In some setups (notably server setups) you do not need that dependency.
Gracefully handle the absence of python when NO_PYTHON is defined.

Signed-off-by: Johannes E. Schindelin <Johannes.Schindelin@gmx.de>

---

 Makefile                     |    8 +++++++-
 git-merge.sh                 |    6 +++++-
 t/Makefile                   |    5 +++++
 t/t0000-basic.sh             |    2 ++
 t/t6021-merge-criss-cross.sh |    6 ++++++
 t/t6022-merge-rename.sh      |    6 ++++++
 t/test-lib.sh                |    2 ++
 7 files changed, 33 insertions(+), 2 deletions(-)

aa0aef85a93da00f3afbbed9105b45ad41b8427c
diff --git a/Makefile b/Makefile
index 7e1990b..1ee61e6 100644
--- a/Makefile
+++ b/Makefile
@@ -58,6 +58,8 @@ all:
 # Define NO_ACCURATE_DIFF if your diff program at least sometimes misses
 # a missing newline at the end of the file.
 #
+# Define NO_PYTHON if you want to loose all benefits of the recursive merge.
+#
 # Define COLLISION_CHECK below if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
 # sufficient guarantee that no collisions between objects will ever happen.
@@ -422,6 +424,9 @@ endif
 ifdef NO_ACCURATE_DIFF
 	ALL_CFLAGS += -DNO_ACCURATE_DIFF
 endif
+ifdef NO_PYTHON
+	TEST_DEFS += NO_PYTHON=YesPlease
+endif
 
 # Shell quote (do not use $(call) to accomodate ancient setups);
 
@@ -462,6 +467,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_QUOTED)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
+	    -e 's/@@NO_PYTHON@@/$(NO_PYTHON)/g' \
 	    $@.sh >$@
 	chmod +x $@
 
@@ -552,7 +558,7 @@ doc:
 ### Testing rules
 
 test: all
-	$(MAKE) -C t/ all
+	$(MAKE) -C t/ all $(TEST_DEFS)
 
 test-date$X: test-date.c date.o ctype.o
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) test-date.c date.o ctype.o
diff --git a/git-merge.sh b/git-merge.sh
index 74f0761..c0f53df 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -11,7 +11,11 @@ LF='
 '
 
 all_strategies='recursive octopus resolve stupid ours'
-default_strategies='recursive'
+if test -z "@@NO_PYTHON@@"; then
+	default_strategies='recursive'
+else
+	default_strategies='resolve'
+fi
 use_strategies=
 
 dropsave() {
diff --git a/t/Makefile b/t/Makefile
index d78404f..12e2c16 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -12,9 +12,14 @@ SHELL_PATH_QUOTED = '$(subst ','\'',$(SH
 
 T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 
+ifdef NO_PYTHON
+	GIT_TEST_OPTS += --no-python
+endif
+
 all: $(T) clean
 
 $(T):
+	echo $(SHELL_PATH_QUOTED) $@ $(GIT_TEST_OPTS)
 	@echo "*** $@ ***"; $(SHELL_PATH_QUOTED) $@ $(GIT_TEST_OPTS)
 
 clean:
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index c339a36..fe7f448 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -42,11 +42,13 @@ fi
 
 . ./test-lib.sh
 
+if test -z "$no_python"; then
 "$PYTHON" -c 'import subprocess' || {
 	echo >&2 'Your python seem to lack "subprocess" module.
 Please check INSTALL document.'
 	exit 1
 }
+fi
 
 ################################################################
 # init-db has been done in an empty repository.
diff --git a/t/t6021-merge-criss-cross.sh b/t/t6021-merge-criss-cross.sh
index e8606c7..2623813 100755
--- a/t/t6021-merge-criss-cross.sh
+++ b/t/t6021-merge-criss-cross.sh
@@ -10,6 +10,12 @@
 test_description='Test criss-cross merge'
 . ./test-lib.sh
 
+if test "$no_python"; then
+	echo "Skipping: no python => no recursive merge"
+	test_done
+	exit 0
+fi
+
 test_expect_success 'prepare repository' \
 'echo "1
 2
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 1292caf..a2d24b5 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -3,6 +3,12 @@
 test_description='Merge-recursive merging renames'
 . ./test-lib.sh
 
+if test "$no_python"; then
+	echo "Skipping: no python => no recursive merge"
+	test_done
+	exit 0
+fi
+
 test_expect_success setup \
 '
 cat >A <<\EOF &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7a58a86..43c8e55 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -63,6 +63,8 @@ do
 		exit 0 ;;
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
 		verbose=t; shift ;;
+	--no-python)
+		no_python=t; shift ;;
 	*)
 		break ;;
 	esac
-- 
1.2.1.g09fe-dirty
