From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] t6050: make sure we test not just commit replacement
Date: Sun, 15 May 2011 12:54:51 -0700
Message-ID: <1305489294-14341-3-git-send-email-gitster@pobox.com>
References: <1305489294-14341-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 21:55:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLhPR-0004pq-Hl
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 21:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261Ab1EOTzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 15:55:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50740 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab1EOTzB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 15:55:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3546E4D33
	for <git@vger.kernel.org>; Sun, 15 May 2011 15:57:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/Ju1
	qTUkgDGnrqU6CNoYzM3xpZs=; b=qOazBcbp/jaIPh0kpbtT7EXuxrmHjABeXgf7
	RBdF1zuCA1Ta4XXDzYv7zM+yVhb0GoU5V403b7palaR4VZynaScyRb7MIUkJ+AuP
	/EiZO1HJ/aINfAyKn0+qFsbmF2BW2pq4NUdtJ5T61QMw2dqi5/J6SkxfLMxws/OH
	W/sda9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=HckEb+
	vlkaXn2ibUhONcyL4D9HeKAOCTWBkolzR4tRnJxWlIsGI0w/geNJ5/L7ePhOJp24
	pnGPv3atliddqZ3JqND2IAxb4wVAnSwDyTD6uFqkYtSjbiGzJTBHYsycStVjGe6Y
	dIJri59wZfDikMJsRWiJVINgXKHL4jS+fAt2k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 316BD4D32
	for <git@vger.kernel.org>; Sun, 15 May 2011 15:57:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 97D044D31 for
 <git@vger.kernel.org>; Sun, 15 May 2011 15:57:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.334.gdfd07
In-Reply-To: <1305489294-14341-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 831EF764-7F2D-11E0-B122-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173654>

The replacement mechanism should affect all types of objects not
just commits, so make sure it deals with at least a blob.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6050-replace.sh |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index ae2194e..5c87f28 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -236,6 +236,20 @@ test_expect_success 'index-pack and replacements' '
 	git index-pack test-*.pack
 '
 
-#
-#
+test_expect_success 'not just commits' '
+	echo replaced >file &&
+	git add file &&
+	REPLACED=$(git rev-parse :file) &&
+	mv file file.replaced &&
+
+	echo original >file &&
+	git add file &&
+	ORIGINAL=$(git rev-parse :file) &&
+	git update-ref refs/replace/$ORIGINAL $REPLACED &&
+	mv file file.original &&
+
+	git checkout file &&
+	test_cmp file.replaced file
+'
+
 test_done
-- 
1.7.5.1.334.gdfd07
