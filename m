From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] merge: honor prepare-commit-msg hook
Date: Mon, 14 Feb 2011 20:07:50 -0500
Message-ID: <1297732070-32704-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 15 02:08:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp9Oq-0001Zw-ML
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 02:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769Ab1BOBII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 20:08:08 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42711 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab1BOBIG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 20:08:06 -0500
Received: by vws16 with SMTP id 16so3490550vws.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 17:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=DIDgRpkasA0lPq8iH5S4DnHVU7TLVdk1IdvSaVQtrTs=;
        b=MKTi4bvP0WL3k0qBbiuhOF2a9Vw3YeKI15BOkUCR/sx74G5D1BfL39dLYcXLUcFC28
         COpEX6Zqb4+4UcoQ1GexEuAaOSJ4sDpKmlbI5XzHMr8lQqxiV4CDCdVyaB/iCKgdbP3n
         aNABDFWzxaD+IZbBsnNFFCxVA3OKdl2NoH8ak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JCmxSBdwgJzV6Aq7VON/EXmroI0DpTTKP6YRWJ69yJOGRxgwLAKjZBJasKT0PNrqzd
         CR4K12Ia1+ru3s/WUq+VN69fxB6f/C3PFxQVkn4aBL6zAMqNrgmh2GUkihPlPInmiQmp
         YTx0ZAeMZ6R0j4M4FzEnaep2ceNTGqh9Y+iRc=
Received: by 10.220.199.74 with SMTP id er10mr55374vcb.12.1297732085499;
        Mon, 14 Feb 2011 17:08:05 -0800 (PST)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id u14sm1022114vcr.25.2011.02.14.17.08.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 17:08:04 -0800 (PST)
X-Mailer: git-send-email 1.7.4.5.g9affb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166805>

When a merge is stopped due to conflicts or --no-commit, the
subsequent commit calls the prepare-commit-msg hook. However,
it is not called after a clean merge. Fix this inconsistency
by invoking the hook after clean merges as well.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
I sent this out previously as an RFC:

  http://thread.gmane.org/gmane.comp.version-control.git/151297

But never prepared a proper patch. Here it is.

 builtin/merge.c                    |   38 ++++++++++++++++++++++++++++-------
 t/t7505-prepare-commit-msg-hook.sh |   12 +++++++++++
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 42fff38..83389ed 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -795,6 +795,33 @@ static void add_strategies(const char *string, unsigned attr)
 
 }
 
+static void write_merge_msg(void)
+{
+	int fd = open(git_path("MERGE_MSG"), O_WRONLY | O_CREAT, 0666);
+	if (fd < 0)
+		die_errno("Could not open '%s' for writing",
+			  git_path("MERGE_MSG"));
+	if (write_in_full(fd, merge_msg.buf, merge_msg.len) !=
+		merge_msg.len)
+		die_errno("Could not write to '%s'", git_path("MERGE_MSG"));
+	close(fd);
+}
+
+static void read_merge_msg(void)
+{
+	strbuf_reset(&merge_msg);
+	if (strbuf_read_file(&merge_msg, git_path("MERGE_MSG"), 0) < 0)
+		die_errno("Could not read from '%s'", git_path("MERGE_MSG"));
+}
+
+static void run_prepare_commit_msg(void)
+{
+	write_merge_msg();
+	run_hook(get_index_file(), "prepare-commit-msg",
+		 git_path("MERGE_MSG"), "merge", NULL, NULL);
+	read_merge_msg();
+}
+
 static int merge_trivial(void)
 {
 	unsigned char result_tree[20], result_commit[20];
@@ -806,6 +833,7 @@ static int merge_trivial(void)
 	parent->next = xmalloc(sizeof(*parent->next));
 	parent->next->item = remoteheads->item;
 	parent->next->next = NULL;
+	run_prepare_commit_msg();
 	commit_tree(merge_msg.buf, result_tree, parent, result_commit, NULL);
 	finish(result_commit, "In-index merge");
 	drop_save();
@@ -835,6 +863,7 @@ static int finish_automerge(struct commit_list *common,
 	}
 	free_commit_list(remoteheads);
 	strbuf_addch(&merge_msg, '\n');
+	run_prepare_commit_msg();
 	commit_tree(merge_msg.buf, result_tree, parents, result_commit, NULL);
 	strbuf_addf(&buf, "Merge made by %s.", wt_strategy);
 	finish(result_commit, buf.buf);
@@ -1316,14 +1345,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			die_errno("Could not write to '%s'", git_path("MERGE_HEAD"));
 		close(fd);
 		strbuf_addch(&merge_msg, '\n');
-		fd = open(git_path("MERGE_MSG"), O_WRONLY | O_CREAT, 0666);
-		if (fd < 0)
-			die_errno("Could not open '%s' for writing",
-				  git_path("MERGE_MSG"));
-		if (write_in_full(fd, merge_msg.buf, merge_msg.len) !=
-			merge_msg.len)
-			die_errno("Could not write to '%s'", git_path("MERGE_MSG"));
-		close(fd);
+		write_merge_msg();
 		fd = open(git_path("MERGE_MODE"), O_WRONLY | O_CREAT | O_TRUNC, 0666);
 		if (fd < 0)
 			die_errno("Could not open '%s' for writing",
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index ff18962..5b4b694 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -132,6 +132,18 @@ test_expect_success 'with hook (-c)' '
 
 '
 
+test_expect_success 'with hook (merge)' '
+
+	head=`git rev-parse HEAD` &&
+	git checkout -b other HEAD@{1} &&
+	echo "more" >> file &&
+	git add file &&
+	git commit -m other &&
+	git checkout - &&
+	git merge other &&
+	test "`git log -1 --pretty=format:%s`" = merge
+'
+
 cat > "$HOOK" <<'EOF'
 #!/bin/sh
 exit 1
-- 
1.7.4.5.g9affb
