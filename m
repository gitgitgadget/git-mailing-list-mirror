From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] t6200: test message for merging of an annotated tag
Date: Mon,  1 Apr 2013 12:57:19 -0700
Message-ID: <1364846239-8802-4-git-send-email-gitster@pobox.com>
References: <7v7gl3jmx0.fsf_-_@alter.siamese.dyndns.org>
 <1364846239-8802-1-git-send-email-gitster@pobox.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 01 21:58:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMkrn-0000VT-0O
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 21:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759595Ab3DAT53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 15:57:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46008 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759496Ab3DAT51 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 15:57:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55DDD11065;
	Mon,  1 Apr 2013 19:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=gjNr
	QV3uZwX30l0vCWCgye7Wr4o=; b=FKOAsok4Q6CfIEkUh7UO+Ec9iZnSQw/ry9Qt
	ENIZzpxVl697MsqAcO8Juge+P5taS9X0yuTv+Ghj867djDcZDhM8eMX46lW8Xl+a
	dt7UoOrPDn2ZO1u3tbmY6pdOpjgHWGZETDFQ2phLMEchT+l+0MGHEC0H+9VRUOh4
	28mU7xY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	d/yRN5n92iqflynm2iGAmTTJWgfjfedqSaFuLbDkLXAUq39f5b4ZowxPt8lPqsP7
	tZVVkJkl2cPmOcGap0HqwvKx0j5LejSxudmA6irHg3iTOn0izzeV/j+WmaUeEj4i
	M71uOpEa3DfQM0859b9IWF9IbxWqpElQ+N1/tW3PJDE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A3B911064;
	Mon,  1 Apr 2013 19:57:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFC9911062; Mon,  1 Apr
 2013 19:57:26 +0000 (UTC)
X-Mailer: git-send-email 1.8.2-480-g064f421
In-Reply-To: <1364846239-8802-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 60A31E6C-9B06-11E2-A25D-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219705>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6200-fmt-merge-msg.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index f84bb0c..f73ecea 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -469,4 +469,43 @@ test_expect_success 'merge-msg lots of commits' '
 	test_cmp expected actual
 '
 
+test_expect_success 'merge-msg with "merging" an annotated tag' '
+	test_config merge.log true &&
+
+	git checkout master^0 &&
+	git commit --allow-empty -m "One step ahead" &&
+	git tag -a -m "An annotated one" annote HEAD &&
+
+	git checkout master &&
+	git fetch . annote &&
+
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	{
+		cat <<-\EOF
+		Merge tag '\''annote'\''
+
+		An annotated one
+
+		* tag '\''annote'\'':
+		  One step ahead
+		EOF
+	} >expected &&
+	test_cmp expected actual &&
+
+	test_when_finished "git reset --hard" &&
+	annote=$(git rev-parse annote) &&
+	git merge --no-commit $annote &&
+	{
+		cat <<-EOF
+		Merge tag '\''$annote'\''
+
+		An annotated one
+
+		* tag '\''$annote'\'':
+		  One step ahead
+		EOF
+	} >expected &&
+	test_cmp expected .git/MERGE_MSG
+'
+
 test_done
-- 
1.8.2-480-g064f421
