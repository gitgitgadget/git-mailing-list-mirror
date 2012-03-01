From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] t4011: illustrate "diff-index -p" on stat-dirty paths
Date: Wed, 29 Feb 2012 18:14:15 -0800
Message-ID: <1330568057-27304-3-git-send-email-gitster@pobox.com>
References: <1330568057-27304-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 03:14:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2vXX-00040Z-1x
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 03:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441Ab2CACO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 21:14:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63745 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757239Ab2CACOY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 21:14:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E7A67D58
	for <git@vger.kernel.org>; Wed, 29 Feb 2012 21:14:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ReLL
	XUcWPt7ljcj76xf9dLajKZA=; b=ueYvG9g0k3R0NizX2Kb/mct9CHyhn812OIfX
	mJRsGtk1ieYaq44rvWEqdOSyPQQQuEwUu1OdUFucN8Eox+Wex2Axp7mw8XcHKxl9
	IqrPXtKffuQie/gDptsnkCsPPD/+vXB3zewT+NtKj/3kzR3wavNYfdZamGn9Ch1V
	c0CAid0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=tE5kZG
	AQGCLMctA257JsmMsfxccjfkIsIY1ktpGbY88OTREbPZzPxTOgxU80VsSELqvoLq
	v9KF1BRuIuUR3fknLqpRXbqVHMUCyEluKESGhv1ZWVXellPddpUE1NNph+b/lE9F
	wAmTOVWcqWCLrkQ9bpVtJplYi1Xah/H9oQ27Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 851757D57
	for <git@vger.kernel.org>; Wed, 29 Feb 2012 21:14:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C491C7D55 for
 <git@vger.kernel.org>; Wed, 29 Feb 2012 21:14:22 -0500 (EST)
X-Mailer: git-send-email 1.7.9.2.350.g74d65
In-Reply-To: <1330568057-27304-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 42D770EA-6344-11E1-9ADD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191889>

The plumbing that looks at the working tree, i.e. "diff-index" and
"diff-files", always emit the "diff --git a/path b/path" header lines
without anything else for paths that are only stat-dirty (i.e. different
only because the cached stat information in the index no longer matches
that of the working tree, but the real contents are the same), when
these commands are run with "-p" option to produce patches.

Illustrate this current behaviour.  The new part that uses "-w" option
demonstrates that we do not show any "diff --git" header for blobs whose
true contents are different but compares the same when whitespaces are
ignored, which is inconsistent with the behaviour for stat-dirty paths.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4011-diff-symlink.sh |   47 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index cb47ec1..6097e19 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -9,7 +9,7 @@ test_description='Test diff of symlinks.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
 
-test_expect_success SYMLINKS 'diff new symlink' '
+test_expect_success SYMLINKS 'diff new symlink and file' '
 	cat >expected <<-\EOF &&
 	diff --git a/frotz b/frotz
 	new file mode 120000
@@ -19,22 +19,30 @@ test_expect_success SYMLINKS 'diff new symlink' '
 	@@ -0,0 +1 @@
 	+xyzzy
 	\ No newline at end of file
+	diff --git a/nitfol b/nitfol
+	new file mode 100644
+	index 0000000..7c465af
+	--- /dev/null
+	+++ b/nitfol
+	@@ -0,0 +1 @@
+	+xyzzy
 	EOF
 	ln -s xyzzy frotz &&
+	echo xyzzy >nitfol &&
 	git update-index &&
 	tree=$(git write-tree) &&
-	git update-index --add frotz &&
+	git update-index --add frotz nitfol &&
 	GIT_DIFF_OPTS=--unified=0 git diff-index -M -p $tree >current &&
 	compare_diff_patch expected current
 '
 
-test_expect_success SYMLINKS 'diff unchanged symlink'  '
+test_expect_success SYMLINKS 'diff unchanged symlink and file'  '
 	tree=$(git write-tree) &&
-	git update-index frotz &&
+	git update-index frotz nitfol &&
 	test -z "$(git diff-index --name-only $tree)"
 '
 
-test_expect_success SYMLINKS 'diff removed symlink' '
+test_expect_success SYMLINKS 'diff removed symlink and file' '
 	cat >expected <<-\EOF &&
 	diff --git a/frotz b/frotz
 	deleted file mode 120000
@@ -44,22 +52,39 @@ test_expect_success SYMLINKS 'diff removed symlink' '
 	@@ -1 +0,0 @@
 	-xyzzy
 	\ No newline at end of file
+	diff --git a/nitfol b/nitfol
+	deleted file mode 100644
+	index 7c465af..0000000
+	--- a/nitfol
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-xyzzy
 	EOF
 	mv frotz frotz2 &&
+	mv nitfol nitfol2 &&
 	git diff-index -M -p $tree >current &&
 	compare_diff_patch expected current
 '
 
-test_expect_success SYMLINKS 'diff identical, but newly created symlink' '
+test_expect_success SYMLINKS 'diff identical, but newly created symlink and file' '
 	cat >expected <<-\EOF &&
 	diff --git a/frotz b/frotz
+	diff --git a/nitfol b/nitfol
 	EOF
+	sleep 3 &&
+	rm -f frotz &&
+	echo xyzzy >nitfol3 &&
+	mv nitfol3 nitfol &&
 	ln -s xyzzy frotz &&
 	git diff-index -M -p $tree >current &&
+	compare_diff_patch expected current &&
+
+	>expected &&
+	git diff-index -M -p -w $tree >current &&
 	compare_diff_patch expected current
 '
 
-test_expect_success SYMLINKS 'diff different symlink' '
+test_expect_success SYMLINKS 'diff different symlink and file' '
 	cat >expected <<-\EOF &&
 	diff --git a/frotz b/frotz
 	index 7c465af..df1db54 120000
@@ -70,9 +95,17 @@ test_expect_success SYMLINKS 'diff different symlink' '
 	\ No newline at end of file
 	+yxyyz
 	\ No newline at end of file
+	diff --git a/nitfol b/nitfol
+	index 7c465af..df1db54 100644
+	--- a/nitfol
+	+++ b/nitfol
+	@@ -1 +1 @@
+	-xyzzy
+	+yxyyz
 	EOF
 	rm -f frotz &&
 	ln -s yxyyz frotz &&
+	echo yxyyz >nitfol &&
 	git diff-index -M -p $tree >current &&
 	compare_diff_patch expected current
 '
-- 
1.7.9.2.350.g74d65
