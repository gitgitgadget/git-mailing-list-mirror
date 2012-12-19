From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t4014: fix arguments to grep
Date: Tue, 18 Dec 2012 19:20:55 -0800
Message-ID: <7vpq26d8x4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 04:21:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlAEF-0000XX-UP
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 04:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853Ab2LSDU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 22:20:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42084 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752337Ab2LSDU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 22:20:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19618A7CF;
	Tue, 18 Dec 2012 22:20:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=l
	JhYX27igS1ek09kUP19es244FI=; b=En3ZZ9jmpYyVwwfqlWkFhb9vEb/fS+Bn2
	jdBSSclvpqCr9kCDivwdDP1ULGAna0LyYmB+S/uLsA8ulxjJ10S9bsjTAIzko8s+
	nxFp2v5SeRGKf2sBUIyrub4saiZibd/Fs8FX4CTiAfIba3icQA5eCO8ESAx8ywlF
	GDHwQ2eips=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ou1
	169dbVVtdnO4hw3bUOF0bPMkWTQbv9lB+Au0hdDUAgUHAXO1l6JNs8sjgLc97DJH
	K4MXw9/F9WPS+AIk0OsAUdWhqZpHHYA4l6stnzEhkmsb0l42OM7NMqn9dSC3raV4
	Yap7ifOc3vpfuVEJd1d3UK8G5N8BF1K4/bdHcSQ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07541A7CE;
	Tue, 18 Dec 2012 22:20:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7763FA7CD; Tue, 18 Dec 2012
 22:20:57 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1AE3F620-498B-11E2-A21B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211801>

These "expect-failure" tests were not looking for the right string
in the patch file.  For example:

	grep "^ *"S. E. Cipient" <scipient@example.com>\$" patch5

was looking for "^ *S." in three files:

    "E."
    "Cipient <scipient@example.com>$"
    patch5

With some implementations of grep, the lack of file "E." was
reported as an error, leading to the expected failure of the test.
With other implementations of grep, the pattern "^ *S." matched what
was in patch5, without missing files diagnosed as an error, which
lead to these tests to unexpectedly pass.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4014-format-patch.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 16a4ca1..90fd598 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -155,7 +155,7 @@ test_expect_failure 'additional command line cc (rfc822)' '
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
 	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch5 &&
 	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch5 &&
-	grep "^ *"S. E. Cipient" <scipient@example.com>\$" patch5
+	grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" patch5
 '
 
 test_expect_success 'command line headers' '
@@ -183,7 +183,7 @@ test_expect_success 'command line To: header (ascii)' '
 test_expect_failure 'command line To: header (rfc822)' '
 
 	git format-patch --to="R. E. Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch8 &&
-	grep "^To: "R. E. Cipient" <rcipient@example.com>\$" patch8
+	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" patch8
 '
 
 test_expect_failure 'command line To: header (rfc2047)' '
@@ -203,7 +203,7 @@ test_expect_failure 'configuration To: header (rfc822)' '
 
 	git config format.to "R. E. Cipient <rcipient@example.com>" &&
 	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
-	grep "^To: "R. E. Cipient" <rcipient@example.com>\$" patch9
+	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" patch9
 '
 
 test_expect_failure 'configuration To: header (rfc2047)' '
-- 
1.8.1.rc2.196.g90926c8
