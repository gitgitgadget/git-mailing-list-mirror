From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] diffcore-rename: refactor "too many candidates" logic
Date: Thu,  6 Jan 2011 13:50:04 -0800
Message-ID: <1294350606-19530-2-git-send-email-gitster@pobox.com>
References: <1294350606-19530-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 06 22:50:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaxjE-0005g3-A7
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 22:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826Ab1AFVuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 16:50:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741Ab1AFVuN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 16:50:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1BC993152
	for <git@vger.kernel.org>; Thu,  6 Jan 2011 16:50:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=5l9K
	8P9JzvlsHIoc8gfKoXQyB+U=; b=qC27yg0hqkhaAH+iju7Jf5WlHVusT8tiFGpG
	u+UdSZye90BIQ1iej6eQZotXnvuKOZ07p9NWvvHBGK1hMJI7NagMtsR57wDN4tD5
	rXCkXY/lWbuEH/53z34QMZnH/71YINpRQajcnppte7yKg+PxaQ8exsDFI+pF5h9s
	qq3SSM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=CsxBrV
	45WO7n1wogldbXQ3ifqDZajhspfBk9eq4Geql1Xw+HP1WVquGTFxcklzGu1vXTWZ
	hfUEXYQl+/X9q378odJLJ/lSUliVac3sX7PTHBY62Xg2mnWN2ByWXo1fOhhcJF8M
	luySWPuyZUiaaV9F3nzmUKF40D5syzoyAJM3o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 18F6F3151
	for <git@vger.kernel.org>; Thu,  6 Jan 2011 16:50:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5A0493150 for
 <git@vger.kernel.org>; Thu,  6 Jan 2011 16:50:49 -0500 (EST)
X-Mailer: git-send-email 1.7.4.rc1.214.g2a4f9
In-Reply-To: <1294350606-19530-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 069FB61E-19DF-11E0-A3B9-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164678>

Move the logic to a separate function, to be enhanced by later patches in
the series.

While at it, swap the condition used in the if statement from "if it is
too big then do this" to "if it would fit then do this".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-rename.c |   39 +++++++++++++++++++++++++--------------
 1 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index df41be5..6ab050d 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -414,11 +414,34 @@ static void record_if_better(struct diff_score m[], struct diff_score *o)
 		m[worst] = *o;
 }
 
+static int too_many_rename_candidates(int num_create,
+				      struct diff_options *options)
+{
+	int rename_limit = options->rename_limit;
+	int num_src = rename_src_nr;
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
+	return 1;
+}
+
 void diffcore_rename(struct diff_options *options)
 {
 	int detect_rename = options->detect_rename;
 	int minimum_score = options->rename_score;
-	int rename_limit = options->rename_limit;
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
 	struct diff_score *mx;
@@ -484,19 +507,7 @@ void diffcore_rename(struct diff_options *options)
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
-	if (rename_limit <= 0 || rename_limit > 32767)
-		rename_limit = 32767;
-	if ((num_create > rename_limit && num_src > rename_limit) ||
-	    (num_create * num_src > rename_limit * rename_limit)) {
+	if (too_many_rename_candidates(num_create, options)) {
 		if (options->warn_on_too_large_rename)
 			warning("too many files (created: %d deleted: %d), skipping inexact rename detection", num_create, num_src);
 		goto cleanup;
-- 
1.7.4.rc1.214.g2a4f9
