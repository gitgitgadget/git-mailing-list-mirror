From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] git-branch: add support for --merged and --no-merged
Date: Thu, 17 Apr 2008 20:07:17 +0200
Message-ID: <1208455637-17457-1-git-send-email-hjemli@gmail.com>
References: <1208432040-26271-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?SZEDER=20G=E1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 20:39:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmYW5-0000Ke-29
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 20:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763797AbYDQSGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 14:06:38 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762880AbYDQSGi
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 14:06:38 -0400
Received: from mail49.e.nsc.no ([193.213.115.49]:64798 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756244AbYDQSGh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 14:06:37 -0400
Received: from localhost.localdomain (ti0025a380-0176.bb.online.no [88.89.68.176])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id m3HI6958019451;
	Thu, 17 Apr 2008 20:06:11 +0200 (MEST)
X-Mailer: git-send-email 1.5.5.64.g3e6a
In-Reply-To: <1208432040-26271-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79807>

These options filter the output from git branch to only include branche=
s
whose tip is either merged or not merged into HEAD.

The use-case for these options is when working with integration of bran=
ches
from many remotes: `git branch --no-merged -a` will show a nice list of=
 merge
candidates while `git branch --merged -a` will show the progress of you=
r
integration work.

Also, a plain `git branch --merged` is a quick way to find local branch=
es
which you might want to delete.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

This is an alternative implementation which (ab)uses the option parser =
to
achive the same effect as the former patch. I prefer this approach.

SZEDER G=C3=A1bor <szeder@ira.uka.de> wrote:
> How about making it easier to type?

Yes, that's nice, thank you. If my latter patch (i.e. this one ;) is ac=
cepted,
would you mind updating your patch?


 Documentation/git-branch.txt |    4 +++-
 builtin-branch.c             |   27 ++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index 6f07a17..95e9d0d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -8,7 +8,7 @@ git-branch - List, create, or delete branches
 SYNOPSIS
 --------
 [verse]
-'git-branch' [--color | --no-color] [-r | -a]
+'git-branch' [--color | --no-color] [-r | -a] [--merged | --no-merged]
 	   [-v [--abbrev=3D<length> | --no-abbrev]]
 	   [--contains <commit>]
 'git-branch' [--track | --no-track] [-l] [-f] <branchname> [<start-poi=
nt>]
@@ -24,6 +24,8 @@ and option `-a` shows both.
 With `--contains <commit>`, shows only the branches that
 contains the named commit (in other words, the branches whose
 tip commits are descendant of the named commit).
+With `--merged`, only branches merged into HEAD will be listed, and
+with `--no-merged` only branches not merged into HEAD will be listed.
=20
 In its second form, a new branch named <branchname> will be created.
 It will start out with a head equal to the one given as <start-point>.
diff --git a/builtin-branch.c b/builtin-branch.c
index 5bc4526..2c26d90 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -15,7 +15,7 @@
 #include "branch.h"
=20
 static const char * const builtin_branch_usage[] =3D {
-	"git-branch [options] [-r | -a]",
+	"git-branch [options] [-r | -a] [--merged | --no-merged]",
 	"git-branch [options] [-l] [-f] <branchname> [<start-point>]",
 	"git-branch [options] [-r] (-d | -D) <branchname>",
 	"git-branch [options] (-m | -M) [<oldbranch>] <newbranch>",
@@ -46,6 +46,8 @@ enum color_branch {
 	COLOR_BRANCH_CURRENT =3D 4,
 };
=20
+static int mergefilter =3D -1;
+
 static int parse_branch_color_slot(const char *var, int ofs)
 {
 	if (!strcasecmp(var+ofs, "plain"))
@@ -204,6 +206,22 @@ static int has_commit(const unsigned char *sha1, s=
truct commit_list *with_commit
 	return 0;
 }
=20
+static int is_merged(const unsigned char *sha1, const char *refname)
+{
+	static struct commit *head_commit;
+	struct commit *branch;
+
+	if (!head_commit) {
+		head_commit =3D lookup_commit_reference(head_sha1);
+		if (!head_commit)
+			die("Unable to lookup HEAD");
+	}
+	branch =3D lookup_commit_reference(sha1);
+	if (!branch)
+		die("Unable to lookup branch %s", refname);
+	return in_merge_bases(branch, &head_commit, 1);
+}
+
 static int append_ref(const char *refname, const unsigned char *sha1, =
int flags, void *cb_data)
 {
 	struct ref_list *ref_list =3D (struct ref_list*)(cb_data);
@@ -231,6 +249,12 @@ static int append_ref(const char *refname, const u=
nsigned char *sha1, int flags,
 	if ((kind & ref_list->kinds) =3D=3D 0)
 		return 0;
=20
+	if (mergefilter =3D=3D 0 && is_merged(sha1, refname))
+		return 0;
+
+	if (mergefilter =3D=3D 1 && !is_merged(sha1, refname))
+		return 0;
+
 	/* Resize buffer */
 	if (ref_list->index >=3D ref_list->alloc) {
 		ref_list->alloc =3D alloc_nr(ref_list->alloc);
@@ -444,6 +468,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target ex=
ists", 2),
 		OPT_BOOLEAN('l', NULL, &reflog, "create the branch's reflog"),
 		OPT_BOOLEAN('f', NULL, &force_create, "force creation (when already =
exists)"),
+		OPT_SET_INT(0, "merged", &mergefilter, "list only merged branches", =
1),
 		OPT_END(),
 	};
=20
--=20
1.5.5.64.g3e6a
