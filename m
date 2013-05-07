From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 3/3] shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD to origin
Date: Tue,  7 May 2013 20:54:16 +0200
Message-ID: <1367952856-30729-3-git-send-email-johan@herland.net>
References: <CALKQrgcoz-+5Kb-Y1Ui9LhE=+pvcRUdAS+iRWXAfsYnV6+k34w@mail.gmail.com>
 <1367952856-30729-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, bert.wesarg@googlemail.com,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue May 07 20:54:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZn2A-0001I9-VP
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 20:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759668Ab3EGSy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 14:54:29 -0400
Received: from mail-ea0-f169.google.com ([209.85.215.169]:38501 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755483Ab3EGSy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 14:54:26 -0400
Received: by mail-ea0-f169.google.com with SMTP id n15so510302ead.28
        for <git@vger.kernel.org>; Tue, 07 May 2013 11:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=5OSq2+30CNKEdcaaDxpNyAR1U9t0OjlS/gcXz8sAIwQ=;
        b=DUJvKwRGz83Qv4KhD0S0/47c5eiqz5i9oJcTCcc8YtahnL0zoStYyXUn5YCZ9+05Rl
         HJWteow3jWb3piHgtjYIDorQfVL5NGD1cNrkYIA8Fl0HFcAqEBbiac5tDoWgrI5J6I+k
         oL8xaxrM1q9183K0iYFPiIvRVLVD3a9Un6ngCPfKZQOhaSdT60/7wRTJfqRVEIq0rGNH
         oxjNVEMTu6rp6IxyF2OIlodsZelO8iiJrIPP5jOt+anY2cazcIRwYpTeyeG4CsnsjN5u
         k/dh9N/J+sxK12/wuYtadw91xu28O88x7Ehwsi+wVzcDY1hSc3qGPLFaoL1k+7ZzYWlK
         VWKg==
X-Received: by 10.15.82.201 with SMTP id a49mr8059579eez.44.1367952864488;
        Tue, 07 May 2013 11:54:24 -0700 (PDT)
Received: from localhost.localdomain (p57A0A708.dip0.t-ipconnect.de. [87.160.167.8])
        by mx.google.com with ESMTPSA id l6sm41084484eem.9.2013.05.07.11.54.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 07 May 2013 11:54:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1367952856-30729-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223596>

When expanding shorthand refs to full ref names (e.g. in dwim_ref()),
we use the ref_rev_parse_rules list of expansion patterns. This list
allows "origin" to be expanded into "refs/remotes/origin/HEAD", by
using the "refs/remotes/%.*s/HEAD" pattern from that list.

shorten_unambiguous_ref() exists to provide the reverse operation:
turning a full ref name into a shorter (but still unambiguous) name.
It does so by matching the given refname against each pattern from
the ref_rev_parse_rules list (in reverse), and extracting the short-
hand name from the matching rule.

However, when given "refs/remotes/origin/HEAD" it fails to shorten it
into "origin", because we misuse the sscanf() function when matching
"refs/remotes/origin/HEAD" against "refs/remotes/%.*s/HEAD": We end
up calling sscanf like this:

  sscanf("refs/remotes/origin/HEAD", "refs/remotes/%s/HEAD", short_name)

In this case, sscanf() will match the initial "refs/remotes/" part, and
then match the remainder of the refname against the "%s", and place it
("origin/HEAD") into short_name. The part of the pattern following the
"%s" format is never verified, because sscanf() apparently does not
need to do that (it has performed the one expected format extraction,
and will return 1 correspondingly; see [1] for more details).

This patch replaces the misuse of sscanf() with a fairly simple function
that manually matches the refname against patterns, and extracts the
shorthand name.

[1]: If we assume that sscanf() does not do a verification pass prior
to format extraction, there is AFAICS _no_ way for sscanf() - having
already done one or more format extractions - to indicate to its caller
that the input fails to match the trailing part of the format string.
In other words, AFAICS, the scanf() family of function will only verify
matching input up to and including the last format specifier in the
format string. Any data following the last format specifier will not be
verified. Yet another reason to consider the scanf functions harmful...

Cc: Bert Wesarg <bert.wesarg@googlemail.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 refs.c                                       | 77 ++++++++++------------------
 t/t1514-rev-parse-shorten_unambiguous_ref.sh |  4 +-
 t/t6300-for-each-ref.sh                      |  2 +-
 3 files changed, 29 insertions(+), 54 deletions(-)

diff --git a/refs.c b/refs.c
index d17931a..a0ba2fd 100644
--- a/refs.c
+++ b/refs.c
@@ -2945,80 +2945,55 @@ struct ref *find_ref_by_name(const struct ref *list, const char *name)
 	return NULL;
 }
 
-/*
- * generate a format suitable for scanf from a ref_rev_parse_rules
- * rule, that is replace the "%.*s" spec with a "%s" spec
- */
-static void gen_scanf_fmt(char *scanf_fmt, const char *rule)
+static int shorten_ref(const char *refname, const char *pattern, char *short_name)
 {
-	char *spec;
-
-	spec = strstr(rule, "%.*s");
-	if (!spec || strstr(spec + 4, "%.*s"))
-		die("invalid rule in ref_rev_parse_rules: %s", rule);
-
-	/* copy all until spec */
-	strncpy(scanf_fmt, rule, spec - rule);
-	scanf_fmt[spec - rule] = '\0';
-	/* copy new spec */
-	strcat(scanf_fmt, "%s");
-	/* copy remaining rule */
-	strcat(scanf_fmt, spec + 4);
-
-	return;
+	/*
+	 * pattern must be of the form "[pre]%.*s[post]". If refname
+	 * starts with "[pre]" and ends with "[post]", extract the middle
+	 * part into short_name, and return the number of chars in the
+	 * middle part (not counting the added NUL-terminator). Otherwise,
+	 * if refname does not match pattern, return 0.
+	 */
+	int match_len;
+	const char *match_start, *sep = strstr(pattern, "%.*s");
+	if (!sep || strstr(sep + 4, "%.*s"))
+		die("invalid pattern in ref_rev_parse_rules: %s", pattern);
+	match_start = refname + (sep - pattern);
+	match_len = strlen(refname) - (strlen(pattern) - 4);
+	if (match_len <= 0 ||
+	    strncmp(refname, pattern, match_start - refname) ||
+	    strcmp(match_start + match_len, sep + 4))
+		return 0; /* refname does not match */
+	memcpy(short_name, match_start, match_len);
+	short_name[match_len] = '\0';
+	return match_len;
 }
 
 char *shorten_unambiguous_ref(const char *refname, int strict)
 {
 	int i;
-	static char **scanf_fmts;
-	static int nr_rules;
 	char *short_name;
 
-	/* pre generate scanf formats from ref_rev_parse_rules[] */
-	if (!nr_rules) {
-		size_t total_len = 0;
-
-		/* the rule list is NULL terminated, count them first */
-		for (; ref_rev_parse_rules[nr_rules]; nr_rules++)
-			/* no +1 because strlen("%s") < strlen("%.*s") */
-			total_len += strlen(ref_rev_parse_rules[nr_rules]);
-
-		scanf_fmts = xmalloc(nr_rules * sizeof(char *) + total_len);
-
-		total_len = 0;
-		for (i = 0; i < nr_rules; i++) {
-			scanf_fmts[i] = (char *)&scanf_fmts[nr_rules]
-					+ total_len;
-			gen_scanf_fmt(scanf_fmts[i], ref_rev_parse_rules[i]);
-			total_len += strlen(ref_rev_parse_rules[i]);
-		}
-	}
-
-	/* bail out if there are no rules */
-	if (!nr_rules)
-		return xstrdup(refname);
-
 	/* buffer for scanf result, at most refname must fit */
 	short_name = xstrdup(refname);
 
 	/* skip first rule, it will always match */
-	for (i = nr_rules - 1; i > 0 ; --i) {
+	for (i = ARRAY_SIZE(ref_rev_parse_rules) - 2; i > 0 ; --i) {
 		int j;
 		int rules_to_fail = i;
 		int short_name_len;
 
-		if (1 != sscanf(refname, scanf_fmts[i], short_name))
+		if (!(short_name_len = shorten_ref(refname,
+						   ref_rev_parse_rules[i],
+						   short_name)))
 			continue;
 
-		short_name_len = strlen(short_name);
-
 		/*
 		 * in strict mode, all (except the matched one) rules
 		 * must fail to resolve to a valid non-ambiguous ref
 		 */
 		if (strict)
-			rules_to_fail = nr_rules;
+			rules_to_fail = ARRAY_SIZE(ref_rev_parse_rules) - 1;
 
 		/*
 		 * check if the short name resolves to a valid ref,
diff --git a/t/t1514-rev-parse-shorten_unambiguous_ref.sh b/t/t1514-rev-parse-shorten_unambiguous_ref.sh
index ad75436..fd87ce3 100755
--- a/t/t1514-rev-parse-shorten_unambiguous_ref.sh
+++ b/t/t1514-rev-parse-shorten_unambiguous_ref.sh
@@ -58,7 +58,7 @@ test_shortname () {
 	test_cmp expect.sha1 actual.sha1
 }
 
-test_expect_failure 'shortening refnames in strict mode' '
+test_expect_success 'shortening refnames in strict mode' '
 	test_shortname refs/heads/master strict heads/master master_f &&
 	test_shortname refs/heads/origin/master strict heads/origin/master master_b &&
 	test_shortname refs/master strict refs/master master_d &&
@@ -67,7 +67,7 @@ test_expect_failure 'shortening refnames in strict mode' '
 	test_shortname refs/tags/master strict tags/master master_c
 '
 
-test_expect_failure 'shortening refnames in loose mode' '
+test_expect_success 'shortening refnames in loose mode' '
 	test_shortname refs/heads/master loose heads/master master_f &&
 	test_shortname refs/heads/origin/master loose origin/master master_b &&
 	test_shortname refs/master loose master master_d &&
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 5d716c8..57e3109 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -472,7 +472,7 @@ origin
 origin/master
 EOF
 
-test_expect_failure 'Check refs/remotes/origin/HEAD shortens to origin' '
+test_expect_success 'Check refs/remotes/origin/HEAD shortens to origin' '
 	git remote set-head origin master &&
 	git for-each-ref --format="%(refname:short)" refs/remotes >actual &&
 	test_cmp expected actual
-- 
1.8.1.3.704.g33f7d4f
