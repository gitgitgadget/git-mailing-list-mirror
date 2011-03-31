From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 3/4] Use uint32_t for index-pack counters
Date: Wed, 30 Mar 2011 20:24:33 -0500
Message-ID: <1301534674-31981-3-git-send-email-dpmcgee@gmail.com>
References: <1301534674-31981-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 03:25:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q56dE-0007mz-DD
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 03:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933647Ab1CaBYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 21:24:46 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60974 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab1CaBYo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 21:24:44 -0400
Received: by gxk21 with SMTP id 21so782876gxk.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 18:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=BVjFPufWhQu6GK8A72WO050LVo54V1bYwHRwvgqczc0=;
        b=aMVpf7J44LVGp9kcGsR5vWvksddgPPwz1x2IAcJi1dQDIoFV7q7LCC9E2g6AoOF6nH
         tB/Vy7AZcwn+5mO+OY1ZRtpMK8LoaxhN0gJJVbalk4YrnfnYKNP5evXTxgA/9fAGPOii
         zc9Rb8cWBhTvwWx9MZQ76debPkURG0p5428SM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nhwJAVwCWEf8tarL4ouL95OJ7rRxlnS1TkYx4CxY4yTpVhSgAgm25drD3o5UDQFjIN
         YOQLz7wSj19MWsShLtcsEdHuWSFxwMA4vc9Igqu/K2/UuOaKOZbzdDH8N0cMLttMLP1j
         1pBIqJpF7+dWTjRqX0t2S+npO2n2NnCKI/YNo=
Received: by 10.236.31.36 with SMTP id l24mr2818655yha.197.1301534683277;
        Wed, 30 Mar 2011 18:24:43 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id t35sm349650yhg.29.2011.03.30.18.24.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 18:24:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <1301534674-31981-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170438>

This is a bit more complex than the fixes needed for unpack-objects. A
few very old methods were refactored to eliminate the need for negative
value returns or usage.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 builtin/index-pack.c |   89 ++++++++++++++++++++++++-------------------------
 1 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 5a67c81..38e61db 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -45,16 +45,16 @@ struct base_data {
 
 struct delta_entry {
 	union delta_base base;
-	int obj_no;
+	uint32_t obj_no;
 };
 
 static struct object_entry *objects;
 static struct delta_entry *deltas;
 static struct base_data *base_cache;
 static size_t base_cache_used;
-static int nr_objects;
-static int nr_deltas;
-static int nr_resolved_deltas;
+static uint32_t nr_objects;
+static uint32_t nr_deltas;
+static uint32_t nr_resolved_deltas;
 
 static int from_stdin;
 static int strict;
@@ -389,42 +389,40 @@ static void *get_data_from_pack(struct object_entry *obj)
 	return data;
 }
 
-static int find_delta(const union delta_base *base)
-{
-	int first = 0, last = nr_deltas;
-
-        while (first < last) {
-                int next = (first + last) / 2;
-                struct delta_entry *delta = &deltas[next];
-                int cmp;
-
-                cmp = memcmp(base, &delta->base, UNION_BASE_SZ);
-                if (!cmp)
-                        return next;
-                if (cmp < 0) {
-                        last = next;
-                        continue;
-                }
-                first = next+1;
-        }
-        return -first-1;
-}
-
 static void find_delta_children(const union delta_base *base,
-				int *first_index, int *last_index)
+				uint32_t *first_index, uint32_t *last_index)
 {
-	int first = find_delta(base);
-	int last = first;
-	int end = nr_deltas - 1;
+	uint32_t first = 0, last = nr_deltas, next;
 
-	if (first < 0) {
-		*first_index = 0;
-		*last_index = -1;
+	while (first < last) {
+		int cmp;
+		struct delta_entry *delta;
+
+		next = (first + last) / 2;
+		delta = &deltas[next];
+
+		cmp = memcmp(base, &delta->base, UNION_BASE_SZ);
+		if (!cmp)
+			break;
+		if (cmp < 0) {
+			last = next;
+			continue;
+		}
+		first = next + 1;
+	}
+
+	if (first >= last) {
+		/* return non-sensical first/last to show we found nothing */
+		*first_index = 1;
+		*last_index = 0;
 		return;
 	}
+
+	last = first = next;
+
 	while (first > 0 && !memcmp(&deltas[first - 1].base, base, UNION_BASE_SZ))
 		--first;
-	while (last < end && !memcmp(&deltas[last + 1].base, base, UNION_BASE_SZ))
+	while (last < (nr_deltas - 1) && !memcmp(&deltas[last + 1].base, base, UNION_BASE_SZ))
 		++last;
 	*first_index = first;
 	*last_index = last;
@@ -531,7 +529,7 @@ static void resolve_delta(struct object_entry *delta_obj,
 static void find_unresolved_deltas(struct base_data *base,
 				   struct base_data *prev_base)
 {
-	int i, ref_first, ref_last, ofs_first, ofs_last;
+	uint32_t i, ref_first, ref_last, ofs_first, ofs_last;
 
 	/*
 	 * This is a recursive function. Those brackets should help reducing
@@ -548,7 +546,7 @@ static void find_unresolved_deltas(struct base_data *base,
 		find_delta_children(&base_spec, &ofs_first, &ofs_last);
 	}
 
-	if (ref_last == -1 && ofs_last == -1) {
+	if (ref_last < ref_first && ofs_last < ofs_first) {
 		free(base->data);
 		return;
 	}
@@ -560,7 +558,7 @@ static void find_unresolved_deltas(struct base_data *base,
 		if (child->real_type == OBJ_REF_DELTA) {
 			struct base_data result;
 			resolve_delta(child, base, &result);
-			if (i == ref_last && ofs_last == -1)
+			if (i == ref_last && ofs_last < ofs_first)
 				free_base_data(base);
 			find_unresolved_deltas(&result, base);
 		}
@@ -590,7 +588,7 @@ static int compare_delta_entry(const void *a, const void *b)
 /* Parse all objects and return the pack content SHA1 hash */
 static void parse_pack_objects(unsigned char *sha1)
 {
-	int i;
+	uint32_t i;
 	struct delta_entry *delta = deltas;
 	struct stat st;
 
@@ -615,7 +613,7 @@ static void parse_pack_objects(unsigned char *sha1)
 		} else
 			sha1_object(data, obj->size, obj->type, obj->idx.sha1);
 		free(data);
-		display_progress(progress, i+1);
+		display_progress(progress, i + 1);
 	}
 	objects[i].idx.offset = consumed_bytes;
 	stop_progress(&progress);
@@ -726,10 +724,10 @@ static int delta_pos_compare(const void *_a, const void *_b)
 	return a->obj_no - b->obj_no;
 }
 
-static void fix_unresolved_deltas(struct sha1file *f, int nr_unresolved)
+static void fix_unresolved_deltas(struct sha1file *f, uint32_t nr_unresolved)
 {
 	struct delta_entry **sorted_by_pos;
-	int i, n = 0;
+	uint32_t i, n = 0;
 
 	/*
 	 * Since many unresolved deltas may well be themselves base objects
@@ -979,16 +977,17 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 			struct sha1file *f;
 			unsigned char read_sha1[20], tail_sha1[20];
 			char msg[48];
-			int nr_unresolved = nr_deltas - nr_resolved_deltas;
-			int nr_objects_initial = nr_objects;
-			if (nr_unresolved <= 0)
+			uint32_t nr_unresolved, nr_objects_initial;
+			if (nr_resolved_deltas > nr_deltas)
 				die("confusion beyond insanity");
+			nr_unresolved = nr_deltas - nr_resolved_deltas;
+			nr_objects_initial = nr_objects;
 			objects = xrealloc(objects,
 					   (nr_objects + nr_unresolved + 1)
 					   * sizeof(*objects));
 			f = sha1fd(output_fd, curr_pack);
 			fix_unresolved_deltas(f, nr_unresolved);
-			sprintf(msg, "completed with %d local objects",
+			sprintf(msg, "completed with %u local objects",
 				nr_objects - nr_objects_initial);
 			stop_progress_msg(&progress, msg);
 			sha1close(f, tail_sha1, 0);
@@ -1001,7 +1000,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				    "(disk corruption?)", curr_pack);
 		}
 		if (nr_deltas != nr_resolved_deltas)
-			die("pack has %d unresolved deltas",
+			die("pack has %u unresolved deltas",
 			    nr_deltas - nr_resolved_deltas);
 	}
 	free(deltas);
-- 
1.7.4.2
