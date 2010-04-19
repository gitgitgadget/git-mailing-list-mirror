From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2 2/2] receive-pack: detect aliased updates which can occur with symrefs
Date: Mon, 19 Apr 2010 12:39:39 -0400
Message-ID: <1271695179-32131-1-git-send-email-jaysoffian@gmail.com>
References: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 19 18:39:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3u0q-0002TB-7R
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 18:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076Ab0DSQju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 12:39:50 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:53340 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab0DSQju (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 12:39:50 -0400
Received: by gxk9 with SMTP id 9so3189260gxk.8
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YSFXin3wWgnpXfnnUNeT5055y2GNbQvmEm1XP2Pacoc=;
        b=PnndjD4Ev/x5AzvdsfLdtqt4pEykZiLdER1H3iKy4XA1v7AYGDAkvDEzFaegu/1ELB
         FfGOqbDxYYtmFU6WjeuED1FOYMPoNtt5cgwLrAO1mwUgolRCw8w2a83XUao5WaqHFKV8
         PhPLJLVUQcIameaIuZIT+SdfyPnLxc0sk8rMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gKHZGpJ0DCX2Q0Df7iq3JoIFWXgKrez1FxGulzUE5yQI8LUmBH3vU4TGPG44ya4pvn
         Y8vSE40xLofZ1xH2N4qfMk2PAZtBhw8oxtvIkO8WmSiij5GjvLSgMhZxeOQDQl/xcqcX
         6Fjs2R4x93rTXck5AjbkRUMLHTRXD+dQLvRy4=
Received: by 10.100.18.33 with SMTP id 33mr12484585anr.163.1271695185267;
        Mon, 19 Apr 2010 09:39:45 -0700 (PDT)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id 26sm47736191anx.13.2010.04.19.09.39.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 09:39:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.436.g2b878
In-Reply-To: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145316>

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
 builtin/receive-pack.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++-
 t/t5516-fetch-push.sh  |   45 +++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 1 deletions(-)

Changes from v1 (incorporating Junio's feedback):
- Reformatted commit message; minor rewording.
- Detect situation where there is an inconsistent aliased update and
  give a better diagnostic than "failed to lock"
- Add additional test case for inconsistent update situation

[
This one is correct, the interdiff from
<1271694343-31876-2-git-send-email-jaysoffian@gmail.com> is

  diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
  index 414446b..7b269d2 100644
  --- a/builtin/receive-pack.c
  +++ b/builtin/receive-pack.c
  @@ -512,6 +512,8 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
   	    !hashcmp(cmd->new_sha1, dst_cmd->new_sha1))
   		return;
   
  +	dst_cmd->skip_update = 1;
  +
   	strcpy(cmd_oldh, find_unique_abbrev(cmd->old_sha1, DEFAULT_ABBREV));
   	strcat(cmd_newh, find_unique_abbrev(cmd->new_sha1, DEFAULT_ABBREV));
   	strcpy(dst_oldh, find_unique_abbrev(dst_cmd->old_sha1, DEFAULT_ABBREV));
  )
]
  
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index fffb6ea..7b269d2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
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
@@ -503,9 +562,11 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
 		return;
 	}
 
+	check_aliased_updates(commands);
+
 	head_name = resolve_ref("HEAD", sha1, 0, NULL);
 
-	for (cmd = commands; cmd; cmd = cmd->next)
+	for (cmd = commands; cmd && !cmd->skip_update; cmd = cmd->next)
 		cmd->error_string = update(cmd);
 }
 
@@ -545,6 +606,7 @@ static struct command *read_head_info(void)
 		hashcpy(cmd->old_sha1, old_sha1);
 		hashcpy(cmd->new_sha1, new_sha1);
 		memcpy(cmd->ref_name, line + 82, len - 81);
+		cmd->skip_update = 0;
 		cmd->error_string = NULL;
 		cmd->next = NULL;
 		*p = cmd;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 2de98e6..bc3f24f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -660,6 +660,51 @@ test_expect_success 'push with branches containing #' '
 	git checkout master
 '
 
+test_expect_success 'push into aliased refs (consistent)' '
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
+test_expect_success 'push into aliased refs (inconsistent)' '
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
+		: >path3 &&
+		git add path3 &&
+		test_tick &&
+		git commit -a -m child2 &&
+		git branch bar &&
+		test_must_fail git push ../child1 foo bar 2>stderr &&
+		grep "refusing inconsistent update" stderr
+	)
+'
+
 test_expect_success 'push --porcelain' '
 	mk_empty &&
 	echo >.git/foo  "To testrepo" &&
-- 
1.7.0.3.436.g2b878
