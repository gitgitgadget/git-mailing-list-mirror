From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] builtin-for-each-ref.c: check if we need to peel onion
 while parsing the format
Date: Sat, 13 Feb 2010 12:30:31 -0800
Message-ID: <1266093033-9526-3-git-send-email-gitster@pobox.com>
References: <1266093033-9526-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 21:30:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgOdj-00079m-78
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 21:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757940Ab0BMUan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 15:30:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680Ab0BMUal (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 15:30:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C8D399A9B
	for <git@vger.kernel.org>; Sat, 13 Feb 2010 15:30:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0u9I
	QhMs+IRLoJTOkckHe6Y/UoA=; b=vKCsqk24uJ+g62JOpHdTddVnFq27IPi66UWn
	Pp3Cw+eDUriZ2r/SM81y3D8JyDsKAA3rGkJoUoG6gFl1o2d7VkYftN/KSf2ElF79
	ZGnW6new4/Q3LiN3POpkVXNEUaTGlnELml8oLFsWCGFApgx78QCtHfE3sQRXTav3
	2W7T6F0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Uqxeup
	r0uMLPYGogHiwFC8yEGzwqHTX9ROecNyM4l+XmsGrmnUR8WG7uXDSVGUovZRD7dY
	bDrmAxFWnf7CQ+Tj4TpwovF2zqVuzYVunN6s6CaKlOJMXu5BQlXRAakQvkgrrV7E
	bDxbqYZfdZSEDeVd3H/qrpIEsbSNbGKQpxFWE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 45F3499A9A
	for <git@vger.kernel.org>; Sat, 13 Feb 2010 15:30:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B489999A98 for
 <git@vger.kernel.org>; Sat, 13 Feb 2010 15:30:40 -0500 (EST)
X-Mailer: git-send-email 1.7.0.169.g57c99
In-Reply-To: <1266093033-9526-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A744DCBE-18DE-11DF-A303-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139828>

Instead of iterating over the parsed atoms that are used in the output
format after all the parsing is done, check it while parsing the
format string.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-for-each-ref.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 3698e82..d68977e 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -133,6 +133,8 @@ static int parse_atom(const char *atom, const char *ep)
 				  (sizeof(*used_atom_type) * used_atom_cnt));
 	used_atom[at] = xmemdupz(atom, ep - atom);
 	used_atom_type[at] = valid_atom[i].cmp_type;
+	if (*atom == '*')
+		need_tagged = 1;
 	return at;
 }
 
@@ -944,13 +946,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	refs = cbdata.grab_array;
 	num_refs = cbdata.grab_cnt;
 
-	for (i = 0; i < used_atom_cnt; i++) {
-		if (used_atom[i][0] == '*') {
-			need_tagged = 1;
-			break;
-		}
-	}
-
 	sort_refs(sort, refs, num_refs);
 
 	if (!maxcount || num_refs < maxcount)
-- 
1.7.0.169.g57c99
