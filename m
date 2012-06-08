From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] revision: cull side parents before running
 simplify-merges
Date: Fri,  8 Jun 2012 15:53:29 -0700
Message-ID: <1339196009-14555-4-git-send-email-gitster@pobox.com>
References: <1339196009-14555-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 00:54:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd84V-00005d-OB
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 00:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757419Ab2FHWxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 18:53:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51377 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755119Ab2FHWxh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 18:53:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 060998B98
	for <git@vger.kernel.org>; Fri,  8 Jun 2012 18:53:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=njYd
	NfcaQRHTGc6Pt0/NBoqeZ6A=; b=uQCYjOOoY9R2tVcJDo3oI5dgCPorjOJAAqFJ
	+tRPGMIbZTnlW1z3t9vmiiCeBmmzn5qYXuBJuCkYgDPqWAUU7dP/37uGwLhwmluV
	3YUUUYOCBSpYunxncJrUlO7ZNBOwId1unJnJ/tG0avuXXiMeF8qDBdAOukTeIbn8
	WEo0K9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=lOM4bD
	g6ZzoVkg2X9sAfIPND12fDr3bmwdSF8IpZlRtPO6UFDNFq+HyQ5rKgFd0vVVfHSO
	7an09guHPj7g5q4dLD4uvNx9iYstkYeCEs5yBZI402IErUug57lH30j/KuU8IGvi
	eJHoBd35QYk1hF70aos3i73Ch4XDWnnBQ/zRI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F11BD8B97
	for <git@vger.kernel.org>; Fri,  8 Jun 2012 18:53:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 878AD8B96 for
 <git@vger.kernel.org>; Fri,  8 Jun 2012 18:53:36 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc2.29.g85b30f3
In-Reply-To: <1339196009-14555-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C8062DD0-B1BC-11E1-A94C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199539>

The simplify_merges() function needs to look at all history chain to
find the closest ancestor that is relevant after the simplification,
but after --first-parent traversal, side parents haven't been marked
for relevance (they are irrelevant by definition due to the nature
of first-parent-only traversal) nor culled from the parents list of
resulting commits.

Remove these side parents from parents list before starting to
further simplifying the result.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/revision.c b/revision.c
index 814b96f..d93eb7c 100644
--- a/revision.c
+++ b/revision.c
@@ -2031,6 +2031,9 @@ static void simplify_merges(struct rev_info *revs)
 		 * Do not free(list) here yet; the original list
 		 * is used later in this function.
 		 */
+		if (revs->first_parent_only &&
+		    commit->parents && commit->parents->next)
+			commit->parents->next = NULL;
 		commit_list_insert(commit, &yet_to_do);
 	}
 	while (yet_to_do) {
-- 
1.7.11.rc2.29.g85b30f3
