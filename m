From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] object: reclaim one bit in the flags field
Date: Mon, 27 Jun 2011 10:50:59 -0700
Message-ID: <1309197059-7177-3-git-send-email-gitster@pobox.com>
References: <1309197059-7177-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 27 19:54:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbG1R-0000yR-AE
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 19:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab1F0Rw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 13:52:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45668 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907Ab1F0RvG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 13:51:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 27A35657D
	for <git@vger.kernel.org>; Mon, 27 Jun 2011 13:53:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=7htU
	UUqVOsUt+mW/3+sOEBEdcKE=; b=mpvh2yzBvL2vNMvOGWPUdqtKPJtifpYj+jif
	/OizXYOPOzAi/MOH1m+B94qjBcUP4hxtSGonsI8FeBDmJ0JLXWeZvPHOtIO62YQB
	gOUejbOdB2COl2ihfyYYUHu3gD+Bb+YjPXbxOZV1nQcPAH4E3fhGAd9DfroZFM3o
	SbVhZeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Ah0c7V
	OuK5srgtrY3m6vf6jUJWOu4c7Z0UtMhK3Ell39mErw/8dYXqFLCe21ggRMXyG8Rs
	3QGM0urMXx7vTnt4CQLjRiVrxRPwVcmB94PuXrAx/bzECZGJH48dWv1GYYjLVVCk
	mBpgr+AL2zB7j1GqkPH5uEmNDAA9zBQf4XFvI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 20039657C
	for <git@vger.kernel.org>; Mon, 27 Jun 2011 13:53:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4CCEB657B for
 <git@vger.kernel.org>; Mon, 27 Jun 2011 13:53:17 -0400 (EDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1309197059-7177-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5660DA96-A0E6-11E0-A44D-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176356>

The object layer has "used" bit in the structure that is only used while
running fsck. Remove it, and instead use one bit from the flags to record
the fact that an object is referenced from some other object (only during
fsck).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsck.c |    7 ++++---
 object.c       |    1 -
 object.h       |    3 +--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 90f5c2c..dde0907 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -14,6 +14,7 @@
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
+#define USED	  0x0004
 
 static int show_root;
 static int show_tags;
@@ -114,7 +115,7 @@ static int mark_object(struct object *obj, int type, void *data)
 static void mark_object_reachable(struct object *obj)
 {
 	if (obj) {
-		obj->used = 1;
+		obj->flags |= USED;
 		mark_object(obj, OBJ_ANY, NULL);
 	}
 }
@@ -156,7 +157,7 @@ static int mark_used(struct object *obj, int type, void *data)
 {
 	if (!obj)
 		return 1;
-	obj->used = 1;
+	obj->flags |= USED;
 	return 0;
 }
 
@@ -214,7 +215,7 @@ static void check_unreachable_object(struct object *obj)
 	 * deleted a branch by mistake, this is a prime candidate to
 	 * start looking at, for example.
 	 */
-	if (!obj->used) {
+	if (!(obj->flags & USED)) {
 		printf("dangling %s %s\n", typename(obj->type),
 		       sha1_to_hex(obj->sha1));
 		if (write_lost_and_found) {
diff --git a/object.c b/object.c
index 31976b5..4a9d77f 100644
--- a/object.c
+++ b/object.c
@@ -111,7 +111,6 @@ void *create_object(const unsigned char *sha1, int type, void *o)
 	struct object *obj = o;
 
 	obj->parsed = 0;
-	obj->used = 0;
 	obj->type = type;
 	obj->flags = 0;
 	hashcpy(obj->sha1, sha1);
diff --git a/object.h b/object.h
index b6618d9..dbfc88f 100644
--- a/object.h
+++ b/object.h
@@ -19,14 +19,13 @@ struct object_array {
 #define OBJECT_ARRAY_INIT { 0, 0, NULL }
 
 #define TYPE_BITS   3
-#define FLAG_BITS  27
+#define FLAG_BITS  (31-TYPE_BITS)
 
 /*
  * The object type is stored in 3 bits.
  */
 struct object {
 	unsigned parsed : 1;
-	unsigned used : 1;
 	unsigned type : TYPE_BITS;
 	unsigned flags : FLAG_BITS;
 	unsigned char sha1[20];
-- 
1.7.6
