From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/11] object.c: code movement for readability
Date: Thu, 11 Aug 2011 10:53:06 -0700
Message-ID: <1313085196-13249-2-git-send-email-gitster@pobox.com>
References: <1313085196-13249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 19:53:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrZRl-0008JJ-Sx
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 19:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873Ab1HKRxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 13:53:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44526 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752844Ab1HKRxV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 13:53:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2311A4175
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Bpx5
	0CCc4r9yDYeXpdM5kNvBfhQ=; b=h/1cAegMVAr/5quK89U2wBIn4oWCvqKK8e5f
	Meis6wnfsVxuWSSE8NHFb8CJICgiz678oIVerKnYhYaxKhnk4/+/OaX/kicBhNV3
	hxu+dh9j8OaiFHJfRKvmlJvMqGgFNycLyDDq3t42irda+fVWbED32zGFv0ZLhx2q
	sSXkSYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=CX2VLZ
	cLxgVnWvM4cyWIp+fqTXZtpEP5OcuKQk5o0WYrHtV7nMxbaEB+t+EW+I/NUKKyhd
	9eLx6Rr0C9Pv2GrTgOYAQT+Uft7m9CkQuxj62DbZsrkY1WlsGlDlmxfkakjcH6D7
	1B8TAnoU/UQTF9R/bk7RDIJyOUdzEbClCsRKA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B5C54174
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8703B4173 for
 <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:19 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.433.g1421f
In-Reply-To: <1313085196-13249-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CC4D74D8-C442-11E0-88A7-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179116>

This only moves the lines around a bit to gather the definitions of code
and data that manage the hash function and the object hash table into one
place (examine "blame -M" output to see nothing new is introduced).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/object.c b/object.c
index 31976b5..35ff130 100644
--- a/object.c
+++ b/object.c
@@ -5,19 +5,6 @@
 #include "commit.h"
 #include "tag.h"
 
-static struct object **obj_hash;
-static int nr_objs, obj_hash_size;
-
-unsigned int get_max_object_index(void)
-{
-	return obj_hash_size;
-}
-
-struct object *get_indexed_object(unsigned int idx)
-{
-	return obj_hash[idx];
-}
-
 static const char *object_type_strings[] = {
 	NULL,		/* OBJ_NONE = 0 */
 	"commit",	/* OBJ_COMMIT = 1 */
@@ -43,6 +30,19 @@ int type_from_string(const char *str)
 	die("invalid object type \"%s\"", str);
 }
 
+static struct object **obj_hash;
+static int nr_objs, obj_hash_size;
+
+unsigned int get_max_object_index(void)
+{
+	return obj_hash_size;
+}
+
+struct object *get_indexed_object(unsigned int idx)
+{
+	return obj_hash[idx];
+}
+
 static unsigned int hash_obj(struct object *obj, unsigned int n)
 {
 	unsigned int hash;
@@ -50,6 +50,13 @@ static unsigned int hash_obj(struct object *obj, unsigned int n)
 	return hash % n;
 }
 
+static unsigned int hashtable_index(const unsigned char *sha1)
+{
+	unsigned int i;
+	memcpy(&i, sha1, sizeof(unsigned int));
+	return i % obj_hash_size;
+}
+
 static void insert_obj_hash(struct object *obj, struct object **hash, unsigned int size)
 {
 	unsigned int j = hash_obj(obj, size);
@@ -62,13 +69,6 @@ static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
 	hash[j] = obj;
 }
 
-static unsigned int hashtable_index(const unsigned char *sha1)
-{
-	unsigned int i;
-	memcpy(&i, sha1, sizeof(unsigned int));
-	return i % obj_hash_size;
-}
-
 struct object *lookup_object(const unsigned char *sha1)
 {
 	unsigned int i;
-- 
1.7.6.433.g1421f
