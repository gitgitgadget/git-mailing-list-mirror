From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Wed, 19 Jun 2013 16:41:41 +0530
Message-ID: <1371640304-26019-4-git-send-email-artagnon@gmail.com>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 19 13:15:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpGM2-0003Jj-O8
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 13:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934387Ab3FSLPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 07:15:01 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:47696 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933666Ab3FSLO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 07:14:59 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so4996703pbb.28
        for <git@vger.kernel.org>; Wed, 19 Jun 2013 04:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Tcgwr4nwWZDoBoI6XXwhdQzxwXaN0apzG9QB9gxZ3MQ=;
        b=oXGbTRhlpLQHa+PC/3oiTBJHiQaR5Yi3D3DQNtPENUp5/We1on4J2IUbrJEW9HIWXB
         AIIg+TkO+q5BrNWShIpKkm7IIdyewvmRL+vGqnZGDQWcoIvQ6JNQtdukSZeCQJNOyNov
         iZ7CZJOXsfX/arbsAdT7JryZCGWsfBP9Vi/5GX4NquDEwInLYe2QG+/8FD4FTP5rGCb8
         SHgLlqH1yTYC2Pe9EvL2+sHLV7IAR3AK1G+t3uial2D66KKEAmtzooSZorRySKkDr5nA
         o0IYwokvwyLoRfkkED1Ic6lVOXQGlZLiykrkn+1ulGz3eA9ZJTINlkYEXCRN41CPM5Ol
         WD4Q==
X-Received: by 10.68.235.103 with SMTP id ul7mr2424568pbc.14.1371640499296;
        Wed, 19 Jun 2013 04:14:59 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id iq2sm22746579pbb.19.2013.06.19.04.14.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 04:14:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.454.gff6ba36
In-Reply-To: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228386>

When remote.pushdefault or branch.<name>.pushremote is set (a triangular
workflow feature), master@{u} != origin, and push.default is set to
`upstream` or `simple`:

  $ git push
  fatal: You are pushing to remote 'origin', which is not the upstream of
  your current branch 'master', without telling me what to push
  to update which remote branch.

Unfortunately, in the case of `upstream`, the very name indicates that
it is only suitable for use in central workflows; let us not even
attempt to give it a new meaning in triangular workflows, and error out
as usual.  However, the `simple` does not have this problem: it is
poised to be the default for Git 2.0, and we would definitely like it to
do something sensible in triangular workflows.

Decouple `simple` from `upstream` completely, and change it to mean
`current` with a safety feature: a `push` and `pull` should not be
asymmetrical in the special case of central workflows.

Reported-by: Leandro Lucarella <leandro.lucarella@sociomantic.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt | 10 ++++++----
 builtin/push.c           | 21 ++++++++++++++++++++-
 t/t5528-push-default.sh  |  2 +-
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9f04f74..81628e8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1850,10 +1850,12 @@ push.default::
   symmetrical to `pull` in central workflows, and cannot be used in
   non-central workflows.
 
-* `simple` - like `upstream`, but refuses to push if the upstream
-  branch's name is different from the local one. This is the safest
-  option and is well-suited for beginners. It will become the default
-  in Git 2.0.
+* `simple` - a safer version of `current`; push the current branch to
+  update a branch with the same name on the receiving end, with a
+  safety feature: in central workflows, error out if
+  branch.$branch.merge is set and not equal to $branch, to make sure
+  that a `push` and `push` are never asymmetrical.  It will become the
+  default in Git 2.0.
 
 * `matching` - push all branches having the same name on both ends
   (essentially ignoring all newly created local branches).
diff --git a/builtin/push.c b/builtin/push.c
index 2d84d10..d8d27d9 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -120,6 +120,25 @@ static const char message_detached_head_die[] =
 	   "\n"
 	   "    git push %s HEAD:<name-of-remote-branch>\n");
 
+static void setup_push_simple(struct remote *remote)
+{
+	struct branch *branch = branch_get(NULL);
+	if (!branch)
+		die(_(message_detached_head_die), remote->name);
+	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
+		/* No upstream configured */
+		goto end;
+	if (branch->merge_nr != 1)
+		die(_("The current branch %s has multiple upstream branches, "
+		    "refusing to push."), branch->name);
+	if (!strcmp(branch->remote_name, remote->name) &&
+		strcmp(branch->refname, branch->merge[0]->src))
+		/* Central workflow safety feature */
+		die_push_simple(branch, remote);
+end:
+	add_refspec(branch->name);
+}
+
 static void setup_push_upstream(struct remote *remote, int simple)
 {
 	struct strbuf refspec = STRBUF_INIT;
@@ -188,7 +207,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 		break;
 
 	case PUSH_DEFAULT_SIMPLE:
-		setup_push_upstream(remote, 1);
+		setup_push_simple(remote);
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 69ce6bf..e54dd02 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -85,7 +85,7 @@ test_expect_success 'push from/to new branch with current creates remote branch'
 test_expect_success 'push to existing branch, with no upstream configured' '
 	test_config branch.master.remote repo1 &&
 	git checkout master &&
-	test_push_failure simple &&
+	test_push_success simple master &&
 	test_push_failure upstream
 '
 
-- 
1.8.3.1.454.g30263f3.dirty
