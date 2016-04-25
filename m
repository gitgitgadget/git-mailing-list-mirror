From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5b 11/17] ref-filter: introduce symref_atom_parser() and refname_atom_parser()
Date: Mon, 25 Apr 2016 20:47:52 +0530
Message-ID: <1461597478-31855-11-git-send-email-Karthik.188@gmail.com>
References: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 17:18:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auiHc-0005sS-8g
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 17:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbcDYPSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 11:18:40 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35604 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932606AbcDYPSf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 11:18:35 -0400
Received: by mail-pf0-f174.google.com with SMTP id n1so69623593pfn.2
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IaDEyWbJCrMbaEUd5WVnqKpzZj+m/CQ5dimkOECPZbw=;
        b=dA9UhCmni/Qf9GcQUBJD0nNv6qSDaLo+gnhKlwUeqF3xsls4kxIUvJQbxap+rY4mTG
         +e+XdLbir9Ea6EmrGLyKq7Xcs/XvmICPKShUhJxwkpX3JG2jZeNjrCJdfkX22AXGmQUI
         18GnI/VBmIJ52RqQHSl2yiwoUXMIUn/rKWr06vOmJ6skS4gyMOaqSZSxnhl2Nqnw1ChO
         fFMR6jukR/9elIKgVhWe3QFJ7l31p0hEau5hTfgASzzVevrex5QCJifg04XTr/MHkGgF
         smOwcCHCZfjCC2NFOKUvN/olCDxBautGY8i/dxfN1ZWsdYkwMArduomKgj9TI2MS8CFe
         6sBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IaDEyWbJCrMbaEUd5WVnqKpzZj+m/CQ5dimkOECPZbw=;
        b=AJeFirPkOBY3lx33QlnWWKKaqmu9DlhiiI1v7Mev8AsYfrXolp3gO4xQunDIgKyP6n
         3CSMArQeNqxdV4xOno3DG2+8UxhTlXsfNIHboDEYFO5E8FtC2pMDYynIo37EsWOmMIQY
         CNqhyvhxHK7Y2k3NP+ExPQmNKsLzQ1iAx03OIU1YJNp+o5CJnvvp7QUcIAcKYjwmwBwN
         S1MnJ5vC2iL6LELcMzbyaQxuJuMihLuRZ1D1XFOTxvBI6iEn2raYG41WrUS0WWBMWh++
         fBIq38Lq/qOBoIPcaUzKapDVODtkCD6LqEcfcyrrgLdk08BxVq+kK7zfMp1Cs9wzwnTt
         KhQA==
X-Gm-Message-State: AOPr4FX7K4byrBjPLcXse83TSvJkmbbmwoEmNamN5uYzxQCf8B0WVyTGmWKA1ImaO6a64Q==
X-Received: by 10.98.27.129 with SMTP id b123mr46795391pfb.111.1461597514222;
        Mon, 25 Apr 2016 08:18:34 -0700 (PDT)
Received: from ashley.localdomain ([106.51.234.108])
        by smtp.gmail.com with ESMTPSA id ut1sm30812527pac.46.2016.04.25.08.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 08:18:33 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292497>

Using refname_atom_parser_internal(), introduce symref_atom_parser() and
refname_atom_parser() which will parse the atoms %(symref) and
%(refname) respectively. Store the parsed information into the
'used_atom' structure based on the modifiers used along with the atoms.

Now the '%(symref)' atom supports the ':strip' atom modifier. Update the
Documentation and tests to reflect this.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  5 +++
 ref-filter.c                       | 78 ++++++++++++++++++++++----------------
 t/t6300-for-each-ref.sh            |  9 +++++
 3 files changed, 59 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 5c85f27..e0c0a12 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -163,6 +163,11 @@ if::
 	the value between the %(if:...) and %(then) atoms with the
 	given string.
 
+symref::
+	The ref which the given symbolic ref refers to. If not a
+	symbolic ref, nothing is printed. Respects the `:short` and
+	`:strip` options in the same way as `refname` above.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index 778fe02..933f8ca 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -176,6 +176,16 @@ static void objectname_atom_parser(struct used_atom *atom, const char *arg)
 		die(_("unrecognized %%(objectname) argument: %s"), arg);
 }
 
+static void symref_atom_parser(struct used_atom *atom, const char *arg)
+{
+	return refname_atom_parser_internal(&atom->u.refname, arg, atom->name);
+}
+
+static void refname_atom_parser(struct used_atom *atom, const char *arg)
+{
+	return refname_atom_parser_internal(&atom->u.refname, arg, atom->name);
+}
+
 static align_type parse_align_position(const char *s)
 {
 	if (!strcmp(s, "right"))
@@ -244,7 +254,7 @@ static struct {
 	cmp_type cmp_type;
 	void (*parser)(struct used_atom *atom, const char *arg);
 } valid_atom[] = {
-	{ "refname" },
+	{ "refname" , FIELD_STR, refname_atom_parser },
 	{ "objecttype" },
 	{ "objectsize", FIELD_ULONG },
 	{ "objectname", FIELD_STR, objectname_atom_parser },
@@ -273,7 +283,7 @@ static struct {
 	{ "contents", FIELD_STR, contents_atom_parser },
 	{ "upstream", FIELD_STR, remote_ref_atom_parser },
 	{ "push", FIELD_STR, remote_ref_atom_parser },
-	{ "symref" },
+	{ "symref", FIELD_STR, symref_atom_parser },
 	{ "flag" },
 	{ "HEAD" },
 	{ "color", FIELD_STR, color_atom_parser },
@@ -1058,21 +1068,16 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
-static const char *strip_ref_components(const char *refname, const char *nr_arg)
+static const char *strip_ref_components(const char *refname, unsigned int len)
 {
-	char *end;
-	long nr = strtol(nr_arg, &end, 10);
-	long remaining = nr;
+	long remaining = len;
 	const char *start = refname;
 
-	if (nr < 1 || *end != '\0')
-		die(_(":strip= requires a positive integer argument"));
-
 	while (remaining) {
 		switch (*start++) {
 		case '\0':
-			die(_("ref '%s' does not have %ld components to :strip"),
-			    refname, nr);
+			die(_("ref '%s' does not have %ud components to :strip"),
+			    refname, len);
 		case '/':
 			remaining--;
 			break;
@@ -1081,6 +1086,16 @@ static const char *strip_ref_components(const char *refname, const char *nr_arg)
 	return start;
 }
 
+static const char *show_ref(struct refname_atom *atom, const char *refname)
+{
+	if (atom->option == R_SHORT)
+		return shorten_unambiguous_ref(refname, warn_ambiguous_refs);
+	else if (atom->option == R_STRIP)
+		return strip_ref_components(refname, atom->strip);
+	else
+		return refname;
+}
+
 static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 				    struct branch *branch, const char **s)
 {
@@ -1153,6 +1168,21 @@ char *get_head_description(void)
 	return strbuf_detach(&desc, NULL);
 }
 
+static const char *get_symref(struct used_atom *atom, struct ref_array_item *ref)
+{
+	if (!ref->symref)
+		return "";
+	else
+		return show_ref(&atom->u.refname, ref->symref);
+}
+
+static const char *get_refname(struct used_atom *atom, struct ref_array_item *ref)
+{
+	if (ref->kind & FILTER_REFS_DETACHED_HEAD)
+		return get_head_description();
+	return show_ref(&atom->u.refname, ref->refname);
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -1181,7 +1211,6 @@ static void populate_value(struct ref_array_item *ref)
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
 		const char *refname;
-		const char *formatp;
 		struct branch *branch = NULL;
 
 		v->handler = append_atom;
@@ -1192,12 +1221,10 @@ static void populate_value(struct ref_array_item *ref)
 			name++;
 		}
 
-		if (starts_with(name, "refname")) {
-			refname = ref->refname;
-			if (ref->kind & FILTER_REFS_DETACHED_HEAD)
-				refname = get_head_description();
-		} else if (starts_with(name, "symref"))
-			refname = ref->symref ? ref->symref : "";
+		if (starts_with(name, "refname"))
+			refname = get_refname(atom, ref);
+		else if (starts_with(name, "symref"))
+			refname = get_symref(atom, ref);
 		else if (starts_with(name, "upstream")) {
 			const char *branch_name;
 			/* only local branches may have an upstream */
@@ -1273,21 +1300,6 @@ static void populate_value(struct ref_array_item *ref)
 		} else
 			continue;
 
-		formatp = strchr(name, ':');
-		if (formatp) {
-			const char *arg;
-
-			formatp++;
-			if (!strcmp(formatp, "short"))
-				refname = shorten_unambiguous_ref(refname,
-						      warn_ambiguous_refs);
-			else if (skip_prefix(formatp, "strip=", &arg))
-				refname = strip_ref_components(refname, arg);
-			else
-				die(_("unknown %.*s format %s"),
-				    (int)(formatp - name), name, formatp);
-		}
-
 		if (!deref)
 			v->s = refname;
 		else
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index b06ea1c..3d28234 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -589,4 +589,13 @@ test_expect_success 'Verify usage of %(symref:short) atom' '
 	test_cmp expected actual
 '
 
+cat >expected <<EOF
+master
+EOF
+
+test_expect_success 'Verify usage of %(symref:strip) atom' '
+	git for-each-ref --format="%(symref:strip=2)" refs/heads/sym > actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.8.0
