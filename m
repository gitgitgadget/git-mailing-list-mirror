From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] builtin-commit: avoid always using reduce_heads()
Date: Fri, 26 Sep 2008 17:20:32 +0200
Message-ID: <1222442432-7430-1-git-send-email-vmiklos@frugalware.org>
References: <20080926151517.GV23137@genesis.frugalware.org>
Cc: spearce@spearce.org, jnareb@gmail.com, Johannes.Schindelin@gmx.de,
	git@vger.kernel.org
To: SZEDER Gabor <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Sep 26 17:21:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjF8I-0007Oz-W4
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 17:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbYIZPUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 11:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbYIZPUR
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 11:20:17 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:43533 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbYIZPUP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 11:20:15 -0400
Received: from vmobile.example.net (dsl5401CBF6.pool.t-online.hu [84.1.203.246])
	by yugo.frugalware.org (Postfix) with ESMTPA id 72239149C60;
	Fri, 26 Sep 2008 17:20:13 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id C022719E7C3; Fri, 26 Sep 2008 17:20:32 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <20080926151517.GV23137@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96867>

In case git merge --no-ff is used with --no-commit or we have a
conflict, write info about if fast forwards are allowed or not to
$GIT_DIR/MERGE_MODE.

Based on this info, don't run reduce_heads() in case fast-forwards are
denied, to avoid turning a 'merge --no-ff' to a non-merge commit.

Test case by SZEDER Gabor <szeder@ira.uka.de>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Fri, Sep 26, 2008 at 05:15:17PM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
> I'll send a patch that does this in a bit.

Here it is.

 builtin-commit.c |   16 +++++++++++++++-
 builtin-merge.c  |    9 +++++++++
 t/t7600-merge.sh |    9 +++++++++
 3 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 55e1087..aac5cb4 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -937,6 +937,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	unsigned char commit_sha1[20];
 	struct ref_lock *ref_lock;
 	struct commit_list *parents = NULL, **pptr = &parents;
+	struct stat statbuf;
+	int allow_fast_forward = 1;
 
 	git_config(git_commit_config, NULL);
 
@@ -988,7 +990,18 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		reflog_msg = "commit";
 		pptr = &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
 	}
-	parents = reduce_heads(parents);
+	strbuf_reset(&sb);
+	if (!stat(git_path("MERGE_MODE"), &statbuf)) {
+		if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
+			die("could not read MERGE_MODE: %s", strerror(errno));
+		printf("debug, contents of buf: '%s'\n",sb.buf);
+		if (!strcmp(sb.buf, "deny_fast_forward")) {
+			printf("debug, deny fast forward\n");
+			allow_fast_forward = 0;
+		}
+	}
+	if (allow_fast_forward)
+		parents = reduce_heads(parents);
 
 	/* Finally, get the commit message */
 	strbuf_init(&sb, 0);
@@ -1040,6 +1053,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_MSG"));
+	unlink(git_path("MERGE_MODE"));
 	unlink(git_path("SQUASH_MSG"));
 
 	if (commit_index_files())
diff --git a/builtin-merge.c b/builtin-merge.c
index 5c65a58..973b167 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -1210,6 +1210,15 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			merge_msg.len)
 			die("Could not write to %s", git_path("MERGE_MSG"));
 		close(fd);
+		fd = open(git_path("MERGE_MODE"), O_WRONLY | O_CREAT, 0666);
+		if (fd < 0)
+			die("Could open %s for writing", git_path("MERGE_MODE"));
+		strbuf_reset(&buf);
+		if (!allow_fast_forward)
+			strbuf_addf(&buf, "deny_fast_forward");
+		if (write_in_full(fd, buf.buf, buf.len) != buf.len)
+			die("Could not write to %s", git_path("MERGE_MODE"));
+		close(fd);
 	}
 
 	if (merge_was_ok) {
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 9516f54..98cfc53 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -511,4 +511,13 @@ test_expect_success 'in-index merge' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge --no-ff --no-commit && commit' '
+	git reset --hard c0 &&
+	git merge --no-ff --no-commit c1 &&
+	EDITOR=: git commit &&
+	verify_parents $c0 $c1
+'
+
+test_debug 'gitk --all'
+
 test_done
-- 
1.6.0.2
