From: Anders Kaseorg <andersk@ksplice.com>
Subject: =?UTF-8?Q?=5BPATCH_2=2F2=5D_describe=3A_Don=E2=80=99t_look_up_commits_with_--exact-match?=
Date: Tue, 7 Dec 2010 13:22:53 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1012071322120.23348@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu> <20101203084348.GD18202@burratino> <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu> <20101206073214.GA3745@burratino> <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
 <20101207095818.GB1867@neumann> <alpine.DEB.2.02.1012071320240.23348@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Dec 07 19:23:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ2Bv-0004k7-DQ
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 19:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442Ab0LGSW6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 13:22:58 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51962 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab0LGSW5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 13:22:57 -0500
Received: by vws16 with SMTP id 16so211425vws.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 10:22:56 -0800 (PST)
Received: by 10.229.189.194 with SMTP id df2mr6033572qcb.39.1291746175719;
        Tue, 07 Dec 2010 10:22:55 -0800 (PST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
        by mx.google.com with ESMTPS id x9sm4590049qco.10.2010.12.07.10.22.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 10:22:55 -0800 (PST)
X-X-Sender: andersk@dr-wily.mit.edu
In-Reply-To: <alpine.DEB.2.02.1012071320240.23348@dr-wily.mit.edu>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163104>

This makes =E2=80=98git describe --exact-match HEAD=E2=80=99 about 15 t=
imes faster on
a cold cache (2.3s instead of 35s) in a linux-2.6 repository with many
packed tags.  That=E2=80=99s a huge win for the interactivity of the __=
git_ps1
shell prompt helper when on a detached head.

Signed-off-by: Anders Kaseorg <andersk@ksplice.com>

diff --git a/builtin/describe.c b/builtin/describe.c
index 700f740..0cddef1 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -22,7 +22,7 @@ static int tags;	/* Allow lightweight tags */
 static int longformat;
 static int abbrev =3D DEFAULT_ABBREV;
 static int max_candidates =3D 10;
-static int found_names;
+static struct commit_name *names;
 static const char *pattern;
 static int always;
 static const char *dirty;
@@ -34,6 +34,8 @@ static const char *diff_index_args[] =3D {
=20
=20
 struct commit_name {
+	struct commit_name *next;
+	unsigned char peeled[20];
 	struct tag *tag;
 	unsigned prio:2; /* annotated tag =3D 2, tag =3D 1, head =3D 0 */
 	unsigned name_checked:1;
@@ -78,31 +80,26 @@ static int replace_name(struct commit_name *e,
 }
=20
 static void add_to_known_names(const char *path,
-			       struct commit *commit,
+			       const unsigned char *peeled,
 			       int prio,
 			       const unsigned char *sha1)
 {
-	struct commit_name *e =3D commit->util;
 	struct tag *tag =3D NULL;
-	if (replace_name(e, prio, sha1, &tag)) {
-		size_t len =3D strlen(path)+1;
-		free(e);
-		e =3D xmalloc(sizeof(struct commit_name) + len);
-		e->tag =3D tag;
-		e->prio =3D prio;
-		e->name_checked =3D 0;
-		hashcpy(e->sha1, sha1);
-		memcpy(e->path, path, len);
-		commit->util =3D e;
-	}
-	found_names =3D 1;
+	size_t len =3D strlen(path)+1;
+	struct commit_name *e =3D xmalloc(sizeof(struct commit_name) + len);
+	hashcpy(e->peeled, peeled);
+	e->tag =3D tag;
+	e->prio =3D prio;
+	e->name_checked =3D 0;
+	hashcpy(e->sha1, sha1);
+	memcpy(e->path, path, len);
+	e->next =3D names;
+	names =3D e;
 }
=20
 static int get_name(const char *path, const unsigned char *sha1, int f=
lag, void *cb_data)
 {
 	int might_be_tag =3D !prefixcmp(path, "refs/tags/");
-	struct commit *commit;
-	struct object *object;
 	unsigned char peeled[20];
 	int is_tag, prio;
=20
@@ -110,16 +107,10 @@ static int get_name(const char *path, const unsig=
ned char *sha1, int flag, void
 		return 0;
=20
 	if (!peel_ref(path, peeled) && !is_null_sha1(peeled)) {
-		commit =3D lookup_commit_reference_gently(peeled, 1);
-		if (!commit)
-			return 0;
-		is_tag =3D !!hashcmp(sha1, commit->object.sha1);
+		is_tag =3D !!hashcmp(sha1, peeled);
 	} else {
-		commit =3D lookup_commit_reference_gently(sha1, 1);
-		object =3D parse_object(sha1);
-		if (!commit || !object)
-			return 0;
-		is_tag =3D object->type =3D=3D OBJ_TAG;
+		hashcpy(peeled, sha1);
+		is_tag =3D 0;
 	}
=20
 	/* If --all, then any refs are used.
@@ -142,7 +133,7 @@ static int get_name(const char *path, const unsigne=
d char *sha1, int flag, void
 		if (!prio)
 			return 0;
 	}
-	add_to_known_names(all ? path + 5 : path + 10, commit, prio, sha1);
+	add_to_known_names(all ? path + 5 : path + 10, peeled, prio, sha1);
 	return 0;
 }
=20
@@ -228,7 +219,7 @@ static void describe(const char *arg, int last_one)
 	unsigned char sha1[20];
 	struct commit *cmit, *gave_up_on =3D NULL;
 	struct commit_list *list;
-	struct commit_name *n;
+	struct commit_name *n, *e;
 	struct possible_tag all_matches[MAX_TAGS];
 	unsigned int match_cnt =3D 0, annotated_cnt =3D 0, cur_match;
 	unsigned long seen_commits =3D 0;
@@ -240,7 +231,12 @@ static void describe(const char *arg, int last_one=
)
 	if (!cmit)
 		die("%s is not a valid '%s' object", arg, commit_type);
=20
-	n =3D cmit->util;
+	n =3D NULL;
+	for (e =3D names; e; e =3D e->next) {
+		if (!hashcmp(e->peeled, cmit->object.sha1) &&
+		    replace_name(n, e->prio, e->sha1, &e->tag))
+			n =3D e;
+	}
 	if (n && (tags || all || n->prio =3D=3D 2)) {
 		/*
 		 * Exact match to an existing ref.
@@ -259,6 +255,12 @@ static void describe(const char *arg, int last_one=
)
 	if (debug)
 		fprintf(stderr, "searching to describe %s\n", arg);
=20
+	for (e =3D names; e; e =3D e->next) {
+		struct commit *c =3D lookup_commit_reference_gently(e->peeled, 1);
+		if (c && replace_name(c->util, e->prio, e->sha1, &e->tag))
+			c->util =3D e;
+	}
+
 	list =3D NULL;
 	cmit->object.flags =3D SEEN;
 	commit_list_insert(cmit, &list);
@@ -419,7 +421,7 @@ int cmd_describe(int argc, const char **argv, const=
 char *prefix)
 	}
=20
 	for_each_rawref(get_name, NULL);
-	if (!found_names && !always)
+	if (!names && !always)
 		die("No names found, cannot describe anything.");
=20
 	if (argc =3D=3D 0) {
--=20
1.7.3.3
