From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/11] t4200: rerere a merge with two identical conflicts
Date: Mon, 28 Mar 2016 15:42:17 -0700
Message-ID: <1459204942-26601-7-git-send-email-gitster@pobox.com>
References: <1442275050-30497-1-git-send-email-gitster@pobox.com>
 <1459204942-26601-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 00:43:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akfsD-0005OR-Q4
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 00:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506AbcC1Wmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 18:42:40 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60194 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755497AbcC1Wmf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 18:42:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9A80C4FFAF;
	Mon, 28 Mar 2016 18:42:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=RvLa
	9BfBGa2OkCM345BbNquyhEQ=; b=w2olBCweAparujyX+1qzeQzzYJmTJXV3jL9G
	CJsx0G07SbBRd8Hy7yZ46rZUekHc0R4xwZMtxJfxGYvgh9KVjPETv5WzITLo40gG
	OjnsYaLQwRcsfA/JAuCECrVMuFHe5gJsFT/TmoQv+hjN9BUVgwXqTAjJ9CAY2DXk
	5bxdpxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ZXqrDo
	hHgdkLyU+oFC86OGkSI1Fk4oIOAcl9qnTC05oIo1xoDfSPXr99bXjKcpAsiXRH3q
	BWOPW1EhM20IkgwmOlF53OUpXkV474GPze1zpUbM6Wy8v8sC3MzSw0cv75Cwok67
	mA0QwvK8q7LqIGqopBM6NZJHYQS+7J1cVC1mE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 91BF64FFAE;
	Mon, 28 Mar 2016 18:42:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1204B4FFAD;
	Mon, 28 Mar 2016 18:42:34 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-215-g046a488
In-Reply-To: <1459204942-26601-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5CEEA272-F536-11E5-A582-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290075>

When the context of multiple identical conflicts are different, two
seemingly the same conflict resolution cannot be safely applied.

In such a case, at least we should be able to record these two
resolutions separately in the rerere database, and reuse them when
we see the same conflict later.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Unchanged

 t/t4200-rerere.sh | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index c428011..6fcc6d4 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -406,4 +406,78 @@ test_expect_success 'rerere -h' '
 	test_i18ngrep [Uu]sage help
 '
 
+concat_insert () {
+	last=$1
+	shift
+	cat early && printf "%s\n" "$@" && cat late "$last"
+}
+
+test_expect_failure 'multiple identical conflicts' '
+	git reset --hard &&
+
+	test_seq 1 6 >early &&
+	>late &&
+	test_seq 11 15 >short &&
+	test_seq 111 120 >long &&
+	concat_insert short >file1 &&
+	concat_insert long >file2 &&
+	git add file1 file2 &&
+	git commit -m base &&
+	git tag base &&
+	git checkout -b six.1 &&
+	concat_insert short 6.1 >file1 &&
+	concat_insert long 6.1 >file2 &&
+	git add file1 file2 &&
+	git commit -m 6.1 &&
+	git checkout -b six.2 HEAD^ &&
+	concat_insert short 6.2 >file1 &&
+	concat_insert long 6.2 >file2 &&
+	git add file1 file2 &&
+	git commit -m 6.2 &&
+
+	# At this point, six.1 and six.2
+	# - derive from common ancestor that has two files
+	#   1...6 7 11..15 (file1) and 1...6 7 111..120 (file2)
+	# - six.1 replaces these 7s with 6.1
+	# - six.2 replaces these 7s with 6.2
+
+	test_must_fail git merge six.1 &&
+
+	# Check that rerere knows that file1 and file2 have conflicts
+
+	printf "%s\n" file1 file2 >expect &&
+	git ls-files -u | sed -e "s/^.*	//" | sort -u >actual &&
+	test_cmp expect actual &&
+
+	git rerere status | sort >actual &&
+	test_cmp expect actual &&
+
+	# Resolution is to replace 7 with 6.1 and 6.2 (i.e. take both)
+	concat_insert short 6.1 6.2 >file1 &&
+	concat_insert long 6.1 6.2 >file2 &&
+
+	git rerere remaining >actual &&
+	test_cmp expect actual &&
+
+	# We resolved file1 and file2
+	git rerere &&
+	>expect &&
+	git rerere remaining >actual &&
+	test_cmp expect actual &&
+
+	# Now we should be able to resolve them both
+	git reset --hard &&
+	test_must_fail git merge six.1 &&
+	git rerere &&
+
+	>expect &&
+	git rerere remaining >actual &&
+	test_cmp expect actual &&
+
+	concat_insert short 6.1 6.2 >file1.expect &&
+	concat_insert long 6.1 6.2 >file2.expect &&
+	test_cmp file1.expect file1 &&
+	test_cmp file2.expect file2
+'
+
 test_done
-- 
2.8.0-215-g046a488
