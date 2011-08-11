From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/11] object: try 2-way cuckoo again
Date: Thu, 11 Aug 2011 10:53:16 -0700
Message-ID: <1313085196-13249-12-git-send-email-gitster@pobox.com>
References: <1313085196-13249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 19:54:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrZSV-0000IQ-Kh
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 19:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023Ab1HKRxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 13:53:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44750 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974Ab1HKRxm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 13:53:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38EE941AE
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xSw8
	HHf4Fp7fTaxpwcKDF9i71/c=; b=hZyMacXaWH0jZ2sm5ga7lKOEdWFcbcdR8SI6
	O8srjeLYo9sYrBzqVbsBi3FMsSvhwun4HRCG/DIBWWo91c5COXHJsaM+E2eHzBHi
	wjT3QFb+8PMdd2PjjgJV+48OKQESZjnwhBR3EyNWH5Ozd5ugwLdXZZ8vG6JPnMSy
	9wdDohc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=e93pjI
	pTlXR7xynaPfzEsi4jv58jsnkgq5jJ80vjskIzoiGhiJh9ffA++261pQ5079PVrJ
	KaXPSuRpL4M+lOTLjlppWGcwh+JdDCU4+Hjum228bZ75EZEe9DF1YMsCuP8to225
	/M3v5XqcZs8bCfc7zeirKN1FRngvmC2lgweVs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FFED41AD
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B360641AC for
 <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:41 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.433.g1421f
In-Reply-To: <1313085196-13249-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D98617A4-C442-11E0-AE95-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179121>

This should match the first "naive" cuckoo hashing implementation.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
../+v/ddb2c7c09c7af16bf00aa5aef6cdf54ae4611aec/git-pack-objects
Counting objects: 2139209, done.
31.28user 3.15system 0:34.53elapsed 99%CPU (0avgtext+0avgdata 8177056maxresident)k
0inputs+0outputs (0major+1206514minor)pagefaults 0swaps
Counting objects: 2139209, done.
31.06user 3.26system 0:34.43elapsed 99%CPU (0avgtext+0avgdata 8177056maxresident)k
0inputs+0outputs (0major+1206514minor)pagefaults 0swaps
Counting objects: 2139209, done.
31.06user 3.22system 0:34.39elapsed 99%CPU (0avgtext+0avgdata 8176512maxresident)k
0inputs+0outputs (0major+1206542minor)pagefaults 0swaps
---
 object.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/object.c b/object.c
index 18e6bcf..fc08e5b 100644
--- a/object.c
+++ b/object.c
@@ -49,18 +49,16 @@ struct object *get_indexed_object(unsigned int idx)
 struct object *lookup_object(const unsigned char *sha1)
 {
 	struct object *obj;
-	unsigned int hashval[3];
+	unsigned int hashval[2];
 
 	if (!obj_hash)
 		return NULL;
 
-	memcpy(hashval, sha1, 12);
+	memcpy(hashval, sha1, 8);
 	if ((obj = obj_hash[H(hashval, 0)]) && !hashcmp(sha1, obj->sha1))
 		return obj;
 	if ((obj = obj_hash[H(hashval, 1)]) && !hashcmp(sha1, obj->sha1))
 		return obj;
-	if ((obj = obj_hash[H(hashval, 2)]) && !hashcmp(sha1, obj->sha1))
-		return obj;
 	return NULL;
 }
 
@@ -80,20 +78,15 @@ static struct object *insert_obj_hash(struct object *obj)
 	for (loop = obj_hash_size / 2; 0 <= loop; loop--) {
 		struct object *tmp_obj;
 		unsigned int ix;
-		unsigned int hashval[3];
+		unsigned int hashval[2];
 
-		memcpy(hashval, obj->sha1, 12);
+		memcpy(hashval, obj->sha1, 8);
 		ix = H(hashval, 0);
 		if (!obj_hash[ix]) {
 			obj_hash[ix] = obj;
 			return NULL;
 		}
 		ix = H(hashval, 1);
-		if (!obj_hash[ix]) {
-			obj_hash[ix] = obj;
-			return NULL;
-		}
-		ix = H(hashval, 2);
 		tmp_obj = obj_hash[ix];
 		obj_hash[ix] = obj;
 		if (!tmp_obj)
-- 
1.7.6.433.g1421f
