From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/11] object: try 5-way cuckoo -- use all 20-bytes of SHA-1
Date: Thu, 11 Aug 2011 10:53:13 -0700
Message-ID: <1313085196-13249-9-git-send-email-gitster@pobox.com>
References: <1313085196-13249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 19:54:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrZSV-0000IQ-4N
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 19:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031Ab1HKRxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 13:53:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44652 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942Ab1HKRxh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 13:53:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84FF141A2
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=x3nb
	1mPGGqjghSZguqkYMouBym0=; b=O0A9WCVwRRbplZ/q6KYgzPbi+BDVi3KFPXGP
	Z2v2CHDqQ8kRld6x7jVN1yRea5jlLXIpBlwCCPiRhch14ZoxG+qd1i4pUIyusvw3
	uifl+0qRN6Pck2J4TXdQI2PSVLHt59aJLU6DcGxQB3MjNz/gYQsfgZ68a5lgBlNQ
	WU8fKhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=tejQA8
	my1ehoPIh776LwnpYwUfUyysisQBlJcXTDFiNZh34QEtHvbxNp6DUBod/vPseoiz
	VJq6v2hkjaJHxeTAV7WVU0IxbGvcV07cbdNHwx19I/aW3YHzT5atxK3E0ErxI1r/
	aUIh7QE8PVBMojvCMZjokJCOEjB7S4hS3lfDg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CF2A41A1
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7768419F for
 <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.433.g1421f
In-Reply-To: <1313085196-13249-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D6132DB4-C442-11E0-B3ED-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179120>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
../+v/ced878c983ddc9a256b22535aa8af006529ec3d0/git-pack-objects
Counting objects: 2139209, done.
31.66user 2.14system 0:33.91elapsed 99%CPU (0avgtext+0avgdata 2874176maxresident)k
0inputs+0outputs (0major+225342minor)pagefaults 0swaps
Counting objects: 2139209, done.
31.79user 2.03system 0:33.93elapsed 99%CPU (0avgtext+0avgdata 2875808maxresident)k
0inputs+0outputs (0major+225444minor)pagefaults 0swaps
Counting objects: 2139209, done.
31.80user 1.94system 0:33.84elapsed 99%CPU (0avgtext+0avgdata 2875792maxresident)k
0inputs+0outputs (0major+225443minor)pagefaults 0swaps
---
 object.c |   43 ++++++++++++++++++++++++++++++-------------
 1 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/object.c b/object.c
index 7624c48..c777520 100644
--- a/object.c
+++ b/object.c
@@ -43,27 +43,27 @@ struct object *get_indexed_object(unsigned int idx)
 	return obj_hash[idx];
 }
 
-static unsigned int hash_val(const unsigned char *sha1)
-{
-	unsigned int hash;
-	memcpy(&hash, sha1, sizeof(unsigned int));
-	return hash;
-}
-
 
-#define H1(sha1) (hash_val(sha1) % obj_hash_size)
-#define H2(sha1) (hash_val((sha1) + sizeof(unsigned int)) % obj_hash_size)
+#define H(hv,ix) ((hv[ix]) & (obj_hash_size-1))
 
 struct object *lookup_object(const unsigned char *sha1)
 {
 	struct object *obj;
+	unsigned int hashval[5];
 
 	if (!obj_hash)
 		return NULL;
 
-	if ((obj = obj_hash[H1(sha1)]) && !hashcmp(sha1, obj->sha1))
+	memcpy(hashval, sha1, 20);
+	if ((obj = obj_hash[H(hashval, 0)]) && !hashcmp(sha1, obj->sha1))
+		return obj;
+	if ((obj = obj_hash[H(hashval, 1)]) && !hashcmp(sha1, obj->sha1))
+		return obj;
+	if ((obj = obj_hash[H(hashval, 2)]) && !hashcmp(sha1, obj->sha1))
 		return obj;
-	if ((obj = obj_hash[H2(sha1)]) && !hashcmp(sha1, obj->sha1))
+	if ((obj = obj_hash[H(hashval, 3)]) && !hashcmp(sha1, obj->sha1))
+		return obj;
+	if ((obj = obj_hash[H(hashval, 4)]) && !hashcmp(sha1, obj->sha1))
 		return obj;
 	return NULL;
 }
@@ -84,13 +84,30 @@ static struct object *insert_obj_hash(struct object *obj)
 	for (loop = obj_hash_size / 2; 0 <= loop; loop--) {
 		struct object *tmp_obj;
 		unsigned int ix;
+		unsigned int hashval[5];
 
-		ix = H1(obj->sha1);
+		memcpy(hashval, obj->sha1, 20);
+		ix = H(hashval, 0);
+		if (!obj_hash[ix]) {
+			obj_hash[ix] = obj;
+			return NULL;
+		}
+		ix = H(hashval, 1);
+		if (!obj_hash[ix]) {
+			obj_hash[ix] = obj;
+			return NULL;
+		}
+		ix = H(hashval, 2);
+		if (!obj_hash[ix]) {
+			obj_hash[ix] = obj;
+			return NULL;
+		}
+		ix = H(hashval, 3);
 		if (!obj_hash[ix]) {
 			obj_hash[ix] = obj;
 			return NULL;
 		}
-		ix = H2(obj->sha1);
+		ix = H(hashval, 4);
 		tmp_obj = obj_hash[ix];
 		obj_hash[ix] = obj;
 		if (!tmp_obj)
-- 
1.7.6.433.g1421f
