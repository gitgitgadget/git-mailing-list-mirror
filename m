From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6] diff: factor out match_filter()
Date: Wed, 17 Jul 2013 17:30:02 -0700
Message-ID: <1374107406-14357-3-git-send-email-gitster@pobox.com>
References: <7vvc496ruf.fsf@alter.siamese.dyndns.org>
 <1374107406-14357-1-git-send-email-gitster@pobox.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 02:30:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzc74-0006bR-TY
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 02:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835Ab3GRAaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 20:30:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35947 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932666Ab3GRAaP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 20:30:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A573720AA8;
	Thu, 18 Jul 2013 00:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=bxQC
	AMzb86FTRXZHvvJjsYJikiE=; b=FcdzDAmeNdZs/U8naa4CoDFYEp4uNZaFjzqx
	vXv6Z+jYhEqz+w6N3yQg81fi16OANobHEVHSwyrMs5Lt+VqiIbsJ89vJuzQtr/aW
	ZoQ7y0beT0cQDgeHxDmRkIAG/gVkOhnC6mY/vgUYtU/Qyy4FuD8edBjKaup2MLFz
	iEC+aRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	B7A/pSApGgH+so0xriDTrpeaPjYW0Yd34NdxkGz/FAJyICxIAC45YsRzIj6ES0BH
	6dgWNt14VwlV9Gn+o308ZaZQALql13mJDVZVhCiPUbt/yelqvL3X3SxAlN823tti
	xegL2BovIfSAFvtzCm+yonkc59BCBXS7nnmf1iEvQP4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CC2120AA7;
	Thu, 18 Jul 2013 00:30:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10CEE20AA4;
	Thu, 18 Jul 2013 00:30:13 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.3-962-gf04df43
In-Reply-To: <1374107406-14357-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 367F6DFE-EF41-11E2-81EA-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230668>

diffcore_apply_filter() checks if a filepair matches the filter
given with the "--diff-filter" option for each input filepairs with
a fairly complex expression in two places.

Create a helper function and call it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index 41c64f2..0220c19 100644
--- a/diff.c
+++ b/diff.c
@@ -4509,6 +4509,17 @@ free_queue:
 	}
 }
 
+static int match_filter(const struct diff_options *options, const struct diff_filepair *p)
+{
+	return (((p->status == DIFF_STATUS_MODIFIED) &&
+		 ((p->score &&
+		   strchr(options->filter, DIFF_STATUS_FILTER_BROKEN)) ||
+		  (!p->score &&
+		   strchr(options->filter, DIFF_STATUS_MODIFIED)))) ||
+		((p->status != DIFF_STATUS_MODIFIED) &&
+		 strchr(options->filter, p->status)));
+}
+
 static void diffcore_apply_filter(struct diff_options *options)
 {
 	int i;
@@ -4524,14 +4535,7 @@ static void diffcore_apply_filter(struct diff_options *options)
 	if (strchr(filter, DIFF_STATUS_FILTER_AON)) {
 		int found;
 		for (i = found = 0; !found && i < q->nr; i++) {
-			struct diff_filepair *p = q->queue[i];
-			if (((p->status == DIFF_STATUS_MODIFIED) &&
-			     ((p->score &&
-			       strchr(filter, DIFF_STATUS_FILTER_BROKEN)) ||
-			      (!p->score &&
-			       strchr(filter, DIFF_STATUS_MODIFIED)))) ||
-			    ((p->status != DIFF_STATUS_MODIFIED) &&
-			     strchr(filter, p->status)))
+			if (match_filter(options, q->queue[i]))
 				found++;
 		}
 		if (found)
@@ -4549,14 +4553,7 @@ static void diffcore_apply_filter(struct diff_options *options)
 		/* Only the matching ones */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-
-			if (((p->status == DIFF_STATUS_MODIFIED) &&
-			     ((p->score &&
-			       strchr(filter, DIFF_STATUS_FILTER_BROKEN)) ||
-			      (!p->score &&
-			       strchr(filter, DIFF_STATUS_MODIFIED)))) ||
-			    ((p->status != DIFF_STATUS_MODIFIED) &&
-			     strchr(filter, p->status)))
+			if (match_filter(options, p))
 				diff_q(&outq, p);
 			else
 				diff_free_filepair(p);
-- 
1.8.3.3-962-gf04df43
