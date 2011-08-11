From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/11] object: try 3-way cuckoo
Date: Thu, 11 Aug 2011 10:53:15 -0700
Message-ID: <1313085196-13249-11-git-send-email-gitster@pobox.com>
References: <1313085196-13249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 19:54:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrZSW-0000IQ-4f
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 19:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041Ab1HKRxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 13:53:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44727 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752970Ab1HKRxl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 13:53:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 630B041AB
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=NnAj
	H73n42G5/zb8bhPUvUUSw0A=; b=WU4urlAK0WutkWOoWOGTskNeEUiucEQd5lpa
	PRdqgY7mRC6b4DRlXfZtLKhsXvsNDxz6pprHbDm4PSPREnm/4ut7IEd2lYt/wQaF
	ephLLIm9Nh6ynq+fLRo1tUNdfLAz96RWPMrk3JmbY5TdvFkFxcHIQMVNeewAVrQA
	mwj+UpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=bpr50m
	uX244m74Y74iJh+wwMvwYK0pazqXFTQAyzJeAoPfqKPXK7CY82RBb4Udo9bA7Cvn
	21fmuGHWVzj6j8XqU9Qixzjr4B3BDzzKcuSbtd1YDIH10ochdzVzjCEnI4LAwif+
	8XVGdBPmMF2nrrGlrh0IEL5+xsqKR/78ylbAE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AE4741AA
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE4D941A9 for
 <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:39 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.433.g1421f
In-Reply-To: <1313085196-13249-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D86FB488-C442-11E0-883D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179124>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
../+v/48b49262cd2d0d64696b489fe5bdfa8efb9180f5/git-pack-objects
Counting objects: 2139209, done.
30.68user 2.26system 0:33.05elapsed 99%CPU (0avgtext+0avgdata 3660832maxresident)k
0inputs+0outputs (0major+421963minor)pagefaults 0swaps
Counting objects: 2139209, done.
30.76user 2.26system 0:33.12elapsed 99%CPU (0avgtext+0avgdata 3660480maxresident)k
0inputs+0outputs (0major+421941minor)pagefaults 0swaps
Counting objects: 2139209, done.
30.74user 2.33system 0:33.18elapsed 99%CPU (0avgtext+0avgdata 3661696maxresident)k
0inputs+0outputs (0major+422017minor)pagefaults 0swaps
---
 object.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/object.c b/object.c
index caced56..18e6bcf 100644
--- a/object.c
+++ b/object.c
@@ -49,20 +49,18 @@ struct object *get_indexed_object(unsigned int idx)
 struct object *lookup_object(const unsigned char *sha1)
 {
 	struct object *obj;
-	unsigned int hashval[4];
+	unsigned int hashval[3];
 
 	if (!obj_hash)
 		return NULL;
 
-	memcpy(hashval, sha1, 16);
+	memcpy(hashval, sha1, 12);
 	if ((obj = obj_hash[H(hashval, 0)]) && !hashcmp(sha1, obj->sha1))
 		return obj;
 	if ((obj = obj_hash[H(hashval, 1)]) && !hashcmp(sha1, obj->sha1))
 		return obj;
 	if ((obj = obj_hash[H(hashval, 2)]) && !hashcmp(sha1, obj->sha1))
 		return obj;
-	if ((obj = obj_hash[H(hashval, 3)]) && !hashcmp(sha1, obj->sha1))
-		return obj;
 	return NULL;
 }
 
@@ -82,9 +80,9 @@ static struct object *insert_obj_hash(struct object *obj)
 	for (loop = obj_hash_size / 2; 0 <= loop; loop--) {
 		struct object *tmp_obj;
 		unsigned int ix;
-		unsigned int hashval[4];
+		unsigned int hashval[3];
 
-		memcpy(hashval, obj->sha1, 16);
+		memcpy(hashval, obj->sha1, 12);
 		ix = H(hashval, 0);
 		if (!obj_hash[ix]) {
 			obj_hash[ix] = obj;
@@ -96,11 +94,6 @@ static struct object *insert_obj_hash(struct object *obj)
 			return NULL;
 		}
 		ix = H(hashval, 2);
-		if (!obj_hash[ix]) {
-			obj_hash[ix] = obj;
-			return NULL;
-		}
-		ix = H(hashval, 3);
 		tmp_obj = obj_hash[ix];
 		obj_hash[ix] = obj;
 		if (!tmp_obj)
-- 
1.7.6.433.g1421f
