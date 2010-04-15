From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 2/2] receive-pack: ignore duplicated commands which can occur with symrefs
Date: Thu, 15 Apr 2010 16:54:08 -0400
Message-ID: <1271364848-32805-2-git-send-email-jaysoffian@gmail.com>
References: <1271364848-32805-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 15 22:55:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2W5Z-0005ct-Dr
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 22:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756877Ab0DOUyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 16:54:54 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:33902 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793Ab0DOUyx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 16:54:53 -0400
Received: by gxk9 with SMTP id 9so1038660gxk.8
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lHih7IhMO4kjwEwpRhHrnaDyw80vC5uYUATIdFGpUGk=;
        b=qcftFbN+ryaIRTtlSC7Xs3y+qbXOHM9WJoBzrv5NBzeMEdc6WvUi9tti75r7wqzQD8
         b4qk7f9oWGfsJ5nIGR7aWJMLOoosk6L7wAIMmka2NsqEp0+iOc6elHJSGP/tGmm8FYXD
         rW2QuluH+95eoLFnhHbuRGpLB3OcsY+BEH/Dg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dC5mUF1XaupiwliFJPcUZdnOxQ9awwz8ZdImgUR9lSIArg985GHCsXJTJ7EZCxMUfT
         PTZDk7FSmA+hbKK1I8NOVsDvUqQlXhkFDlDkj+j/TMsSbAbGZiErP1OPLraL2Jq5MEqQ
         zlvpF/ueAZWrJnfD63SnPvY1vQO0JDiRuC1Jo=
Received: by 10.101.152.34 with SMTP id e34mr1035031ano.240.1271364891797;
        Thu, 15 Apr 2010 13:54:51 -0700 (PDT)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id r21sm4822421anp.7.2010.04.15.13.54.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 13:54:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.436.g2b878
In-Reply-To: <1271364848-32805-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145023>

When pushing to a remote repo, normally the sending side tries to
filter out any aliased updates (e.g, foo:baz bar:baz). However, it
is impossible for the sender to know if two refs are aliased on the
receiving side via symrefs. Here is one such scenario:

$ git init origin
(cd origin && touch file && git add file && git commit -a -m intial)
git clone --bare origin origin.git
rm -rf origin

git clone origin.git client

git clone --mirror client backup.git &&
(cd backup.git && git remote set-head origin --auto)

(cd client &&
	git remote add --mirror backup ../backup.git &&
	echo change1 > file && git commit -a -m change1 &&
	git push origin &&
	git push backup
)

The push to backup fails with:

Counting objects: 5, done.
Writing objects: 100% (3/3), 244 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
error: Ref refs/remotes/origin/master is at ef307ff6d0026900f84bae7bfe2f5d695238ca66 but expected 262cd5762e76e0aca2c185a3995095318772e2f2
remote: error: failed to lock refs/remotes/origin/master
To ../backup.git
   262cd57..ef307ff  master -> master
   262cd57..ef307ff  origin/HEAD -> origin/HEAD
 ! [remote rejected] origin/master -> origin/master (failed to lock)
error: failed to push some refs to '../backup.git'

The reason is that refs/remotes/origin/HEAD is a symref to
refs/remotes/origin/master, but it is impossible for the sending
side to unambiguously know this in all cases.

This commit fixes the issue by having receive pack ignore updates to
any symrefs IFF the target of the symref is being identically
updated.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin/receive-pack.c |   35 +++++++++++++++++++++++++++++++++--
 t/t5516-fetch-push.sh  |   20 ++++++++++++++++++++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 3fc73cf..a2e3bc8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -9,6 +9,7 @@
 #include "object.h"
 #include "remote.h"
 #include "transport.h"
+#include "string-list.h"
 
 static const char receive_pack_usage[] = "git receive-pack <git-dir>";
 
@@ -486,10 +487,30 @@ static void run_update_post_hook(struct command *commands)
 	}
 }
 
+static int aliased_ref(struct command *cmd, struct string_list *list)
+{
+	struct string_list_item *item;
+	unsigned char sha1[20];
+	int flag;
+
+	const char *dst_name = resolve_ref(cmd->ref_name, sha1, 0, &flag);
+
+	if (!(flag & REF_ISSYMREF))
+		return 0;
+
+	if ((item = string_list_lookup(dst_name, list)) != NULL) {
+		struct command *other_cmd = (struct command *) item->util;
+		return (!(hashcmp(cmd->old_sha1, other_cmd->old_sha1) &&
+			hashcmp(cmd->new_sha1, other_cmd->new_sha1)));
+	}
+	return 0;
+}
+
 static void execute_commands(struct command *commands, const char *unpacker_error)
 {
 	struct command *cmd;
 	unsigned char sha1[20];
+	struct string_list ref_list = { NULL, 0, 0, 0 };
 
 	if (unpacker_error) {
 		for (cmd = commands; cmd; cmd = cmd->next)
@@ -505,8 +526,18 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
 
 	head_name = resolve_ref("HEAD", sha1, 0, NULL);
 
-	for (cmd = commands; cmd; cmd = cmd->next)
-		cmd->error_string = update(cmd);
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		struct string_list_item *item =
+			string_list_append(cmd->ref_name, &ref_list);
+		item->util = (void *)cmd;
+	}
+	sort_string_list(&ref_list);
+
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		if (!aliased_ref(cmd, &ref_list))
+			cmd->error_string = update(cmd);
+	}
+	string_list_clear(&ref_list, 0);
 }
 
 static struct command *read_head_info(void)
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 2de98e6..c384529 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -660,6 +660,26 @@ test_expect_success 'push with branches containing #' '
 	git checkout master
 '
 
+test_expect_success 'push into aliased refs' '
+	mk_test heads/master &&
+	mk_child child1 &&
+	mk_child child2 &&
+	(cd child1 &&
+		git branch foo &&
+		git symbolic-ref refs/heads/bar refs/heads/foo
+		git config receive.denyCurrentBranch false
+	) &&
+	(cd child2 &&
+		: >path2 &&
+		git add path2 &&
+		test_tick &&
+		git commit -a -m child2 &&
+		git branch foo &&
+		git branch bar &&
+		git push ../child1 foo bar
+	)
+'
+
 test_expect_success 'push --porcelain' '
 	mk_empty &&
 	echo >.git/foo  "To testrepo" &&
-- 
1.7.0.3.436.g2b878
