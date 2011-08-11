From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/11] object.c: remove duplicated code for object hashing
Date: Thu, 11 Aug 2011 10:53:07 -0700
Message-ID: <1313085196-13249-3-git-send-email-gitster@pobox.com>
References: <1313085196-13249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 19:53:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrZRm-0008JJ-Td
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 19:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902Ab1HKRx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 13:53:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44543 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249Ab1HKRxW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 13:53:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3EC9417A
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=uk2G
	FuKjeqYHDIurC2l9qigNblM=; b=rDXqk2ONrcy16DGPg8Kdd0bd7lGQJFDTlNjD
	Opmbg8zS7vI5CKkTPYycKaPdVM6CyAfRTvzlETzcX+URx9OUa4bz1pzjPC90e1pa
	yBdbg1BQVON0EGqtpeWxfuJZiujSCUkufxRgRYOaQ1q1Jlv8flFeIZ+9BcC4sU4D
	Y81uxR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Uj+VBW
	H4RGeZZ6ZgXPAfPQqSGofuWne7RfPwUKTrwKrisT/Y5HOkDEGMz2CRDQOPbF4O/y
	SG+iuxZam0uTuBARATVKUIy9zmOBssN+nv5543gkq3/y4sV8gy9BbplQFNiqjwRr
	7QRhHDJHBzLL/DQXa+FLjKUTw2RAsOiu/+gX4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB5E14179
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C8874177 for
 <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:21 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.433.g1421f
In-Reply-To: <1313085196-13249-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CD6DFCB6-C442-11E0-8D5B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179117>

The index into object hash was computed in two different places,
risking them to diverge. Implement a single helper function and
use it in these two locations.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/object.c b/object.c
index 35ff130..4ff2d7d 100644
--- a/object.c
+++ b/object.c
@@ -43,23 +43,16 @@ struct object *get_indexed_object(unsigned int idx)
 	return obj_hash[idx];
 }
 
-static unsigned int hash_obj(struct object *obj, unsigned int n)
+static unsigned int hash_val(const unsigned char *sha1)
 {
 	unsigned int hash;
-	memcpy(&hash, obj->sha1, sizeof(unsigned int));
-	return hash % n;
-}
-
-static unsigned int hashtable_index(const unsigned char *sha1)
-{
-	unsigned int i;
-	memcpy(&i, sha1, sizeof(unsigned int));
-	return i % obj_hash_size;
+	memcpy(&hash, sha1, sizeof(unsigned int));
+	return hash;
 }
 
 static void insert_obj_hash(struct object *obj, struct object **hash, unsigned int size)
 {
-	unsigned int j = hash_obj(obj, size);
+	unsigned int j = hash_val(obj->sha1) % size;
 
 	while (hash[j]) {
 		j++;
@@ -77,7 +70,7 @@ struct object *lookup_object(const unsigned char *sha1)
 	if (!obj_hash)
 		return NULL;
 
-	i = hashtable_index(sha1);
+	i = hash_val(sha1) % obj_hash_size;
 	while ((obj = obj_hash[i]) != NULL) {
 		if (!hashcmp(sha1, obj->sha1))
 			break;
-- 
1.7.6.433.g1421f
