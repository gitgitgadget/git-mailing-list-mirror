X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Store peeled refs in packed-refs (take 2).
Date: Tue, 21 Nov 2006 23:36:35 -0800
Message-ID: <7vac2kvsos.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 22 Nov 2006 07:36:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32069>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmmev-0002Or-5v for gcvg-git@gmane.org; Wed, 22 Nov
 2006 08:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755011AbWKVHgh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 02:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755522AbWKVHgh
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 02:36:37 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:32224 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1755011AbWKVHgg
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 02:36:36 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061122073636.YPR18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>; Wed, 22
 Nov 2006 02:36:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id pjc61V00E1kojtg0000000; Wed, 22 Nov 2006
 02:36:06 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This fixes the previous implementation which failed to optimize
repositories with tons of lightweight tags.  The updated
packed-refs format begins with "# packed-refs with:" line that
lists the kind of extended data the file records.  Currently,
there is only one such extension defined, "peeled".  This stores
the "peeled tag" on a line that immediately follows a line for a
tag object itself in the format "^<sha-1>".

The header line itself and any extended data are ignored by
older implementation, so packed-refs file generated with this
version can still be used by older git.  packed-refs made by
older git can of course be used with this version.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-pack-refs.c |    8 +++-
 builtin-show-ref.c  |    6 ++-
 refs.c              |  111 +++++++++++++++++++++++++++++---------------------
 refs.h              |    7 +--
 4 files changed, 77 insertions(+), 55 deletions(-)

diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index ee5a556..8dc5b9e 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -46,8 +46,8 @@ static int handle_one_ref(const char *pa
 		if (o->type == OBJ_TAG) {
 			o = deref_tag(o, path, 0);
 			if (o)
-				fprintf(cb->refs_file, "%s  %s^{}\n",
-					sha1_to_hex(o->sha1), path);
+				fprintf(cb->refs_file, "^%s\n",
+					sha1_to_hex(o->sha1));
 		}
 	}
 
@@ -111,6 +111,10 @@ int cmd_pack_refs(int argc, const char *
 	if (!cbdata.refs_file)
 		die("unable to create ref-pack file structure (%s)",
 		    strerror(errno));
+
+	/* perhaps other traits later as well */
+	fprintf(cbdata.refs_file, "# pack-refs with: peeled \n");
+
 	for_each_ref(handle_one_ref, &cbdata);
 	fflush(cbdata.refs_file);
 	fsync(fd);
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 9ae3d08..0739798 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -67,8 +67,10 @@ match:
 		return 0;
 
 	if ((flag & REF_ISPACKED) && !peel_ref(refname, peeled)) {
-		hex = find_unique_abbrev(peeled, abbrev);
-		printf("%s %s^{}\n", hex, refname);
+		if (!is_null_sha1(peeled)) {
+			hex = find_unique_abbrev(peeled, abbrev);
+			printf("%s %s^{}\n", hex, refname);
+		}
 	}
 	else {
 		obj = parse_object(sha1);
diff --git a/refs.c b/refs.c
index 75cbc0e..96ea8b6 100644
--- a/refs.c
+++ b/refs.c
@@ -5,14 +5,18 @@
 
 #include <errno.h>
 
+/* ISSYMREF=01 and ISPACKED=02 are public interfaces */
+#define REF_KNOWS_PEELED 04
+
 struct ref_list {
 	struct ref_list *next;
-	unsigned char flag; /* ISSYMREF? ISPACKED? ISPEELED? */
+	unsigned char flag; /* ISSYMREF? ISPACKED? */
 	unsigned char sha1[20];
+	unsigned char peeled[20];
 	char name[FLEX_ARRAY];
 };
 
-static const char *parse_ref_line(char *line, unsigned char *sha1, int *flag)
+static const char *parse_ref_line(char *line, unsigned char *sha1)
 {
 	/*
 	 * 42: the answer to everything.
@@ -23,7 +27,6 @@ static const char *parse_ref_line(char *
 	 *  +1 (newline at the end of the line)
 	 */
 	int len = strlen(line) - 42;
-	int peeled = 0;
 
 	if (len <= 0)
 		return NULL;
@@ -32,29 +35,18 @@ static const char *parse_ref_line(char *
 	if (!isspace(line[40]))
 		return NULL;
 	line += 41;
-
-	if (isspace(*line)) {
-		/* "SHA-1 SP SP refs/tags/tagname^{} LF"? */
-		line++;
-		len--;
-		peeled = 1;
-	}
+	if (isspace(*line))
+		return NULL;
 	if (line[len] != '\n')
 		return NULL;
 	line[len] = 0;
 
-	if (peeled && (len < 3 || strcmp(line + len - 3, "^{}")))
-		return NULL;
-
-	if (!peeled)
-		*flag &= ~REF_ISPEELED;
-	else
-		*flag |= REF_ISPEELED;
 	return line;
 }
 
 static struct ref_list *add_ref(const char *name, const unsigned char *sha1,
-				int flag, struct ref_list *list)
+				int flag, struct ref_list *list,
+				struct ref_list **new_entry)
 {
 	int len;
 	struct ref_list **p = &list, *entry;
@@ -66,8 +58,11 @@ static struct ref_list *add_ref(const ch
 			break;
 
 		/* Same as existing entry? */
-		if (!cmp)
+		if (!cmp) {
+			if (new_entry)
+				*new_entry = entry;
 			return list;
+		}
 		p = &entry->next;
 	}
 
@@ -75,10 +70,13 @@ static struct ref_list *add_ref(const ch
 	len = strlen(name) + 1;
 	entry = xmalloc(sizeof(struct ref_list) + len);
 	hashcpy(entry->sha1, sha1);
+	hashclr(entry->peeled);
 	memcpy(entry->name, name, len);
 	entry->flag = flag;
 	entry->next = *p;
 	*p = entry;
+	if (new_entry)
+		*new_entry = entry;
 	return list;
 }
 
@@ -114,27 +112,50 @@ static void invalidate_cached_refs(void)
 	ca->did_loose = ca->did_packed = 0;
 }
 
+static void read_packed_refs(FILE *f, struct cached_refs *cached_refs)
+{
+	struct ref_list *list = NULL;
+	struct ref_list *last = NULL;
+	char refline[PATH_MAX];
+	int flag = REF_ISPACKED;
+
+	while (fgets(refline, sizeof(refline), f)) {
+		unsigned char sha1[20];
+		const char *name;
+		static const char header[] = "# pack-refs with:";
+
+		if (!strncmp(refline, header, sizeof(header)-1)) {
+			const char *traits = refline + sizeof(header) - 1;
+			if (strstr(traits, " peeled "))
+				flag |= REF_KNOWS_PEELED;
+			/* perhaps other traits later as well */
+			continue;
+		}
+
+		name = parse_ref_line(refline, sha1);
+		if (name) {
+			list = add_ref(name, sha1, flag, list, &last);
+			continue;
+		}
+		if (last &&
+		    refline[0] == '^' &&
+		    strlen(refline) == 42 &&
+		    refline[41] == '\n' &&
+		    !get_sha1_hex(refline + 1, sha1))
+			hashcpy(last->peeled, sha1);
+	}
+	cached_refs->packed = list;
+}
+
 static struct ref_list *get_packed_refs(void)
 {
 	if (!cached_refs.did_packed) {
-		struct ref_list *refs = NULL;
 		FILE *f = fopen(git_path("packed-refs"), "r");
+		cached_refs.packed = NULL;
 		if (f) {
-			struct ref_list *list = NULL;
-			char refline[PATH_MAX];
-			while (fgets(refline, sizeof(refline), f)) {
-				unsigned char sha1[20];
-				int flag = REF_ISPACKED;
-				const char *name =
-					parse_ref_line(refline, sha1, &flag);
-				if (!name)
-					continue;
-				list = add_ref(name, sha1, flag, list);
-			}
+			read_packed_refs(f, &cached_refs);
 			fclose(f);
-			refs = list;
 		}
-		cached_refs.packed = refs;
 		cached_refs.did_packed = 1;
 	}
 	return cached_refs.packed;
@@ -177,7 +198,7 @@ static struct ref_list *get_ref_dir(cons
 				error("%s points nowhere!", ref);
 				continue;
 			}
-			list = add_ref(ref, sha1, flag, list);
+			list = add_ref(ref, sha1, flag, list, NULL);
 		}
 		free(ref);
 		closedir(dir);
@@ -225,8 +246,7 @@ const char *resolve_ref(const char *ref,
 		if (lstat(path, &st) < 0) {
 			struct ref_list *list = get_packed_refs();
 			while (list) {
-				if (!(list->flag & REF_ISPEELED) &&
-				    !strcmp(ref, list->name)) {
+				if (!strcmp(ref, list->name)) {
 					hashcpy(sha1, list->sha1);
 					if (flag)
 						*flag |= REF_ISPACKED;
@@ -348,8 +368,6 @@ static int do_one_ref(const char *base,
 		return 0;
 	if (is_null_sha1(entry->sha1))
 		return 0;
-	if (entry->flag & REF_ISPEELED)
-		return 0;
 	if (!has_sha1_file(entry->sha1)) {
 		error("%s does not point to a valid object!", entry->name);
 		return 0;
@@ -368,22 +386,21 @@ int peel_ref(const char *ref, unsigned c
 
 	if ((flag & REF_ISPACKED)) {
 		struct ref_list *list = get_packed_refs();
-		int len = strlen(ref);
 
 		while (list) {
-			if ((list->flag & REF_ISPEELED) &&
-			    !strncmp(list->name, ref, len) &&
-			    strlen(list->name) == len + 3 &&
-			    !strcmp(list->name + len, "^{}")) {
-				hashcpy(sha1, list->sha1);
-				return 0;
+			if (!strcmp(list->name, ref)) {
+				if (list->flag & REF_KNOWS_PEELED) {
+					hashcpy(sha1, list->peeled);
+					return 0;
+				}
+				/* older pack-refs did not leave peeled ones */
+				break;
 			}
 			list = list->next;
 		}
-		/* older pack-refs did not leave peeled ones in */
 	}
 
-	/* otherwise ... */
+	/* fallback - callers should not call this for unpacked refs */
 	o = parse_object(base);
 	if (o->type == OBJ_TAG) {
 		o = deref_tag(o, ref, 0);
diff --git a/refs.h b/refs.h
index 40048a6..cd1e1d6 100644
--- a/refs.h
+++ b/refs.h
@@ -10,14 +10,13 @@ struct ref_lock {
 	int force_write;
 };
 
+#define REF_ISSYMREF 01
+#define REF_ISPACKED 02
+
 /*
  * Calls the specified function for each ref file until it returns nonzero,
  * and returns the value
  */
-#define REF_ISSYMREF 01
-#define REF_ISPACKED 02
-#define REF_ISPEELED 04 /* internal use */
-
 typedef int each_ref_fn(const char *refname, const unsigned char *sha1, int flags, void *cb_data);
 extern int head_ref(each_ref_fn, void *);
 extern int for_each_ref(each_ref_fn, void *);
-- 
1.4.4.g26805

