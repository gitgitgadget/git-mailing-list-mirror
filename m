From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] for-each-ref: `:short` format for `refname`
Date: Sun, 31 Aug 2008 14:41:07 +0200
Message-ID: <1220186467-24623-1-git-send-email-bert.wesarg@googlemail.com>
References: <7vprnpbqmo.fsf@gitster.siamese.dyndns.org>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	szeder@ira.uka.de, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 14:42:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZmGE-0000tb-Nk
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 14:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758380AbYHaMlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 08:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758124AbYHaMlV
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 08:41:21 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:15638 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757895AbYHaMlU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 08:41:20 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1532711muf.1
        for <git@vger.kernel.org>; Sun, 31 Aug 2008 05:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/VgxnZrSMXCK4OruxTPBporFwCrG7BFnrvQaUU7/IzY=;
        b=Nlx0gPhkAWw+eLNsGWYIUyszLXzsyjCNFvH/MWQR/RlFNJqQyrAaJdeI0Aw/RHL4eV
         V/GnRJWBPV7IJhAQLB/4rSpD/Nd2FoC0H7mzWKfZRbUdYfrBX2S6hs+9jLXrYl2Qqm+B
         5MK0Xsh3S8RrHxKtJX95Lb3O2BeisUOsHZQ/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NSSzn5WT/LJwLx+cHB7qMiJYkKFAcYXXzCKaQ9J+SVwo0Mqi43JgUrfQeIpIOc9bo6
         NWhikSUMEISI9xBSP0nA8zDDalN26srTIciKF4IxowmR5t/PMGUboIaRIIt3IPrXTj0C
         tjfOSARFOjeSQu5Kv/bwdU5rYpLmYEOshYQWk=
Received: by 10.103.238.4 with SMTP id p4mr3467673mur.66.1220186476758;
        Sun, 31 Aug 2008 05:41:16 -0700 (PDT)
Received: from localhost ( [91.15.60.177])
        by mx.google.com with ESMTPS id j9sm23814917mue.3.2008.08.31.05.41.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Aug 2008 05:41:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.0
In-Reply-To: <7vprnpbqmo.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94478>

This strips from the refname the common directory prefix with the
matched pattern.

This is particular usefull for bash completion, to get refs without
`refs/heads` or `refs/tags`.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 Documentation/git-for-each-ref.txt |    5 ++
 builtin-for-each-ref.c             |   74 +++++++++++++++++++++++++++++++----
 t/t6300-for-each-ref.sh            |   61 +++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index eae6c0e..deeae79 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -74,6 +74,11 @@ For all objects, the following names can be used:
 
 refname::
 	The name of the ref (the part after $GIT_DIR/).
+	For a short name of the ref append `:short`. This will strip
+	the common directory prefix with the pattern which matches this ref.
+	I.e. for a the pattern `refs/heads` you get `master`, or for
+	`refs/tags/v1.5.[01].*` you get `v1.5.[01].*`.
+	This is particular usefull for bash completion.
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 21e92bb..946f79b 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -31,6 +31,7 @@ struct ref_sort {
 
 struct refinfo {
 	char *refname;
+	const char *pattern; /* the pattern which matched this ref */
 	unsigned char objectname[20];
 	struct atom_value *value;
 };
@@ -546,6 +547,40 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, v
 }
 
 /*
+ * Use the matched pattern from ref to shorten the refname
+ */
+static char *get_short_ref(struct refinfo *ref)
+{
+	int rlen, plen, common = 0;
+
+	if (!ref->pattern)
+		return ref->refname;
+
+	rlen = strlen(ref->refname);
+	plen = strlen(ref->pattern);
+
+	if ((plen <= rlen) &&
+	    !strncmp(ref->refname, ref->pattern, plen) &&
+	    (ref->refname[plen] == '\0' ||
+	     ref->refname[plen] == '/' ||
+	     ref->pattern[plen - 1] == '/')) {
+		common = plen + (ref->refname[plen] == '/');
+		/* prevent stripping the whole refname */
+		if (common == rlen)
+			common = 0;
+	} else {
+		/* find the first wildcard and go back to the previous '/' */
+		common = strcspn(ref->pattern, "*?[");
+		while (common >= 0 && ref->pattern[common] != '/')
+			--common;
+		common++;
+	}
+
+	return ref->refname + common;
+}
+
+
+/*
  * Parse the object referred by ref, and grab needed value.
  */
 static void populate_value(struct refinfo *ref)
@@ -570,13 +605,33 @@ static void populate_value(struct refinfo *ref)
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
 
@@ -641,9 +696,9 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	struct grab_ref_cbdata *cb = cb_data;
 	struct refinfo *ref;
 	int cnt;
+	const char **pattern = cb->grab_pattern;
 
-	if (*cb->grab_pattern) {
-		const char **pattern;
+	if (*pattern) {
 		int namelen = strlen(refname);
 		for (pattern = cb->grab_pattern; *pattern; pattern++) {
 			const char *p = *pattern;
@@ -668,6 +723,7 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	 */
 	ref = xcalloc(1, sizeof(*ref));
 	ref->refname = xstrdup(refname);
+	ref->pattern = *pattern;
 	hashcpy(ref->objectname, sha1);
 
 	cnt = cb->grab_cnt;
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 8ced593..a4a2fd3 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -262,6 +262,67 @@ for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --perl"; do
 	"
 done
 
+cat >expected <<\EOF
+master
+testtag
+master
+testtag
+EOF
+
+test_expect_success 'Check short refname format' '
+	(git for-each-ref --format="%(refname:short)" refs/heads &&
+	git for-each-ref --format="%(refname:short)" refs/tags &&
+	git for-each-ref --format="%(refname:short)" refs/heads/ &&
+	git for-each-ref --format="%(refname:short)" refs/tags/) >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+master
+testtag
+EOF
+
+test_expect_success 'Check short refname format with multiple patterns' '
+	(git for-each-ref --format="%(refname:short)" refs/heads refs/tags) >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+refs/heads/master
+refs/tags/testtag
+EOF
+
+test_expect_success 'Check short refname format without patterns' '
+	git for-each-ref --format="%(refname:short)" >actual &&
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
+testtag
+EOF
+
+test_expect_success 'Check short refname format with wildcard pattern' '
+	(git for-each-ref --format="%(refname:short)" refs/*/m* &&
+	git for-each-ref --format="%(refname:short)" refs/heads/?aster &&
+	git for-each-ref --format="%(refname:short)" refs/tags/t[aeiou]sttag) >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+refs/heads/master
+EOF
+
+test_expect_success 'Check disabled short refname format with exact pattern' '
+	(git for-each-ref --format="%(refname:short)" refs/heads/master) >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'an unusual tag with an incomplete line' '
 
 	git tag -m "bogo" bogo &&
-- 
tg: (445cac1..) t/for-each-ref-refshort (depends on: master)
