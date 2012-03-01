From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4 v2] t4011: illustrate "diff-index -p" on stat-dirty paths
Date: Thu, 01 Mar 2012 08:52:34 -0800
Message-ID: <7vr4xcnu0d.fsf_-_@alter.siamese.dyndns.org>
References: <1330568057-27304-1-git-send-email-gitster@pobox.com>
 <1330568057-27304-3-git-send-email-gitster@pobox.com>
 <87399slmh4.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 01 17:52:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S39FE-00021R-Q1
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 17:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758126Ab2CAQwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 11:52:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33285 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757057Ab2CAQwi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 11:52:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2694D60F2;
	Thu,  1 Mar 2012 11:52:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h9Smzlr8zuHyEXJB5fcSiZIxJjs=; b=ElFyXS
	uK6R2Im23bB0jVvgWy8sbTqOd/ZsnJ8eBWz712bvOaLtYTDjkWfFHdJ7nn0nNmvu
	fbTSPihxc4gIfeLXJmOnrXnOMAbJMROeE/8hmckxQj9CO9BxlAiLegdzlB9mWYEW
	hqPQqW8O+nVzi3rO9YN4qt12MaW61VqD2GyBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kptbLsNbgHtPtLYzDHjPirFL5M1bBNcL
	SVMTcX91JGdSTQk0M/prw8n02aW9v0eTwXgG5Xgv5ak2cJwZSb76ZTS01OZUmPZ3
	tmHUX6kVdvUMuAdq6wW5eZhnImgFHdJgxbvmYJFB9hEZpCou+v1IxnhhH1eKCurt
	1W6EBRQDMiQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DEDB60F1;
	Thu,  1 Mar 2012 11:52:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C4F260F0; Thu,  1 Mar 2012
 11:52:36 -0500 (EST)
In-Reply-To: <87399slmh4.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 1 Mar 2012 10:05:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2B26C52-63BE-11E1-AE0C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191944>

The plumbing that looks at the working tree, i.e. "diff-index" and
"diff-files", always emit the "diff --git a/path b/path" header lines
without anything else for paths that are only stat-dirty (i.e. different
only because the cached stat information in the index no longer matches
that of the working tree, but the real contents are the same), when
these commands are run with "-p" option to produce patches.

Illustrate this current behaviour.  Also demonstrate that with the "-w"
option, we (correctly) hold off showing a "diff --git" header until actual
differences have been found.  This also suppresses the header for merely
stat-dirty files, which is inconsistent.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This time with test-chmtime to get rid of the annoying 3 second delay
   to invalidate the cached stat information.

 t/t4011-diff-symlink.sh |   46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index cb47ec1..164f153 100755
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
@@ -44,22 +52,38 @@ test_expect_success SYMLINKS 'diff removed symlink' '
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
+	rm -f frotz nitfol &&
+	echo xyzzy >nitfol &&
+	test-chmtime +10 nitfol &&
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
@@ -70,9 +94,17 @@ test_expect_success SYMLINKS 'diff different symlink' '
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
