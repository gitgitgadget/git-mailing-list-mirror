From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] diff: --ignore-case
Date: Sun, 19 Feb 2012 18:16:28 -0800
Message-ID: <1329704188-9955-6-git-send-email-gitster@pobox.com>
References: <1329704188-9955-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 03:16:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzIoB-0007vG-9f
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 03:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410Ab2BTCQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Feb 2012 21:16:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59466 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212Ab2BTCQk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2012 21:16:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08A9B77EA
	for <git@vger.kernel.org>; Sun, 19 Feb 2012 21:16:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=YVxh
	i0xByL3kbnISx4STmJsshsI=; b=gYJjjCHk9JuEAjVpT7Hw68fOecAt4nGO0OAI
	nAb6f6BSlyIUoAOu58dO/371AKEZYmIF3JqQLOOVI5VwGj4l+EkRr6aJsNTLn7I7
	p/vuc0riLDOcqrdpck19WQdJMGKZwCtI5A9nzFXXihXcbVED1biCFUO0ZZTdCsI5
	ilqZ8PA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=hlYHrC
	Fnc1E30IHpLExSjU0ebBn3RJ8w1Ga4qfX1JU03MEzoiJ9jy8ZoDWgtAWSrdp2Y8C
	CYgl0dZM3TJh+VCFyrlhtp5w+KenTvngX/CNH2VqEJL+URXdSKAwkdNdmVcFb1J6
	prtufdXVpbzQ3qbAYgHD29fztojbpD5OWenL0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFD1677E9
	for <git@vger.kernel.org>; Sun, 19 Feb 2012 21:16:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4086377E7 for
 <git@vger.kernel.org>; Sun, 19 Feb 2012 21:16:39 -0500 (EST)
X-Mailer: git-send-email 1.7.9.1.265.g25f75
In-Reply-To: <1329704188-9955-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EC0B9DFA-5B68-11E1-A09B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191039>

Teach the front-end to flip XDF_IGNORE_CASE bit with the options GNU diff
uses.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt |    4 ++++
 diff.c                         |    2 ++
 t/lib-diff-alternative.sh      |   45 ++++++++++++++++++++++++++++++++++++++--
 t/t4033-diff-patience.sh       |    6 ++++++
 t/t4050-diff-histogram.sh      |    2 ++
 5 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9f7cba2..791e07f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -404,6 +404,10 @@ endif::git-format-patch[]
 	differences even if one line has whitespace where the other
 	line has none.
 
+--ignore-case::
+	Ignore changes in case only; only ASCII alphabet is supported for
+	now.
+
 --inter-hunk-context=<lines>::
 	Show the context between diff hunks, up to the specified number
 	of lines, thereby fusing hunks that are close to each other.
diff --git a/diff.c b/diff.c
index 87b2ec1..d7604b7 100644
--- a/diff.c
+++ b/diff.c
@@ -3399,6 +3399,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_CHANGE);
 	else if (!strcmp(arg, "--ignore-space-at-eol"))
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
+	else if (!strcmp(arg, "--ignore-case"))
+		DIFF_XDL_SET(options, IGNORE_CASE);
 	else if (!strcmp(arg, "--patience"))
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
 	else if (!strcmp(arg, "--histogram"))
diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
index 75ffd91..45c665e 100644
--- a/t/lib-diff-alternative.sh
+++ b/t/lib-diff-alternative.sh
@@ -104,8 +104,9 @@ EOF
 
 	STRATEGY=$1
 
+	cmd='git diff --no-index'
 	test_expect_success "$STRATEGY diff" '
-		test_must_fail git diff --no-index "--$STRATEGY" file1 file2 > output &&
+		test_must_fail $cmd ${STRATEGY:+"--$STRATEGY"} file1 file2 >output &&
 		test_cmp expect output
 	'
 
@@ -157,9 +158,49 @@ EOF
 
 	STRATEGY=$1
 
+	cmd='git diff --no-index'
 	test_expect_success 'completely different files' '
-		test_must_fail git diff --no-index "--$STRATEGY" uniq1 uniq2 > output &&
+
+		test_must_fail $cmd  ${STRATEGY:+"--$STRATEGY"} uniq1 uniq2 >output &&
 		test_cmp expect output
 	'
 }
 
+test_diff_ignore () {
+
+	STRATEGY=$1
+
+	echo "A quick brown fox" >test.0
+	echo "A  quick brown fox" >test-b
+	echo " A quick brownfox" >test-w
+	echo "A quick brown fox " >test--ignore-space-at-eol
+	echo "A Quick Brown Fox" >test--ignore-case
+	echo "A Quick  Brown Fox" >test--ignore-case-b
+	echo "A quick brown fox jumps" >test
+	cases="-b -w --ignore-space-at-eol --ignore-case"
+
+	if test -z "$STRATEGY"
+	then
+		label=baseline
+	else
+		label=$STRATEGY
+	fi
+
+	cmd="git diff --no-index ${STRATEGY:+--$STRATEGY}"
+
+	test_expect_success "$label diff" '
+		test_must_fail $cmd test.0 test
+	'
+	for case in $cases
+	do
+		test_expect_success "$label diff $case" '
+			$cmd $case test.0 test$case &&
+			test_must_fail $cmd test.0 test
+		'
+	done
+
+	test_expect_success "$label diff -b --ignore-case" '
+		$cmd -b --ignore-case test.0 test--ignore-case-b
+	'
+
+}
diff --git a/t/t4033-diff-patience.sh b/t/t4033-diff-patience.sh
index 3c9932e..c7f8c6c 100755
--- a/t/t4033-diff-patience.sh
+++ b/t/t4033-diff-patience.sh
@@ -5,8 +5,14 @@ test_description='patience diff algorithm'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-alternative.sh
 
+# baseline
+test_diff_unique ""
+test_diff_ignore ""
+
 test_diff_frobnitz "patience"
 
 test_diff_unique "patience"
 
+test_diff_ignore "patience"
+
 test_done
diff --git a/t/t4050-diff-histogram.sh b/t/t4050-diff-histogram.sh
index fd3e86a..98c6686 100755
--- a/t/t4050-diff-histogram.sh
+++ b/t/t4050-diff-histogram.sh
@@ -9,4 +9,6 @@ test_diff_frobnitz "histogram"
 
 test_diff_unique "histogram"
 
+test_diff_ignore "histogram"
+
 test_done
-- 
1.7.9.1.265.g25f75
