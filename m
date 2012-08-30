From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] in_merge_bases(): use paint_down_to_common()
Date: Thu, 30 Aug 2012 16:13:07 -0700
Message-ID: <1346368388-23576-4-git-send-email-gitster@pobox.com>
References: <1346368388-23576-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 01:13:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7Dve-0007Wq-IF
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 01:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920Ab2H3XNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 19:13:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40852 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752763Ab2H3XNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 19:13:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5002F8D0C
	for <git@vger.kernel.org>; Thu, 30 Aug 2012 19:13:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=od3E
	G+aefl+/EMb94V2NcjlOg7w=; b=W84ub0xvOu2G7bv/ue7ICjQmR5XZqqnWPchm
	m/MXPI+NfbXzgC3inL+kyOlOnnVLqLVzVyGjLk1Mi3QWIP3yHwyyleKrdpEK/TQd
	y88E8boisFeDF1O3jzlpuhc+H0N6I2YXAW5zi0+A0XX90Z3agPiII8GmtRrX4tIJ
	eAvB12o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=dP6/L2
	aKqJRObfEwJldVBqu8yTa7ixvkQq8W9DX9o3EKSFJCSHV16YLrofMgGQTOvuKF2I
	sObTorT5ju5LZmkp2fES0/JuFc4MnYiLBdBIZI0UnNbJAxdwMoqDCdABYbK4c4Ch
	oQNPVpHe+P7tzhvlLmhq8o8AlylocUVRWBgsk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D3648D0B
	for <git@vger.kernel.org>; Thu, 30 Aug 2012 19:13:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BB488D0A for
 <git@vger.kernel.org>; Thu, 30 Aug 2012 19:13:15 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.293.g6aeebca
In-Reply-To: <1346368388-23576-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4718B490-F2F8-11E1-9930-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204576>

With paint_down_to_common(), we can tell if "commit" is reachable
from "reference" by simply looking at its object flag, instead of
iterating over the merge bases.
---
 commit.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/commit.c b/commit.c
index 0058fa5..d39a9e9 100644
--- a/commit.c
+++ b/commit.c
@@ -786,20 +786,17 @@ int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
  */
 int in_merge_bases(struct commit *commit, struct commit *reference)
 {
-	struct commit_list *bases, *b;
+	struct commit_list *bases;
 	int ret = 0;
 
-	bases = merge_bases_many(commit, 1, &reference);
+	if (parse_commit(commit) || parse_commit(reference))
+		return ret;
+
+	bases = paint_down_to_common(commit, 1, &reference);
+	if (commit->object.flags & PARENT2)
+		ret = 1;
 	clear_commit_marks(commit, all_flags);
 	clear_commit_marks(reference, all_flags);
-
-	for (b = bases; b; b = b->next) {
-		if (!hashcmp(commit->object.sha1, b->item->object.sha1)) {
-			ret = 1;
-			break;
-		}
-	}
-
 	free_commit_list(bases);
 	return ret;
 }
-- 
1.7.12.293.g6aeebca
