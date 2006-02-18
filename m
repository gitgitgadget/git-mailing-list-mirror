From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/5] Optionally work without python
Date: Sat, 18 Feb 2006 13:01:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602181257330.2993@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0602171523510.24274@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvevdtb2j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 13:01:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAQmM-0004d2-C0
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 13:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWBRMBU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 07:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWBRMBU
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 07:01:20 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:56724 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750805AbWBRMBT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 07:01:19 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6537F1461A5; Sat, 18 Feb 2006 13:01:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 5684310B1;
	Sat, 18 Feb 2006 13:01:18 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2193E1461A5; Sat, 18 Feb 2006 13:01:18 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvevdtb2j.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16409>


In some setups (notably server setups) you do not need that dependency.
Gracefully handle the absence of python when NO_PYTHON is defined.

Signed-off-by: Johannes E. Schindelin <Johannes.Schindelin@gmx.de>

---

	On Fri, 17 Feb 2006, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > +ifdef NO_PYTHON
	> > +	TEST_DEFS += NO_PYTHON=YesPlease
	> > +endif
	> 
	> I wonder if there is a better way to do this.  All future
	> NO_BLAH that may affect tests need to have something like this
	> otherwise.

	There is: Just an "export". This defines all variables in a 
	sub-make. However, if you do that, the environment gets quite 
	large, and some programs crash, notably xargs on the box I tested.
	So, for now, use "export NO_PYTHON".

	> > -default_strategies='recursive'
	> > +if test -z "@@NO_PYTHON@@"; then
	> > +	default_strategies='recursive'
	> > +else
	> > +	default_strategies='resolve'
	> > +fi
	> 
	> Somebody commented on this part to make it shorter...

	Fixed.

	> I'll take 2, 3, and 4 from this series for now.  They will
	> appear in "next".  Thanks.

	Thank you!

 Makefile                     |    9 +++++++++
 git-merge.sh                 |    4 ++++
 t/Makefile                   |    6 ++++
 t/t0000-basic.sh             |    2 +-
 t/t6021-merge-criss-cross.sh |    6 ++++++
 t/t6022-merge-rename.sh      |    6 ++++++
 t/test-lib.sh                |    2 ++
 7 files changed, 32 insertions(+), 1 deletions(-)

b7c435d3d594c9826e4297ee8b0353d27ef8c5b0
diff --git a/Makefile b/Makefile
index d59eede..685b714 100644
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
@@ -460,6 +462,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_QUOTED)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
+	    -e 's/@@NO_PYTHON@@/$(NO_PYTHON)/g' \
 	    $@.sh >$@
 	chmod +x $@
 
@@ -548,6 +551,12 @@ doc:
 
 
 ### Testing rules
+
+# GNU make supports exporting all variables by "export" without parameters.
+# However, the environment gets quite big, and some programs have problems
+# with that.
+
+export NO_PYTHON
 
 test: all
 	$(MAKE) -C t/ all
diff --git a/git-merge.sh b/git-merge.sh
index 74f0761..a05eeb2 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -13,6 +13,10 @@ LF='
 all_strategies='recursive octopus resolve stupid ours'
 default_strategies='recursive'
 use_strategies=
+if test "@@NO_PYTHON@@"; then
+	all_strategies='resolve octopus stupid ours'
+	default_strategies='resolve'
+fi
 
 dropsave() {
 	rm -f -- "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/MERGE_MSG" \
diff --git a/t/Makefile b/t/Makefile
index e7e4229..4e89d23 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -12,10 +12,14 @@ SHELL_PATH_QUOTED = $(subst ','\'',$(SHE
 
 T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 
+ifdef NO_PYTHON
+	GIT_TEST_OPTS += --no-python
+endif
+
 all: $(T) clean
 
 $(T):
	@echo "*** $@ ***"; '$(SHELL_PATH_QUOTED)' $@ $(GIT_TEST_OPTS)
 
 clean:
 	rm -fr trash
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index c339a36..6729a18 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -42,7 +42,7 @@ fi
 
 . ./test-lib.sh
 
-"$PYTHON" -c 'import subprocess' || {
+test "$no_python" || "$PYTHON" -c 'import subprocess' || {
 	echo >&2 'Your python seem to lack "subprocess" module.
 Please check INSTALL document.'
 	exit 1
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
1.2.1.g05ee-dirty
