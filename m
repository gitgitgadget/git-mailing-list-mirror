From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] format-patch: don't pass on the --quiet flag
Date: Tue, 12 Apr 2011 17:35:38 +0200
Message-ID: <1302622538-7535-1-git-send-email-cmn@elego.de>
References: <7v8vvgv5dm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 17:35:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9fd6-0005GY-5W
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 17:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757595Ab1DLPfm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 11:35:42 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:34596 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756700Ab1DLPfl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 11:35:41 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id AEECB4612C;
	Tue, 12 Apr 2011 17:35:26 +0200 (CEST)
Received: (nullmailer pid 7579 invoked by uid 1000);
	Tue, 12 Apr 2011 15:35:38 -0000
X-Mailer: git-send-email 1.7.4.2.437.g4fc7e.dirty
In-Reply-To: <7v8vvgv5dm.fsf@alter.siamese.dyndns.org>
References: <4DA36D95.6060108@windriver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171397>

The --quiet flag is not meant to be passed on to the diff, as the user
always wants the patches to be produced so catch it and pass it to
reopen_stdout which decides whether to print the filename or not.

Noticed by Paul Gortmaker

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
> A patch to make --quiet not to squelch the patch output, and instead
> silence any progress output would be a good addition.

Something like this? I guess the only use case would be together with
-o.

 builtin/log.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 9a15d69..1ce00ba 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -623,7 +623,7 @@ static FILE *realstdout =3D NULL;
 static const char *output_directory =3D NULL;
 static int outdir_offset;
=20
-static int reopen_stdout(struct commit *commit, struct rev_info *rev)
+static int reopen_stdout(struct commit *commit, struct rev_info *rev, =
int quiet)
 {
 	struct strbuf filename =3D STRBUF_INIT;
 	int suffix_len =3D strlen(fmt_patch_suffix) + 1;
@@ -639,7 +639,7 @@ static int reopen_stdout(struct commit *commit, str=
uct rev_info *rev)
=20
 	get_patch_filename(commit, rev->nr, fmt_patch_suffix, &filename);
=20
-	if (!DIFF_OPT_TST(&rev->diffopt, QUICK))
+	if (!quiet)
 		fprintf(realstdout, "%s\n", filename.buf + outdir_offset);
=20
 	if (freopen(filename.buf, "w", stdout) =3D=3D NULL)
@@ -718,7 +718,8 @@ static void print_signature(void)
 static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      int numbered, int numbered_files,
 			      struct commit *origin,
-			      int nr, struct commit **list, struct commit *head)
+			      int nr, struct commit **list, struct commit *head,
+			      int quiet)
 {
 	const char *committer;
 	const char *subject_start =3D NULL;
@@ -754,7 +755,7 @@ static void make_cover_letter(struct rev_info *rev,=
 int use_stdout,
 			sha1_to_hex(head->object.sha1), committer, committer);
 	}
=20
-	if (!use_stdout && reopen_stdout(commit, rev))
+	if (!use_stdout && reopen_stdout(commit, rev, quiet))
 		return;
=20
 	if (commit) {
@@ -995,6 +996,7 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 	char *add_signoff =3D NULL;
 	struct strbuf buf =3D STRBUF_INIT;
 	int use_patch_format =3D 0;
+	int quiet =3D 0;
 	const struct option builtin_format_patch_options[] =3D {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
 			    "use [PATCH n/m] even with a single patch",
@@ -1050,6 +1052,8 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 			    PARSE_OPT_OPTARG, thread_callback },
 		OPT_STRING(0, "signature", &signature, "signature",
 			    "add a signature"),
+		OPT_BOOLEAN(0, "quiet", &quiet,
+			    "don't print the patch filenames"),
 		OPT_END()
 	};
=20
@@ -1259,7 +1263,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 		if (thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, use_stdout, numbered, numbered_files,
-				  origin, nr, list, head);
+				  origin, nr, list, head, quiet);
 		total++;
 		start_number--;
 	}
@@ -1305,7 +1309,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 		}
=20
 		if (!use_stdout && reopen_stdout(numbered_files ? NULL : commit,
-						 &rev))
+						 &rev, quiet))
 			die("Failed to create output files");
 		shown =3D log_tree_commit(&rev, commit);
 		free(commit->buffer);
--=20
1.7.4.2.437.g4fc7e.dirty
