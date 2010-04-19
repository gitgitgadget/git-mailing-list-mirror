From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v3 3/3] receive-pack: detect aliased updates which can occur with symrefs
Date: Mon, 19 Apr 2010 18:08:32 -0400
Message-ID: <1271714912-56659-4-git-send-email-jaysoffian@gmail.com>
References: <1271714912-56659-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	"Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junio@kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 20 00:09:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3z9h-0005uP-KJ
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 00:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698Ab0DSWJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 18:09:20 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53241 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab0DSWJS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 18:09:18 -0400
Received: by mail-gw0-f46.google.com with SMTP id 19so429991gwj.19
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 15:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=owkD3st7iguVOt8cW8CkAq8jAgXDu6JCMlYRXW4GBeE=;
        b=GWyZHmARgzlnHbJ1Euz4YgOce/I2g6bUwRMRTjGsmdsJ8lO2OEFoA13dCgCaEkF85R
         bg8gs6PzLfGjUYrIXV6LTEDJFZAxwmylsQX8cBM17K6MOwZDBkwRf39epYjon9CnsDrx
         Q/QQ+X4Q/jDHDE/AABAaFGomdgj4OL3oeNoNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=I86GTXGPUe24Hxq5nEICAKFGpIhF8SvV0XraEeYXt7VoJEBvM2KIDkCR7Ou9z6lAh2
         /WlGoRPN6+vhiBUNUJGjVCCB3f3gFVjFbXDOeva91HC4h8H34gDJNeRBL2yKX6edvb6R
         Vxn7+SZDY+Mmxc2wan2pJ6xM/jbtZYmEO0Ttc=
Received: by 10.101.149.17 with SMTP id b17mr15097688ano.80.1271714954413;
        Mon, 19 Apr 2010 15:09:14 -0700 (PDT)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id y2sm49670116ani.14.2010.04.19.15.09.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 15:09:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.436.g2b878
In-Reply-To: <1271714912-56659-1-git-send-email-jaysoffian@gmail.com>
In-Reply-To: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
References: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145337>

When pushing to a remote repo the sending side filters out aliased
updates (e.g., foo:baz bar:baz). However, it is not possible for the
sender to know if two refs are aliased on the receiving side via
symrefs. Here is one such scenario:

  $ git init origin
  $ (cd origin && touch file && git add file && git commit -a -m intial)
  $ git clone --bare origin origin.git
  $ rm -rf origin

  $ git clone origin.git client

  $ git clone --mirror client backup.git &&
  $ (cd backup.git && git remote set-head origin --auto)

  $ (cd client &&
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
  error: Ref refs/remotes/origin/master is at ef3... but expected 262...
  remote: error: failed to lock refs/remotes/origin/master
  To ../backup.git
     262cd57..ef307ff  master -> master
     262cd57..ef307ff  origin/HEAD -> origin/HEAD
   ! [remote rejected] origin/master -> origin/master (failed to lock)
  error: failed to push some refs to '../backup.git'

The reason is that refs/remotes/origin/HEAD is a symref to
refs/remotes/origin/master, but it is not possible for the sending side
to unambiguously know this.

This commit fixes the issue by having receive-pack ignore any update to
a symref whose target is being identically updated. If a symref and its
target are being updated inconsistently, then the update for both fails
with an error message ("refusing inconsistent update...") to help
diagnose the situation.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-receive-pack.c |   68 +++++++++++++++++++++++++++++++++++++++++++++---
 t/t5516-fetch-push.sh  |   49 ++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index fffb6ea..bb34757 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -9,6 +9,7 @@
 #include "object.h"
 #include "remote.h"
 #include "transport.h"
+#include "string-list.h"
 
 static const char receive_pack_usage[] = "git receive-pack <git-dir>";
 
@@ -129,6 +130,7 @@ static void write_head_info(void)
 struct command {
 	struct command *next;
 	const char *error_string;
+	unsigned int skip_update;
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
 	char ref_name[FLEX_ARRAY]; /* more */
@@ -486,6 +488,63 @@ static void run_update_post_hook(struct command *commands)
 	}
 }
 
+static void check_aliased_update(struct command *cmd, struct string_list *list)
+{
+	struct string_list_item *item;
+	struct command *dst_cmd;
+	unsigned char sha1[20];
+	char cmd_oldh[41], cmd_newh[41], dst_oldh[41], dst_newh[41];
+	int flag;
+
+	const char *dst_name = resolve_ref(cmd->ref_name, sha1, 0, &flag);
+
+	if (!(flag & REF_ISSYMREF))
+		return;
+
+	if ((item = string_list_lookup(dst_name, list)) == NULL)
+		return;
+
+	cmd->skip_update = 1;
+
+	dst_cmd = (struct command *) item->util;
+
+	if (!hashcmp(cmd->old_sha1, dst_cmd->old_sha1) &&
+	    !hashcmp(cmd->new_sha1, dst_cmd->new_sha1))
+		return;
+
+	dst_cmd->skip_update = 1;
+
+	strcpy(cmd_oldh, find_unique_abbrev(cmd->old_sha1, DEFAULT_ABBREV));
+	strcat(cmd_newh, find_unique_abbrev(cmd->new_sha1, DEFAULT_ABBREV));
+	strcpy(dst_oldh, find_unique_abbrev(dst_cmd->old_sha1, DEFAULT_ABBREV));
+	strcat(dst_newh, find_unique_abbrev(dst_cmd->new_sha1, DEFAULT_ABBREV));
+	rp_error("refusing inconsistent update between symref '%s' (%s..%s) and"
+		 " its target '%s' (%s..%s)",
+		 cmd->ref_name, cmd_oldh, cmd_newh,
+		 dst_cmd->ref_name, dst_oldh, dst_newh);
+
+	cmd->error_string = dst_cmd->error_string =
+		"inconsistent aliased update";
+}
+
+static void check_aliased_updates(struct command *commands)
+{
+	struct command *cmd;
+	struct string_list ref_list = { NULL, 0, 0, 0 };
+
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		struct string_list_item *item =
+			string_list_append(cmd->ref_name, &ref_list);
+		item->util = (void *)cmd;
+	}
+	sort_string_list(&ref_list);
+
+	for (cmd = commands; cmd; cmd = cmd->next)
+		check_aliased_update(cmd, &ref_list);
+
+	string_list_clear(&ref_list, 0);
+}
+
 static void execute_commands(struct command *commands, const char *unpacker_error)
 {
 	struct command *cmd;
@@ -503,10 +562,13 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
 		return;
 	}
 
+	check_aliased_updates(commands);
+
 	head_name = resolve_ref("HEAD", sha1, 0, NULL);
 
 	for (cmd = commands; cmd; cmd = cmd->next)
-		cmd->error_string = update(cmd);
+		if (!cmd->skip_update)
+			cmd->error_string = update(cmd);
 }
 
 static struct command *read_head_info(void)
@@ -541,12 +603,10 @@ static struct command *read_head_info(void)
 			if (strstr(refname + reflen + 1, "side-band-64k"))
 				use_sideband = LARGE_PACKET_MAX;
 		}
-		cmd = xmalloc(sizeof(struct command) + len - 80);
+		cmd = xcalloc(1, sizeof(struct command) + len - 80);
 		hashcpy(cmd->old_sha1, old_sha1);
 		hashcpy(cmd->new_sha1, new_sha1);
 		memcpy(cmd->ref_name, line + 82, len - 81);
-		cmd->error_string = NULL;
-		cmd->next = NULL;
 		*p = cmd;
 		p = &cmd->next;
 	}
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 3148789..f0813e0 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -683,4 +683,53 @@ test_expect_success 'push with branches containing #' '
 	git checkout master
 '
 
+test_expect_success 'push into aliased refs (consistent)' '
+	mk_test heads/master &&
+	mk_child child1 &&
+	mk_child child2 &&
+	(
+		cd child1 &&
+		git branch foo &&
+		git symbolic-ref refs/heads/bar refs/heads/foo
+		git config receive.denyCurrentBranch false
+	) &&
+	(
+		cd child2 &&
+		>path2 &&
+		git add path2 &&
+		test_tick &&
+		git commit -a -m child2 &&
+		git branch foo &&
+		git branch bar &&
+		git push ../child1 foo bar
+	)
+'
+
+test_expect_success 'push into aliased refs (inconsistent)' '
+	mk_test heads/master &&
+	mk_child child1 &&
+	mk_child child2 &&
+	(
+		cd child1 &&
+		git branch foo &&
+		git symbolic-ref refs/heads/bar refs/heads/foo
+		git config receive.denyCurrentBranch false
+	) &&
+	(
+		cd child2 &&
+		>path2 &&
+		git add path2 &&
+		test_tick &&
+		git commit -a -m child2 &&
+		git branch foo &&
+		>path3 &&
+		git add path3 &&
+		test_tick &&
+		git commit -a -m child2 &&
+		git branch bar &&
+		test_must_fail git push ../child1 foo bar 2>stderr &&
+		grep "refusing inconsistent update" stderr
+	)
+'
+
 test_done
-- 
1.7.0.3.436.g2b878
