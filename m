From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t4019 "grep" portability fix
Date: Sat, 26 Dec 2009 13:53:17 -0800
Message-ID: <7vvdftxv02.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 26 22:54:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOeb0-0005Qp-7m
	for gcvg-git-2@lo.gmane.org; Sat, 26 Dec 2009 22:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbZLZVx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Dec 2009 16:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbZLZVx1
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Dec 2009 16:53:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbZLZVx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2009 16:53:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 36A89AA40E;
	Sat, 26 Dec 2009 16:53:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=P7Hx
	M3JdJIouKVl8sL1+NgxNoNw=; b=KUfVEhH9hFilsc/DfUvO9YQWDUBnUWx/9v0v
	B+G9rvvoqxqXJro3xwQMnFq3/jsGGhRsMwwk5pLL12iYXGJKvnMHPjewbRIYgy2s
	0v+Uo/hopmh+ivo9iC7B6rAO4M/ljrWtCGXK4Rmh6FHFOL/srC+22RDSyQ7sRHqC
	gRvtOe8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=g1E
	dVuoi6vkXRWwG2cmQzTM248bPqPj6a1WUsW57PTsp2e3n1hJmOzc6BledU0L1CHG
	LZdOA9Rqxv16y8y7BnV6b6dAVuECxn6BoC8zh0DI3/WJ6fFPeQEcyJsJdQi34EL7
	DnW6jzpVtZ5gXN3De/p2fe6tdw4Q7LmvmJ8FP86E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 240FCAA40D;
	Sat, 26 Dec 2009 16:53:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1A0FCAA40C; Sat, 26 Dec 2009
 16:53:19 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 15EDA8CC-F269-11DE-B02D-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135694>

Input to "grep" is supposed to be "text", but we deliberately feed output
from "git diff --color" to sift it into two sets of lines (ones with
errors, the other without).  Some implementations of "grep" only report
matches with the exit status, without showing the matched lines in their
output (e.g. OpenBSD 4.6, which says "Binary file .. matches").

Fortunately, "grep -a" is often a way to force the command to treat its
input as text.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4019-diff-wserror.sh |   56 +++++++++++++++++++++++-----------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index 3a3663f..f6d1f1e 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -20,11 +20,27 @@ test_expect_success setup '
 
 blue_grep='7;34m' ;# ESC [ 7 ; 3 4 m
 
+printf "\033[%s" "$blue_grep" >check-grep
+if (grep "$blue_grep" <check-grep | grep "$blue_grep") >/dev/null 2>&1
+then
+	grep_a=grep
+elif (grep -a "$blue_grep" <check-grep | grep -a "$blue_grep") >/dev/null 2>&1
+then
+	grep_a='grep -a'
+else
+	grep_a=grep ;# expected to fail...
+fi
+rm -f check-grep
+
+prepare_output () {
+	git diff --color >output
+	$grep_a "$blue_grep" output >error
+	$grep_a -v "$blue_grep" output >normal
+}
+
 test_expect_success default '
 
-	git diff --color >output
-	grep "$blue_grep" output >error
-	grep -v "$blue_grep" output >normal
+	prepare_output
 
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -37,9 +53,7 @@ test_expect_success default '
 test_expect_success 'without -trail' '
 
 	git config core.whitespace -trail
-	git diff --color >output
-	grep "$blue_grep" output >error
-	grep -v "$blue_grep" output >normal
+	prepare_output
 
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -53,9 +67,7 @@ test_expect_success 'without -trail (attribute)' '
 
 	git config --unset core.whitespace
 	echo "F whitespace=-trail" >.gitattributes
-	git diff --color >output
-	grep "$blue_grep" output >error
-	grep -v "$blue_grep" output >normal
+	prepare_output
 
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -69,9 +81,7 @@ test_expect_success 'without -space' '
 
 	rm -f .gitattributes
 	git config core.whitespace -space
-	git diff --color >output
-	grep "$blue_grep" output >error
-	grep -v "$blue_grep" output >normal
+	prepare_output
 
 	grep Eight normal >/dev/null &&
 	grep HT normal >/dev/null &&
@@ -85,9 +95,7 @@ test_expect_success 'without -space (attribute)' '
 
 	git config --unset core.whitespace
 	echo "F whitespace=-space" >.gitattributes
-	git diff --color >output
-	grep "$blue_grep" output >error
-	grep -v "$blue_grep" output >normal
+	prepare_output
 
 	grep Eight normal >/dev/null &&
 	grep HT normal >/dev/null &&
@@ -101,9 +109,7 @@ test_expect_success 'with indent-non-tab only' '
 
 	rm -f .gitattributes
 	git config core.whitespace indent,-trailing,-space
-	git diff --color >output
-	grep "$blue_grep" output >error
-	grep -v "$blue_grep" output >normal
+	prepare_output
 
 	grep Eight error >/dev/null &&
 	grep HT normal >/dev/null &&
@@ -117,9 +123,7 @@ test_expect_success 'with indent-non-tab only (attribute)' '
 
 	git config --unset core.whitespace
 	echo "F whitespace=indent,-trailing,-space" >.gitattributes
-	git diff --color >output
-	grep "$blue_grep" output >error
-	grep -v "$blue_grep" output >normal
+	prepare_output
 
 	grep Eight error >/dev/null &&
 	grep HT normal >/dev/null &&
@@ -133,9 +137,7 @@ test_expect_success 'with cr-at-eol' '
 
 	rm -f .gitattributes
 	git config core.whitespace cr-at-eol
-	git diff --color >output
-	grep "$blue_grep" output >error
-	grep -v "$blue_grep" output >normal
+	prepare_output
 
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -149,9 +151,7 @@ test_expect_success 'with cr-at-eol (attribute)' '
 
 	git config --unset core.whitespace
 	echo "F whitespace=trailing,cr-at-eol" >.gitattributes
-	git diff --color >output
-	grep "$blue_grep" output >error
-	grep -v "$blue_grep" output >normal
+	prepare_output
 
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -195,7 +195,7 @@ test_expect_success 'color new trailing blank lines' '
 	git add x &&
 	{ echo a; echo; echo; echo; echo c; echo; echo; echo; echo; } >x &&
 	git diff --color x >output &&
-	cnt=$(grep "${blue_grep}" output | wc -l) &&
+	cnt=$($grep_a "${blue_grep}" output | wc -l) &&
 	test $cnt = 2
 '
 
