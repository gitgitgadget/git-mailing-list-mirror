From: Anders Kaseorg <andersk@ksplice.com>
Subject: [PATCH v2.1 3/4] describe: Store commit_names in a hash table by
 commit SHA1
Date: Wed, 8 Dec 2010 13:23:24 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1012081319320.23348@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu> <20101203084348.GD18202@burratino> <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu> <20101206073214.GA3745@burratino> <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
 <7vfwu9qvew.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.02.1012072204371.23348@dr-wily.mit.edu> <alpine.DEB.2.02.1012072341570.23348@dr-wily.mit.edu> <alpine.DEB.2.02.1012072343300.23348@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 19:23:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQOfu-0000HT-3v
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 19:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986Ab0LHSX3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 13:23:29 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51729 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755937Ab0LHSX2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 13:23:28 -0500
Received: by qwa26 with SMTP id 26so1598873qwa.19
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 10:23:27 -0800 (PST)
Received: by 10.224.67.67 with SMTP id q3mr7342331qai.171.1291832607253;
        Wed, 08 Dec 2010 10:23:27 -0800 (PST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
        by mx.google.com with ESMTPS id n7sm527485qcu.40.2010.12.08.10.23.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 10:23:25 -0800 (PST)
X-X-Sender: andersk@dr-wily.mit.edu
In-Reply-To: <alpine.DEB.2.02.1012072343300.23348@dr-wily.mit.edu>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163212>

describe is currently forced to look up the commit at each tag in
order to store the struct commit_name pointers in struct commit.util.
=46or --exact-match queries, those lookups are wasteful.  In preparatio=
n
for removing them, put the commit_names into a hash table, indexed by
commit SHA1, that can be used to quickly check for exact matches.

Signed-off-by: Anders Kaseorg <andersk@ksplice.com>
---
Change from v2: I had forgotten to make =E2=80=98names=E2=80=99 static =
again (thanks=20
Jonathan).

 builtin/describe.c |   36 +++++++++++++++++++++++++++++++-----
 1 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 5b8461d..5d709b6 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -6,6 +6,7 @@
 #include "exec_cmd.h"
 #include "parse-options.h"
 #include "diff.h"
+#include "hash.h"
=20
 #define SEEN		(1u<<0)
 #define MAX_TAGS	(FLAG_BITS - 1)
@@ -22,7 +23,7 @@ static int tags;	/* Allow lightweight tags */
 static int longformat;
 static int abbrev =3D DEFAULT_ABBREV;
 static int max_candidates =3D 10;
-static int found_names;
+static struct hash_table names;
 static const char *pattern;
 static int always;
 static const char *dirty;
@@ -34,6 +35,8 @@ static const char *diff_index_args[] =3D {
=20
=20
 struct commit_name {
+	struct commit_name *next;
+	unsigned char peeled[20];
 	struct tag *tag;
 	unsigned prio:2; /* annotated tag =3D 2, tag =3D 1, head =3D 0 */
 	unsigned name_checked:1;
@@ -44,6 +47,19 @@ static const char *prio_names[] =3D {
 	"head", "lightweight", "annotated",
 };
=20
+static inline unsigned int hash_sha1(const unsigned char *sha1)
+{
+	return *(unsigned int *)sha1;
+}
+
+static inline struct commit_name *find_commit_name(const unsigned char=
 *peeled)
+{
+	struct commit_name *n =3D lookup_hash(hash_sha1(peeled), &names);
+	while (n && !!hashcmp(peeled, n->peeled))
+		n =3D n->next;
+	return n;
+}
+
 static int replace_name(struct commit_name *e,
 			       int prio,
 			       const unsigned char *sha1,
@@ -82,12 +98,22 @@ static void add_to_known_names(const char *path,
 			       int prio,
 			       const unsigned char *sha1)
 {
-	struct commit_name *e =3D commit->util;
+	const unsigned char *peeled =3D commit->object.sha1;
+	struct commit_name *e =3D find_commit_name(peeled);
 	struct tag *tag =3D NULL;
 	if (replace_name(e, prio, sha1, &tag)) {
 		if (!e) {
+			void **pos;
 			e =3D xmalloc(sizeof(struct commit_name));
 			commit->util =3D e;
+			hashcpy(e->peeled, peeled);
+			pos =3D insert_hash(hash_sha1(peeled), e, &names);
+			if (pos) {
+				e->next =3D *pos;
+				*pos =3D e;
+			} else {
+				e->next =3D NULL;
+			}
 		}
 		e->tag =3D tag;
 		e->prio =3D prio;
@@ -95,7 +121,6 @@ static void add_to_known_names(const char *path,
 		hashcpy(e->sha1, sha1);
 		e->path =3D path;
 	}
-	found_names =3D 1;
 }
=20
 static int get_name(const char *path, const unsigned char *sha1, int f=
lag, void *cb_data)
@@ -240,7 +265,7 @@ static void describe(const char *arg, int last_one)
 	if (!cmit)
 		die("%s is not a valid '%s' object", arg, commit_type);
=20
-	n =3D cmit->util;
+	n =3D find_commit_name(cmit->object.sha1);
 	if (n && (tags || all || n->prio =3D=3D 2)) {
 		/*
 		 * Exact match to an existing ref.
@@ -418,8 +443,9 @@ int cmd_describe(int argc, const char **argv, const=
 char *prefix)
 		return cmd_name_rev(i + argc, args, prefix);
 	}
=20
+	init_hash(&names);
 	for_each_rawref(get_name, NULL);
-	if (!found_names && !always)
+	if (!names.nr && !always)
 		die("No names found, cannot describe anything.");
=20
 	if (argc =3D=3D 0) {
--=20
1.7.3.3
