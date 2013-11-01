From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] t1005: add test for "read-tree --reset -u A B"
Date: Fri,  1 Nov 2013 15:44:55 -0700
Message-ID: <1383345895-23341-4-git-send-email-gitster@pobox.com>
References: <20131031172116.GA19428@sigill.intra.peff.net>
 <1383345895-23341-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 01 23:45:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcNT1-0002Ft-Mf
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 23:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145Ab3KAWpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 18:45:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754646Ab3KAWpH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 18:45:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D8094D133;
	Fri,  1 Nov 2013 18:45:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=fA7L
	46fJnO9gx/Z9Zjhr/4pl/t4=; b=GYazO83Ty4QSsj/JGOaWYn2uuECCjPx3vU+q
	PpHhVfLvVGy5cIHvReCOalwt4AjK317ez8Q73h7EC1jlRJ//fzLA4B1KHk1Z/Fci
	ADZTB7dGW5/hiT96Jq2vXOHpvN3fTbGmXXP4nRrZAugUFj8K3Z5xz48DN088CnrS
	vavVlkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	bxEngnP6EnB8EyeJgYUF3/C59ikz5dnjVmVyIdm5lWfgYa1xNQoLXU9tXbmCVE2d
	Q3t42vLXnk2Vp/+KXTgr5AUfnS7oCUOlopDvEbx5+TounIDUmjhtsbK7NGQ7Rynn
	a33VD8JmwouAUux2tXvthG1DqapV9s3xwtRUazEaV+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EFDE4D132;
	Fri,  1 Nov 2013 18:45:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC8694D131;
	Fri,  1 Nov 2013 18:45:06 -0400 (EDT)
X-Mailer: git-send-email 1.8.5-rc0-281-g8951339
In-Reply-To: <1383345895-23341-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 415FA9D2-4347-11E3-84E3-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237228>

With a conflicted index, this used to give us an error.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1005-read-tree-reset.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
index e29cf63..0745685 100755
--- a/t/t1005-read-tree-reset.sh
+++ b/t/t1005-read-tree-reset.sh
@@ -43,6 +43,21 @@ test_expect_success 'reset should remove remnants from a failed merge' '
 	! test -f old
 '
 
+test_expect_success 'two-way reset should remove remnants too' '
+	read_tree_u_must_succeed --reset -u HEAD &&
+	git ls-files -s >expect &&
+	sha1=$(git rev-parse :new) &&
+	(
+		echo "100644 $sha1 1	old"
+		echo "100644 $sha1 3	old"
+	) | git update-index --index-info &&
+	>old &&
+	git ls-files -s &&
+	read_tree_u_must_succeed --reset -u HEAD HEAD &&
+	git ls-files -s >actual &&
+	! test -f old
+'
+
 test_expect_success 'Porcelain reset should remove remnants too' '
 	read_tree_u_must_succeed --reset -u HEAD &&
 	git ls-files -s >expect &&
-- 
1.8.5-rc0-281-g8951339
