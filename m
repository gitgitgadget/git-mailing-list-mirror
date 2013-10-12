From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2] sha1-name: refactor get_sha1() parsing
Date: Sat, 12 Oct 2013 02:08:12 -0500
Message-ID: <1381561692-20869-1-git-send-email-felipe.contreras@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Matthieu Moy <matthieu.moy@imag.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:14:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtP7-0006B4-63
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779Ab3JLHOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:14:18 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:50338 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860Ab3JLHOO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:14:14 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so2585202oag.31
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JtwrURAHxJ9T+KSpIQnaQllshBNKNlfdsmzlokqxff4=;
        b=YkRCHbfKSc7xPm5nsl2xSgB8ENDQaWrnvWa+m559ENs1y68/hCfQwBCojhXHEwDt3H
         F68AaQRwh3ipmZlihJyH4Ayo9IoznSWPt8f64nBaqTpzX0UtZ4ia/JSIG4gfKPwg2UXE
         3orexSHJZeZtx8ed1Lrz6p/8cYleH1c9VReJZcRfo64r8DpcWv8GVw+DkuNQerR23ceo
         ib/4bGnsZJV4hunVvMm4paHGv4UQ6+hRiAgPBXuM2Sr9HakarpVlXgCIS9UKOf2x+hpW
         1g+v42cyBBN2iQ5LxldPkmTCnKuR054Qsk1TS6Y1WbsbcTqHLvsYjmbzTlko86y1bi7d
         lJ2w==
X-Received: by 10.182.214.98 with SMTP id nz2mr13744784obc.37.1381562053989;
        Sat, 12 Oct 2013 00:14:13 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d3sm101390634oek.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:14:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236029>

Instead of parsing left to right, do it right do left, this way it is
much more natural and probably efficient too, as there's less
recursivity.

In theory there shouldn't be any functional changes, although there's at
least one error message that has changed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c                    | 319 ++++++++++++++++++++++++-----------------
 t/t1506-rev-parse-diagnosis.sh |   2 +-
 2 files changed, 185 insertions(+), 136 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 65ad066..e66bda1 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -430,7 +430,6 @@ static inline int upstream_mark(const char *string, int len)
 	return 0;
 }
 
-static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned lookup_flags);
 static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf);
 
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
@@ -571,29 +570,24 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	return 0;
 }
 
-static int get_parent(const char *name, int len,
-		      unsigned char *result, int idx)
+static int get_parent(unsigned char *sha1, int idx)
 {
-	unsigned char sha1[20];
-	int ret = get_sha1_1(name, len, sha1, GET_SHA1_COMMITTISH);
 	struct commit *commit;
 	struct commit_list *p;
 
-	if (ret)
-		return ret;
 	commit = lookup_commit_reference(sha1);
 	if (!commit)
 		return -1;
 	if (parse_commit(commit))
 		return -1;
 	if (!idx) {
-		hashcpy(result, commit->object.sha1);
+		hashcpy(sha1, commit->object.sha1);
 		return 0;
 	}
 	p = commit->parents;
 	while (p) {
 		if (!--idx) {
-			hashcpy(result, p->item->object.sha1);
+			hashcpy(sha1, p->item->object.sha1);
 			return 0;
 		}
 		p = p->next;
@@ -601,16 +595,10 @@ static int get_parent(const char *name, int len,
 	return -1;
 }
 
-static int get_nth_ancestor(const char *name, int len,
-			    unsigned char *result, int generation)
+static int get_nth_ancestor(unsigned char *sha1, int generation)
 {
-	unsigned char sha1[20];
 	struct commit *commit;
-	int ret;
 
-	ret = get_sha1_1(name, len, sha1, GET_SHA1_COMMITTISH);
-	if (ret)
-		return ret;
 	commit = lookup_commit_reference(sha1);
 	if (!commit)
 		return -1;
@@ -620,7 +608,7 @@ static int get_nth_ancestor(const char *name, int len,
 			return -1;
 		commit = commit->parents->item;
 	}
-	hashcpy(result, commit->object.sha1);
+	hashcpy(sha1, commit->object.sha1);
 	return 0;
 }
 
@@ -649,12 +637,10 @@ struct object *peel_to_type(const char *name, int namelen,
 	}
 }
 
-static int peel_onion(const char *name, int len, unsigned char *sha1)
+static int peel_onion(const char *name, const char *str, int len, unsigned char *sha1)
 {
-	unsigned char outer[20];
-	const char *sp;
+	const char *sp, *end = NULL;
 	unsigned int expected_type = 0;
-	unsigned lookup_flags = 0;
 	struct object *o;
 
 	/*
@@ -665,18 +651,24 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 	 * "ref^{commit}".  "commit^{tree}" could be used to find the
 	 * top-level tree of the given commit.
 	 */
-	if (len < 4 || name[len-1] != '}')
-		return -1;
 
-	for (sp = name + len - 1; name <= sp; sp--) {
-		int ch = *sp;
-		if (ch == '{' && name < sp && sp[-1] == '^')
+	if (len < 3)
+		return 0;
+
+	sp = str;
+	if (sp[0] != '^' || sp[1] != '{')
+		return 0;
+
+	for (end = sp; *end; end++)
+		if (*end == '}')
 			break;
-	}
-	if (sp <= name)
-		return -1;
+	if (!end)
+		return 0;
+
+	end++;
+	len = end - str;
 
-	sp++; /* beginning of type name, or closing brace for empty */
+	sp += 2;
 	if (!strncmp(commit_type, sp, 6) && sp[6] == '}')
 		expected_type = OBJ_COMMIT;
 	else if (!strncmp(tree_type, sp, 4) && sp[4] == '}')
@@ -692,35 +684,28 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 	else
 		return -1;
 
-	if (expected_type == OBJ_COMMIT)
-		lookup_flags = GET_SHA1_COMMITTISH;
-	else if (expected_type == OBJ_TREE)
-		lookup_flags = GET_SHA1_TREEISH;
-
-	if (get_sha1_1(name, sp - name - 2, outer, lookup_flags))
-		return -1;
-
-	o = parse_object(outer);
+	o = parse_object(sha1);
 	if (!o)
 		return -1;
 	if (!expected_type) {
-		o = deref_tag(o, name, sp - name - 2);
+		o = deref_tag(o, name, end - name);
 		if (!o || (!o->parsed && !parse_object(o->sha1)))
 			return -1;
 		hashcpy(sha1, o->sha1);
-		return 0;
+		return len;
 	}
 
 	/*
-	 * At this point, the syntax look correct, so
+	 * At this point, the syntax looks correct, so
 	 * if we do not get the needed object, we should
 	 * barf.
 	 */
-	o = peel_to_type(name, len, o, expected_type);
+	o = peel_to_type(name, end - name, o, expected_type);
 	if (!o)
 		return -1;
 
 	hashcpy(sha1, o->sha1);
+
 	if (sp[0] == '/') {
 		/* "$commit^{/foo}" */
 		char *prefix;
@@ -732,15 +717,16 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 		 * We don't need regex anyway. '' pattern always matches.
 		 */
 		if (sp[1] == '}')
-			return 0;
+			return len;
 
-		prefix = xstrndup(sp + 1, name + len - 1 - (sp + 1));
+		prefix = xstrndup(sp + 1, end - sp - 2);
 		commit_list_insert((struct commit *)o, &list);
 		ret = get_sha1_oneline(prefix, sha1, list);
 		free(prefix);
-		return ret;
+		if (ret)
+			return -1;
 	}
-	return 0;
+	return len;
 }
 
 static int get_describe_name(const char *name, int len, unsigned char *sha1)
@@ -764,54 +750,6 @@ static int get_describe_name(const char *name, int len, unsigned char *sha1)
 	return -1;
 }
 
-static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned lookup_flags)
-{
-	int ret, has_suffix;
-	const char *cp;
-
-	/*
-	 * "name~3" is "name^^^", "name~" is "name~1", and "name^" is "name^1".
-	 */
-	has_suffix = 0;
-	for (cp = name + len - 1; name <= cp; cp--) {
-		int ch = *cp;
-		if ('0' <= ch && ch <= '9')
-			continue;
-		if (ch == '~' || ch == '^')
-			has_suffix = ch;
-		break;
-	}
-
-	if (has_suffix) {
-		int num = 0;
-		int len1 = cp - name;
-		cp++;
-		while (cp < name + len)
-			num = num * 10 + *cp++ - '0';
-		if (!num && len1 == len - 1)
-			num = 1;
-		if (has_suffix == '^')
-			return get_parent(name, len1, sha1, num);
-		/* else if (has_suffix == '~') -- goes without saying */
-		return get_nth_ancestor(name, len1, sha1, num);
-	}
-
-	ret = peel_onion(name, len, sha1);
-	if (!ret)
-		return 0;
-
-	ret = get_sha1_basic(name, len, sha1);
-	if (!ret)
-		return 0;
-
-	/* It could be describe output that is "SOMETHING-gXXXX" */
-	ret = get_describe_name(name, len, sha1);
-	if (!ret)
-		return 0;
-
-	return get_short_sha1(name, len, sha1, lookup_flags);
-}
-
 /*
  * This interprets names like ':/Initial revision of "git"' by searching
  * through history and returning the first commit whose message starts
@@ -1288,22 +1226,168 @@ static char *resolve_relative_path(const char *rel)
 			   rel);
 }
 
+static int resolve_ancestry(const char *str, int len, unsigned char *sha1)
+{
+	int has_suffix;
+	const char *cp, *end;
+	int num = 0, ret;
+
+	/*
+	 * "name~3" is "name^^^", "name~" is "name~1", and "name^" is "name^1".
+	 */
+	has_suffix = 0;
+	for (cp = str; *cp; cp++) {
+		int ch = *cp;
+		if ('0' <= ch && ch <= '9')
+			continue;
+		if (ch == '~' || ch == '^') {
+			if (has_suffix)
+				break;
+			has_suffix = ch;
+			continue;
+		}
+		break;
+	}
+
+	if (!has_suffix)
+		return 0;
+
+	end = cp;
+	cp = str + 1;
+	if (cp == end)
+		num = 1;
+	else
+		while (cp < end)
+			num = num * 10 + *cp++ - '0';
+	len = end - str;
+	if (has_suffix == '^')
+		ret = get_parent(sha1, num);
+	else
+		ret = get_nth_ancestor(sha1, num);
+	if (ret)
+		return ret;
+	return len;
+}
+
+static int resolve_tree(struct object_context *oc, const char *str, int len,
+		unsigned char *sha1, unsigned char *tree_sha1)
+{
+	int ret;
+	const char *filename = str + 1;
+	char *new_filename = NULL;
+
+	new_filename = resolve_relative_path(filename);
+	if (new_filename)
+		filename = new_filename;
+	hashcpy(tree_sha1, sha1);
+	ret = get_tree_entry(tree_sha1, filename, sha1, &oc->mode);
+	hashcpy(oc->tree, tree_sha1);
+	strncpy(oc->path, filename, sizeof(oc->path));
+	oc->path[sizeof(oc->path) - 1] = '\0';
+
+	free(new_filename);
+	return ret;
+}
+
+static int resolve(const char *name, int len, unsigned char *sha1,
+		struct object_context *oc, const char *prefix, unsigned flags)
+{
+	const char *cp;
+	int ret;
+	int tmp_len;
+	int bracket_depth;
+	unsigned char tree_sha1[20];
+	unsigned lookup_flags = flags;
+
+	for (cp = name, bracket_depth = 0; *cp; cp++) {
+		if (*cp == '{')
+			bracket_depth++;
+		else if (bracket_depth && *cp == '}')
+			bracket_depth--;
+		else if (!bracket_depth) {
+			if (*cp == '^') {
+				if (cp[1] == '{') {
+					const char *sp = cp + 2;
+					if (!strncmp(commit_type, sp, 6) && sp[6] == '}')
+						lookup_flags = GET_SHA1_COMMITTISH;
+					else if (!strncmp(tree_type, sp, 4) && sp[4] == '}')
+						lookup_flags = GET_SHA1_TREEISH;
+					else if (sp[0] == '/')
+						lookup_flags = GET_SHA1_COMMITTISH;
+					else
+						lookup_flags = 0;
+				} else {
+					lookup_flags = GET_SHA1_COMMITTISH;
+				}
+				break;
+			}
+			if (*cp == '~') {
+				lookup_flags = GET_SHA1_COMMITTISH;
+				break;
+			}
+			if (*cp == ':') {
+				lookup_flags = GET_SHA1_TREEISH;
+				break;
+			}
+		}
+	}
+
+	tmp_len = cp - name;
+	ret = get_sha1_basic(name, tmp_len, sha1);
+	if (!ret)
+		goto next;
+	ret = get_short_sha1(name, tmp_len, sha1, lookup_flags);
+	if (!ret)
+		goto next;
+	ret = get_describe_name(name, tmp_len, sha1);
+	if (!ret)
+		goto next;
+
+	return -1;
+
+next:
+	if (!*cp)
+		return 0;
+	while (*cp == '^' || *cp == '~') {
+		ret = peel_onion(name, cp, len - (cp - name), sha1);
+		if (ret < 0)
+			return ret;
+		cp += ret;
+		ret = resolve_ancestry(cp, len - (cp - name), sha1);
+		if (ret < 0)
+			return ret;
+		cp += ret;
+	}
+	if (!*cp)
+		return 0;
+	if (*cp != ':')
+		/* malformed */
+		return -1;
+	ret = resolve_tree(oc, cp, len - (cp - name), sha1, tree_sha1);
+	if (ret < 0) {
+		if (flags & GET_SHA1_ONLY_TO_DIE) {
+			diagnose_invalid_sha1_path(prefix, oc->path,
+						   tree_sha1,
+						   name, cp - name);
+		}
+		return ret;
+	}
+	return 0;
+}
+
 static int get_sha1_with_context_1(const char *name,
 				   unsigned flags,
 				   const char *prefix,
 				   unsigned char *sha1,
 				   struct object_context *oc)
 {
-	int ret, bracket_depth;
 	int namelen = strlen(name);
 	const char *cp;
 	int only_to_die = flags & GET_SHA1_ONLY_TO_DIE;
 
 	memset(oc, 0, sizeof(*oc));
 	oc->mode = S_IFINVALID;
-	ret = get_sha1_1(name, namelen, sha1, flags);
-	if (!ret)
-		return ret;
+
 	/*
 	 * sha1:path --> object name of path in ent sha1
 	 * :path -> object name of absolute path in index
@@ -1364,43 +1448,8 @@ static int get_sha1_with_context_1(const char *name,
 		free(new_path);
 		return -1;
 	}
-	for (cp = name, bracket_depth = 0; *cp; cp++) {
-		if (*cp == '{')
-			bracket_depth++;
-		else if (bracket_depth && *cp == '}')
-			bracket_depth--;
-		else if (!bracket_depth && *cp == ':')
-			break;
-	}
-	if (*cp == ':') {
-		unsigned char tree_sha1[20];
-		int len = cp - name;
-		if (!get_sha1_1(name, len, tree_sha1, GET_SHA1_TREEISH)) {
-			const char *filename = cp+1;
-			char *new_filename = NULL;
-
-			new_filename = resolve_relative_path(filename);
-			if (new_filename)
-				filename = new_filename;
-			ret = get_tree_entry(tree_sha1, filename, sha1, &oc->mode);
-			if (ret && only_to_die) {
-				diagnose_invalid_sha1_path(prefix, filename,
-							   tree_sha1,
-							   name, len);
-			}
-			hashcpy(oc->tree, tree_sha1);
-			strncpy(oc->path, filename,
-				sizeof(oc->path));
-			oc->path[sizeof(oc->path)-1] = '\0';
 
-			free(new_filename);
-			return ret;
-		} else {
-			if (only_to_die)
-				die("Invalid object name '%.*s'.", len, name);
-		}
-	}
-	return ret;
+	return resolve(name, namelen, sha1, oc, prefix, flags);
 }
 
 /*
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index f950c10..0f76d1f 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -104,7 +104,7 @@ test_expect_success 'correct relative file objects (6)' '
 
 test_expect_success 'incorrect revision id' '
 	test_must_fail git rev-parse foobar:file.txt 2>error &&
-	grep "Invalid object name '"'"'foobar'"'"'." error &&
+	grep "unknown revision or path not in the working tree." error
 	test_must_fail git rev-parse foobar 2> error &&
 	grep "unknown revision or path not in the working tree." error
 '
-- 
1.8.4-fc
