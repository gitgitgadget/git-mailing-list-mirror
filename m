From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] in_merge_bases(): omit unnecessary redundant common
 ancestor reduction
Date: Mon, 27 Aug 2012 16:12:02 -0700
Message-ID: <1346109123-12357-5-git-send-email-gitster@pobox.com>
References: <1346109123-12357-1-git-send-email-gitster@pobox.com>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 01:12:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T68Tr-0007Qr-Gz
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 01:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976Ab2H0XMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 19:12:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48275 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754153Ab2H0XMO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 19:12:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C1AF916E;
	Mon, 27 Aug 2012 19:12:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Li5T
	7Q2Qzg+mZNRdsTiqlGnXaJI=; b=pMRoWS330kxRvmtthvTmq7r7Dnc96IqnuqAW
	2McRkWc6mcX5elF2ZNsTgSVhlIC7dQR4csbDl44gbfWKhKJx9TnGbp+N7/kFD3Nm
	igPKwkCjr3witPxdAEDehGlZMglvVzeyJiWGUgs6U/1A3NkRO/C69UI8WNcycQgT
	Eo+yr5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	WS7/ZggLZd6bpcMkl7HiuYYu4ITrb4LMS8JORPqe2an4aWJbeIp2Pi+awjbiuF71
	rY4hXP6b/KS04tlI0OUwPUbTlBIexxDI16kBEYjBzszGKmZfX/5tiw52q68Dilnw
	BG+if1RedswwhHURmGCWmeBUTFKg3KmOspUY4yRW7W0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A164916D;
	Mon, 27 Aug 2012 19:12:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A75C916A; Mon, 27 Aug 2012
 19:12:13 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.270.g724661d
In-Reply-To: <1346109123-12357-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A2BE4386-F09C-11E1-8AB6-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204391>

The function get_merge_bases() needs to postprocess the result from
merge_bases_many() in order to make sure none of the commit is a
true ancestor of another commit, which is expensive.  However, when
checking if a commit is an ancestor of another commit, we only need
to see if the commit is a common ancestor between the two, and do
not have to care if other common ancestors merge_bases_many() finds
are true merge bases or an ancestor of another merge base.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 74ec5f1..f5211bd 100644
--- a/commit.c
+++ b/commit.c
@@ -806,7 +806,10 @@ int in_merge_bases(struct commit *commit, struct commit *reference)
 	struct commit_list *bases, *b;
 	int ret = 0;
 
-	bases = get_merge_bases(commit, reference, 1);
+	bases = merge_bases_many(commit, 1, &reference);
+	clear_commit_marks(commit, all_flags);
+	clear_commit_marks(reference, all_flags);
+
 	for (b = bases; b; b = b->next) {
 		if (!hashcmp(commit->object.sha1, b->item->object.sha1)) {
 			ret = 1;
-- 
1.7.12.116.g31e0100
