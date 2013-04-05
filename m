From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] diffcore-pickaxe: port optimization from has_changes()
 to diff_grep()
Date: Thu,  4 Apr 2013 21:45:24 -0700
Message-ID: <1365137126-21659-1-git-send-email-gitster@pobox.com>
References: <7v1uapfuyp.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 05 06:45:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNyXF-0007Sq-UK
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 06:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043Ab3DEEp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 00:45:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56682 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab3DEEp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 00:45:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ED0411B46
	for <git@vger.kernel.org>; Fri,  5 Apr 2013 04:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=cTlC
	IMBZjVYaTK+U8eOtJphVDyM=; b=vf6DoIg80YxJ6if8W9yNDCgyfxYHD2/I6Uvw
	rVcM9OY4swXk2zK0Gzk3uRqr/NrpZup34opfoIhqQ+A1mKy2vT5IJenCNyXl7i5R
	Nu4wNr0SqthbZxsh9iGUj/tWSVUQ/bLT88dk5Kodcb2+EkBv+ILYwiIRZOlz4/Lb
	VQpRPU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=TTM8Vr
	U7IOUSKkIIkUN33DRZMe9nAcqkVNhjCCIjxzHVC27co07ReXU0z8eXTo0ChSb0eo
	ghRcJOQcvtZ1et9Q4zKhJgRtViKVmF1Y5PhcgqTyCwN5tonMwPPJR6wQ+bWv0d/c
	+K3N2udziv3tRIM4rP0sPFa25YP4gDejMaDNo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 376E011B45
	for <git@vger.kernel.org>; Fri,  5 Apr 2013 04:45:28 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCC8811B40 for
 <git@vger.kernel.org>; Fri,  5 Apr 2013 04:45:27 +0000 (UTC)
X-Mailer: git-send-email 1.8.2-588-gbf1c992
In-Reply-To: <7v1uapfuyp.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: A3376DD0-9DAB-11E2-8649-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220137>

These two functions are called in the same codeflow to implement
"log -S<block>" and "log -G<pattern>", respectively, but the latter
lacked two obvious optimizations the former implemented, namely:

 - When a pickaxe limit is not given at all, they should return
   without wasting any cycle;

 - When both sides of the filepair are the same, and the same
   textconv conversion apply to them, return early, as there will be
   no interesting differences between the two anyway.

Also release the filespec data once the processing is done (this is
not about leaking memory--it is about releasing data we finished
looking at as early as possible).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-pickaxe.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 26ddf00..bfaabab 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -83,7 +83,7 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
 	mmfile_t mf1, mf2;
 	int hit;
 
-	if (diff_unmodified_pair(p))
+	if (!o->pickaxe[0])
 		return 0;
 
 	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
@@ -91,6 +91,9 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
 		textconv_two = get_textconv(p->two);
 	}
 
+	if (textconv_one == textconv_two && diff_unmodified_pair(p))
+		return 0;
+
 	mf1.size = fill_textconv(textconv_one, p->one, &mf1.ptr);
 	mf2.size = fill_textconv(textconv_two, p->two, &mf2.ptr);
 
@@ -125,6 +128,8 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
 		free(mf1.ptr);
 	if (textconv_two)
 		free(mf2.ptr);
+	diff_free_filespec_data(p->one);
+	diff_free_filespec_data(p->two);
 	return hit;
 }
 
-- 
1.8.2-588-gbf1c992
