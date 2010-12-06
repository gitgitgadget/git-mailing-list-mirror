From: Anders Kaseorg <andersk@ksplice.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_describe=3A_Don=E2=80=99t_look_up_commits_with_--exact-match?=
Date: Mon, 6 Dec 2010 12:28:59 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu> <20101203084348.GD18202@burratino> <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu> <20101206073214.GA3745@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 18:29:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPesS-0002WJ-MI
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 18:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086Ab0LFR3V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 12:29:21 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42089 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab0LFR3U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 12:29:20 -0500
Received: by qyk11 with SMTP id 11so3870676qyk.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 09:29:19 -0800 (PST)
Received: by 10.224.47.130 with SMTP id n2mr4762173qaf.100.1291656542168;
        Mon, 06 Dec 2010 09:29:02 -0800 (PST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
        by mx.google.com with ESMTPS id s28sm3691045qcp.33.2010.12.06.09.29.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 09:29:01 -0800 (PST)
X-X-Sender: andersk@dr-wily.mit.edu
In-Reply-To: <20101206073214.GA3745@burratino>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163001>

On Mon, 6 Dec 2010, Jonathan Nieder wrote:
> Depends on what "Don't lookup commits" means, I suppose.  I
> think the difference between _ref and _rawref is
> [=E2=80=A6]
> so if I understand correctly, for_each_ref would still allow one to
> get away without unpacking the objects.  Is that correct?

Yeah.  Okay, I see that =E2=80=9Clookup=E2=80=9D implies unpacking, as =
opposed to =E2=80=9Cfind=E2=80=9D,=20
which doesn=E2=80=99t.  The important part is to avoid the find, of cou=
rse,=20
because the I/O is expensive.

Anyway, here=E2=80=99s a series with that change split out.

Anders

-- 8< --
=46rom 2ad1e58b8f6e9c117c77748b6e8b85227d9d5412 Mon Sep 17 00:00:00 200=
1
=46rom: Anders Kaseorg <andersk@ksplice.com>
Subject: [PATCH 1/2] describe: Use for_each_rawref

Don=E2=80=99t waste time checking for dangling refs; they wouldn=E2=80=99=
t affect the
output of =E2=80=98git describe=E2=80=99 anyway.  Although this doesn=E2=
=80=99t gain much
performance by itself, it does in conjunction with the next commit.

Signed-off-by: Anders Kaseorg <andersk@ksplice.com>
---
 builtin/describe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 43caff2..700f740 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -418,7 +418,7 @@ int cmd_describe(int argc, const char **argv, const=
 char *prefix)
 		return cmd_name_rev(i + argc, args, prefix);
 	}
=20
-	for_each_ref(get_name, NULL);
+	for_each_rawref(get_name, NULL);
 	if (!found_names && !always)
 		die("No names found, cannot describe anything.");
=20
--=20
1.7.3.3


=46rom ce8a2ab9cf80247c2834d21f36f63cedb794e62f Mon Sep 17 00:00:00 200=
1
=46rom: Anders Kaseorg <andersk@ksplice.com>
Subject: describe: Don=E2=80=99t look up commits with --exact-match

This makes =E2=80=98git describe --exact-match HEAD=E2=80=99 about 15 t=
imes faster on
a cold cache (2.3s instead of 35s) in a linux-2.6 repository with many
packed tags.  That=E2=80=99s a huge win for the interactivity of the __=
git_ps1
shell prompt helper.

Signed-off-by: Anders Kaseorg <andersk@ksplice.com>
---
 builtin/describe.c |   62 ++++++++++++++++++++++++++------------------=
-------
 1 files changed, 32 insertions(+), 30 deletions(-)

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
