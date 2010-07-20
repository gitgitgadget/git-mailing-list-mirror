From: Jay Soffian <jaysoffian@gmail.com>
Subject: [RFC/PATCH] merge: honor prepare-commit-msg hook
Date: Tue, 20 Jul 2010 00:29:04 -0400
Message-ID: <1279600144-89629-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 20 06:29:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ob4SG-0003zb-NL
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 06:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271Ab0GTE3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 00:29:15 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59818 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228Ab0GTE3O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 00:29:14 -0400
Received: by gwj18 with SMTP id 18so2368002gwj.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 21:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=HAdMjQNF6UNpvW4LQURG2HM+7aecRnN/l41eIKUXP7E=;
        b=GOZMuQ+c+f1B116XY8h0dSGK8eI4pmnToRfn2mP8g4nZ1B4oElCkPl7aqNMsgXzGOS
         3gpWUKMdre8QZiXErqQBipeFOX4aj275GsMQqRWfrbnhmkP2KPdNHCl7wpmpf+HAO7de
         1rYAFX6QBJkLQ9rUGU/06MCFNe4yFnMfo/tXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XLSeaHzWBQ0LqFR999vILMw0wfgH6vMQ5ONEg0xe5fqJcYX+gkMkWRzg4V/JPeHhLf
         0pZ6jcgAhxpH8fuWJ6hveNIC3Zh0DWlY/wi8pfGKeTCjyFFtDZSaqzO7QT4SrCpzpkJg
         D/336Hy/7nRpwCZFsrVuqkroVTTZf/+fsf6j8=
Received: by 10.150.181.3 with SMTP id d3mr6007626ybf.63.1279600153162;
        Mon, 19 Jul 2010 21:29:13 -0700 (PDT)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id m11sm6326526ybn.4.2010.07.19.21.29.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 21:29:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.53.g670aa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151297>

---
I couldn't figure out why my prepare-commit-msg wasn't being honored
by git merge. I assumed that the standard commit hooks would be honored,
as after-all, merge is creating a new commit. Alas, this is not the case
since merge calls commit_tree directly.

I wonder whether the low-level commit_tree should be responsible for
invoking this hook instead of the commit porcelain?

In any case, this does what I want, but I'm not sure it's the best approach.

Comments?

 builtin/merge.c |   38 ++++++++++++++++++++++++++++++--------
 1 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 37ce4f5..28a9960 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -768,6 +768,33 @@ static void add_strategies(const char *string, unsigned attr)
 
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
@@ -779,6 +806,7 @@ static int merge_trivial(void)
 	parent->next = xmalloc(sizeof(*parent->next));
 	parent->next->item = remoteheads->item;
 	parent->next->next = NULL;
+	run_prepare_commit_msg();
 	commit_tree(merge_msg.buf, result_tree, parent, result_commit, NULL);
 	finish(result_commit, "In-index merge");
 	drop_save();
@@ -808,6 +836,7 @@ static int finish_automerge(struct commit_list *common,
 	}
 	free_commit_list(remoteheads);
 	strbuf_addch(&merge_msg, '\n');
+	run_prepare_commit_msg();
 	commit_tree(merge_msg.buf, result_tree, parents, result_commit, NULL);
 	strbuf_addf(&buf, "Merge made by %s.", wt_strategy);
 	finish(result_commit, buf.buf);
@@ -1276,14 +1305,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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
-- 
1.7.2.rc3.53.g670aa
