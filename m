From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH v3] refs: Use binary search to lookup refs faster
Date: Thu, 29 Sep 2011 23:11:42 +0100
Message-ID: <20110929221143.23806.25666.julian@quantumfyre.co.uk>
References: <4DF6A8B6.9030301@op5.se>
 <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com>
 <201109281338.04378.mfick@codeaurora.org>
 <201109281610.49322.mfick@codeaurora.org>
 <c76d7f65203c0fc2c6e4e14fe2f33274@quantumfyre.co.uk>
 <960aacbf-8d4d-4b2a-8902-f6380ff9febd@email.android.com>
 <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk>
 <4E84B89F.4060304@lsrfire.ath.cx> <7vy5x7rwq9.fsf@alter.siamese.dyndns.org>
 <20110929041811.5363.33396.julian@quantumfyre.co.uk>
 <7vvcsbqa0k.fsf@alter.siamese.dyndns.org>
Cc: Martin Fick <mfick@codeaurora.org>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 00:19:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9OxM-00074x-PM
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 00:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478Ab1I2WTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 18:19:48 -0400
Received: from neutrino.quantumfyre.co.uk ([93.93.128.23]:42155 "EHLO
	neutrino.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750940Ab1I2WTr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 18:19:47 -0400
Received: from reaper.quantumfyre.co.uk (quantumfyre-1-pt.tunnel.tserv5.lon1.ipv6.he.net [IPv6:2001:470:1f08:1724::2])
	by neutrino.quantumfyre.co.uk (Postfix) with ESMTP id ABFABC060D;
	Thu, 29 Sep 2011 23:19:45 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 8DEF536A880;
	Thu, 29 Sep 2011 23:19:45 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id YzfuZEQ5voWG; Thu, 29 Sep 2011 23:19:43 +0100 (BST)
Received: from [172.16.70.128] (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 3192136940A;
	Thu, 29 Sep 2011 23:19:43 +0100 (BST)
X-git-sha1: 74ff494e9db86d14d5697f81db57fbee94a4474b 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <7vvcsbqa0k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182451>

Currently we linearly search through lists of refs when we need to
find a specific ref.  This can be very slow if we need to lookup a
large number of refs.  By changing to a binary search we can make this
faster.

In order to be able to use a binary search we need to change from
using linked lists to arrays, which we can manage using ALLOC_GROW.

We can now also use the standard library qsort function to sort the
refs arrays.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

On Thu, 29 Sep 2011 15:06:03 -0700, Junio C Hamano wrote:
> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> +static void add_ref(const char *name, const unsigned char *sha1,
>> +		    int flag, struct ref_array *refs,
>> +		    struct ref_entry **new_entry)
>>  {
>>  	int len;
>> -	struct ref_list *entry;
>> +	struct ref_entry *entry;
>>
>>  	/* Allocate it and add it in.. */
>>  	len = strlen(name) + 1;
>> -	entry = xmalloc(sizeof(struct ref_list) + len);
>> +	entry = xmalloc(sizeof(struct ref) + len);
>
> This should be sizeof(struct ref_entry), no?  There is another such
> misallocation in search_ref_array() where it prepares a temporary.

Indeed, thanks.

Looks like two instances of not noticing that "struct ref" already existed
managed to survive.  Drat.  Of course since "struct ref" is bigger than "struct
ref_entry", everthing worked fine ... so no failed tests to tip me off.

 refs.c |  329 ++++++++++++++++++++++++++--------------------------------------
 1 files changed, 133 insertions(+), 196 deletions(-)

diff --git a/refs.c b/refs.c
index a49ff74..4c01d79 100644
--- a/refs.c
+++ b/refs.c
@@ -8,14 +8,18 @@
 #define REF_KNOWS_PEELED 04
 #define REF_BROKEN 010
 
-struct ref_list {
-	struct ref_list *next;
+struct ref_entry {
 	unsigned char flag; /* ISSYMREF? ISPACKED? */
 	unsigned char sha1[20];
 	unsigned char peeled[20];
 	char name[FLEX_ARRAY];
 };
 
+struct ref_array {
+	int nr, alloc;
+	struct ref_entry **refs;
+};
+
 static const char *parse_ref_line(char *line, unsigned char *sha1)
 {
 	/*
@@ -44,108 +48,58 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
 	return line;
 }
 
-static struct ref_list *add_ref(const char *name, const unsigned char *sha1,
-				int flag, struct ref_list *list,
-				struct ref_list **new_entry)
+static void add_ref(const char *name, const unsigned char *sha1,
+		    int flag, struct ref_array *refs,
+		    struct ref_entry **new_entry)
 {
 	int len;
-	struct ref_list *entry;
+	struct ref_entry *entry;
 
 	/* Allocate it and add it in.. */
 	len = strlen(name) + 1;
-	entry = xmalloc(sizeof(struct ref_list) + len);
+	entry = xmalloc(sizeof(struct ref_entry) + len);
 	hashcpy(entry->sha1, sha1);
 	hashclr(entry->peeled);
 	memcpy(entry->name, name, len);
 	entry->flag = flag;
-	entry->next = list;
 	if (new_entry)
 		*new_entry = entry;
-	return entry;
+	ALLOC_GROW(refs->refs, refs->nr + 1, refs->alloc);
+	refs->refs[refs->nr++] = entry;
 }
 
-/* merge sort the ref list */
-static struct ref_list *sort_ref_list(struct ref_list *list)
+static int ref_entry_cmp(const void *a, const void *b)
 {
-	int psize, qsize, last_merge_count, cmp;
-	struct ref_list *p, *q, *l, *e;
-	struct ref_list *new_list = list;
-	int k = 1;
-	int merge_count = 0;
-
-	if (!list)
-		return list;
-
-	do {
-		last_merge_count = merge_count;
-		merge_count = 0;
-
-		psize = 0;
+	struct ref_entry *one = *(struct ref_entry **)a;
+	struct ref_entry *two = *(struct ref_entry **)b;
+	return strcmp(one->name, two->name);
+}
 
-		p = new_list;
-		q = new_list;
-		new_list = NULL;
-		l = NULL;
+static void sort_ref_array(struct ref_array *array)
+{
+	qsort(array->refs, array->nr, sizeof(*array->refs), ref_entry_cmp);
+}
 
-		while (p) {
-			merge_count++;
+static struct ref_entry *search_ref_array(struct ref_array *array, const char *name)
+{
+	struct ref_entry *e, **r;
+	int len;
 
-			while (psize < k && q->next) {
-				q = q->next;
-				psize++;
-			}
-			qsize = k;
-
-			while ((psize > 0) || (qsize > 0 && q)) {
-				if (qsize == 0 || !q) {
-					e = p;
-					p = p->next;
-					psize--;
-				} else if (psize == 0) {
-					e = q;
-					q = q->next;
-					qsize--;
-				} else {
-					cmp = strcmp(q->name, p->name);
-					if (cmp < 0) {
-						e = q;
-						q = q->next;
-						qsize--;
-					} else if (cmp > 0) {
-						e = p;
-						p = p->next;
-						psize--;
-					} else {
-						if (hashcmp(q->sha1, p->sha1))
-							die("Duplicated ref, and SHA1s don't match: %s",
-							    q->name);
-						warning("Duplicated ref: %s", q->name);
-						e = q;
-						q = q->next;
-						qsize--;
-						free(e);
-						e = p;
-						p = p->next;
-						psize--;
-					}
-				}
+	if (name == NULL)
+		return NULL;
 
-				e->next = NULL;
+	len = strlen(name) + 1;
+	e = xmalloc(sizeof(struct ref_entry) + len);
+	memcpy(e->name, name, len);
 
-				if (l)
-					l->next = e;
-				if (!new_list)
-					new_list = e;
-				l = e;
-			}
+	r = bsearch(&e, array->refs, array->nr, sizeof(*array->refs), ref_entry_cmp);
 
-			p = q;
-		};
+	free(e);
 
-		k = k * 2;
-	} while ((last_merge_count != merge_count) || (last_merge_count != 1));
+	if (r == NULL)
+		return NULL;
 
-	return new_list;
+	return *r;
 }
 
 /*
@@ -155,38 +109,37 @@ static struct ref_list *sort_ref_list(struct ref_list *list)
 static struct cached_refs {
 	char did_loose;
 	char did_packed;
-	struct ref_list *loose;
-	struct ref_list *packed;
+	struct ref_array loose;
+	struct ref_array packed;
 } cached_refs, submodule_refs;
-static struct ref_list *current_ref;
+static struct ref_entry *current_ref;
 
-static struct ref_list *extra_refs;
+static struct ref_array extra_refs;
 
-static void free_ref_list(struct ref_list *list)
+static void free_ref_array(struct ref_array *array)
 {
-	struct ref_list *next;
-	for ( ; list; list = next) {
-		next = list->next;
-		free(list);
-	}
+	int i;
+	for (i = 0; i < array->nr; i++)
+		free(array->refs[i]);
+	free(array->refs);
+	array->nr = array->alloc = 0;
+	array->refs = NULL;
 }
 
 static void invalidate_cached_refs(void)
 {
 	struct cached_refs *ca = &cached_refs;
 
-	if (ca->did_loose && ca->loose)
-		free_ref_list(ca->loose);
-	if (ca->did_packed && ca->packed)
-		free_ref_list(ca->packed);
-	ca->loose = ca->packed = NULL;
+	if (ca->did_loose)
+		free_ref_array(&ca->loose);
+	if (ca->did_packed)
+		free_ref_array(&ca->packed);
 	ca->did_loose = ca->did_packed = 0;
 }
 
 static void read_packed_refs(FILE *f, struct cached_refs *cached_refs)
 {
-	struct ref_list *list = NULL;
-	struct ref_list *last = NULL;
+	struct ref_entry *last = NULL;
 	char refline[PATH_MAX];
 	int flag = REF_ISPACKED;
 
@@ -205,7 +158,7 @@ static void read_packed_refs(FILE *f, struct cached_refs *cached_refs)
 
 		name = parse_ref_line(refline, sha1);
 		if (name) {
-			list = add_ref(name, sha1, flag, list, &last);
+			add_ref(name, sha1, flag, &cached_refs->packed, &last);
 			continue;
 		}
 		if (last &&
@@ -215,21 +168,20 @@ static void read_packed_refs(FILE *f, struct cached_refs *cached_refs)
 		    !get_sha1_hex(refline + 1, sha1))
 			hashcpy(last->peeled, sha1);
 	}
-	cached_refs->packed = sort_ref_list(list);
+	sort_ref_array(&cached_refs->packed);
 }
 
 void add_extra_ref(const char *name, const unsigned char *sha1, int flag)
 {
-	extra_refs = add_ref(name, sha1, flag, extra_refs, NULL);
+	add_ref(name, sha1, flag, &extra_refs, NULL);
 }
 
 void clear_extra_refs(void)
 {
-	free_ref_list(extra_refs);
-	extra_refs = NULL;
+	free_ref_array(&extra_refs);
 }
 
-static struct ref_list *get_packed_refs(const char *submodule)
+static struct ref_array *get_packed_refs(const char *submodule)
 {
 	const char *packed_refs_file;
 	struct cached_refs *refs;
@@ -237,7 +189,7 @@ static struct ref_list *get_packed_refs(const char *submodule)
 	if (submodule) {
 		packed_refs_file = git_path_submodule(submodule, "packed-refs");
 		refs = &submodule_refs;
-		free_ref_list(refs->packed);
+		free_ref_array(&refs->packed);
 	} else {
 		packed_refs_file = git_path("packed-refs");
 		refs = &cached_refs;
@@ -245,18 +197,17 @@ static struct ref_list *get_packed_refs(const char *submodule)
 
 	if (!refs->did_packed || submodule) {
 		FILE *f = fopen(packed_refs_file, "r");
-		refs->packed = NULL;
 		if (f) {
 			read_packed_refs(f, refs);
 			fclose(f);
 		}
 		refs->did_packed = 1;
 	}
-	return refs->packed;
+	return &refs->packed;
 }
 
-static struct ref_list *get_ref_dir(const char *submodule, const char *base,
-				    struct ref_list *list)
+static void get_ref_dir(const char *submodule, const char *base,
+			struct ref_array *array)
 {
 	DIR *dir;
 	const char *path;
@@ -299,7 +250,7 @@ static struct ref_list *get_ref_dir(const char *submodule, const char *base,
 			if (stat(refdir, &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
-				list = get_ref_dir(submodule, ref, list);
+				get_ref_dir(submodule, ref, array);
 				continue;
 			}
 			if (submodule) {
@@ -314,12 +265,11 @@ static struct ref_list *get_ref_dir(const char *submodule, const char *base,
 					hashclr(sha1);
 					flag |= REF_BROKEN;
 				}
-			list = add_ref(ref, sha1, flag, list, NULL);
+			add_ref(ref, sha1, flag, array, NULL);
 		}
 		free(ref);
 		closedir(dir);
 	}
-	return list;
 }
 
 struct warn_if_dangling_data {
@@ -356,21 +306,21 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
 
-static struct ref_list *get_loose_refs(const char *submodule)
+static struct ref_array *get_loose_refs(const char *submodule)
 {
 	if (submodule) {
-		free_ref_list(submodule_refs.loose);
-		submodule_refs.loose = get_ref_dir(submodule, "refs", NULL);
-		submodule_refs.loose = sort_ref_list(submodule_refs.loose);
-		return submodule_refs.loose;
+		free_ref_array(&submodule_refs.loose);
+		get_ref_dir(submodule, "refs", &submodule_refs.loose);
+		sort_ref_array(&submodule_refs.loose);
+		return &submodule_refs.loose;
 	}
 
 	if (!cached_refs.did_loose) {
-		cached_refs.loose = get_ref_dir(NULL, "refs", NULL);
-		cached_refs.loose = sort_ref_list(cached_refs.loose);
+		get_ref_dir(NULL, "refs", &cached_refs.loose);
+		sort_ref_array(&cached_refs.loose);
 		cached_refs.did_loose = 1;
 	}
-	return cached_refs.loose;
+	return &cached_refs.loose;
 }
 
 /* We allow "recursive" symbolic refs. Only within reason, though */
@@ -381,8 +331,8 @@ static int resolve_gitlink_packed_ref(char *name, int pathlen, const char *refna
 {
 	FILE *f;
 	struct cached_refs refs;
-	struct ref_list *ref;
-	int retval;
+	struct ref_entry *ref;
+	int retval = -1;
 
 	strcpy(name + pathlen, "packed-refs");
 	f = fopen(name, "r");
@@ -390,17 +340,12 @@ static int resolve_gitlink_packed_ref(char *name, int pathlen, const char *refna
 		return -1;
 	read_packed_refs(f, &refs);
 	fclose(f);
-	ref = refs.packed;
-	retval = -1;
-	while (ref) {
-		if (!strcmp(ref->name, refname)) {
-			retval = 0;
-			memcpy(result, ref->sha1, 20);
-			break;
-		}
-		ref = ref->next;
+	ref = search_ref_array(&refs.packed, refname);
+	if (ref != NULL) {
+		memcpy(result, ref->sha1, 20);
+		retval = 0;
 	}
-	free_ref_list(refs.packed);
+	free_ref_array(&refs.packed);
 	return retval;
 }
 
@@ -501,15 +446,13 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		git_snpath(path, sizeof(path), "%s", ref);
 		/* Special case: non-existing file. */
 		if (lstat(path, &st) < 0) {
-			struct ref_list *list = get_packed_refs(NULL);
-			while (list) {
-				if (!strcmp(ref, list->name)) {
-					hashcpy(sha1, list->sha1);
-					if (flag)
-						*flag |= REF_ISPACKED;
-					return ref;
-				}
-				list = list->next;
+			struct ref_array *packed = get_packed_refs(NULL);
+			struct ref_entry *r = search_ref_array(packed, ref);
+			if (r != NULL) {
+				hashcpy(sha1, r->sha1);
+				if (flag)
+					*flag |= REF_ISPACKED;
+				return ref;
 			}
 			if (reading || errno != ENOENT)
 				return NULL;
@@ -584,7 +527,7 @@ int read_ref(const char *ref, unsigned char *sha1)
 
 #define DO_FOR_EACH_INCLUDE_BROKEN 01
 static int do_one_ref(const char *base, each_ref_fn fn, int trim,
-		      int flags, void *cb_data, struct ref_list *entry)
+		      int flags, void *cb_data, struct ref_entry *entry)
 {
 	if (prefixcmp(entry->name, base))
 		return 0;
@@ -630,18 +573,12 @@ int peel_ref(const char *ref, unsigned char *sha1)
 		return -1;
 
 	if ((flag & REF_ISPACKED)) {
-		struct ref_list *list = get_packed_refs(NULL);
+		struct ref_array *array = get_packed_refs(NULL);
+		struct ref_entry *r = search_ref_array(array, ref);
 
-		while (list) {
-			if (!strcmp(list->name, ref)) {
-				if (list->flag & REF_KNOWS_PEELED) {
-					hashcpy(sha1, list->peeled);
-					return 0;
-				}
-				/* older pack-refs did not leave peeled ones */
-				break;
-			}
-			list = list->next;
+		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
+			hashcpy(sha1, r->peeled);
+			return 0;
 		}
 	}
 
@@ -660,36 +597,39 @@ fallback:
 static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,
 			   int trim, int flags, void *cb_data)
 {
-	int retval = 0;
-	struct ref_list *packed = get_packed_refs(submodule);
-	struct ref_list *loose = get_loose_refs(submodule);
+	int retval = 0, i, p = 0, l = 0;
+	struct ref_array *packed = get_packed_refs(submodule);
+	struct ref_array *loose = get_loose_refs(submodule);
 
-	struct ref_list *extra;
+	struct ref_array *extra = &extra_refs;
 
-	for (extra = extra_refs; extra; extra = extra->next)
-		retval = do_one_ref(base, fn, trim, flags, cb_data, extra);
+	for (i = 0; i < extra->nr; i++)
+		retval = do_one_ref(base, fn, trim, flags, cb_data, extra->refs[i]);
 
-	while (packed && loose) {
-		struct ref_list *entry;
-		int cmp = strcmp(packed->name, loose->name);
+	while (p < packed->nr && l < loose->nr) {
+		struct ref_entry *entry;
+		int cmp = strcmp(packed->refs[p]->name, loose->refs[l]->name);
 		if (!cmp) {
-			packed = packed->next;
+			p++;
 			continue;
 		}
 		if (cmp > 0) {
-			entry = loose;
-			loose = loose->next;
+			entry = loose->refs[l++];
 		} else {
-			entry = packed;
-			packed = packed->next;
+			entry = packed->refs[p++];
 		}
 		retval = do_one_ref(base, fn, trim, flags, cb_data, entry);
 		if (retval)
 			goto end_each;
 	}
 
-	for (packed = packed ? packed : loose; packed; packed = packed->next) {
-		retval = do_one_ref(base, fn, trim, flags, cb_data, packed);
+	if (l < loose->nr) {
+		p = l;
+		packed = loose;
+	}
+
+	for (; p < packed->nr; p++) {
+		retval = do_one_ref(base, fn, trim, flags, cb_data, packed->refs[p]);
 		if (retval)
 			goto end_each;
 	}
@@ -1005,24 +945,24 @@ static int remove_empty_directories(const char *file)
 }
 
 static int is_refname_available(const char *ref, const char *oldref,
-				struct ref_list *list, int quiet)
-{
-	int namlen = strlen(ref); /* e.g. 'foo/bar' */
-	while (list) {
-		/* list->name could be 'foo' or 'foo/bar/baz' */
-		if (!oldref || strcmp(oldref, list->name)) {
-			int len = strlen(list->name);
+				struct ref_array *array, int quiet)
+{
+	int i, namlen = strlen(ref); /* e.g. 'foo/bar' */
+	for (i = 0; i < array->nr; i++ ) {
+		struct ref_entry *entry = array->refs[i];
+		/* entry->name could be 'foo' or 'foo/bar/baz' */
+		if (!oldref || strcmp(oldref, entry->name)) {
+			int len = strlen(entry->name);
 			int cmplen = (namlen < len) ? namlen : len;
-			const char *lead = (namlen < len) ? list->name : ref;
-			if (!strncmp(ref, list->name, cmplen) &&
+			const char *lead = (namlen < len) ? entry->name : ref;
+			if (!strncmp(ref, entry->name, cmplen) &&
 			    lead[cmplen] == '/') {
 				if (!quiet)
 					error("'%s' exists; cannot create '%s'",
-					      list->name, ref);
+					      entry->name, ref);
 				return 0;
 			}
 		}
-		list = list->next;
 	}
 	return 1;
 }
@@ -1129,18 +1069,13 @@ static struct lock_file packlock;
 
 static int repack_without_ref(const char *refname)
 {
-	struct ref_list *list, *packed_ref_list;
-	int fd;
-	int found = 0;
+	struct ref_array *packed;
+	struct ref_entry *ref;
+	int fd, i;
 
-	packed_ref_list = get_packed_refs(NULL);
-	for (list = packed_ref_list; list; list = list->next) {
-		if (!strcmp(refname, list->name)) {
-			found = 1;
-			break;
-		}
-	}
-	if (!found)
+	packed = get_packed_refs(NULL);
+	ref = search_ref_array(packed, refname);
+	if (ref == NULL)
 		return 0;
 	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
 	if (fd < 0) {
@@ -1148,17 +1083,19 @@ static int repack_without_ref(const char *refname)
 		return error("cannot delete '%s' from packed refs", refname);
 	}
 
-	for (list = packed_ref_list; list; list = list->next) {
+	for (i = 0; i < packed->nr; i++) {
 		char line[PATH_MAX + 100];
 		int len;
 
-		if (!strcmp(refname, list->name))
+		ref = packed->refs[i];
+
+		if (!strcmp(refname, ref->name))
 			continue;
 		len = snprintf(line, sizeof(line), "%s %s\n",
-			       sha1_to_hex(list->sha1), list->name);
+			       sha1_to_hex(ref->sha1), ref->name);
 		/* this should not happen but just being defensive */
 		if (len > sizeof(line))
-			die("too long a refname '%s'", list->name);
+			die("too long a refname '%s'", ref->name);
 		write_or_die(fd, line, len);
 	}
 	return commit_lock_file(&packlock);
-- 
1.7.6.1
