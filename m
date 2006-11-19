X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sat, 18 Nov 2006 17:40:02 -0800
Message-ID: <7vfycg9pu5.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com>
	<7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net>
	<20061118184345.GO7201@pasky.or.cz>
	<e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com>
	<7vac2oefuz.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
	<Pine.LNX.4.64.0611181706250.3692@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 01:41:00 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611181706250.3692@woody.osdl.org> (Linus
	Torvalds's message of "Sat, 18 Nov 2006 17:11:28 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31820>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlbfN-0007rB-7L for gcvg-git@gmane.org; Sun, 19 Nov
 2006 02:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755484AbWKSBkG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 20:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755486AbWKSBkF
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 20:40:05 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:51404 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1755484AbWKSBkD
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 20:40:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061119014003.CSVA21630.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Sat, 18
 Nov 2006 20:40:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oRfa1V00e1kojtg0000000; Sat, 18 Nov 2006
 20:39:35 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 19 Nov 2006, Marco Costalba wrote:
>> 
>> Tested also with show-ref only, not useful to me, but just as a comparison.
>> 
>> - git tree 1420ms
>> - linux tree 1021ms
>> 
>> Better, but still slower then what I would expected.
>
> MUCH slower than expected.

This is still a WIP and for discussion only (I have to leave to
pick up my wife now so I won't be making any further progress
tonight), but I think parse_object() in show-ref is costing us.

One worry is that existing git will misinterpret packed-refs
file prepared with this version.

If you say "git show-ref -d --tags" to this version, it takes
the fast path which seems to shave about 1/3 of the runtime.

---

diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 042d271..0c770f5 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -1,5 +1,7 @@
 #include "cache.h"
 #include "refs.h"
+#include "object.h"
+#include "tag.h"
 
 static const char builtin_pack_refs_usage[] =
 "git-pack-refs [--all] [--prune]";
@@ -29,12 +31,24 @@ static int handle_one_ref(const char *pa
 			  int flags, void *cb_data)
 {
 	struct pack_refs_cb_data *cb = cb_data;
+	int is_tag_ref;
 
-	if (!cb->all && strncmp(path, "refs/tags/", 10))
-		return 0;
 	/* Do not pack the symbolic refs */
-	if (!(flags & REF_ISSYMREF))
-		fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
+	if ((flags & REF_ISSYMREF))
+		return 0;
+	is_tag_ref = !strncmp(path, "refs/tags/", 10);
+	if (!cb->all && !is_tag_ref)
+		return 0;
+
+	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
+	if (is_tag_ref) {
+		struct object *o = parse_object(sha1);
+		o = deref_tag(o, path, 0);
+		if (o)
+			fprintf(cb->refs_file, "%s %s^{}\n",
+				sha1_to_hex(o->sha1), path);
+	}
+
 	if (cb->prune && !do_not_prune(flags)) {
 		int namelen = strlen(path) + 1;
 		struct ref_to_prune *n = xcalloc(1, sizeof(*n) + namelen);
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 06ec400..32cbcb8 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -13,6 +13,7 @@ static int show_ref(const char *refname,
 {
 	struct object *obj;
 	const char *hex;
+	unsigned char peeled[20];
 
 	if (tags_only || heads_only) {
 		int match;
@@ -44,6 +45,17 @@ static int show_ref(const char *refname,
 
 match:
 	found_match++;
+
+	/* Fastpath for demonstration only */
+	if (deref_tags && (flag & REF_ISPACKED) &&
+	    !peel_ref(refname, peeled) && !quiet && !hash_only) {
+		hex = find_unique_abbrev(sha1, abbrev);
+		printf("%s %s\n", hex, refname);
+		hex = find_unique_abbrev(peeled, abbrev);
+		printf("%s %s^{}\n", hex, refname);
+		return 0;
+	}
+
 	obj = parse_object(sha1);
 	if (!obj) {
 		if (quiet)
@@ -59,8 +71,13 @@ match:
 	else
 		printf("%s %s\n", hex, refname);
 	if (deref_tags && obj->type == OBJ_TAG) {
-		obj = deref_tag(obj, refname, 0);
-		hex = find_unique_abbrev(obj->sha1, abbrev);
+		unsigned char sha1[20];
+		if ((flag & REF_ISPACKED) && !peel_ref(refname, sha1))
+			hex = find_unique_abbrev(sha1, abbrev);
+		else {
+			obj = deref_tag(obj, refname, 0);
+			hex = find_unique_abbrev(obj->sha1, abbrev);
+		}
 		printf("%s %s^{}\n", hex, refname);
 	}
 	return 0;
diff --git a/refs.c b/refs.c
index f003a0b..347c9b7 100644
--- a/refs.c
+++ b/refs.c
@@ -1,16 +1,18 @@
 #include "refs.h"
 #include "cache.h"
+#include "object.h"
+#include "tag.h"
 
 #include <errno.h>
 
 struct ref_list {
 	struct ref_list *next;
-	unsigned char flag; /* ISSYMREF? ISPACKED? */
+	unsigned char flag; /* ISSYMREF? ISPACKED? ISPEELED? */
 	unsigned char sha1[20];
 	char name[FLEX_ARRAY];
 };
 
-static const char *parse_ref_line(char *line, unsigned char *sha1)
+static const char *parse_ref_line(char *line, unsigned char *sha1, int *flag)
 {
 	/*
 	 * 42: the answer to everything.
@@ -34,6 +36,10 @@ static const char *parse_ref_line(char *
 	if (line[len] != '\n')
 		return NULL;
 	line[len] = 0;
+	if (len < 3 || strcmp(line + len - 3, "^{}"))
+	    *flag &= ~REF_ISPEELED;
+	else
+	    *flag |= REF_ISPEELED;
 	return line;
 }
 
@@ -108,10 +114,12 @@ static struct ref_list *get_packed_refs(
 			char refline[PATH_MAX];
 			while (fgets(refline, sizeof(refline), f)) {
 				unsigned char sha1[20];
-				const char *name = parse_ref_line(refline, sha1);
+				int flag = REF_ISPACKED;
+				const char *name =
+					parse_ref_line(refline, sha1, &flag);
 				if (!name)
 					continue;
-				list = add_ref(name, sha1, REF_ISPACKED, list);
+				list = add_ref(name, sha1, flag, list);
 			}
 			fclose(f);
 			refs = list;
@@ -207,7 +215,8 @@ const char *resolve_ref(const char *ref,
 		if (lstat(path, &st) < 0) {
 			struct ref_list *list = get_packed_refs();
 			while (list) {
-				if (!strcmp(ref, list->name)) {
+				if (!(list->flag & REF_ISPEELED) &&
+				    !strcmp(ref, list->name)) {
 					hashcpy(sha1, list->sha1);
 					if (flag)
 						*flag |= REF_ISPACKED;
@@ -322,6 +331,41 @@ int read_ref(const char *ref, unsigned c
 	return -1;
 }
 
+int peel_ref(const char *ref, unsigned char *sha1)
+{
+	int flag;
+	unsigned char base[20];
+	struct object *o;
+
+	if (!resolve_ref(ref, base, 1, &flag))
+		return -1;
+
+	if ((flag & REF_ISPACKED)) {
+		struct ref_list *list = get_packed_refs();		
+		int len = strlen(ref);
+		while (list) {
+			if ((list->flag & REF_ISPEELED) &&
+			    !strncmp(list->name, ref, len) &&
+			    strlen(list->name) == len + 3 &&
+			    !strcmp(list->name + len, "^{}")) {
+				hashcpy(sha1, list->sha1);
+				return 0;
+			}
+			list = list->next;
+		}
+		/* older pack-refs did not leave peeled ones in */
+	}
+
+	/* otherwise ... */
+	o = parse_object(sha1);
+	o = deref_tag(o, ref, 0);
+	if (o) {
+		hashcpy(sha1, o->sha1);
+		return 0;
+	}
+	return -1;
+}
+
 static int do_for_each_ref(const char *base, each_ref_fn fn, int trim,
 			   void *cb_data)
 {
@@ -347,6 +391,8 @@ static int do_for_each_ref(const char *b
 			continue;
 		if (is_null_sha1(entry->sha1))
 			continue;
+		if (entry->flag & REF_ISPEELED)
+			continue;
 		if (!has_sha1_file(entry->sha1)) {
 			error("%s does not point to a valid object!", entry->name);
 			continue;
@@ -357,15 +403,22 @@ static int do_for_each_ref(const char *b
 			return retval;
 	}
 
-	packed = packed ? packed : loose;
-	while (packed) {
-		if (!strncmp(base, packed->name, trim)) {
-			retval = fn(packed->name + trim, packed->sha1,
-				    packed->flag, cb_data);
-			if (retval)
-				return retval;
+	for (packed = packed ? packed : loose; packed; packed = packed->next) {
+		if (strncmp(base, packed->name, trim))
+			continue;
+		if (is_null_sha1(packed->sha1))
+			continue;
+		if (packed->flag & REF_ISPEELED)
+			continue;
+		if (!has_sha1_file(packed->sha1)) {
+			error("%s does not point to a valid object!",
+			      packed->name);
+			continue;
 		}
-		packed = packed->next;
+		retval = fn(packed->name + trim, packed->sha1,
+			    packed->flag, cb_data);
+		if (retval)
+			return retval;
 	}
 	return 0;
 }
diff --git a/refs.h b/refs.h
index a57d437..40048a6 100644
--- a/refs.h
+++ b/refs.h
@@ -16,6 +16,8 @@ struct ref_lock {
  */
 #define REF_ISSYMREF 01
 #define REF_ISPACKED 02
+#define REF_ISPEELED 04 /* internal use */
+
 typedef int each_ref_fn(const char *refname, const unsigned char *sha1, int flags, void *cb_data);
 extern int head_ref(each_ref_fn, void *);
 extern int for_each_ref(each_ref_fn, void *);
@@ -23,6 +25,8 @@ extern int for_each_tag_ref(each_ref_fn,
 extern int for_each_branch_ref(each_ref_fn, void *);
 extern int for_each_remote_ref(each_ref_fn, void *);
 
+extern int peel_ref(const char *, unsigned char *);
+
 /** Reads the refs file specified into sha1 **/
 extern int get_ref_sha1(const char *ref, unsigned char *sha1);
 
