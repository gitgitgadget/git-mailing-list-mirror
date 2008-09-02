From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v2] for-each-ref: `:short` format for `refname`
Date: Tue,  2 Sep 2008 23:57:17 +0200
Message-ID: <1220392637-24978-1-git-send-email-bert.wesarg@googlemail.com>
References: <20080902143912.GB28704@spearce.org>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	szeder@ira.uka.de, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 23:58:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KadtO-0000xv-7Q
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 23:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbYIBV5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 17:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752714AbYIBV5Y
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 17:57:24 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:19700 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbYIBV5X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 17:57:23 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2527875muf.1
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 14:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0BxU7ZHVGhEg1iWZsS+2ZJ2yg9Kc8qiirRvnGibhYHY=;
        b=eQlo9Ar3vVg/0IeHk8DXyGO/vA6RstOa5hJnFYtAXWQYs/z0jPnV2yOyGEXN7taHXg
         mxlLr54DKw3fHWeYPx2Nsr5q4L13iV1OVsW5rIW61XzdTZJNraGUlT9ZT1sqok8CQPIX
         nf3F0xoW9N/P63Ge9ftd8e4Q37cdrvd/t4ujg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pKSPPzBuzol90Fh5vNcEhdnkLFaZ4bO6WvUMKU5i6AJTVoMbAfRI8yswFlR2kYW0lB
         vhsh+K8hazNYtuvcZeHV6kQ5Hv0L+l9ThZCvCEcEwZWPy3r+zSB7JisEOCPU+vGs6DXP
         RCDOa91QFoydsLdiWbQkxUEeEn6hdIJFUHcpc=
Received: by 10.103.22.16 with SMTP id z16mr5757327mui.78.1220392640785;
        Tue, 02 Sep 2008 14:57:20 -0700 (PDT)
Received: from localhost ( [91.15.96.153])
        by mx.google.com with ESMTPS id e10sm12896256muf.14.2008.09.02.14.57.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Sep 2008 14:57:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.0
In-Reply-To: <20080902143912.GB28704@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94723>

Tries to shorten the refname to a non-ambiguous name.
I.e. the full and the short refname points to the same object.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org
Cc: szeder@ira.uka.de
Cc: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-for-each-ref.txt |    2 +
 builtin-for-each-ref.c             |  133 ++++++++++++++++++++++++++++++++++--
 t/t6300-for-each-ref.sh            |   31 ++++++++
 3 files changed, 159 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index eae6c0e..89158d9 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -74,6 +74,8 @@ For all objects, the following names can be used:
 
 refname::
 	The name of the ref (the part after $GIT_DIR/).
+	For a non-ambiguous short name of the ref append `:short`.
+	I.e. both the full and short name will resolve to the same object.
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 21e92bb..6359ad7 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -546,6 +546,105 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, v
 }
 
 /*
+ * generate a format suitable for scanf from a ref_rev_parse_rules
+ * rule, that is replace the "%.*s" spec with a "%s" spec
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
+
+	return;
+}
+
+/*
+ * Shorten the refname to an non-ambiguous form
+ */
+static char *get_short_ref(struct refinfo *ref)
+{
+	int i;
+	static char **scanf_fmts;
+	static int nr_rules;
+	char *short_name;
+	unsigned char fullref_sha1[20];
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
+	/* bail out if there are no rules */
+	if (!nr_rules)
+		return ref->refname;
+
+	read_ref(ref->refname, fullref_sha1);
+
+	/* buffer for scanf result, at most ref->refname must fit */
+	short_name = strdup(ref->refname);
+
+	/* skip first rule, will always match */
+	for (i = 0; i < nr_rules - 1; i++) {
+		const char **p;
+		int short_name_len;
+
+		if (1 != sscanf(ref->refname, scanf_fmts[nr_rules - 1 - i],
+				short_name))
+			continue;
+
+		short_name_len = strlen(short_name);
+
+		/* check if full and short point to the same object
+		 * by checking all rules in forward direction
+		 */
+		for (p = ref_rev_parse_rules; *p; p++) {
+			unsigned char short_sha1[20];
+
+			/* check for valid ref */
+			if (read_ref(mkpath(*p, short_name_len, short_name),
+				     short_sha1))
+				continue;
+
+			/* if the objects differ the short name is ambiguous */
+			if (hashcmp(fullref_sha1, short_sha1))
+				break;
+
+			/* ok, short and full ref point to the same object */
+			return short_name;
+		}
+	}
+
+	free(short_name);
+	return ref->refname;
+}
+
+
+/*
  * Parse the object referred by ref, and grab needed value.
  */
 static void populate_value(struct refinfo *ref)
@@ -570,13 +669,33 @@ static void populate_value(struct refinfo *ref)
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i];
 		struct atom_value *v = &ref->value[i];
-		if (!strcmp(name, "refname"))
-			v->s = ref->refname;
-		else if (!strcmp(name, "*refname")) {
-			int len = strlen(ref->refname);
-			char *s = xmalloc(len + 4);
-			sprintf(s, "%s^{}", ref->refname);
-			v->s = s;
+		int deref = 0;
+		if (*name == '*') {
+			deref = 1;
+			name++;
+		}
+		if (!prefixcmp(name, "refname")) {
+			const char *formatp = strchr(name, ':');
+			const char *refname = ref->refname;
+
+			/* look for "short" refname format */
+			if (formatp) {
+				formatp++;
+				if (!strcmp(formatp, "short"))
+					refname = get_short_ref(ref);
+				else
+					die("unknown refname format %s",
+					    formatp);
+			}
+
+			if (!deref)
+				v->s = refname;
+			else {
+				int len = strlen(refname);
+				char *s = xmalloc(len + 4);
+				sprintf(s, "%s^{}", refname);
+				v->s = s;
+			}
 		}
 	}
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 8ced593..ad8d48e 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -262,6 +262,37 @@ for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --perl"; do
 	"
 done
 
+cat >expected <<\EOF
+master
+testtag
+EOF
+
+test_expect_success 'Check short refname format' '
+	(git for-each-ref --format="%(refname:short)" refs/heads &&
+	git for-each-ref --format="%(refname:short)" refs/tags) >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Check for invalid refname format' '
+	test_must_fail git for-each-ref --format="%(refname:INVALID)"
+'
+
+cat >expected <<\EOF
+heads/master
+master
+EOF
+
+test_expect_success 'Check ambiguous head and tag refs' '
+	git checkout -b newtag &&
+	echo "Using $datestamp" > one &&
+	git add one &&
+	git commit -m "Branch" &&
+	setdate_and_increment &&
+	git tag -m "Tagging at $datestamp" master &&
+	git for-each-ref --format "%(refname:short)" refs/heads/master refs/tags/master >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'an unusual tag with an incomplete line' '
 
 	git tag -m "bogo" bogo &&
-- 
1.6.0
