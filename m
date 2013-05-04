From: Johan Herland <johan@herland.net>
Subject: [PATCH 4/7] refs.c: Refactor rules for expanding shorthand names into full refnames
Date: Sun,  5 May 2013 01:55:46 +0200
Message-ID: <1367711749-8812-5-git-send-email-johan@herland.net>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 05 01:56:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYmJL-0005n7-W5
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 01:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149Ab3EDX4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 19:56:05 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34716 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab3EDX4C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 19:56:02 -0400
Received: by mail-bk0-f46.google.com with SMTP id w5so1145033bku.5
        for <git@vger.kernel.org>; Sat, 04 May 2013 16:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Sp+8okJNFX2WbU8T24g0BPP19ncYFYo3j2e8JKAQCJI=;
        b=iav40ghPlb6qos1HLSgp28p3RlC+yiWiv5kOsvkz+RrBNkq0fDCJH7Ofdln9CdJzUn
         xPmJszRQP9rjM3an4q1DYLo/AUGaIkjfhRvd8WwF9AHfTO3awgalhj8wJyWiVn/eZZOs
         f/DoLjfBbE3NEDtDL7ea/m9VFt0cnUGBvmK5RqxUwRVc0uGR+Yhrg3Y3TldN/s6rJjHf
         IUuvcgHdQawyhUiHo2M4ef27mWW84CjeBZc4/NNhNJuZzDYx0l1CFVQMsPj8BVmabeh6
         fZw4+1DgUmhEDCOL1RdSXsPhsw9eCHreISNC01ZiRGJEcGa0pxIz3wW3PJUesKHtVEn5
         zXVw==
X-Received: by 10.204.199.70 with SMTP id er6mr5901891bkb.122.1367711761347;
        Sat, 04 May 2013 16:56:01 -0700 (PDT)
Received: from localhost.localdomain (p5DC5A30A.dip0.t-ipconnect.de. [93.197.163.10])
        by mx.google.com with ESMTPSA id iy11sm3810775bkb.11.2013.05.04.16.55.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 04 May 2013 16:56:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1367711749-8812-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223388>

In preparation for allowing alternative ways of expanding shorthand refs
(like "master") into full refnames (like "refs/heads/master"): Expand
the current ref_rev_parse_rules list into ref_expand_rules, a list of
struct ref_expand_rule objects that encode both an expansion pattern
(e.g. "refs/heads/%.*s") and an associated expansion function
(e.g. the code that applies "master" to "refs/heads/%.*s" to produce
"refs/heads/master"). This allows us to later add expansion rules that
do something other than the current purely textual expansion.

The current expansion behavior is encoded in the new ref_expand_txtly()
helper function, which does the mksnpath() call that were previously
performed by all users of ref_rev_parse_rules.

The end result is identical in behavior to the existing code, but makes
it easier to adjust the way ref expansion happens for remote-tracking
branches in future patches

Most of the existing code that uses ref_rev_parse_rules to expand
shorthand refs are converted to use ref_expand_rules instead.

Signed-off-by: Johan Herland <johan@herland.net>
---
 cache.h  |  4 ----
 refs.c   | 46 +++++++++++++++++++++++++++++++++-------------
 refs.h   | 11 +++++++++++
 remote.c |  6 +++---
 4 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/cache.h b/cache.h
index 7ce9061..6adab04 100644
--- a/cache.h
+++ b/cache.h
@@ -875,10 +875,6 @@ extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
 extern int interpret_branch_name(const char *str, struct strbuf *);
 extern int get_sha1_mb(const char *str, unsigned char *sha1);
 
-extern int refname_match(const char *abbrev_name, const char *full_name, const char **rules);
-extern const char *ref_rev_parse_rules[];
-#define ref_fetch_rules ref_rev_parse_rules
-
 extern int create_symref(const char *ref, const char *refs_heads_master, const char *logmsg);
 extern int validate_headref(const char *ref);
 
diff --git a/refs.c b/refs.c
index 7231f54..8b02140 100644
--- a/refs.c
+++ b/refs.c
@@ -1724,7 +1724,24 @@ const char *prettify_refname(const char *name)
 		0);
 }
 
-const char *ref_rev_parse_rules[] = {
+static void ref_expand_txtly(const struct ref_expand_rule *rule,
+			     char *dst, size_t dst_len,
+			     const char *shortname, size_t shortname_len)
+{
+	mksnpath(dst, dst_len, rule->pattern, shortname_len, shortname);
+}
+
+const struct ref_expand_rule ref_expand_rules[] = {
+	{ ref_expand_txtly, "%.*s" },
+	{ ref_expand_txtly, "refs/%.*s" },
+	{ ref_expand_txtly, "refs/tags/%.*s" },
+	{ ref_expand_txtly, "refs/heads/%.*s" },
+	{ ref_expand_txtly, "refs/remotes/%.*s" },
+	{ ref_expand_txtly, "refs/remotes/%.*s/HEAD" },
+	{ NULL, NULL }
+};
+
+static const char *ref_rev_parse_rules[] = {
 	"%.*s",
 	"refs/%.*s",
 	"refs/tags/%.*s",
@@ -1734,15 +1751,17 @@ const char *ref_rev_parse_rules[] = {
 	NULL
 };
 
-int refname_match(const char *abbrev_name, const char *full_name, const char **rules)
+int refname_match(const char *abbrev_name, const char *full_name,
+		  const struct ref_expand_rule *rules)
 {
-	const char **p;
+	const struct ref_expand_rule *p;
 	const int abbrev_name_len = strlen(abbrev_name);
+	char n[PATH_MAX];
 
-	for (p = rules; *p; p++) {
-		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name))) {
+	for (p = rules; p->expand; p++) {
+		p->expand(p, n, sizeof(n), abbrev_name, abbrev_name_len);
+		if (!strcmp(full_name, n))
 			return 1;
-		}
 	}
 
 	return 0;
@@ -1807,21 +1826,22 @@ static char *substitute_branch_name(const char **string, int *len)
 int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 {
 	char *last_branch = substitute_branch_name(&str, &len);
-	const char **p, *r;
+	const struct ref_expand_rule *p;
+	const char *r;
 	int refs_found = 0;
 
 	*ref = NULL;
-	for (p = ref_rev_parse_rules; *p; p++) {
+	for (p = ref_expand_rules; p->expand; p++) {
 		char fullref[PATH_MAX];
 		unsigned char sha1_from_ref[20];
 		unsigned char *this_result;
 		int flag;
 
 		this_result = refs_found ? sha1_from_ref : sha1;
-		mksnpath(fullref, sizeof(fullref), *p, len, str);
+		p->expand(p, fullref, sizeof(fullref), str, len);
 		r = resolve_ref_unsafe(fullref, this_result, 1, &flag);
 		if (r) {
-			if (!refs_found++)
+			if ((!*ref || strcmp(*ref, r)) && !refs_found++)
 				*ref = xstrdup(r);
 			if (!warn_ambiguous_refs)
 				break;
@@ -1838,17 +1858,17 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 {
 	char *last_branch = substitute_branch_name(&str, &len);
-	const char **p;
+	const struct ref_expand_rule *p;
 	int logs_found = 0;
 
 	*log = NULL;
-	for (p = ref_rev_parse_rules; *p; p++) {
+	for (p = ref_expand_rules; p->expand; p++) {
 		struct stat st;
 		unsigned char hash[20];
 		char path[PATH_MAX];
 		const char *ref, *it;
 
-		mksnpath(path, sizeof(path), *p, len, str);
+		p->expand(p, path, sizeof(path), str, len);
 		ref = resolve_ref_unsafe(path, hash, 1, NULL);
 		if (!ref)
 			continue;
diff --git a/refs.h b/refs.h
index 8060ed8..85710cb 100644
--- a/refs.h
+++ b/refs.h
@@ -164,6 +164,17 @@ extern int for_each_reflog(each_ref_fn, void *);
 extern int check_refname_format(const char *refname, int flags);
 
 extern const char *prettify_refname(const char *refname);
+
+struct ref_expand_rule {
+	void (*expand)(const struct ref_expand_rule *rule,
+		       char *dst, size_t dst_len,
+		       const char *shortname, size_t shortname_len);
+	const char *pattern;
+};
+extern const struct ref_expand_rule ref_expand_rules[];
+extern int refname_match(const char *abbrev_name, const char *full_name,
+			 const struct ref_expand_rule *rules);
+
 extern char *shorten_unambiguous_ref(const char *refname, int strict);
 
 /** rename ref, return 0 on success **/
diff --git a/remote.c b/remote.c
index 68eb99b..5ef34c9 100644
--- a/remote.c
+++ b/remote.c
@@ -981,7 +981,7 @@ static int count_refspec_match(const char *pattern,
 		char *name = refs->name;
 		int namelen = strlen(name);
 
-		if (!refname_match(pattern, name, ref_rev_parse_rules))
+		if (!refname_match(pattern, name, ref_expand_rules))
 			continue;
 
 		/* A match is "weak" if it is with refs outside
@@ -1499,7 +1499,7 @@ int branch_merge_matches(struct branch *branch,
 {
 	if (!branch || i < 0 || i >= branch->merge_nr)
 		return 0;
-	return refname_match(branch->merge[i]->src, refname, ref_fetch_rules);
+	return refname_match(branch->merge[i]->src, refname, ref_expand_rules);
 }
 
 static int ignore_symref_update(const char *refname)
@@ -1545,7 +1545,7 @@ static const struct ref *find_ref_by_name_abbrev(const struct ref *refs, const c
 {
 	const struct ref *ref;
 	for (ref = refs; ref; ref = ref->next) {
-		if (refname_match(name, ref->name, ref_fetch_rules))
+		if (refname_match(name, ref->name, ref_expand_rules))
 			return ref;
 	}
 	return NULL;
-- 
1.8.1.3.704.g33f7d4f
