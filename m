From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v4] for-each-ref: `:short` format for `refname`
Date: Fri,  5 Sep 2008 23:16:23 +0200
Message-ID: <1220649383-17916-1-git-send-email-bert.wesarg@googlemail.com>
References: <7vtzcxaxgr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	szeder@ira.uka.de, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 23:17:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbigS-0000nn-Sm
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 23:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbYIEVQa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Sep 2008 17:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbYIEVQa
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 17:16:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:16031 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbYIEVQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 17:16:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so817916fgg.17
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 14:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=s91iuyNf1HeJwWEc98GYSfR1IGKQxgJ0au8Ze4DmAxs=;
        b=WLcdnzOE9c/6k4KLkId/sP/nyn6qbj4rzrDCb6KUAsQ6pyOdJ5ma89fsi8hjtFK9mR
         7SGzCVr65eaBQBm4W0n01LGu/xeOvvphYJ3ilJbWRkpIakClr/MoxXKeiuXSYPDnZS9u
         crMXje5dEgbfzw+65/luJmQNayrBhg7D8Ag7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=MfJR53c1CnOMM5qy0fZRr5c3EWweoDAmqtmF+bJkG6liBOZQXZlC04uib+6XVTvrLa
         8kOvY3xttJEyPrvoN2T07b/ZMwkMPWb7F8YIri9bwHHAGjBRX9dvPkQWR5fCFqfspqsm
         eaqplG7+0RlXh7cKiAzBVwlF5hG5i/miFIQyY=
Received: by 10.86.90.13 with SMTP id n13mr7576086fgb.3.1220649387299;
        Fri, 05 Sep 2008 14:16:27 -0700 (PDT)
Received: from localhost ( [91.15.73.19])
        by mx.google.com with ESMTPS id e20sm1433118fga.1.2008.09.05.14.16.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Sep 2008 14:16:26 -0700 (PDT)
X-Mailer: git-send-email 1.6.0
In-Reply-To: <7vtzcxaxgr.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95041>

Tries to shorten the refname to a non-ambiguous name.

Szeder G=C3=A1bor noticed that the git bash completion takes a
tremendous amount of time to strip leading components from
heads and tags refs (i.e. refs/heads, refs/tags, ...). He
proposed a new atom called 'refbasename' which removes at
most two leading components from the ref name.

I myself, proposed a more dynamic solution, which strips off
common leading components with the matched pattern.

But the current bash solution and both proposals suffer from
one mayor problem: ambiguous refs.

A ref is ambiguous, if it resolves to more than one full refs.
I.e. given the refs refs/heads/xyzzy and refs/tags/xyzzy. The
(short) ref xyzzy can point to both refs.

( Note: Its irrelevant whether the referenced objects are the
  same or not. )

This proposal solves this by checking for ambiguity of the
shorten ref name.

The shortening is done with the same rules for resolving refs
but in the reverse order. The short name is checked if it
resolves to a different ref.

To continue the above example, the output would be like this:

heads/xyzzy
xyzzy

So, if you want just tags, xyzzy is not ambiguous, because it
will resolve to a tag. If you need the heads you get a also
a non-ambiguous short form of the ref.

To integrate this new format into the bash completion to get
only non-ambiguous refs is beyond the scope of this patch.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
Cc: git@vger.kernel.org
Cc: szeder@ira.uka.de
Cc: Shawn O. Pearce <spearce@spearce.org>

 Documentation/git-for-each-ref.txt |    1 +
 builtin-for-each-ref.c             |  135 ++++++++++++++++++++++++++++=
++++++--
 t/t6300-for-each-ref.sh            |   44 ++++++++++++
 3 files changed, 173 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for=
-each-ref.txt
index eae6c0e..4016f59 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -74,6 +74,7 @@ For all objects, the following names can be used:
=20
 refname::
 	The name of the ref (the part after $GIT_DIR/).
+	For a non-ambiguous short name of the ref append `:short`.
=20
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 21e92bb..9b44092 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -546,6 +546,107 @@ static void grab_values(struct atom_value *val, i=
nt deref, struct object *obj, v
 }
=20
 /*
+ * generate a format suitable for scanf from a ref_rev_parse_rules
+ * rule, that is replace the "%.*s" spec with a "%s" spec
+ */
+static void gen_scanf_fmt(char *scanf_fmt, const char *rule)
+{
+	char *spec;
+
+	spec =3D strstr(rule, "%.*s");
+	if (!spec || strstr(spec + 4, "%.*s"))
+		die("invalid rule in ref_rev_parse_rules: %s", rule);
+
+	/* copy all until spec */
+	strncpy(scanf_fmt, rule, spec - rule);
+	scanf_fmt[spec - rule] =3D '\0';
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
+		size_t total_len =3D 0;
+
+		/* the rule list is NULL terminated, count them first */
+		for (; ref_rev_parse_rules[nr_rules]; nr_rules++)
+			/* no +1 because strlen("%s") < strlen("%.*s") */
+			total_len +=3D strlen(ref_rev_parse_rules[nr_rules]);
+
+		scanf_fmts =3D xmalloc(nr_rules * sizeof(char *) + total_len);
+
+		total_len =3D 0;
+		for (i =3D 0; i < nr_rules; i++) {
+			scanf_fmts[i] =3D (char *)&scanf_fmts[nr_rules]
+					+ total_len;
+			gen_scanf_fmt(scanf_fmts[i], ref_rev_parse_rules[i]);
+			total_len +=3D strlen(ref_rev_parse_rules[i]);
+		}
+	}
+
+	/* bail out if there are no rules */
+	if (!nr_rules)
+		return ref->refname;
+
+	/* buffer for scanf result, at most ref->refname must fit */
+	short_name =3D xstrdup(ref->refname);
+
+	/* skip first rule, it will always match */
+	for (i =3D nr_rules - 1; i > 0 ; --i) {
+		int j;
+		int short_name_len;
+
+		if (1 !=3D sscanf(ref->refname, scanf_fmts[i], short_name))
+			continue;
+
+		short_name_len =3D strlen(short_name);
+
+		/*
+		 * check if the short name resolves to a valid ref,
+		 * but use only rules prior to the matched one
+		 */
+		for (j =3D 0; j < i; j++) {
+			const char *rule =3D ref_rev_parse_rules[j];
+			unsigned char short_objectname[20];
+
+			/*
+			 * the short name is ambiguous, if it resolves
+			 * (with this previous rule) to a valid ref
+			 * read_ref() returns 0 on success
+			 */
+			if (!read_ref(mkpath(rule, short_name_len, short_name),
+				      short_objectname))
+				break;
+		}
+
+		/*
+		 * short name is non-ambiguous if all previous rules
+		 * haven't resolved to a valid ref
+		 */
+		if (j =3D=3D i)
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
@@ -570,13 +671,33 @@ static void populate_value(struct refinfo *ref)
 	for (i =3D 0; i < used_atom_cnt; i++) {
 		const char *name =3D used_atom[i];
 		struct atom_value *v =3D &ref->value[i];
-		if (!strcmp(name, "refname"))
-			v->s =3D ref->refname;
-		else if (!strcmp(name, "*refname")) {
-			int len =3D strlen(ref->refname);
-			char *s =3D xmalloc(len + 4);
-			sprintf(s, "%s^{}", ref->refname);
-			v->s =3D s;
+		int deref =3D 0;
+		if (*name =3D=3D '*') {
+			deref =3D 1;
+			name++;
+		}
+		if (!prefixcmp(name, "refname")) {
+			const char *formatp =3D strchr(name, ':');
+			const char *refname =3D ref->refname;
+
+			/* look for "short" refname format */
+			if (formatp) {
+				formatp++;
+				if (!strcmp(formatp, "short"))
+					refname =3D get_short_ref(ref);
+				else
+					die("unknown refname format %s",
+					    formatp);
+			}
+
+			if (!deref)
+				v->s =3D refname;
+			else {
+				int len =3D strlen(refname);
+				char *s =3D xmalloc(len + 4);
+				sprintf(s, "%s^{}", refname);
+				v->s =3D s;
+			}
 		}
 	}
=20
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 8ced593..4f247dd 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -262,6 +262,50 @@ for i in "--perl --shell" "-s --python" "--python =
--tcl" "--tcl --perl"; do
 	"
 done
=20
+cat >expected <<\EOF
+master
+testtag
+EOF
+
+test_expect_success 'Check short refname format' '
+	(git for-each-ref --format=3D"%(refname:short)" refs/heads &&
+	git for-each-ref --format=3D"%(refname:short)" refs/tags) >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Check for invalid refname format' '
+	test_must_fail git for-each-ref --format=3D"%(refname:INVALID)"
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
+	git for-each-ref --format "%(refname:short)" refs/heads/master refs/t=
ags/master >actual &&
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
+	git for-each-ref --format "%(refname:short)" refs/heads/ambiguous ref=
s/tags/ambiguous >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'an unusual tag with an incomplete line' '
=20
 	git tag -m "bogo" bogo &&
--=20
1.6.0
