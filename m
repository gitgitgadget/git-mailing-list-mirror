From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 1/3] Refactoring: Split up diff_tree_stdin
Date: Fri, 08 Aug 2008 22:48:23 +0200
Message-ID: <20080808204823.7744.57203.stgit@yoghurt>
References: <20080808204348.7744.46006.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 22:49:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRYu6-00058H-8M
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 22:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277AbYHHUsi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 16:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753139AbYHHUsi
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 16:48:38 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4158 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbYHHUsh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 16:48:37 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KRZEM-0000vU-00; Fri, 08 Aug 2008 22:10:38 +0100
In-Reply-To: <20080808204348.7744.46006.stgit@yoghurt>
User-Agent: StGIT/0.14.3.222.g9ef2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91711>

Into a first half that determines what operation to do, and a second
half that does it.

Currently the only operation is diffing one or more commits, but a
later patch will add diffing of trees, at which point this refactoring
will pay off.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 builtin-diff-tree.c |   31 +++++++++++++++++++------------
 1 files changed, 19 insertions(+), 12 deletions(-)


diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 415cb16..ebbd631 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -14,20 +14,10 @@ static int diff_tree_commit_sha1(const unsigned cha=
r *sha1)
 	return log_tree_commit(&log_tree_opt, commit);
 }
=20
-static int diff_tree_stdin(char *line)
+/* Diff one or more commits. */
+static int stdin_diff_commit(struct commit *commit, char *line, int le=
n)
 {
-	int len =3D strlen(line);
 	unsigned char sha1[20];
-	struct commit *commit;
-
-	if (!len || line[len-1] !=3D '\n')
-		return -1;
-	line[len-1] =3D 0;
-	if (get_sha1_hex(line, sha1))
-		return -1;
-	commit =3D lookup_commit(sha1);
-	if (!commit || parse_commit(commit))
-		return -1;
 	if (isspace(line[40]) && !get_sha1_hex(line+41, sha1)) {
 		/* Graft the fake parents locally to the commit */
 		int pos =3D 41;
@@ -52,6 +42,23 @@ static int diff_tree_stdin(char *line)
 	return log_tree_commit(&log_tree_opt, commit);
 }
=20
+static int diff_tree_stdin(char *line)
+{
+	int len =3D strlen(line);
+	unsigned char sha1[20];
+	struct commit *commit;
+
+	if (!len || line[len-1] !=3D '\n')
+		return -1;
+	line[len-1] =3D 0;
+	if (get_sha1_hex(line, sha1))
+		return -1;
+	commit =3D lookup_commit(sha1);
+	if (!commit || parse_commit(commit))
+		return -1;
+	return stdin_diff_commit(commit, line, len);
+}
+
 static const char diff_tree_usage[] =3D
 "git diff-tree [--stdin] [-m] [-c] [--cc] [-s] [-v] [--pretty] [-t] [-=
r] [--root] "
 "[<common diff options>] <tree-ish> [<tree-ish>] [<path>...]\n"
