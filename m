From: Junio C Hamano <gitster@pobox.com>
Subject: [FFT/PATCH 12/11] object.c: make object hash implementation more
 opaque
Date: Thu, 11 Aug 2011 16:33:48 -0700
Message-ID: <7vd3gbplpf.fsf@alter.siamese.dyndns.org>
References: <1313085196-13249-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 01:34:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrelB-0002FM-O5
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 01:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071Ab1HKXdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 19:33:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60005 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753627Ab1HKXdw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 19:33:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E2A84774;
	Thu, 11 Aug 2011 19:33:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kOD8zqESBL/V/FuHv5PrpEBHWYU=; b=XGUXMA
	PRJd6oRZR/QBwpzumCcx8jBGhM2vu65/8Lu2PzphsaHrcEUCNLEnS+2SlmfFvigf
	/CkUjdUjxUDPegXvOgzsrtEB4Rt8Bpej7YmOIO6PXZsMCLD+MJQ/Z6792/laJMQS
	We4y4HbWtQujTJD7z+TgTJxnkFKT4KL0L/xMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SA9spxwN6Z2OcYiIPMQCC393hgyzcCos
	dm0TBerQuFaOpw9qLQW+rc6sxNfcl9H4v4sgoq8HT8QGGpMW+S/WvePPAmCf2Ogg
	Sdn04cyQe3+B6c5FcXk19mWePmKnt9Um0pYwGAtwoDGvvcXHQMnHF68wt9C9X0To
	HJi11F9IVVc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 061D04773;
	Thu, 11 Aug 2011 19:33:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C1C54772; Thu, 11 Aug 2011
 19:33:49 -0400 (EDT)
In-Reply-To: <1313085196-13249-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Thu, 11 Aug 2011 10:53:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5DD3D378-C472-11E0-9792-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179152>

There are only a handful of callers that want to enumerate all the objects
known to the process. Unfortunately they at least know that the object
hash can be iterated over with an integer index.

Introduce an opaque "struct object_cursor" type to hide the implementation
detail, so that later we may be able to switch to an implementation that
is not a based on a flat and sparse array that is used as a hash table.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is not necessary for the purpose of the earlier "cuckoo" update,
   as that still is an implementation based on a single flat sparse array,
   but I am throwing it out as a food-for-thought.

   - The function "object_cursor_max()" returns obj_hash_size, but it only
     is used by fsck to give an overestimate of the number of objects to
     check. We could change it to return nr_obj to give a more precise
     number, but I kept the behaviour bug-for-bug compatible for now.

   - Later if we need to libify the in-core object store, we would wrap
     obj_hash, nr_obj and obj_hash_size into a single "struct obj_ctx"
     (the context of a series of git operations that access the object
     store), and have a pointer to it in the "struct object_cursor".
     get_object_cursor() API function may get a new variant that takes a
     pointer to "struct obj_ctx" to switch between contexts, etc.

   This patch is designed to apply before all the others, outside the main
   series. If this "more opaque" approach is going in a desirable
   direction, the "cuckoo" series should be rebased on top of this.

 builtin/fsck.c       |   17 ++++++++---------
 builtin/index-pack.c |   10 ++++++----
 builtin/name-rev.c   |   12 +++++-------
 object.c             |   34 ++++++++++++++++++++++++++++++----
 object.h             |    7 +++++--
 5 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 5ae0366..a71b36d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -266,22 +266,21 @@ static void check_object(struct object *obj)
 
 static void check_connectivity(void)
 {
-	int i, max;
+	struct object_cursor *objects;
+	struct object *obj;
 
 	/* Traverse the pending reachable objects */
 	traverse_reachable();
 
 	/* Look up all the requirements, warn about missing objects.. */
-	max = get_max_object_index();
+	objects = get_object_cursor();
 	if (verbose)
-		fprintf(stderr, "Checking connectivity (%d objects)\n", max);
-
-	for (i = 0; i < max; i++) {
-		struct object *obj = get_indexed_object(i);
+		fprintf(stderr, "Checking connectivity (%d objects)\n",
+			object_cursor_max(objects));
 
-		if (obj)
-			check_object(obj);
-	}
+	while ((obj = get_next_object(objects)) != NULL)
+		check_object(obj);
+	free_object_cursor(objects);
 }
 
 static int fsck_sha1(const unsigned char *sha1)
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index e40451f..ca172d5 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -104,11 +104,13 @@ static void check_object(struct object *obj)
 
 static void check_objects(void)
 {
-	unsigned i, max;
+	struct object_cursor *objects;
+	struct object *obj;
 
-	max = get_max_object_index();
-	for (i = 0; i < max; i++)
-		check_object(get_indexed_object(i));
+	objects = get_object_cursor();
+	while ((obj = get_next_object(objects)) != NULL)
+		check_object(obj);
+	free_object_cursor(objects);
 }
 
 
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 31f5c1c..ec6b952 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -284,16 +284,14 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 			name_rev_line(p, &data);
 		}
 	} else if (all) {
-		int i, max;
+		struct object_cursor *objects;
+		struct object *obj;
 
-		max = get_max_object_index();
-		for (i = 0; i < max; i++) {
-			struct object *obj = get_indexed_object(i);
-			if (!obj)
-				continue;
+		objects = get_object_cursor();
+		while ((obj = get_next_object(objects)) != NULL)
 			show_name(obj, NULL,
 				  always, allow_undefined, data.name_only);
-		}
+		free_object_cursor(objects);
 	} else {
 		int i;
 		for (i = 0; i < revs.nr; i++)
diff --git a/object.c b/object.c
index 31976b5..986d243 100644
--- a/object.c
+++ b/object.c
@@ -8,14 +8,40 @@
 static struct object **obj_hash;
 static int nr_objs, obj_hash_size;
 
-unsigned int get_max_object_index(void)
+struct object_cursor {
+	int cursor_at;
+};
+
+struct object_cursor *get_object_cursor(void)
 {
-	return obj_hash_size;
+	struct object_cursor *objects;
+	objects = xmalloc(sizeof(*objects));
+	objects->cursor_at = 0;
+	return objects;
+}
+
+int object_cursor_max(struct object_cursor *objects)
+{
+	return obj_hash_size; /* nr_objs is more precise, though */
+}
+
+struct object *get_next_object(struct object_cursor *objects)
+{
+	int i = objects->cursor_at;
+	while (i < obj_hash_size) {
+		struct object *obj = obj_hash[i++];
+		if (!obj)
+			continue;
+		objects->cursor_at = i;
+		return obj;
+	}
+	objects->cursor_at = i;
+	return NULL;
 }
 
-struct object *get_indexed_object(unsigned int idx)
+void free_object_cursor(struct object_cursor *objects)
 {
-	return obj_hash[idx];
+	free(objects);
 }
 
 static const char *object_type_strings[] = {
diff --git a/object.h b/object.h
index b6618d9..fdd14a1 100644
--- a/object.h
+++ b/object.h
@@ -35,8 +35,11 @@ struct object {
 extern const char *typename(unsigned int type);
 extern int type_from_string(const char *str);
 
-extern unsigned int get_max_object_index(void);
-extern struct object *get_indexed_object(unsigned int);
+struct object_cursor; /* opaque */
+extern struct object_cursor *get_object_cursor(void);
+extern int object_cursor_max(struct object_cursor *);
+extern struct object *get_next_object(struct object_cursor *);
+extern void free_object_cursor(struct object_cursor *);
 
 /*
  * This can be used to see if we have heard of the object before, but
