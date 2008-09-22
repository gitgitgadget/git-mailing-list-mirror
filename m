From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 2/3] for-each-ref: factor out get_short_ref() into refs.c:abbreviate_refname()
Date: Mon, 22 Sep 2008 11:09:50 +0200
Message-ID: <1222074591-26548-2-git-send-email-bert.wesarg@googlemail.com>
References: <1222074591-26548-1-git-send-email-bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, szeder@ira.uka.de,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 11:11:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhhRm-0008Ll-95
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 11:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbYIVJKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 05:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbYIVJKB
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 05:10:01 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:40802 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbYIVJJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 05:09:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1299170fgg.17
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=G7XnABzfM4ds9/czqhnXtjjyoANs1cUcy2D4JJfpyW8=;
        b=TI4GmbuPnqZyHKCvxJPSUebQx9rkZonSQDwwwclqA3gLxXRl+2TCRsKiiM86mJZ7Ro
         ct7Vrd1pkbOfi5THVmllkUNWxEs97SlaeK+Qyk+N3xfQ1RNb0YQRXYMU7xY3zl3jQNWv
         PEhVGjGbV9AO5++OTs9Rxl/H67t7aTOh9qXwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mSNgwwjpHWca1TDIfeIbPERC7T4cEyICuyMjY3oilpQ3XXlfZqvZEMnWSgluevW9AF
         omq+kdfRme1y2BGwZoblPPbgXxRnLmtPuXox7fdV8ODswJT9bZuOKBngMt12meoa518k
         PFxcdi9zCnsUoDKeztPyPMzrKdScQCcyurL9I=
Received: by 10.86.27.19 with SMTP id a19mr4541708fga.37.1222074598609;
        Mon, 22 Sep 2008 02:09:58 -0700 (PDT)
Received: from localhost (p5B0F5781.dip.t-dialin.net [91.15.87.129])
        by mx.google.com with ESMTPS id l19sm5128758fgb.7.2008.09.22.02.09.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Sep 2008 02:09:57 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <1222074591-26548-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96465>

Moves the function get_short_ref() from builtin-for-each-ref.c into refs.c
as function abbreviate_refname().

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---

Cc: git@vger.kernel.org
Cc: szeder@ira.uka.de
Cc: "Shawn O. Pearce" <spearce@spearce.org>

 builtin-for-each-ref.c |  116 +----------------------------------------------
 cache.h                |    1 +
 refs.c                 |  110 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+), 113 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index e7b7712..06fd6a2 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -546,117 +546,6 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, v
 }
 
 /*
- * generate a format suitable for scanf from a ref_rev_parse_rules
- * rule, that is replace the "%.*s" spec with a "%s" spec
- */
-static void gen_scanf_fmt(char *scanf_fmt, const char *rule)
-{
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
-}
-
-/*
- * Shorten the refname to an non-ambiguous form
- */
-static void get_short_ref(struct refinfo *ref, int strict, char **short_ref)
-{
-	int i;
-	static char **scanf_fmts;
-	static int nr_rules;
-	char *short_name;
-
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
-	/* buffer for scanf result, at most ref->refname must fit */
-	short_name = xstrdup(ref->refname);
-	*short_ref = short_name;
-
-	/* bail out if there are no rules */
-	if (!nr_rules)
-		return;
-
-	for (i = nr_rules - 1; i >= 0 ; --i) {
-		int j, rules_to_fail = i;
-		int short_name_len;
-
-		if (1 != sscanf(ref->refname, scanf_fmts[i], short_name))
-			continue;
-
-		short_name_len = strlen(short_name);
-
-		/*
-		 * in strict mode, all (except the matched one) rules
-		 * must fail to resolve to a valid ref
-		 */
-		if (strict)
-			rules_to_fail = nr_rules;
-		/*
-		 * check if the short name resolves to a valid ref,
-		 * but use only rules prior to the matched one
-		 */
-		for (j = 0; j < rules_to_fail; j++) {
-			const char *rule = ref_rev_parse_rules[j];
-			unsigned char short_objectname[20];
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
-			if (!read_ref(mkpath(rule, short_name_len, short_name),
-				      short_objectname))
-				break;
-		}
-
-		/*
-		 * short name is non-ambiguous if all previous rules
-		 * doesn't resolved to a valid ref
-		 */
-		if (j == rules_to_fail)
-			return;
-	}
-
-	/* can't abbreviate refname, return full name */
-	strcpy(short_name, ref->refname);
-}
-
-
-/*
  * Parse the object referred by ref, and grab needed value.
  */
 static void populate_value(struct refinfo *ref)
@@ -694,8 +583,9 @@ static void populate_value(struct refinfo *ref)
 			if (formatp) {
 				formatp++;
 				if (!strcmp(formatp, "short"))
-					get_short_ref(ref, warn_ambiguous_refs,
-						      &refname);
+					abbreviate_refname(ref->refname,
+							   warn_ambiguous_refs,
+							   &refname);
 				else
 					die("unknown refname format %s",
 					    formatp);
diff --git a/cache.h b/cache.h
index de8c2b6..8a128a5 100644
--- a/cache.h
+++ b/cache.h
@@ -582,6 +582,7 @@ extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
 extern int refname_match(const char *abbrev_name, const char *full_name, const char **rules);
 extern const char *ref_rev_parse_rules[];
 extern const char *ref_fetch_rules[];
+extern void abbreviate_refname(const char *refname, int strict, char **abbrev_name);
 
 extern int create_symref(const char *ref, const char *refs_heads_master, const char *logmsg);
 extern int validate_headref(const char *ref);
diff --git a/refs.c b/refs.c
index b680750..f370081 100644
--- a/refs.c
+++ b/refs.c
@@ -730,6 +730,116 @@ int refname_match(const char *abbrev_name, const char *full_name, const char **r
 	return 0;
 }
 
+/*
+ * generate a format suitable for scanf from a ref_rev_parse_rules rule
+ * that is replace the "%.*s" spec with a "%s" spec
+ */
+static void gen_scanf_fmt(char *scanf_fmt, const char *rule)
+{
+	char *spec;
+
+	spec = strstr(rule, "%.*s");
+	if (!spec || strstr(spec + 4, "%.*s"))
+		die("invalid rule in ref_rev_parse_rules: %s", rule);
+
+	/* copy all until spec */
+	strncpy(scanf_fmt, rule, spec - rule);
+	scanf_fmt[spec - rule] = '\0';
+	/* copy new spec */
+	strcat(scanf_fmt, "%s");
+	/* copy remaining rule */
+	strcat(scanf_fmt, spec + 4);
+}
+
+/*
+ * Abbreviate refname to an non-ambiguous form, undefined if refname is not
+ * a fully quallified refname
+ */
+void abbreviate_refname(const char *refname, int strict, char **abbrev_name)
+{
+	int i;
+	static char **scanf_fmts;
+	static int nr_rules;
+	char *abbrev;
+
+	/* pre generate scanf formats from ref_rev_parse_rules[] */
+	if (!nr_rules) {
+		size_t total_len = 0;
+
+		/* the rule list is NULL terminated, count them first */
+		for (; ref_rev_parse_rules[nr_rules]; nr_rules++)
+			/* no +1 because strlen("%s") < strlen("%.*s") */
+			total_len += strlen(ref_rev_parse_rules[nr_rules]);
+
+		scanf_fmts = xmalloc(nr_rules * sizeof(char *) + total_len);
+
+		total_len = 0;
+		for (i = 0; i < nr_rules; i++) {
+			scanf_fmts[i] = (char *)&scanf_fmts[nr_rules]
+					+ total_len;
+			gen_scanf_fmt(scanf_fmts[i], ref_rev_parse_rules[i]);
+			total_len += strlen(ref_rev_parse_rules[i]);
+		}
+	}
+
+	/* buffer for scanf result, at most refname must fit */
+	abbrev = xstrdup(refname);
+	*abbrev_name = abbrev;
+
+	/* bail out if there are no rules */
+	if (!nr_rules)
+		return;
+
+	for (i = nr_rules - 1; i >= 0 ; --i) {
+		int j, rules_to_fail = i;
+		int abbrev_len;
+
+		if (1 != sscanf(refname, scanf_fmts[i], abbrev))
+			continue;
+
+		abbrev_len = strlen(abbrev);
+
+		/*
+		 * in strict mode, all (except the matched one) rules
+		 * must fail to resolve to a valid ref
+		 */
+		if (strict)
+			rules_to_fail = nr_rules;
+
+		/*
+		 * check if the short name resolves to a valid ref,
+		 */
+		for (j = 0; j < rules_to_fail; j++) {
+			const char *rule = ref_rev_parse_rules[j];
+			unsigned char abbrev_objectname[20];
+
+			/* skip matched rule */
+			if (i == j)
+				continue;
+
+			/*
+			 * the abbreviated name is ambiguous,
+			 * if it resolves to a valid ref
+			 *
+			 * read_ref() returns 0 on success
+			 */
+			if (!read_ref(mkpath(rule, abbrev_len, abbrev),
+				      abbrev_objectname))
+				break;
+		}
+
+		/*
+		 * abbrev is non-ambiguous if all rules
+		 * doesn't resolved to a valid ref
+		 */
+		if (j == rules_to_fail)
+			return;
+	}
+
+	/* can't abbreviate refname, return full name */
+	strcpy(abbrev, refname);
+}
+
 static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
 {
-- 
1.6.0.1
