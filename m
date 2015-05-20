From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 3/4] for-each-ref: convert to ref-filter
Date: Wed, 20 May 2015 18:48:23 +0530
Message-ID: <1432127904-21070-3-git-send-email-karthik.188@gmail.com>
References: <555C88C2.8060902@gmail.com>
Cc: matthieu.moy@grenoble-inp.fr, christian.couder@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 15:19:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv3u0-0002Yk-9A
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 15:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbbETNTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 09:19:04 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36650 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbbETNTA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 09:19:00 -0400
Received: by pabts4 with SMTP id ts4so67010645pab.3
        for <git@vger.kernel.org>; Wed, 20 May 2015 06:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+AvA2iYn2qY+uEuBPQ+cv8mbI9nfcpqY+BknBCK+xVo=;
        b=AIS/uL5uj5Pn/LJoHmfdwbOt0d0An8HhE7MYBMTqJniVTKrEmMTCSLRQwPATNjZU3f
         PaMQGOaqNfjm7yNJLKrrtf/3mBnz6BNep0ecbSt0tAPzJX+t+235GzoE+Uj9hYmbHK6+
         Znf8eF6fE1IWO9N1hOgoyDClnDlipzQrvbLKp5n4rUYvlp34heY9qAOSCnDKgKUUa9Eh
         8VgUZsZIgRqC0aD6ODRLNtgEHpFFNbpARhWoxWPOaNV8XNvVrmFQ3ipWRV391DGd5vv5
         gZfQa7S0Zr6f0S0aU80zDnE5XM/TYPh9tBwZPOg6Lyn/iw1K9ffy/qpB/9d+s76BwptI
         yy5Q==
X-Received: by 10.68.114.131 with SMTP id jg3mr328897pbb.54.1432127939810;
        Wed, 20 May 2015 06:18:59 -0700 (PDT)
Received: from ashley.localdomain ([106.51.128.148])
        by mx.google.com with ESMTPSA id g2sm16230585pdn.3.2015.05.20.06.18.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 May 2015 06:18:59 -0700 (PDT)
X-Mailer: git-send-email 2.4.1
In-Reply-To: <555C88C2.8060902@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269464>

convert 'for-each-ref' to use the common API provided by 'ref-filter'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 118 +++++++++----------------------------------------
 1 file changed, 20 insertions(+), 98 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 2721228..c9875d1 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -10,6 +10,7 @@
 #include "parse-options.h"
 #include "remote.h"
 #include "color.h"
+#include "ref-filter.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -20,25 +21,6 @@
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
-struct atom_value {
-	const char *s;
-	unsigned long ul; /* used for sorting when not FIELD_STR */
-};
-
-struct ref_sort {
-	struct ref_sort *next;
-	int atom; /* index into used_atom array */
-	unsigned reverse : 1;
-};
-
-struct refinfo {
-	char *name;
-	unsigned char sha1[20];
-	int flags;
-	const char *symref;
-	struct atom_value *value;
-};
-
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -85,7 +67,7 @@ static struct {
  * a "*" to denote deref_tag().
  *
  * We parse given format string and sort specifiers, and make a list
- * of properties that we need to extract out of objects.  refinfo
+ * of properties that we need to extract out of objects.  ref_filter_item
  * structure will hold an array of values extracted that can be
  * indexed with the "atom number", which is an index into this
  * array.
@@ -622,7 +604,7 @@ static inline char *copy_advance(char *dst, const char *src)
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-static void populate_value(struct refinfo *ref)
+static void populate_value(struct ref_filter_item *ref)
 {
 	void *buf;
 	struct object *obj;
@@ -821,7 +803,7 @@ static void populate_value(struct refinfo *ref)
  * Given a ref, return the value for the atom.  This lazily gets value
  * out of the object by calling populate value.
  */
-static void get_value(struct refinfo *ref, int atom, struct atom_value **v)
+static void get_value(struct ref_filter_item *ref, int atom, struct atom_value **v)
 {
 	if (!ref->value) {
 		populate_value(ref);
@@ -830,65 +812,7 @@ static void get_value(struct refinfo *ref, int atom, struct atom_value **v)
 	*v = &ref->value[atom];
 }
 
-struct grab_ref_cbdata {
-	struct refinfo **grab_array;
-	const char **grab_pattern;
-	int grab_cnt;
-};
-
-/*
- * A call-back given to for_each_ref().  Filter refs and keep them for
- * later object processing.
- */
-static int grab_single_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
-{
-	struct grab_ref_cbdata *cb = cb_data;
-	struct refinfo *ref;
-	int cnt;
-
-	if (flag & REF_BAD_NAME) {
-		  warning("ignoring ref with broken name %s", refname);
-		  return 0;
-	}
-
-	if (*cb->grab_pattern) {
-		const char **pattern;
-		int namelen = strlen(refname);
-		for (pattern = cb->grab_pattern; *pattern; pattern++) {
-			const char *p = *pattern;
-			int plen = strlen(p);
-
-			if ((plen <= namelen) &&
-			    !strncmp(refname, p, plen) &&
-			    (refname[plen] == '\0' ||
-			     refname[plen] == '/' ||
-			     p[plen-1] == '/'))
-				break;
-			if (!wildmatch(p, refname, WM_PATHNAME, NULL))
-				break;
-		}
-		if (!*pattern)
-			return 0;
-	}
-
-	/*
-	 * We do not open the object yet; sort may only need refname
-	 * to do its job and the resulting list may yet to be pruned
-	 * by maxcount logic.
-	 */
-	ref = xcalloc(1, sizeof(*ref));
-	ref->name = xstrdup(refname);
-	hashcpy(ref->sha1, sha1);
-	ref->flags = flag;
-
-	cnt = cb->grab_cnt;
-	REALLOC_ARRAY(cb->grab_array, cnt + 1);
-	cb->grab_array[cnt++] = ref;
-	cb->grab_cnt = cnt;
-	return 0;
-}
-
-static int cmp_ref_sort(struct ref_sort *s, struct refinfo *a, struct refinfo *b)
+static int cmp_ref_sort(struct ref_sort *s, struct ref_filter_item *a, struct ref_filter_item *b)
 {
 	struct atom_value *va, *vb;
 	int cmp;
@@ -915,8 +839,8 @@ static int cmp_ref_sort(struct ref_sort *s, struct refinfo *a, struct refinfo *b
 static struct ref_sort *ref_sort;
 static int compare_refs(const void *a_, const void *b_)
 {
-	struct refinfo *a = *((struct refinfo **)a_);
-	struct refinfo *b = *((struct refinfo **)b_);
+	struct ref_filter_item *a = *((struct ref_filter_item **)a_);
+	struct ref_filter_item *b = *((struct ref_filter_item **)b_);
 	struct ref_sort *s;
 
 	for (s = ref_sort; s; s = s->next) {
@@ -927,10 +851,10 @@ static int compare_refs(const void *a_, const void *b_)
 	return 0;
 }
 
-static void sort_refs(struct ref_sort *sort, struct refinfo **refs, int num_refs)
+static void sort_refs(struct ref_sort *sort, struct ref_filter *refs)
 {
 	ref_sort = sort;
-	qsort(refs, num_refs, sizeof(struct refinfo *), compare_refs);
+	qsort(refs->items, refs->count, sizeof(struct ref_filter_item *), compare_refs);
 }
 
 static void print_value(struct atom_value *v, int quote_style)
@@ -997,7 +921,7 @@ static void emit(const char *cp, const char *ep)
 	}
 }
 
-static void show_ref(struct refinfo *info, const char *format, int quote_style)
+static void show_ref(struct ref_filter_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
 
@@ -1066,12 +990,12 @@ static char const * const for_each_ref_usage[] = {
 
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
-	int i, num_refs;
+	int i;
 	const char *format = "%(objectname) %(objecttype)\t%(refname)";
 	struct ref_sort *sort = NULL, **sort_tail = &sort;
 	int maxcount = 0, quote_style = 0;
-	struct refinfo **refs;
-	struct grab_ref_cbdata cbdata;
+	struct ref_filter refs;
+	memset(&refs, 0, sizeof(refs));
 
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &quote_style,
@@ -1109,17 +1033,15 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	/* for warn_ambiguous_refs */
 	git_config(git_default_config, NULL);
 
-	memset(&cbdata, 0, sizeof(cbdata));
-	cbdata.grab_pattern = argv;
-	for_each_rawref(grab_single_ref, &cbdata);
-	refs = cbdata.grab_array;
-	num_refs = cbdata.grab_cnt;
+	refs.name_patterns = argv;
+	for_each_rawref(ref_filter_add, &refs);
 
-	sort_refs(sort, refs, num_refs);
+	sort_refs(sort, &refs);
 
-	if (!maxcount || num_refs < maxcount)
-		maxcount = num_refs;
+	if (!maxcount || refs.count < maxcount)
+		maxcount = refs.count;
 	for (i = 0; i < maxcount; i++)
-		show_ref(refs[i], format, quote_style);
+		show_ref(refs.items[i], format, quote_style);
+	ref_filter_clear(&refs);
 	return 0;
 }
-- 
2.4.1
