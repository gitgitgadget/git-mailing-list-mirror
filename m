From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 03/10] refs.c: Refactor code for mapping between shorthand names and full refnames
Date: Sat, 11 May 2013 18:21:13 +0200
Message-ID: <1368289280-30337-4-git-send-email-johan@herland.net>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 18:22:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCYb-0007jj-Ps
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376Ab3EKQVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:21:35 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:38443 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722Ab3EKQVb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:21:31 -0400
Received: by mail-wg0-f48.google.com with SMTP id f11so4864596wgh.3
        for <git@vger.kernel.org>; Sat, 11 May 2013 09:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=9s7gyucQUxyZd6JvCsAuxQHJ0joEffB26hb3u5B3tqw=;
        b=hhLhyLV18nlMoN4IgUG7PYE7fFrR+rusG55E8LkvOJeZTo/fxXrYOUhjyR+yq9odKs
         SsXUdp8QTG43LeiT7aPMTg7Ul6eSxEYbBYH2GbpStL5IpztcqYx3/Ocg6nh6f2eFxTRi
         AEdaeViYayDLvWY/xstmlWAruAoHdWr0MjSplBhkDvz0lj2Q9Ial186vzqwmfMlFxHc9
         AwBA+mtmQFtlNhNzH6N/P8TrqYmAibh7yuK1tFpWXx3IVVel3UDjqNsqqg3VHVB4lvfX
         R7Dpon9Uo77baS7eLaNoh0EyhsyOCDm8uHJ22giEJIjyeF/KiHBZZ0Ed3YJAqk4XXLM5
         Grdw==
X-Received: by 10.180.82.74 with SMTP id g10mr9812174wiy.10.1368289290196;
        Sat, 11 May 2013 09:21:30 -0700 (PDT)
Received: from localhost.localdomain ([213.221.117.228])
        by mx.google.com with ESMTPSA id er17sm4722405wic.0.2013.05.11.09.21.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 09:21:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1368289280-30337-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223991>

This patch is in preparation for extending the ways in which we expand
shorthand names into full refnames, and shorten full refnames into
unambiguous shorthand names.

We collect the logic for performing the expansion and shortening into two
functions: refname_expand() and refname_shorten(). refname_expand() takes
a shorthand name, and a pattern containing a wildcard (more on those
below), and substitutes the shorthand name for the wildcard. The result
is written into a strbuf provided by the caller. Correspondingly,
refname_shorten() takes a full refname and matches it against the given
pattern, extracting the portion of the full refname that matches the
pattern wildcard. The resulting shorthand name is written into a strbuf
provided by the caller.

The refname_expand() function no longer uses mkpath()/mksnpath() to
perform the pattern expansion. Instead, it uses strbuf_expand(), which
removes the need for using fixed-length buffers from the code. This also
means we no longer call cleanup_path() on the resulting refs, but AFAICS,
this is not really needed anyway (also it breaks no existing tests).

Since the pattern expansion is now done by strbuf_expand(), the syntax of
the pattern wildcard must change as well. Whereas a pattern used to look
like this:

    "refs/remotes/%.*s/HEAD"

it now looks like this:

    "refs/remotes/%*/HEAD"

where the "%*" wildcard is meant to be read as "the full shorthand name".
More wildcards will be added by future patches that require more complex
wildcard matching.

The list of patterns has been renamed from "ref_rev_parse_rules" to
"refname_patterns" (which should be more descriptive), and it has lost
the NULL terminator, which is no longer needed, since all iterations of
the list now uses ARRAY_SIZE(refname_patterns) to end iteration, instead
of testing each member against NULL.

Furthermore, refname_match() used to take the list of patterns as an
argument, but since all callers pass the one and only pattern list, we
can drop the argument altogether, and use refname_patterns directly in
refname_match(). This also enables us to make the pattern list static.

The code for shortening full refnames into shorthands, has been adjusted
to deal with the new "%*" patterns. It now uses strbuf_split_str() with
the '%' as terminator, to split the prefix part from the suffix part.
Then - as before - it matches the prefix from the start of the given
refname and the suffix from the end of the refname. If both matches are
successful, the middle portion is extracted as the resulting shorthand
name.

The end result of this refactoring is equivalent in behavior to the
existing code, but makes it easier for future patches to adjust how
expansion and shortening happens.

All of the existing users of ref_rev_parse_rules are converted to
refname_patterns by this patch, so ref_rev_parse_rules is removed
as well.

Signed-off-by: Johan Herland <johan@herland.net>
---
 cache.h  |   4 --
 refs.c   | 187 ++++++++++++++++++++++++++++++++++++++-------------------------
 refs.h   |   3 +
 remote.c |   6 +-
 4 files changed, 119 insertions(+), 81 deletions(-)

diff --git a/cache.h b/cache.h
index ac620b2..0cc43b2 100644
--- a/cache.h
+++ b/cache.h
@@ -874,10 +874,6 @@ extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
 extern int interpret_branch_name(const char *str, struct strbuf *);
 extern int get_sha1_mb(const char *str, unsigned char *sha1);
 
-extern int refname_match(const char *abbrev_name, const char *full_name, const char **rules);
-extern const char *ref_rev_parse_rules[];
-#define ref_fetch_rules ref_rev_parse_rules
-
 extern int create_symref(const char *ref, const char *refs_heads_master, const char *logmsg);
 extern int validate_headref(const char *ref);
 
diff --git a/refs.c b/refs.c
index 006f369..ab5e120 100644
--- a/refs.c
+++ b/refs.c
@@ -1783,27 +1783,91 @@ const char *prettify_refname(const char *name)
 		0);
 }
 
-const char *ref_rev_parse_rules[] = {
-	"%.*s",
-	"refs/%.*s",
-	"refs/tags/%.*s",
-	"refs/heads/%.*s",
-	"refs/remotes/%.*s",
-	"refs/remotes/%.*s/HEAD",
-	NULL
+static const char *refname_patterns[] = {
+	"%*",
+	"refs/%*",
+	"refs/tags/%*",
+	"refs/heads/%*",
+	"refs/remotes/%*",
+	"refs/remotes/%*/HEAD"
 };
 
-int refname_match(const char *abbrev_name, const char *full_name, const char **rules)
+struct wildcard_data {
+	const char *s;
+	size_t len;
+	int done;
+};
+
+static size_t refname_expand_helper(struct strbuf *sb, const char *placeholder,
+				    void *context)
 {
-	const char **p;
-	const int abbrev_name_len = strlen(abbrev_name);
+	struct wildcard_data *cb = context;
+	if (*placeholder == '*' && !cb->done) {
+		strbuf_add(sb, cb->s, cb->len);
+		cb->done = 1;
+		return 1;
+	}
+	return 0;
+}
 
-	for (p = rules; *p; p++) {
-		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name))) {
+static int refname_expand(struct strbuf *dst, const char *pattern,
+			  const char *shortname, size_t shortname_len)
+{
+	struct wildcard_data cbdata = { shortname, shortname_len, 0 };
+	strbuf_reset(dst);
+	strbuf_expand(dst, pattern, refname_expand_helper, &cbdata);
+	if (!cbdata.done)
+		strbuf_reset(dst);
+	return !cbdata.done;
+}
+
+static int refname_shorten(struct strbuf *dst, const char *pattern,
+			   const char *refname, size_t refname_len)
+{
+	/*
+	 * Match refname against pattern, using "%*" as wildcard, and
+	 * extract the wildcard-matching portion of refname into dst.
+	 * Return 0 on success (positive match, wildcard-matching portion
+	 * copied into dst), and non-zero on failure (no match, dst empty).
+	 */
+	const char *match_end;
+	struct strbuf **fragments = strbuf_split_str(pattern, '%', 2);
+	struct strbuf *prefix = fragments[0], *suffix = fragments[1];
+	assert(!fragments[2]);
+	assert(prefix->len && prefix->buf[prefix->len - 1] == '%');
+	assert(suffix->len && suffix->buf[0] == '*');
+
+	strbuf_reset(dst);
+	match_end = refname + refname_len - (suffix->len - 1);
+	if (refname_len <= (prefix->len - 1) + (suffix->len - 1) ||
+	    memcmp(prefix->buf, refname, prefix->len - 1) ||
+	    memcmp(suffix->buf + 1, match_end, suffix->len - 1)) {
+		strbuf_list_free(fragments);
+		return 1; /* refname does not match pattern */
+	}
+
+	refname += prefix->len - 1;
+	strbuf_add(dst, refname, match_end - refname);
+	strbuf_list_free(fragments);
+	return 0;
+}
+
+int refname_match(const char *abbrev_name, const char *full_name)
+{
+	size_t i;
+	const size_t abbrev_len = strlen(abbrev_name);
+	struct strbuf exp = STRBUF_INIT;
+
+	for (i = 0; i < ARRAY_SIZE(refname_patterns); i++) {
+		if (!refname_expand(&exp, refname_patterns[i],
+				    abbrev_name, abbrev_len) &&
+		    !strcmp(full_name, exp.buf)) {
+			strbuf_release(&exp);
 			return 1;
 		}
 	}
 
+	strbuf_release(&exp);
 	return 0;
 }
 
@@ -1866,30 +1930,33 @@ static char *substitute_branch_name(const char **string, int *len)
 int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 {
 	char *last_branch = substitute_branch_name(&str, &len);
-	const char **p, *r;
+	struct strbuf exp = STRBUF_INIT;
 	int refs_found = 0;
+	size_t i;
 
 	*ref = NULL;
-	for (p = ref_rev_parse_rules; *p; p++) {
-		char fullref[PATH_MAX];
+	for (i = 0; i < ARRAY_SIZE(refname_patterns); i++) {
 		unsigned char sha1_from_ref[20];
 		unsigned char *this_result;
+		const char *r;
 		int flag;
 
 		this_result = refs_found ? sha1_from_ref : sha1;
-		mksnpath(fullref, sizeof(fullref), *p, len, str);
-		r = resolve_ref_unsafe(fullref, this_result, 1, &flag);
+		if (refname_expand(&exp, refname_patterns[i], str, len))
+			continue;
+		r = resolve_ref_unsafe(exp.buf, this_result, 1, &flag);
 		if (r) {
-			if (!refs_found++)
+			if ((!*ref || strcmp(*ref, r)) && !refs_found++)
 				*ref = xstrdup(r);
 			if (!warn_ambiguous_refs)
 				break;
-		} else if ((flag & REF_ISSYMREF) && strcmp(fullref, "HEAD")) {
-			warning("ignoring dangling symref %s.", fullref);
-		} else if ((flag & REF_ISBROKEN) && strchr(fullref, '/')) {
-			warning("ignoring broken ref %s.", fullref);
+		} else if ((flag & REF_ISSYMREF) && strcmp(exp.buf, "HEAD")) {
+			warning("ignoring dangling symref %s.", exp.buf);
+		} else if ((flag & REF_ISBROKEN) && strchr(exp.buf, '/')) {
+			warning("ignoring broken ref %s.", exp.buf);
 		}
 	}
+	strbuf_release(&exp);
 	free(last_branch);
 	return refs_found;
 }
@@ -1897,24 +1964,25 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 {
 	char *last_branch = substitute_branch_name(&str, &len);
-	const char **p;
+	struct strbuf path = STRBUF_INIT;
 	int logs_found = 0;
+	size_t i;
 
 	*log = NULL;
-	for (p = ref_rev_parse_rules; *p; p++) {
+	for (i = 0; i < ARRAY_SIZE(refname_patterns); i++) {
 		struct stat st;
 		unsigned char hash[20];
-		char path[PATH_MAX];
 		const char *ref, *it;
 
-		mksnpath(path, sizeof(path), *p, len, str);
-		ref = resolve_ref_unsafe(path, hash, 1, NULL);
+		if (refname_expand(&path, refname_patterns[i], str, len))
+			continue;
+		ref = resolve_ref_unsafe(path.buf, hash, 1, NULL);
 		if (!ref)
 			continue;
-		if (!stat(git_path("logs/%s", path), &st) &&
+		if (!stat(git_path("logs/%s", path.buf), &st) &&
 		    S_ISREG(st.st_mode))
-			it = path;
-		else if (strcmp(ref, path) &&
+			it = path.buf;
+		else if (strcmp(ref, path.buf) &&
 			 !stat(git_path("logs/%s", ref), &st) &&
 			 S_ISREG(st.st_mode))
 			it = ref;
@@ -1927,6 +1995,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 		if (!warn_ambiguous_refs)
 			break;
 	}
+	strbuf_release(&path);
 	free(last_branch);
 	return logs_found;
 }
@@ -3004,47 +3073,20 @@ struct ref *find_ref_by_name(const struct ref *list, const char *name)
 	return NULL;
 }
 
-static int shorten_ref(const char *refname, const char *pattern, char *short_name)
-{
-	/*
-	 * pattern must be of the form "[pre]%.*s[post]". If refname
-	 * starts with "[pre]" and ends with "[post]", extract the middle
-	 * part into short_name, and return the number of chars in the
-	 * middle part (not counting the added NUL-terminator). Otherwise,
-	 * if refname does not match pattern, return 0.
-	 */
-	int match_len;
-	const char *match_start, *sep = strstr(pattern, "%.*s");
-	if (!sep || strstr(sep + 4, "%.*s"))
-		die("invalid pattern in ref_rev_parse_rules: %s", pattern);
-	match_start = refname + (sep - pattern);
-	match_len = strlen(refname) - (strlen(pattern) - 4);
-	if (match_len <= 0 ||
-	    memcmp(refname, pattern, match_start - refname) ||
-	    strcmp(match_start + match_len, sep + 4))
-		return 0; /* refname does not match */
-	memcpy(short_name, match_start, match_len);
-	short_name[match_len] = '\0';
-	return match_len;
-}
-
 char *shorten_unambiguous_ref(const char *refname, int strict)
 {
+	size_t refname_len = strlen(refname);
 	int i;
-	char *short_name;
-
-	/* buffer for scanf result, at most refname must fit */
-	short_name = xstrdup(refname);
+	struct strbuf shortname = STRBUF_INIT;
+	struct strbuf expanded = STRBUF_INIT;
 
 	/* skip first rule, it will always match */
-	for (i = ARRAY_SIZE(ref_rev_parse_rules) - 2; i > 0; --i) {
+	for (i = ARRAY_SIZE(refname_patterns) - 1; i > 0; --i) {
 		int j;
 		int rules_to_fail = i;
-		int short_name_len;
 
-		if (!(short_name_len = shorten_ref(refname,
-						   ref_rev_parse_rules[i],
-						   short_name)))
+		if (refname_shorten(&shortname, refname_patterns[i],
+				    refname, refname_len))
 			continue;
 
 		/*
@@ -3052,16 +3094,13 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 		 * must fail to resolve to a valid non-ambiguous ref
 		 */
 		if (strict)
-			rules_to_fail = ARRAY_SIZE(ref_rev_parse_rules) - 1;
+			rules_to_fail = ARRAY_SIZE(refname_patterns);
 
 		/*
 		 * check if the short name resolves to a valid ref,
 		 * but use only rules prior to the matched one
 		 */
 		for (j = 0; j < rules_to_fail; j++) {
-			const char *rule = ref_rev_parse_rules[j];
-			char refname[PATH_MAX];
-
 			/* skip matched rule */
 			if (i == j)
 				continue;
@@ -3069,23 +3108,23 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 			/*
 			 * the short name is ambiguous, if it resolves
 			 * (with this previous rule) to a valid ref
-			 * read_ref() returns 0 on success
 			 */
-			mksnpath(refname, sizeof(refname),
-				 rule, short_name_len, short_name);
-			if (ref_exists(refname))
+			if (!refname_expand(&expanded, refname_patterns[j],
+					    shortname.buf, shortname.len) &&
+			    ref_exists(expanded.buf))
 				break;
 		}
+		strbuf_release(&expanded);
 
 		/*
 		 * short name is non-ambiguous if all previous rules
 		 * haven't resolved to a valid ref
 		 */
 		if (j == rules_to_fail)
-			return short_name;
+			return strbuf_detach(&shortname, NULL);
 	}
 
-	free(short_name);
+	strbuf_release(&shortname);
 	return xstrdup(refname);
 }
 
diff --git a/refs.h b/refs.h
index 8060ed8..e05c1f1 100644
--- a/refs.h
+++ b/refs.h
@@ -164,6 +164,9 @@ extern int for_each_reflog(each_ref_fn, void *);
 extern int check_refname_format(const char *refname, int flags);
 
 extern const char *prettify_refname(const char *refname);
+
+extern int refname_match(const char *abbrev_name, const char *full_name);
+
 extern char *shorten_unambiguous_ref(const char *refname, int strict);
 
 /** rename ref, return 0 on success **/
diff --git a/remote.c b/remote.c
index 68eb99b..8ca4823 100644
--- a/remote.c
+++ b/remote.c
@@ -981,7 +981,7 @@ static int count_refspec_match(const char *pattern,
 		char *name = refs->name;
 		int namelen = strlen(name);
 
-		if (!refname_match(pattern, name, ref_rev_parse_rules))
+		if (!refname_match(pattern, name))
 			continue;
 
 		/* A match is "weak" if it is with refs outside
@@ -1499,7 +1499,7 @@ int branch_merge_matches(struct branch *branch,
 {
 	if (!branch || i < 0 || i >= branch->merge_nr)
 		return 0;
-	return refname_match(branch->merge[i]->src, refname, ref_fetch_rules);
+	return refname_match(branch->merge[i]->src, refname);
 }
 
 static int ignore_symref_update(const char *refname)
@@ -1545,7 +1545,7 @@ static const struct ref *find_ref_by_name_abbrev(const struct ref *refs, const c
 {
 	const struct ref *ref;
 	for (ref = refs; ref; ref = ref->next) {
-		if (refname_match(name, ref->name, ref_fetch_rules))
+		if (refname_match(name, ref->name))
 			return ref;
 	}
 	return NULL;
-- 
1.8.1.3.704.g33f7d4f
