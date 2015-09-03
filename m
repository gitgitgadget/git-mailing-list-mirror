From: David Turner <dturner@twopensource.com>
Subject: [PATCH 09/43] refs.c: move dwim and friend functions to the common refs code
Date: Wed,  2 Sep 2015 21:54:39 -0400
Message-ID: <1441245313-11907-10-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:58:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJmt-0007YP-6Z
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbbICB55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:57:57 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34652 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756297AbbICBzf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:35 -0400
Received: by qkfq186 with SMTP id q186so15070798qkf.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RFxTRXbgP55Ag0th38uNd81Lzn4iCWxWKuuC26WXdLo=;
        b=JhOt2i63HJbgW/349OhlCNH/kXRV3LB9wBclLRuegQDANHDCmBq6CMZmn31ErdGyNu
         y9exaQ7d8bUD1CxCTgmJ4rCMYJdi1FuG5lYzFtLmHH0yWaqWAphPUcT/tw1ds2xCN1wE
         OHMbLFDnXas0d87Kdx7pjqirXrQvYJGqjGn6Jpn/FFjv1WiSQ/7qSYwmG8nTY7nXVnVE
         Ay5koVgqZXDK+4aUBeyLdDjgVC2X/H3TqVbRZf1H/lkZBQaCSByYLpLspJ8H/tcADird
         9eo9IJHTwoQriDUOUiL0BNnaa36YGkkkYYOaZd2gX8jAEKfPf21M5gB7DktvNkrblxj6
         Lb+A==
X-Gm-Message-State: ALoCoQnpVjMiE4rQEbc5An4A2QkFjlYWU4ckaQuAOFGU4AcMTevgalfxnytPWv4KfhHuhBpCG2+g
X-Received: by 10.55.51.84 with SMTP id z81mr11821569qkz.21.1441245335236;
        Wed, 02 Sep 2015 18:55:35 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:34 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277177>

From: Ronnie Sahlberg <sahlberg@google.com>

These functions do not contain any backend specific code so we move
them to the common code and share across all backends.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twitter.com>
---
 refs-be-files.c | 203 --------------------------------------------------------
 refs.c          | 203 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 203 insertions(+), 203 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index e559d46..4f0e3c7 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2257,30 +2257,6 @@ const char *prettify_refname(const char *name)
 		0);
 }
 
-static const char *ref_rev_parse_rules[] = {
-	"%.*s",
-	"refs/%.*s",
-	"refs/tags/%.*s",
-	"refs/heads/%.*s",
-	"refs/remotes/%.*s",
-	"refs/remotes/%.*s/HEAD",
-	NULL
-};
-
-int refname_match(const char *abbrev_name, const char *full_name)
-{
-	const char **p;
-	const int abbrev_name_len = strlen(abbrev_name);
-
-	for (p = ref_rev_parse_rules; *p; p++) {
-		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name))) {
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
 static void unlock_ref(struct ref_lock *lock)
 {
 	/* Do not free lock->lk -- atexit() still looks at them */
@@ -2333,92 +2309,6 @@ static int remove_empty_directories(struct strbuf *path)
 }
 
 /*
- * *string and *len will only be substituted, and *string returned (for
- * later free()ing) if the string passed in is a magic short-hand form
- * to name a branch.
- */
-static char *substitute_branch_name(const char **string, int *len)
-{
-	struct strbuf buf = STRBUF_INIT;
-	int ret = interpret_branch_name(*string, *len, &buf);
-
-	if (ret == *len) {
-		size_t size;
-		*string = strbuf_detach(&buf, &size);
-		*len = size;
-		return (char *)*string;
-	}
-
-	return NULL;
-}
-
-int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
-{
-	char *last_branch = substitute_branch_name(&str, &len);
-	const char **p, *r;
-	int refs_found = 0;
-
-	*ref = NULL;
-	for (p = ref_rev_parse_rules; *p; p++) {
-		char fullref[PATH_MAX];
-		unsigned char sha1_from_ref[20];
-		unsigned char *this_result;
-		int flag;
-
-		this_result = refs_found ? sha1_from_ref : sha1;
-		mksnpath(fullref, sizeof(fullref), *p, len, str);
-		r = resolve_ref_unsafe(fullref, RESOLVE_REF_READING,
-				       this_result, &flag);
-		if (r) {
-			if (!refs_found++)
-				*ref = xstrdup(r);
-			if (!warn_ambiguous_refs)
-				break;
-		} else if ((flag & REF_ISSYMREF) && strcmp(fullref, "HEAD")) {
-			warning("ignoring dangling symref %s.", fullref);
-		} else if ((flag & REF_ISBROKEN) && strchr(fullref, '/')) {
-			warning("ignoring broken ref %s.", fullref);
-		}
-	}
-	free(last_branch);
-	return refs_found;
-}
-
-int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
-{
-	char *last_branch = substitute_branch_name(&str, &len);
-	const char **p;
-	int logs_found = 0;
-
-	*log = NULL;
-	for (p = ref_rev_parse_rules; *p; p++) {
-		unsigned char hash[20];
-		char path[PATH_MAX];
-		const char *ref, *it;
-
-		mksnpath(path, sizeof(path), *p, len, str);
-		ref = resolve_ref_unsafe(path, RESOLVE_REF_READING,
-					 hash, NULL);
-		if (!ref)
-			continue;
-		if (reflog_exists(path))
-			it = path;
-		else if (strcmp(ref, path) && reflog_exists(ref))
-			it = ref;
-		else
-			continue;
-		if (!logs_found++) {
-			*log = xstrdup(it);
-			hashcpy(sha1, hash);
-		}
-		if (!warn_ambiguous_refs)
-			break;
-	}
-	free(last_branch);
-	return logs_found;
-}
-
-/*
  * Locks a ref returning the lock on success and NULL on failure.
  * On failure errno is set to something meaningful.
  */
@@ -4086,99 +3976,6 @@ cleanup:
 	return ret;
 }
 
-char *shorten_unambiguous_ref(const char *refname, int strict)
-{
-	int i;
-	static char **scanf_fmts;
-	static int nr_rules;
-	char *short_name;
-
-	if (!nr_rules) {
-		/*
-		 * Pre-generate scanf formats from ref_rev_parse_rules[].
-		 * Generate a format suitable for scanf from a
-		 * ref_rev_parse_rules rule by interpolating "%s" at the
-		 * location of the "%.*s".
-		 */
-		size_t total_len = 0;
-		size_t offset = 0;
-
-		/* the rule list is NULL terminated, count them first */
-		for (nr_rules = 0; ref_rev_parse_rules[nr_rules]; nr_rules++)
-			/* -2 for strlen("%.*s") - strlen("%s"); +1 for NUL */
-			total_len += strlen(ref_rev_parse_rules[nr_rules]) - 2 + 1;
-
-		scanf_fmts = xmalloc(nr_rules * sizeof(char *) + total_len);
-
-		offset = 0;
-		for (i = 0; i < nr_rules; i++) {
-			assert(offset < total_len);
-			scanf_fmts[i] = (char *)&scanf_fmts[nr_rules] + offset;
-			offset += snprintf(scanf_fmts[i], total_len - offset,
-					   ref_rev_parse_rules[i], 2, "%s") + 1;
-		}
-	}
-
-	/* bail out if there are no rules */
-	if (!nr_rules)
-		return xstrdup(refname);
-
-	/* buffer for scanf result, at most refname must fit */
-	short_name = xstrdup(refname);
-
-	/* skip first rule, it will always match */
-	for (i = nr_rules - 1; i > 0 ; --i) {
-		int j;
-		int rules_to_fail = i;
-		int short_name_len;
-
-		if (1 != sscanf(refname, scanf_fmts[i], short_name))
-			continue;
-
-		short_name_len = strlen(short_name);
-
-		/*
-		 * in strict mode, all (except the matched one) rules
-		 * must fail to resolve to a valid non-ambiguous ref
-		 */
-		if (strict)
-			rules_to_fail = nr_rules;
-
-		/*
-		 * check if the short name resolves to a valid ref,
-		 * but use only rules prior to the matched one
-		 */
-		for (j = 0; j < rules_to_fail; j++) {
-			const char *rule = ref_rev_parse_rules[j];
-			char refname[PATH_MAX];
-
-			/* skip matched rule */
-			if (i == j)
-				continue;
-
-			/*
-			 * the short name is ambiguous, if it resolves
-			 * (with this previous rule) to a valid ref
-			 * read_ref() returns 0 on success
-			 */
-			mksnpath(refname, sizeof(refname),
-				 rule, short_name_len, short_name);
-			if (ref_exists(refname))
-				break;
-		}
-
-		/*
-		 * short name is non-ambiguous if all previous rules
-		 * haven't resolved to a valid ref
-		 */
-		if (j == rules_to_fail)
-			return short_name;
-	}
-
-	free(short_name);
-	return xstrdup(refname);
-}
-
 struct expire_reflog_cb {
 	unsigned int flags;
 	reflog_expiry_should_prune_fn *should_prune_fn;
diff --git a/refs.c b/refs.c
index 6b2fc39..310b7f5 100644
--- a/refs.c
+++ b/refs.c
@@ -378,3 +378,206 @@ int ref_is_hidden(const char *refname)
 	}
 	return 0;
 }
+
+static const char *ref_rev_parse_rules[] = {
+	"%.*s",
+	"refs/%.*s",
+	"refs/tags/%.*s",
+	"refs/heads/%.*s",
+	"refs/remotes/%.*s",
+	"refs/remotes/%.*s/HEAD",
+	NULL
+};
+
+int refname_match(const char *abbrev_name, const char *full_name)
+{
+	const char **p;
+	const int abbrev_name_len = strlen(abbrev_name);
+
+	for (p = ref_rev_parse_rules; *p; p++) {
+		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name))) {
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * *string and *len will only be substituted, and *string returned (for
+ * later free()ing) if the string passed in is a magic short-hand form
+ * to name a branch.
+ */
+static char *substitute_branch_name(const char **string, int *len)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret = interpret_branch_name(*string, *len, &buf);
+
+	if (ret == *len) {
+		size_t size;
+		*string = strbuf_detach(&buf, &size);
+		*len = size;
+		return (char *)*string;
+	}
+
+	return NULL;
+}
+
+int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
+{
+	char *last_branch = substitute_branch_name(&str, &len);
+	const char **p, *r;
+	int refs_found = 0;
+
+	*ref = NULL;
+	for (p = ref_rev_parse_rules; *p; p++) {
+		char fullref[PATH_MAX];
+		unsigned char sha1_from_ref[20];
+		unsigned char *this_result;
+		int flag;
+
+		this_result = refs_found ? sha1_from_ref : sha1;
+		mksnpath(fullref, sizeof(fullref), *p, len, str);
+		r = resolve_ref_unsafe(fullref, RESOLVE_REF_READING,
+				       this_result, &flag);
+		if (r) {
+			if (!refs_found++)
+				*ref = xstrdup(r);
+			if (!warn_ambiguous_refs)
+				break;
+		} else if ((flag & REF_ISSYMREF) && strcmp(fullref, "HEAD")) {
+			warning("ignoring dangling symref %s.", fullref);
+		} else if ((flag & REF_ISBROKEN) && strchr(fullref, '/')) {
+			warning("ignoring broken ref %s.", fullref);
+		}
+	}
+	free(last_branch);
+	return refs_found;
+}
+
+int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
+{
+	char *last_branch = substitute_branch_name(&str, &len);
+	const char **p;
+	int logs_found = 0;
+
+	*log = NULL;
+	for (p = ref_rev_parse_rules; *p; p++) {
+		unsigned char hash[20];
+		char path[PATH_MAX];
+		const char *ref, *it;
+
+		mksnpath(path, sizeof(path), *p, len, str);
+		ref = resolve_ref_unsafe(path, RESOLVE_REF_READING,
+					 hash, NULL);
+		if (!ref)
+			continue;
+		if (reflog_exists(path))
+			it = path;
+		else if (strcmp(ref, path) && reflog_exists(ref))
+			it = ref;
+		else
+			continue;
+		if (!logs_found++) {
+			*log = xstrdup(it);
+			hashcpy(sha1, hash);
+		}
+		if (!warn_ambiguous_refs)
+			break;
+	}
+	free(last_branch);
+	return logs_found;
+}
+
+char *shorten_unambiguous_ref(const char *refname, int strict)
+{
+	int i;
+	static char **scanf_fmts;
+	static int nr_rules;
+	char *short_name;
+
+	if (!nr_rules) {
+		/*
+		 * Pre-generate scanf formats from ref_rev_parse_rules[].
+		 * Generate a format suitable for scanf from a
+		 * ref_rev_parse_rules rule by interpolating "%s" at the
+		 * location of the "%.*s".
+		 */
+		size_t total_len = 0;
+		size_t offset = 0;
+
+		/* the rule list is NULL terminated, count them first */
+		for (nr_rules = 0; ref_rev_parse_rules[nr_rules]; nr_rules++)
+			/* -2 for strlen("%.*s") - strlen("%s"); +1 for NUL */
+			total_len += strlen(ref_rev_parse_rules[nr_rules]) - 2 + 1;
+
+		scanf_fmts = xmalloc(nr_rules * sizeof(char *) + total_len);
+
+		offset = 0;
+		for (i = 0; i < nr_rules; i++) {
+			assert(offset < total_len);
+			scanf_fmts[i] = (char *)&scanf_fmts[nr_rules] + offset;
+			offset += snprintf(scanf_fmts[i], total_len - offset,
+					   ref_rev_parse_rules[i], 2, "%s") + 1;
+		}
+	}
+
+	/* bail out if there are no rules */
+	if (!nr_rules)
+		return xstrdup(refname);
+
+	/* buffer for scanf result, at most refname must fit */
+	short_name = xstrdup(refname);
+
+	/* skip first rule, it will always match */
+	for (i = nr_rules - 1; i > 0 ; --i) {
+		int j;
+		int rules_to_fail = i;
+		int short_name_len;
+
+		if (1 != sscanf(refname, scanf_fmts[i], short_name))
+			continue;
+
+		short_name_len = strlen(short_name);
+
+		/*
+		 * in strict mode, all (except the matched one) rules
+		 * must fail to resolve to a valid non-ambiguous ref
+		 */
+		if (strict)
+			rules_to_fail = nr_rules;
+
+		/*
+		 * check if the short name resolves to a valid ref,
+		 * but use only rules prior to the matched one
+		 */
+		for (j = 0; j < rules_to_fail; j++) {
+			const char *rule = ref_rev_parse_rules[j];
+			char refname[PATH_MAX];
+
+			/* skip matched rule */
+			if (i == j)
+				continue;
+
+			/*
+			 * the short name is ambiguous, if it resolves
+			 * (with this previous rule) to a valid ref
+			 * read_ref() returns 0 on success
+			 */
+			mksnpath(refname, sizeof(refname),
+				 rule, short_name_len, short_name);
+			if (ref_exists(refname))
+				break;
+		}
+
+		/*
+		 * short name is non-ambiguous if all previous rules
+		 * haven't resolved to a valid ref
+		 */
+		if (j == rules_to_fail)
+			return short_name;
+	}
+
+	free(short_name);
+	return xstrdup(refname);
+}
-- 
2.0.4.315.gad8727a-twtrsrc
