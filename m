From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/11] object: try 4-way cuckoo
Date: Thu, 11 Aug 2011 10:53:14 -0700
Message-ID: <1313085196-13249-10-git-send-email-gitster@pobox.com>
References: <1313085196-13249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 19:54:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrZSW-0000IQ-Kx
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 19:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096Ab1HKRxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 13:53:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44681 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752989Ab1HKRxj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 13:53:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 896FE41A8
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xXjL
	0aJjGv3EoJpFjUDwJX+vlkg=; b=lGd0rzSpKe+cC3cj7Uond5MeWniqTilJ0GEh
	0Hx9qCJOO7DG39WnTGhFu+faObfo0cY2vk1wjINll2HA5C6jyhEsN8vSuWvbfcDo
	dqYemBdugNAddUPZvSi+xzQTbkZHSXy/+S0bb5ogpvJij2bjLRi8LnhKbCog41wi
	rzlEg7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=GbpQtf
	qVrRg8plycTRoeIqKrqHkSZhWdQxrZ4hx7C1FaHmTe86nFTUS8CFmWvqcUEW4HA/
	YjC4vWbJWccaoHAwCMDA3bW4faBcECWEKjJwYLHIyfCNZtORI8BZJWDaRsPpZUTh
	XA6ZVequdCHOmneVgsJ2Gt1taeaFkTQB34FLY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 818E341A7
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E048441A6 for
 <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:37 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.433.g1421f
In-Reply-To: <1313085196-13249-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D73FCF6C-C442-11E0-9D68-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179126>

The more we probe alternative slots, the more expensive average
look-up gets, while it helps reduce the load factor of the hash
table.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
../+v/6bb99816f5676ed5ddb6922363b7470a7e8c61f7/git-pack-objects
Counting objects: 2139209, done.
31.09user 2.05system 0:33.25elapsed 99%CPU (0avgtext+0avgdata 3135840maxresident)k
0inputs+0outputs (0major+290849minor)pagefaults 0swaps
Counting objects: 2139209, done.
31.12user 2.14system 0:33.37elapsed 99%CPU (0avgtext+0avgdata 3136128maxresident)k
0inputs+0outputs (0major+290866minor)pagefaults 0swaps
Counting objects: 2139209, done.
31.17user 2.01system 0:33.29elapsed 99%CPU (0avgtext+0avgdata 3136512maxresident)k
0inputs+0outputs (0major+290890minor)pagefaults 0swaps
---
 object.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/object.c b/object.c
index c777520..caced56 100644
--- a/object.c
+++ b/object.c
@@ -49,12 +49,12 @@ struct object *get_indexed_object(unsigned int idx)
 struct object *lookup_object(const unsigned char *sha1)
 {
 	struct object *obj;
-	unsigned int hashval[5];
+	unsigned int hashval[4];
 
 	if (!obj_hash)
 		return NULL;
 
-	memcpy(hashval, sha1, 20);
+	memcpy(hashval, sha1, 16);
 	if ((obj = obj_hash[H(hashval, 0)]) && !hashcmp(sha1, obj->sha1))
 		return obj;
 	if ((obj = obj_hash[H(hashval, 1)]) && !hashcmp(sha1, obj->sha1))
@@ -63,8 +63,6 @@ struct object *lookup_object(const unsigned char *sha1)
 		return obj;
 	if ((obj = obj_hash[H(hashval, 3)]) && !hashcmp(sha1, obj->sha1))
 		return obj;
-	if ((obj = obj_hash[H(hashval, 4)]) && !hashcmp(sha1, obj->sha1))
-		return obj;
 	return NULL;
 }
 
@@ -84,9 +82,9 @@ static struct object *insert_obj_hash(struct object *obj)
 	for (loop = obj_hash_size / 2; 0 <= loop; loop--) {
 		struct object *tmp_obj;
 		unsigned int ix;
-		unsigned int hashval[5];
+		unsigned int hashval[4];
 
-		memcpy(hashval, obj->sha1, 20);
+		memcpy(hashval, obj->sha1, 16);
 		ix = H(hashval, 0);
 		if (!obj_hash[ix]) {
 			obj_hash[ix] = obj;
@@ -103,11 +101,6 @@ static struct object *insert_obj_hash(struct object *obj)
 			return NULL;
 		}
 		ix = H(hashval, 3);
-		if (!obj_hash[ix]) {
-			obj_hash[ix] = obj;
-			return NULL;
-		}
-		ix = H(hashval, 4);
 		tmp_obj = obj_hash[ix];
 		obj_hash[ix] = obj;
 		if (!tmp_obj)
-- 
1.7.6.433.g1421f
