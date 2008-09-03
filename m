From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v3] for-each-ref: `:short` format for `refname`
Date: Wed,  3 Sep 2008 10:42:32 +0200
Message-ID: <1220431352-30605-1-git-send-email-bert.wesarg@googlemail.com>
References: <36ca99e90809030133r43fc5a3agad1aa38339a758a3@mail.gmail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	szeder@ira.uka.de, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 10:44:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kanxy-0002u6-81
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 10:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbYICIms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 04:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbYICIms
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 04:42:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:11469 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbYICImr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 04:42:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so88974fgg.17
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 01:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=y6ItwAs8hohIzpLwdvVYFGwCrqHCVtFbfQTmqxxqtxs=;
        b=Da/rMELRsHL4m4kshyZ2V7AyHw+rG2j8BavF6ilJ6jm6siSwyF7mZl204cCSgziU+9
         a/rMqPMWtKE7MonBySOMd0L9PVdz/LW+W0eAW7o4TQCHXpYzpXql7hZdCPxPuvvaXDOG
         WAC68AbmGoHqeg1bO/5BVnoC/WbjI/lWlufww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ngbmkr1qM9IbVq+Bg6q1/AbaiMZwHD8T8ZLUN/sg8RsFe2nBjH276rSV4pQnERoHTD
         p8D7kXuLXmu4PKqroVA4j51Q5bxl2c8wID9WqAYgc+7bfTcGXtH8WCnt7yWuyfQQy/U9
         1+KWF6tj3beXPIzWcpWZGc1fgQuFEUqGl3C4A=
Received: by 10.103.248.17 with SMTP id a17mr6141766mus.63.1220431365246;
        Wed, 03 Sep 2008 01:42:45 -0700 (PDT)
Received: from localhost ( [91.15.100.72])
        by mx.google.com with ESMTPS id j9sm43288503mue.3.2008.09.03.01.42.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Sep 2008 01:42:44 -0700 (PDT)
X-Mailer: git-send-email 1.6.0
In-Reply-To: <36ca99e90809030133r43fc5a3agad1aa38339a758a3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94764>

Try to shorten the refname to a non-ambiguous name.

Changes in v3:
 * don't compare sha1's, its ambiguous if the short name
   resovles to more than one ref
 * use xstrdup()
 * use indexes for the loops to clarify backward/forward
   direction


Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org
Cc: szeder@ira.uka.de
Cc: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-for-each-ref.txt |    1 +
 builtin-for-each-ref.c             |  138 ++++++++++++++++++++++++++++++++++--
 t/t6300-for-each-ref.sh            |   44 +++++++++++
 3 files changed, 176 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index eae6c0e..4016f59 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -74,6 +74,7 @@ For all objects, the following names can be used:
 
 refname::
 	The name of the ref (the part after $GIT_DIR/).
+	For a non-ambiguous short name of the ref append `:short`.
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 21e92bb..abe0804 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -546,6 +546,110 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, v
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
+	/* buffer for scanf result, at most ref->refname must fit */
+	short_name = xstrdup(ref->refname);
+
+	/* skip first rule, it will always match */
+	for (i = nr_rules - 1; i > 0 ; --i) {
+		int j;
+		int short_name_len;
+
+		if (1 != sscanf(ref->refname, scanf_fmts[i], short_name))
+			continue;
+
+		short_name_len = strlen(short_name);
+
+		/*
+		 * check if the short name resolves to a valid ref,
+		 * but use only rules prior to the matched one
+		 */
+		for (j = 0; j < i; j++) {
+			const char *p = ref_rev_parse_rules[j];
+			unsigned char short_objectname[20];
+
+			/* check for valid ref */
+			if (read_ref(mkpath(p, short_name_len, short_name),
+				     short_objectname))
+				continue;
+
+			/*
+			 * short_name resolves to a valid ref,
+			 * but its a differnet path than that of ref->refname,
+			 * therefore the short name is ambiguous
+			 */
+			break;
+		}
+
+		/*
+		 * short name is non-ambiguous if all previous rules
+		 * don't resolve to a valid ref
+		 */
+		if (j == i)
+			return short_name;
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
@@ -570,13 +674,33 @@ static void populate_value(struct refinfo *ref)
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
index 8ced593..4f247dd 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -262,6 +262,50 @@ for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --perl"; do
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
+cat >expected <<\EOF
+heads/ambiguous
+ambiguous
+EOF
+
+test_expect_success 'Check ambiguous head and tag refs II' '
+	git checkout master &&
+	git tag ambiguous testtag^0 &&
+	git branch ambiguous testtag^0 &&
+	git for-each-ref --format "%(refname:short)" refs/heads/ambiguous refs/tags/ambiguous >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'an unusual tag with an incomplete line' '
 
 	git tag -m "bogo" bogo &&
-- 
1.6.0
