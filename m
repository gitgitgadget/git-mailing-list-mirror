From: Anders Kaseorg <andersk@ksplice.com>
Subject: [PATCH v2 4/4] describe: Delay looking up commits until searching
 for an inexact match
Date: Tue, 7 Dec 2010 23:46:16 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1012072344000.23348@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu> <20101203084348.GD18202@burratino> <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu> <20101206073214.GA3745@burratino> <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
 <7vfwu9qvew.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.02.1012072204371.23348@dr-wily.mit.edu> <alpine.DEB.2.02.1012072341570.23348@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 05:46:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQBv6-0004MU-9V
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 05:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714Ab0LHEqT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 23:46:19 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55177 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab0LHEqT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 23:46:19 -0500
Received: by qwa26 with SMTP id 26so808164qwa.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 20:46:18 -0800 (PST)
Received: by 10.229.230.198 with SMTP id jn6mr3618282qcb.206.1291783578304;
        Tue, 07 Dec 2010 20:46:18 -0800 (PST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
        by mx.google.com with ESMTPS id u2sm146263qcq.19.2010.12.07.20.46.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 20:46:18 -0800 (PST)
X-X-Sender: andersk@dr-wily.mit.edu
In-Reply-To: <alpine.DEB.2.02.1012072341570.23348@dr-wily.mit.edu>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163170>

Now that struct commit.util is not used until after we=E2=80=99ve check=
ed that
the argument doesn=E2=80=99t exactly match a tag, we can wait until the=
n to
look up the commits for each tag.

This avoids a lot of I/O on --exact-match queries in repositories with
many tags.  For example, =E2=80=98git describe --exact-match HEAD=E2=80=
=99 becomes
about 12 times faster on a cold cache (3.2s instead of 39s) in a
linux-2.6 repository with 2000 packed tags.  That=E2=80=99s a huge win =
for the
interactivity of the __git_ps1 shell prompt helper when on a detached
HEAD.

Signed-off-by: Anders Kaseorg <andersk@ksplice.com>
---

(The benchmark numbers are different because my linux-2.6 repository ha=
s=20
changed; I don=E2=80=99t think this version is actually slower.)

 builtin/describe.c |   35 ++++++++++++++++++++---------------
 1 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index afc50c0..2633371 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -24,6 +24,7 @@ static int longformat;
 static int abbrev =3D DEFAULT_ABBREV;
 static int max_candidates =3D 10;
 struct hash_table names;
+static int have_util;
 static const char *pattern;
 static int always;
 static const char *dirty;
@@ -60,6 +61,15 @@ static inline struct commit_name *find_commit_name(c=
onst unsigned char *peeled)
 	return n;
 }
=20
+static int set_util(void *vn)
+{
+	struct commit_name *n =3D vn;
+	struct commit *c =3D lookup_commit_reference_gently(n->peeled, 1);
+	if (c)
+		c->util =3D n;
+	return 0;
+}
+
 static int replace_name(struct commit_name *e,
 			       int prio,
 			       const unsigned char *sha1,
@@ -94,18 +104,16 @@ static int replace_name(struct commit_name *e,
 }
=20
 static void add_to_known_names(const char *path,
-			       struct commit *commit,
+			       const unsigned char *peeled,
 			       int prio,
 			       const unsigned char *sha1)
 {
-	const unsigned char *peeled =3D commit->object.sha1;
 	struct commit_name *e =3D find_commit_name(peeled);
 	struct tag *tag =3D NULL;
 	if (replace_name(e, prio, sha1, &tag)) {
 		if (!e) {
 			void **pos;
 			e =3D xmalloc(sizeof(struct commit_name));
-			commit->util =3D e;
 			hashcpy(e->peeled, peeled);
 			pos =3D insert_hash(hash_sha1(peeled), e, &names);
 			if (pos) {
@@ -126,8 +134,6 @@ static void add_to_known_names(const char *path,
 static int get_name(const char *path, const unsigned char *sha1, int f=
lag, void *cb_data)
 {
 	int might_be_tag =3D !prefixcmp(path, "refs/tags/");
-	struct commit *commit;
-	struct object *object;
 	unsigned char peeled[20];
 	int is_tag, prio;
=20
@@ -135,16 +141,10 @@ static int get_name(const char *path, const unsig=
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
@@ -167,7 +167,7 @@ static int get_name(const char *path, const unsigne=
d char *sha1, int flag, void
 		if (!prio)
 			return 0;
 	}
-	add_to_known_names(all ? path + 5 : path + 10, commit, prio, sha1);
+	add_to_known_names(all ? path + 5 : path + 10, peeled, prio, sha1);
 	return 0;
 }
=20
@@ -284,6 +284,11 @@ static void describe(const char *arg, int last_one=
)
 	if (debug)
 		fprintf(stderr, "searching to describe %s\n", arg);
=20
+	if (!have_util) {
+		for_each_hash(&names, set_util);
+		have_util =3D 1;
+	}
+
 	list =3D NULL;
 	cmit->object.flags =3D SEEN;
 	commit_list_insert(cmit, &list);
--=20
1.7.3.3
