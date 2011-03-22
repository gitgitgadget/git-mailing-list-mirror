From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] diffcore-rename: refactor "too many candidates" logic
Date: Tue, 22 Mar 2011 14:50:47 -0700
Message-ID: <1300830649-22830-1-git-send-email-gitster@pobox.com>
References: <7vk4fqkewo.fsf@alter.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 22:51:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q29Tj-0008Pq-Uk
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 22:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378Ab1CVVu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 17:50:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932346Ab1CVVu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 17:50:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B3D504658;
	Tue, 22 Mar 2011 17:52:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qX/W
	CDU89JuGe4rfhA5yQIYX/5A=; b=OqrImbCKh9iVrw7YxuYE4EoG15JC5FI39XUl
	0CXqSTFA9VaQ1tq4Np9DxkhU0TQ1AW8CttrL9Hlw5Tj/KYPYrgtGDkjfCR/1Lgnv
	AzR5DvwmYQD7tQDJMDxz1dG91RjhP2uVnp+IHySyrdEDpQlsXwGbFwLzu5+UNI0K
	YL8cuc4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	MdDNRjvMNUCytsdLH8CrxGVSxJDGGaY+dPJpVFaeK9YkZaNgUhK2E0/dF/vlCx2V
	sAxEm5uvmEoid2n4a9es+M3z+q35duB8LzJ4Z2mteX3ycwHsU8DPpol3R4sHfbvf
	InZFl1GcPWzSeK19KFa4P3zcmIBuGL+Yd2qw3x2+U+s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 83C944655;
	Tue, 22 Mar 2011 17:52:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 77A254654; Tue, 22 Mar 2011
 17:52:29 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.554.gfdad8
In-Reply-To: <7vk4fqkewo.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: B008A0CE-54CE-11E0-B9AD-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169782>

Move the logic to a separate function, to be enhanced by later patches in
the series.

While at it, swap the condition used in the if statement from "if it is
too big then do this" to "if it would fit then do this".

Signed-off-by: Junio C Hamano <gitster@pobox.com>

---

 Rebased to 'master' as the logic to use the result of this logic was
 updated recently, together with the addition of eye-candy.
---
 diffcore-rename.c |   47 +++++++++++++++++++++++++++++------------------
 1 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index d40e40a..00f7f84 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -419,6 +419,34 @@ static void record_if_better(struct diff_score m[], struct diff_score *o)
 		m[worst] = *o;
 }
 
+static int too_many_rename_candidates(int num_create,
+				      struct diff_options *options)
+{
+	int rename_limit = options->rename_limit;
+	int num_src = rename_src_nr;
+
+	options->needed_rename_limit = 0;
+
+	/*
+	 * This basically does a test for the rename matrix not
+	 * growing larger than a "rename_limit" square matrix, ie:
+	 *
+	 *    num_create * num_src > rename_limit * rename_limit
+	 *
+	 * but handles the potential overflow case specially (and we
+	 * assume at least 32-bit integers)
+	 */
+	if (rename_limit <= 0 || rename_limit > 32767)
+		rename_limit = 32767;
+	if ((num_create <= rename_limit || num_src <= rename_limit) &&
+	    (num_create * num_src <= rename_limit * rename_limit))
+		return 0;
+
+	options->needed_rename_limit =
+		num_src > num_create ? num_src : num_create;
+	return 1;
+}
+
 static int find_renames(struct diff_score *mx, int dst_cnt, int minimum_score, int copies)
 {
 	int count = 0, i;
@@ -444,7 +472,6 @@ void diffcore_rename(struct diff_options *options)
 {
 	int detect_rename = options->detect_rename;
 	int minimum_score = options->rename_score;
-	int rename_limit = options->rename_limit;
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
 	struct diff_score *mx;
@@ -511,24 +538,8 @@ void diffcore_rename(struct diff_options *options)
 	if (!num_create)
 		goto cleanup;
 
-	/*
-	 * This basically does a test for the rename matrix not
-	 * growing larger than a "rename_limit" square matrix, ie:
-	 *
-	 *    num_create * num_src > rename_limit * rename_limit
-	 *
-	 * but handles the potential overflow case specially (and we
-	 * assume at least 32-bit integers)
-	 */
-	options->needed_rename_limit = 0;
-	if (rename_limit <= 0 || rename_limit > 32767)
-		rename_limit = 32767;
-	if ((num_create > rename_limit && num_src > rename_limit) ||
-	    (num_create * num_src > rename_limit * rename_limit)) {
-		options->needed_rename_limit =
-			num_src > num_create ? num_src : num_create;
+	if (too_many_rename_candidates(num_create, options))
 		goto cleanup;
-	}
 
 	if (options->show_rename_progress) {
 		progress = start_progress_delay(
-- 
1.7.4.1.554.gfdad8
