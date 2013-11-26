From: Nick Townsend <nick.townsend@mac.com>
Subject: [PATCH] submodule recursion in git-archive
Date: Mon, 25 Nov 2013 16:04:14 -0800
Message-ID: <2E636B58-47EB-4712-93CA-39E8D1BA3DB9@mac.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 26 02:04:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl74j-0003a2-SS
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 02:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717Ab3KZBEV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Nov 2013 20:04:21 -0500
Received: from nk11p03mm-asmtp001.mac.com ([17.158.232.236]:51587 "EHLO
	nk11p03mm-asmtp001.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753666Ab3KZBET convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 20:04:19 -0500
X-Greylist: delayed 3603 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Nov 2013 20:04:19 EST
Received: from [172.16.1.4]
 (99-120-78-245.lightspeed.sntcca.sbcglobal.net [99.120.78.245])
 by nk11p03mm-asmtp001.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0MWU00IZVG70DR50@nk11p03mm-asmtp001.mac.com> for
 git@vger.kernel.org; Tue, 26 Nov 2013 00:04:14 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.10.8794,1.0.14,0.0.0000
 definitions=2013-11-25_05:2013-11-25,2013-11-25,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1308280000 definitions=main-1311250209
X-Mailer: Apple Mail (2.1822)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238367>

All,
My first git patch - so shout out if I=92ve got the etiquette wrong! Or=
 of course if I=92ve missed something.
I googled around looking for solutions to my problem but just came up w=
ith a few shell-scripts
that didn=92t quite get the functionality I needed.
The first patch fixes some typos that crept in to existing doc and decl=
arations. It is required
for the second which actually implements the changes.

All comments gratefully received!

Regards
Nick Townsend

Subject: [PATCH 1/2] submodule: add_submodule_odb() usability

Although add_submodule_odb() is documented as being
externally usable, it is declared static and also
has incorrect documentation.

This commit fixes those and makes no changes to
existing code using them. All tests still pass.
---
 Documentation/technical/api-ref-iteration.txt | 4 ++--
 submodule.c                                   | 2 +-
 submodule.h                                   | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-ref-iteration.txt b/Documentat=
ion/technical/api-ref-iteration.txt
index aa1c50f..cbee624 100644
--- a/Documentation/technical/api-ref-iteration.txt
+++ b/Documentation/technical/api-ref-iteration.txt
@@ -50,10 +50,10 @@ submodules object database. You can do this by a co=
de-snippet like
 this:
=20
 	const char *path =3D "path/to/submodule"
-	if (!add_submodule_odb(path))
+	if (add_submodule_odb(path))
 		die("Error submodule '%s' not populated.", path);
=20
-`add_submodule_odb()` will return an non-zero value on success. If you
+`add_submodule_odb()` will return a zero value on success. If you
 do not do this you will get an error for each ref that it does not poi=
nt
 to a valid object.
=20
diff --git a/submodule.c b/submodule.c
index 1905d75..1ea46be 100644
--- a/submodule.c
+++ b/submodule.c
@@ -143,7 +143,7 @@ void stage_updated_gitmodules(void)
 		die(_("staging updated .gitmodules failed"));
 }
=20
-static int add_submodule_odb(const char *path)
+int add_submodule_odb(const char *path)
 {
 	struct strbuf objects_directory =3D STRBUF_INIT;
 	struct alternate_object_database *alt_odb;
diff --git a/submodule.h b/submodule.h
index 7beec48..3e3cdca 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,5 +41,6 @@ int find_unpushed_submodules(unsigned char new_sha1[2=
0], const char *remotes_nam
 		struct string_list *needs_pushing);
 int push_unpushed_submodules(unsigned char new_sha1[20], const char *r=
emotes_name);
 void connect_work_tree_and_git_dir(const char *work_tree, const char *=
git_dir);
+int add_submodule_odb(const char *path);
=20
 #endif
--=20
1.8.3.4 (Apple Git-47)

Subject: [PATCH 2/2] archive: allow submodule recursion on git-archive

When using git-archive to produce a dump of a
repository, the existing code does not recurse
into a submodule when it encounters it in the tree
traversal. These changes add a command line flag
that permits this.

Note that the submodules must be updated in the
repository, otherwise this cannot take place.

The feature is disabled for remote repositories as
the git_work_tree fails. This is a possible future
enhancement.

Two additional fields are added to archiver_args:
  * recurse  - a boolean indicator
  * treepath - the path part of the tree-ish
               eg. the 'www' in HEAD:www

The latter is used within the archive writer to
determin the correct path for the submodule .git
file.

Signed-off-by: Nick Townsend <nick.townsend@mac.com>
---
 Documentation/git-archive.txt |  9 +++++++++
 archive.c                     | 38 +++++++++++++++++++++++++++++++++++=
+--
 archive.h                     |  2 ++
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.=
txt
index b97aaab..b4df735 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git archive' [--format=3D<fmt>] [--list] [--prefix=3D<prefix>/] [<ext=
ra>]
 	      [-o <file> | --output=3D<file>] [--worktree-attributes]
+	      [--recursive|--recurse-submodules]
 	      [--remote=3D<repo> [--exec=3D<git-upload-archive>]] <tree-ish>
 	      [<path>...]
=20
@@ -51,6 +52,14 @@ OPTIONS
 --prefix=3D<prefix>/::
 	Prepend <prefix>/ to each filename in the archive.
=20
+--recursive::
+--recurse-submodules::
+	Archive entries in submodules. Errors occur if the submodules
+	have not been initialized and updated.
+	Run `git submodule update --init --recursive` immediately after
+	the clone is finished to avoid this.
+	This option is not available with remote repositories.
+
 -o <file>::
 --output=3D<file>::
 	Write the archive to <file> instead of stdout.
diff --git a/archive.c b/archive.c
index 346f3b2..f6313c9 100644
--- a/archive.c
+++ b/archive.c
@@ -5,6 +5,7 @@
 #include "archive.h"
 #include "parse-options.h"
 #include "unpack-trees.h"
+#include "submodule.h"
=20
 static char const * const archive_usage[] =3D {
 	N_("git archive [options] <tree-ish> [<path>...]"),
@@ -131,13 +132,32 @@ static int write_archive_entry(const unsigned cha=
r *sha1, const char *base,
 		args->convert =3D ATTR_TRUE(check[1].value);
 	}
=20
+	if (S_ISGITLINK(mode) && args->recurse) {
+		const char *work_tree =3D get_git_work_tree();
+		if (!work_tree) {
+			  die("Can't go recursive when no work dir");
+		}
+		static struct strbuf dotgit =3D STRBUF_INIT;
+		strbuf_reset(&dotgit);
+		strbuf_grow(&dotgit, PATH_MAX);
+		strbuf_addstr(&dotgit, work_tree);
+		strbuf_addch(&dotgit, '/');
+		if (args->treepath) {
+			  strbuf_addstr(&dotgit, args->treepath);
+			  strbuf_addch(&dotgit, '/');
+		}
+		strbuf_add(&dotgit, path_without_prefix,strlen(path_without_prefix)-=
1);
+		if (add_submodule_odb(dotgit.buf))
+			  die("Can't add submodule: %s", dotgit.buf);
+		strbuf_release(&dotgit);
+	}
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
 		err =3D write_entry(args, sha1, path.buf, path.len, mode);
 		if (err)
 			return err;
-		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
+		return (S_ISGITLINK(mode) && !args->recurse) ? 0: READ_TREE_RECURSIV=
E;
 	}
=20
 	if (args->verbose)
@@ -256,10 +276,16 @@ static void parse_treeish_arg(const char **argv,
 	const struct commit *commit;
 	unsigned char sha1[20];
=20
+	const char *colon =3D strchr(name, ':');
+
+	/* Store the path on the ref for later (required for --recursive) */
+	char *treepath =3D NULL;
+	if (colon) {
+		treepath =3D strdup(colon+1);
+	}
 	/* Remotes are only allowed to fetch actual refs */
 	if (remote) {
 		char *ref =3D NULL;
-		const char *colon =3D strchr(name, ':');
 		int refnamelen =3D colon ? colon - name : strlen(name);
=20
 		if (!dwim_ref(name, refnamelen, sha1, &ref))
@@ -296,9 +322,11 @@ static void parse_treeish_arg(const char **argv,
 		tree =3D parse_tree_indirect(tree_sha1);
 	}
 	ar_args->tree =3D tree;
+	ar_args->treepath =3D treepath;
 	ar_args->commit_sha1 =3D commit_sha1;
 	ar_args->commit =3D commit;
 	ar_args->time =3D archive_time;
+
 }
=20
 #define OPT__COMPR(s, v, h, p) \
@@ -318,6 +346,7 @@ static int parse_archive_args(int argc, const char =
**argv,
 	const char *exec =3D NULL;
 	const char *output =3D NULL;
 	int compression_level =3D -1;
+	int recurse =3D 0;
 	int verbose =3D 0;
 	int i;
 	int list =3D 0;
@@ -331,6 +360,8 @@ static int parse_archive_args(int argc, const char =
**argv,
 			N_("write the archive to this file")),
 		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
 			N_("read .gitattributes in working directory")),
+		OPT_BOOL(0, "recursive", &recurse, N_("include submodules in archive=
")),
+		OPT_BOOL(0, "recurse-submodules", &recurse, N_("include submodules i=
n archive")),
 		OPT__VERBOSE(&verbose, N_("report archived files on stderr")),
 		OPT__COMPR('0', &compression_level, N_("store only"), 0),
 		OPT__COMPR('1', &compression_level, N_("compress faster"), 1),
@@ -355,6 +386,8 @@ static int parse_archive_args(int argc, const char =
**argv,
=20
 	argc =3D parse_options(argc, argv, NULL, opts, archive_usage, 0);
=20
+	if (is_remote && recurse)
+		die("Cannot include submodules with option --remote");
 	if (remote)
 		die("Unexpected option --remote");
 	if (exec)
@@ -393,6 +426,7 @@ static int parse_archive_args(int argc, const char =
**argv,
 					format, compression_level);
 		}
 	}
+	args->recurse =3D recurse;
 	args->verbose =3D verbose;
 	args->base =3D base;
 	args->baselen =3D strlen(base);
diff --git a/archive.h b/archive.h
index 4a791e1..577238d 100644
--- a/archive.h
+++ b/archive.h
@@ -7,10 +7,12 @@ struct archiver_args {
 	const char *base;
 	size_t baselen;
 	struct tree *tree;
+	const char *treepath;
 	const unsigned char *commit_sha1;
 	const struct commit *commit;
 	time_t time;
 	struct pathspec pathspec;
+	unsigned int recurse : 1;
 	unsigned int verbose : 1;
 	unsigned int worktree_attributes : 1;
 	unsigned int convert : 1;
--=20
1.8.3.4 (Apple Git-47)
