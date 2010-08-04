From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] tests: A new test prereq for testing chmod -w as root
Date: Wed,  4 Aug 2010 15:00:26 +0000
Message-ID: <1280934026-25658-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 04 17:00:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgfSe-0001RI-Vx
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 17:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932985Ab0HDPAr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 11:00:47 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59459 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932966Ab0HDPAq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 11:00:46 -0400
Received: by wwj40 with SMTP id 40so6546242wwj.1
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=XZ+zLlu6lPzVvrHQOXQr6iIv1i1GUrbLvRLAEsU2Zpo=;
        b=Ohgi2AmuOmzgNbSPqRyg4pF+Hiv+UjSatcQsQ6srAFr2XV2VdPvmamcosUQ0fwbMEP
         WNwnI+cDkzWM0QCrvqf0bfGtBMQLqrG2Qy1jZNSFjKdqBslVUHdIXpVPyME5IZnqrxwb
         nkNFR1XoJmAQUOcf0PtSQpp16SIlKniSYTB5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=BpH2CGZEHp0mW5sjoI/JDEHRT4UBIN5s0AqeiNnvZB2f6gjg03UvqMMISEhHeb07wF
         ET2ZYh81V+/yTwks8ZvJ58c9jJhN4SVG1vpsbMoE3/vZf098eH3oJuAlUFc8zKedM/ER
         RQZOXdyvbxk+KGUzA5kere5E/kMuOmPgehWG4=
Received: by 10.216.234.132 with SMTP id s4mr2236453weq.0.1280934044833;
        Wed, 04 Aug 2010 08:00:44 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e8sm4369735wej.46.2010.08.04.08.00.39
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Aug 2010 08:00:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152582>

Some tests depend on not being able to read files after chmod -w. This
doesn't work when running the tests as root.

Change test-lib.sh to test if this works, and if so it sets a new
CHMOD_0000 test prerequisite. The tests that use this previously
failed when run under root.

There was already a test for this in t3600-rm.sh added by Junio C
Hamano in 2283645b85 in 2006. That check now uses the new CHMOD_0000
prerequisite.

There are also two other prerequisites, "POSIXPERM_AND_CHMOD_0000" and
"SYMLINKS_AND_CHMOD_0000". They're being used for tests that failed
and already depended on POSIXPERM or SYMLINKS. They're possibly
redundant, but I don't have access to a system without POSIX
permissions or symlinks so I couldn't test that.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t0001-init.sh             |    2 +-
 t/t0004-unwritable.sh       |    8 ++++----
 t/t1004-read-tree-m-u-wf.sh |    2 +-
 t/t3600-rm.sh               |   16 ----------------
 t/t3700-add.sh              |   10 +++++-----
 t/t7300-clean.sh            |    7 +++----
 t/t7508-status.sh           |    2 +-
 t/test-lib.sh               |   14 ++++++++++++++
 8 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 7c0a698..7c62582 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -301,7 +301,7 @@ test_expect_success 'init notices EEXIST (2)' '
 	)
 '
=20
-test_expect_success POSIXPERM 'init notices EPERM' '
+test_expect_success POSIXPERM_AND_CHMOD_0000 'init notices EPERM' '
 	rm -fr newdir &&
 	(
 		mkdir newdir &&
diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index 2342ac5..1299f52 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -15,7 +15,7 @@ test_expect_success setup '
=20
 '
=20
-test_expect_success POSIXPERM 'write-tree should notice unwritable rep=
ository' '
+test_expect_success POSIXPERM_AND_CHMOD_0000 'write-tree should notice=
 unwritable repository' '
=20
 	(
 		chmod a-w .git/objects .git/objects/?? &&
@@ -27,7 +27,7 @@ test_expect_success POSIXPERM 'write-tree should noti=
ce unwritable repository' '
=20
 '
=20
-test_expect_success POSIXPERM 'commit should notice unwritable reposit=
ory' '
+test_expect_success POSIXPERM_AND_CHMOD_0000 'commit should notice unw=
ritable repository' '
=20
 	(
 		chmod a-w .git/objects .git/objects/?? &&
@@ -39,7 +39,7 @@ test_expect_success POSIXPERM 'commit should notice u=
nwritable repository' '
=20
 '
=20
-test_expect_success POSIXPERM 'update-index should notice unwritable r=
epository' '
+test_expect_success POSIXPERM_AND_CHMOD_0000 'update-index should noti=
ce unwritable repository' '
=20
 	(
 		echo 6O >file &&
@@ -52,7 +52,7 @@ test_expect_success POSIXPERM 'update-index should no=
tice unwritable repository'
=20
 '
=20
-test_expect_success POSIXPERM 'add should notice unwritable repository=
' '
+test_expect_success POSIXPERM_AND_CHMOD_0000 'add should notice unwrit=
able repository' '
=20
 	(
 		echo b >file &&
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index f19b4a2..ceb0fd4 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -177,7 +177,7 @@ test_expect_success SYMLINKS 'funny symlink in work=
 tree' '
=20
 '
=20
-test_expect_success SYMLINKS 'funny symlink in work tree, un-unlink-ab=
le' '
+test_expect_success SYMLINKS_AND_CHMOD_0000 'funny symlink in work tre=
e, un-unlink-able' '
=20
 	rm -fr a b &&
 	git reset --hard &&
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index b514cbb..b26cabd 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -28,22 +28,6 @@ embedded' &&
      git commit -m 'add files with tabs and newlines'
 "
=20
-# Determine rm behavior
-# Later we will try removing an unremovable path to make sure
-# git rm barfs, but if the test is run as root that cannot be
-# arranged.
-: >test-file
-chmod a-w .
-rm -f test-file 2>/dev/null
-if test -f test-file
-then
-	test_set_prereq RO_DIR
-else
-	skip_all=3D'skipping removal failure test (perhaps running as root?)'
-fi
-chmod 775 .
-rm -f test-file
-
 test_expect_success \
     'Pre-check that foo exists and is in index before git rm foo' \
     '[ -f foo ] && git ls-files --error-unmatch foo'
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 7d7140d..a0f3e7c 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -179,7 +179,7 @@ test_expect_success 'git add --refresh' '
 	test -z "`git diff-index HEAD -- foo`"
 '
=20
-test_expect_success POSIXPERM 'git add should fail atomically upon an =
unreadable file' '
+test_expect_success POSIXPERM_AND_CHMOD_0000 'git add should fail atom=
ically upon an unreadable file' '
 	git reset --hard &&
 	date >foo1 &&
 	date >foo2 &&
@@ -190,7 +190,7 @@ test_expect_success POSIXPERM 'git add should fail =
atomically upon an unreadable
=20
 rm -f foo2
=20
-test_expect_success POSIXPERM 'git add --ignore-errors' '
+test_expect_success POSIXPERM_AND_CHMOD_0000 'git add --ignore-errors'=
 '
 	git reset --hard &&
 	date >foo1 &&
 	date >foo2 &&
@@ -201,7 +201,7 @@ test_expect_success POSIXPERM 'git add --ignore-err=
ors' '
=20
 rm -f foo2
=20
-test_expect_success POSIXPERM 'git add (add.ignore-errors)' '
+test_expect_success POSIXPERM_AND_CHMOD_0000 'git add (add.ignore-erro=
rs)' '
 	git config add.ignore-errors 1 &&
 	git reset --hard &&
 	date >foo1 &&
@@ -212,7 +212,7 @@ test_expect_success POSIXPERM 'git add (add.ignore-=
errors)' '
 '
 rm -f foo2
=20
-test_expect_success POSIXPERM 'git add (add.ignore-errors =3D false)' =
'
+test_expect_success POSIXPERM_AND_CHMOD_0000 'git add (add.ignore-erro=
rs =3D false)' '
 	git config add.ignore-errors 0 &&
 	git reset --hard &&
 	date >foo1 &&
@@ -223,7 +223,7 @@ test_expect_success POSIXPERM 'git add (add.ignore-=
errors =3D false)' '
 '
 rm -f foo2
=20
-test_expect_success POSIXPERM '--no-ignore-errors overrides config' '
+test_expect_success POSIXPERM_AND_CHMOD_0000 '--no-ignore-errors overr=
ides config' '
        git config add.ignore-errors 1 &&
        git reset --hard &&
        date >foo1 &&
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 7d8ed68..5533973 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -388,16 +388,15 @@ test_expect_success 'core.excludesfile' '
=20
 '
=20
-test_expect_success 'removal failure' '
+test_expect_success CHMOD_0000 'removal failure' '
=20
 	mkdir foo &&
 	touch foo/bar &&
 	(exec <foo/bar &&
 	 chmod 0 foo &&
-	 test_must_fail git clean -f -d)
-
+	 test_must_fail git clean -f -d &&
+	 chmod 755 foo)
 '
-chmod 755 foo
=20
 test_expect_success 'nested git work tree' '
 	rm -fr foo bar &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index a72fe3a..4f85db5 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -793,7 +793,7 @@ test_expect_success 'commit --dry-run submodule sum=
mary (--amend)' '
 	test_cmp expect output
 '
=20
-test_expect_success POSIXPERM 'status succeeds in a read-only reposito=
ry' '
+test_expect_success POSIXPERM_AND_CHMOD_0000 'status succeeds in a rea=
d-only repository' '
 	(
 		chmod a-w .git &&
 		# make dir1/tracked stat-dirty
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e8f21d5..41052fb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -886,3 +886,17 @@ test -z "$NO_PYTHON" && test_set_prereq PYTHON
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYML=
INKS
 rm -f y
+
+# test whether we can make read-only files
+mkdir hla
+chmod -w hla
+touch hla/gh >/dev/null 2>&1
+if ! test -f hla/gh
+then
+    test_set_prereq CHMOD_0000
+    # A hack around not being able to supply more than one
+    # prerequisite in the test_* functions.
+    test_have_prereq POSIXPERM && test_set_prereq POSIXPERM_AND_CHMOD_=
0000
+    test_have_prereq SYMLINKS  && test_set_prereq SYMLINKS_AND_CHMOD_0=
000
+fi
+rm -rf hla
--=20
1.7.1
