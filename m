From: Johan Herland <johan@herland.net>
Subject: [PATCH 5/7] refs.c: Refactor code for shortening full refnames into shorthand names
Date: Sun,  5 May 2013 01:55:47 +0200
Message-ID: <1367711749-8812-6-git-send-email-johan@herland.net>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 05 01:56:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYmJM-0005n7-G6
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 01:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165Ab3EDX4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 19:56:08 -0400
Received: from mail-bk0-f41.google.com ([209.85.214.41]:62890 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab3EDX4F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 19:56:05 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc3so1147152bkc.14
        for <git@vger.kernel.org>; Sat, 04 May 2013 16:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=e6+w5RCz8xiKuNfyec0Oz9Amrxkp8Ghh7WGg6RBPYXQ=;
        b=nmhk2c763XszNjj4b9r5Rd2vhO8pcIrIW+VdK+BVX6bkH4h+q4Hp7cr/MaYTTf6McE
         fA2zzw/I9QQZAyf9vEcCooXVpv3Qo314O+AwdgUUGxXaZnnjbBZyGVmu67fboNsFgXbK
         YcZHkuVERciJcLDAt7NMWvYN4HG9MelDVOQDgqJ1ccGxyrrHHIqpkYGngoRkfukGPueC
         sUcJ1BKGz2fMXkFSLS/ZejO7Fmobtvf+DHzH9IbzxjybSQXTQFiZDZqonwbwephEUBjd
         rJt+5X1k03Z93ubJ3xC9M8MQ/ZjyqU7/QJii+MYpwtY6cfvh+g+nX9t2GxK7MMn2ZBjV
         W1aQ==
X-Received: by 10.204.168.201 with SMTP id v9mr5818633bky.116.1367711763694;
        Sat, 04 May 2013 16:56:03 -0700 (PDT)
Received: from localhost.localdomain (p5DC5A30A.dip0.t-ipconnect.de. [93.197.163.10])
        by mx.google.com with ESMTPSA id iy11sm3810775bkb.11.2013.05.04.16.56.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 04 May 2013 16:56:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1367711749-8812-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223387>

shorten_unambiguous_ref() provides the reverse functionality to the
expansion of shorthand names into full refnames, i.e. it takes a full
refname (like "refs/heads/master"), and matches it against a pattern
(like "refs/heads/%.*s") to produce a shorthand name (like "master").

Being the last remaining user of ref_rev_parse_rules list, this patch
converts it to use ref_expand_rules instead. However, as we associated
an expansion function with each expansion rule - to allow for alternative
expansion behavior in the future - we also need to associate a
"shortening" function with each rule, to allow for the reverse operation
to be customized as well.

Therefore, we add a "shorten" function to struct ref_expand_rule, to
encode the shortening of a full refname into a shorthand name. The
relevant rule and the full refname is passed as arguments, and the
resulting shorthand name is returned as an allocated string. If the
refname could not be shortened according to the given rule, NULL is
returned.

The reason for moving the allocation of the shorthand name into the
shortening function, is that one assumes the shortening function itself
will best know exactly how much memory is needed to hold the shorthand
string.

Naturally, we provide a shortening function that encodes the current
textual shortening algorithm - called ref_shorten_txtly() - which is
merely a slight refactoring of the former shorten_ref() function.

This patch removes the only remaining user of ref_rev_parse_rules.
It has now been fully replaced by ref_expand_rules. Hence this patch
also removes ref_rev_parse_rules.

Signed-off-by: Johan Herland <johan@herland.net>
---
 refs.c | 110 ++++++++++++++++++++++++++++-------------------------------------
 refs.h |   2 ++
 2 files changed, 50 insertions(+), 62 deletions(-)

diff --git a/refs.c b/refs.c
index 8b02140..a866489 100644
--- a/refs.c
+++ b/refs.c
@@ -1731,24 +1731,41 @@ static void ref_expand_txtly(const struct ref_expand_rule *rule,
 	mksnpath(dst, dst_len, rule->pattern, shortname_len, shortname);
 }
 
-const struct ref_expand_rule ref_expand_rules[] = {
-	{ ref_expand_txtly, "%.*s" },
-	{ ref_expand_txtly, "refs/%.*s" },
-	{ ref_expand_txtly, "refs/tags/%.*s" },
-	{ ref_expand_txtly, "refs/heads/%.*s" },
-	{ ref_expand_txtly, "refs/remotes/%.*s" },
-	{ ref_expand_txtly, "refs/remotes/%.*s/HEAD" },
-	{ NULL, NULL }
-};
+static char *ref_shorten_txtly(const struct ref_expand_rule *rule,
+			       const char *refname)
+{
+	/*
+	 * rule->pattern must be of the form "[pre]%.*s[post]". Check if
+	 * refname starts with "[pre]" and ends with "[post]". If so,
+	 * extract the middle part into a newly-allocated buffer, and
+	 * return it. Else - if refname does not match rule->pattern -
+	 * return NULL.
+	 */
+	size_t pre_len, post_start, post_len, match_len;
+	size_t ref_len = strlen(refname);
+	char *sep = strstr(rule->pattern, "%.*s");
+	if (!sep || strstr(sep + 4, "%.*s"))
+		die("invalid pattern in ref_rev_parse_rules_alt: %s", rule->pattern);
+	pre_len = sep - rule->pattern;
+	post_start = pre_len + 4;
+	post_len = strlen(rule->pattern + post_start);
+	if (pre_len + post_len >= ref_len)
+		return NULL; /* refname too short */
+	match_len = ref_len - (pre_len + post_len);
+	if (strncmp(refname, rule->pattern, pre_len) ||
+	    strncmp(refname + ref_len - post_len, rule->pattern + post_start, post_len))
+		return NULL; /* refname does not match */
+	return xstrndup(refname + pre_len, match_len);
+}
 
-static const char *ref_rev_parse_rules[] = {
-	"%.*s",
-	"refs/%.*s",
-	"refs/tags/%.*s",
-	"refs/heads/%.*s",
-	"refs/remotes/%.*s",
-	"refs/remotes/%.*s/HEAD",
-	NULL
+const struct ref_expand_rule ref_expand_rules[] = {
+	{ ref_expand_txtly, NULL, "%.*s" },
+	{ ref_expand_txtly, ref_shorten_txtly, "refs/%.*s" },
+	{ ref_expand_txtly, ref_shorten_txtly, "refs/tags/%.*s" },
+	{ ref_expand_txtly, ref_shorten_txtly, "refs/heads/%.*s" },
+	{ ref_expand_txtly, ref_shorten_txtly, "refs/remotes/%.*s" },
+	{ ref_expand_txtly, ref_shorten_txtly, "refs/remotes/%.*s/HEAD" },
+	{ NULL, NULL, NULL }
 };
 
 int refname_match(const char *abbrev_name, const char *full_name,
@@ -2965,68 +2982,35 @@ struct ref *find_ref_by_name(const struct ref *list, const char *name)
 	return NULL;
 }
 
-int shorten_ref(const char *refname, const char *pattern, char *short_name)
-{
-	/*
-	 * pattern must be of the form "[pre]%.*s[post]". Check if refname
-	 * starts with "[pre]" and ends with "[post]". If so, write the
-	 * middle part into short_name, and return the number of chars
-	 * written (not counting the added NUL-terminator). Otherwise,
-	 * if refname does not match pattern, return 0.
-	 */
-	size_t pre_len, post_start, post_len, match_len;
-	size_t ref_len = strlen(refname);
-	char *sep = strstr(pattern, "%.*s");
-	if (!sep || strstr(sep + 4, "%.*s"))
-		die("invalid pattern in ref_rev_parse_rules: %s", pattern);
-	pre_len = sep - pattern;
-	post_start = pre_len + 4;
-	post_len = strlen(pattern + post_start);
-	if (pre_len + post_len >= ref_len)
-		return 0; /* refname too short */
-	match_len = ref_len - (pre_len + post_len);
-	if (strncmp(refname, pattern, pre_len) ||
-	    strncmp(refname + ref_len - post_len, pattern + post_start, post_len))
-		return 0; /* refname does not match */
-	memcpy(short_name, refname + pre_len, match_len);
-	short_name[match_len] = '\0';
-	return match_len;
-}
-
 char *shorten_unambiguous_ref(const char *refname, int strict)
 {
 	int i;
 	char *short_name;
 
-	/* buffer for scanf result, at most refname must fit */
-	short_name = xstrdup(refname);
-
-	/* skip first rule, it will always match */
-	for (i = ARRAY_SIZE(ref_rev_parse_rules) - 1; i > 0 ; --i) {
+	for (i = ARRAY_SIZE(ref_expand_rules) - 1; i >= 0 ; --i) {
 		int j;
 		int rules_to_fail = i;
 		int short_name_len;
+		const struct ref_expand_rule *p = ref_expand_rules + i;
 
-		if (!ref_rev_parse_rules[i] ||
-		    !(short_name_len = shorten_ref(refname,
-						   ref_rev_parse_rules[i],
-						   short_name)))
+		if (!p->shorten || !(short_name = p->shorten(p, refname)))
 			continue;
+		short_name_len = strlen(short_name);
 
 		/*
 		 * in strict mode, all (except the matched one) rules
 		 * must fail to resolve to a valid non-ambiguous ref
 		 */
 		if (strict)
-			rules_to_fail = ARRAY_SIZE(ref_rev_parse_rules);
+			rules_to_fail = ARRAY_SIZE(ref_expand_rules);
 
 		/*
 		 * check if the short name resolves to a valid ref,
 		 * but use only rules prior to the matched one
 		 */
 		for (j = 0; j < rules_to_fail; j++) {
-			const char *rule = ref_rev_parse_rules[j];
-			char refname[PATH_MAX];
+			const struct ref_expand_rule *q = ref_expand_rules + j;
+			char resolved[PATH_MAX];
 
 			/* skip matched rule */
 			if (i == j)
@@ -3037,10 +3021,12 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 			 * (with this previous rule) to a valid ref
 			 * read_ref() returns 0 on success
 			 */
-			mksnpath(refname, sizeof(refname),
-				 rule, short_name_len, short_name);
-			if (ref_exists(refname))
-				break;
+			if (q->expand) {
+				q->expand(q, resolved, sizeof(resolved),
+					  short_name, short_name_len);
+				if (ref_exists(resolved))
+					break;
+			}
 		}
 
 		/*
@@ -3049,9 +3035,9 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 		 */
 		if (j == rules_to_fail)
 			return short_name;
+		free(short_name);
 	}
 
-	free(short_name);
 	return xstrdup(refname);
 }
 
diff --git a/refs.h b/refs.h
index 85710cb..245af6f 100644
--- a/refs.h
+++ b/refs.h
@@ -169,6 +169,8 @@ struct ref_expand_rule {
 	void (*expand)(const struct ref_expand_rule *rule,
 		       char *dst, size_t dst_len,
 		       const char *shortname, size_t shortname_len);
+	char *(*shorten)(const struct ref_expand_rule *rule,
+			 const char *refname);
 	const char *pattern;
 };
 extern const struct ref_expand_rule ref_expand_rules[];
-- 
1.8.1.3.704.g33f7d4f
