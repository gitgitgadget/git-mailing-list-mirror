From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv3 1/5] refs: add match_pattern()
Date: Tue, 21 Feb 2012 17:28:46 -0800
Message-ID: <1329874130-16818-2-git-send-email-tmgrennan@gmail.com>
References: <1329874130-16818-1-git-send-email-tmgrennan@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, jasampler@gmail.com,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 02:29:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0117-0004C9-A7
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 02:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544Ab2BVB3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 20:29:04 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49052 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab2BVB3D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 20:29:03 -0500
Received: by qadc10 with SMTP id c10so4979488qad.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 17:29:02 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.229.137.73 as permitted sender) client-ip=10.229.137.73;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.229.137.73 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.229.137.73])
        by 10.229.137.73 with SMTP id v9mr20966505qct.45.1329874142375 (num_hops = 1);
        Tue, 21 Feb 2012 17:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=utF9gOwg3GGmYHm4yYaXmZUKlvEZwa7/zZqgREpTUeU=;
        b=LaJQXMFuvwxj4VpmWORp66smahx4BoM3De8Fluioz4L3t9Fc4YL5XNdubgW0BuIqCQ
         KeYdRr//UanrD8Wtr3KEQfJ6T2GYgLA+Kxi7VBrdBw+fVxAv+icTxcuU+Le67JC9FRwe
         8NgQGQO6/QiY+IuItAbkHgb6uQm+VCXNiz648=
Received: by 10.229.137.73 with SMTP id v9mr17718537qct.45.1329874142282;
        Tue, 21 Feb 2012 17:29:02 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id n8sm2148026qan.12.2012.02.21.17.29.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Feb 2012 17:29:01 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1329874130-16818-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <20120211190856.GB4903@tgrennan-laptop>
References: <20120211190856.GB4903@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191212>

Used-by: git-branch, git-for-each-ref, git-ls-remote, and git-tag

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 builtin/branch.c       |   16 ++--------------
 builtin/for-each-ref.c |   21 ++-------------------
 builtin/ls-remote.c    |   12 +++---------
 builtin/tag.c          |   13 +------------
 refs.c                 |   36 ++++++++++++++++++++++++++++++++++++
 refs.h                 |   12 ++++++++++++
 6 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index cb17bc3..e46ed58 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -266,18 +266,6 @@ struct append_ref_cb {
 	int ret;
 };
 
-static int match_patterns(const char **pattern, const char *refname)
-{
-	if (!*pattern)
-		return 1; /* no pattern always matches */
-	while (*pattern) {
-		if (!fnmatch(*pattern, refname, 0))
-			return 1;
-		pattern++;
-	}
-	return 0;
-}
-
 static int append_ref(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct append_ref_cb *cb = (struct append_ref_cb *)(cb_data);
@@ -312,7 +300,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if ((kind & ref_list->kinds) == 0)
 		return 0;
 
-	if (!match_patterns(cb->pattern, refname))
+	if (!match_pattern(refname, cb->pattern, NULL, 0))
 		return 0;
 
 	commit = NULL;
@@ -542,7 +530,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
 	detached = (detached && (kinds & REF_LOCAL_BRANCH));
-	if (detached && match_patterns(pattern, "HEAD"))
+	if (detached && match_pattern("HEAD", pattern, NULL, 0))
 		show_detached(&ref_list);
 
 	for (i = 0; i < ref_list.index; i++) {
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index b01d76a..bd6a114 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -781,25 +781,8 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	struct refinfo *ref;
 	int cnt;
 
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
-			if (!fnmatch(p, refname, FNM_PATHNAME))
-				break;
-		}
-		if (!*pattern)
-			return 0;
-	}
+	if (!match_pattern(refname, cb->grab_pattern, NULL, FNM_PATHNAME))
+		return 0;
 
 	/*
 	 * We do not open the object yet; sort may only need refname
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 41c88a9..29f2b38 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "transport.h"
 #include "remote.h"
+#include "refs.h"
 
 static const char ls_remote_usage[] =
 "git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]\n"
@@ -13,19 +14,12 @@ static const char ls_remote_usage[] =
  */
 static int tail_match(const char **pattern, const char *path)
 {
-	const char *p;
 	char pathbuf[PATH_MAX];
 
-	if (!pattern)
-		return 1; /* no restriction */
-
 	if (snprintf(pathbuf, sizeof(pathbuf), "/%s", path) > sizeof(pathbuf))
 		return error("insanely long ref %.*s...", 20, path);
-	while ((p = *(pattern++)) != NULL) {
-		if (!fnmatch(p, pathbuf, 0))
-			return 1;
-	}
-	return 0;
+
+	return match_pattern(pathbuf, pattern, NULL, 0);
 }
 
 int cmd_ls_remote(int argc, const char **argv, const char *prefix)
diff --git a/builtin/tag.c b/builtin/tag.c
index fe7e5e5..9dcd7d2 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -34,17 +34,6 @@ struct tag_filter {
 
 static struct sha1_array points_at;
 
-static int match_pattern(const char **patterns, const char *ref)
-{
-	/* no pattern means match everything */
-	if (!*patterns)
-		return 1;
-	for (; *patterns; patterns++)
-		if (!fnmatch(*patterns, ref, 0))
-			return 1;
-	return 0;
-}
-
 static const unsigned char *match_points_at(const char *refname,
 					    const unsigned char *sha1)
 {
@@ -149,7 +138,7 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 {
 	struct tag_filter *filter = cb_data;
 
-	if (match_pattern(filter->patterns, refname)) {
+	if (match_pattern(refname, filter->patterns, NULL, 0)) {
 		if (filter->with_commit) {
 			struct commit *commit;
 
diff --git a/refs.c b/refs.c
index c9f6835..0c50e81 100644
--- a/refs.c
+++ b/refs.c
@@ -3,6 +3,7 @@
 #include "object.h"
 #include "tag.h"
 #include "dir.h"
+#include "string-list.h"
 
 /* ISSYMREF=0x01, ISPACKED=0x02 and ISBROKEN=0x04 are public interfaces */
 #define REF_KNOWS_PEELED 0x10
@@ -2127,3 +2128,38 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 	free(short_name);
 	return xstrdup(refname);
 }
+
+static int match_path(const char *name, const char *pattern, int nlen)
+{
+	int plen = strlen(pattern);
+
+	return ((plen <= nlen) &&
+		!strncmp(name, pattern, plen) &&
+		(name[plen] == '\0' ||
+		 name[plen] == '/' ||
+		 pattern[plen-1] == '/'));
+}
+
+int match_pattern(const char *name, const char **match,
+		  struct string_list *exclude, int flags)
+{
+	int nlen = strlen(name);
+
+	if (exclude) {
+		struct string_list_item *x;
+		for_each_string_list_item(x, exclude) {
+			if (!fnmatch(x->string, name, 0))
+				return 0;
+		}
+	}
+	if (!match || !*match)
+		return 1;
+	for (; *match; match++) {
+		if (flags == FNM_PATHNAME)
+			if (match_path(name, *match, nlen))
+				return 1;
+		if (!fnmatch(*match, name, flags))
+			return 1;
+	}
+	return 0;
+}
diff --git a/refs.h b/refs.h
index 33202b0..dd059d8 100644
--- a/refs.h
+++ b/refs.h
@@ -144,4 +144,16 @@ int update_ref(const char *action, const char *refname,
 		const unsigned char *sha1, const unsigned char *oldval,
 		int flags, enum action_on_err onerr);
 
+/*
+ * match_pattern() - compares a name with pattern match and ignore lists
+ * This returns in highest to lowest precedence:
+ *    0 if <name> fnmatch() an <exclude> pattern
+ *    1	if <match> is NULL or empty
+ *    1	if <flags> is FNM_PATHNAME and <name> is an exact match of a listed
+ *	pattern upto and including a trailing '/'
+ *    1 <name> fnmatch() a <match> pattern
+ *    0 otherwise
+ */
+int match_pattern(const char *name, const char **match, struct string_list *exclude, int flags);
+
 #endif /* REFS_H */
-- 
1.7.8
