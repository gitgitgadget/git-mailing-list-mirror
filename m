From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] transport-helper: check when helpers fail
Date: Sun, 21 Oct 2012 21:19:18 +0200
Message-ID: <1350847158-14154-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 21:19:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ13p-0001RO-Nr
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 21:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448Ab2JUTTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 15:19:30 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:44686 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423Ab2JUTT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 15:19:28 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so1089935wey.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=8xbplBVM9YjmpJZ+3AfW6CYkzW9FtwKn5+VZjNTtFsk=;
        b=NnB9PXBXsIrL4Cfri9IoPH8KXwg92F1KNNvaugNRk0BhzOwGLZO+B5biAYXLb33GA8
         axeEbnBZZIIqAd7scEZLkJBKXuNmhefZnn/GqkElfOlgdg8L51Ks7bJG2xs7C68J3pyn
         gsYsmRl+O083eS8nG66IosZkfbc9hG8yvT28Wu/j3uVs2Wp6CujEo8yA6J6UKgBOGFPp
         np+99uvlKe2d5x+2hAMmtaXgn5DkzqDbaz/sdvweEKCXCJHrUVqtMteiQDjplteQ0i3g
         9w60HQ1k4d8HPU05yqigEuUUivLXBFNNQCXHUPWgyTUMJKuc8K1hESr0kmx79qFeH+5O
         +8Rw==
Received: by 10.180.100.97 with SMTP id ex1mr16152017wib.17.1350847167573;
        Sun, 21 Oct 2012 12:19:27 -0700 (PDT)
Received: from localhost (ip-109-43-0-67.web.vodafone.de. [109.43.0.67])
        by mx.google.com with ESMTPS id p4sm17569510wix.0.2012.10.21.12.19.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Oct 2012 12:19:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208139>

Otherwise transport-helper will continue checking for refs and other
things what will confuse the user more.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-testgit.py     |  3 +++
 run-command.c             | 17 +++++++++++++++++
 run-command.h             |  1 +
 t/t5800-remote-helpers.sh |  6 ++++++
 transport-helper.c        |  8 ++++++++
 5 files changed, 35 insertions(+)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 5f3ebd2..355e3f5 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -159,6 +159,9 @@ def do_import(repo, args):
         ref = line[7:].strip()
         refs.append(ref)
 
+    if os.environ.get("GIT_REMOTE_TESTGIT_FAILURE"):
+        die('Told to fail')
+
     repo = update_local_repo(repo)
     repo.exporter.export_repo(repo.gitdir, refs)
 
diff --git a/run-command.c b/run-command.c
index 1101ef7..2852e9d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -559,6 +559,23 @@ int run_command(struct child_process *cmd)
 	return finish_command(cmd);
 }
 
+int check_command(struct child_process *cmd)
+{
+	int status;
+	pid_t pid;
+
+	pid = waitpid(cmd->pid, &status, WNOHANG);
+
+	if (pid < 0)
+		return -1;
+	if (WIFSIGNALED(status))
+		return WTERMSIG(status);
+	if (WIFEXITED(status))
+		return WEXITSTATUS(status);
+
+	return 0;
+}
+
 static void prepare_run_command_v_opt(struct child_process *cmd,
 				      const char **argv,
 				      int opt)
diff --git a/run-command.h b/run-command.h
index 44f7d2b..9019e38 100644
--- a/run-command.h
+++ b/run-command.h
@@ -45,6 +45,7 @@ struct child_process {
 int start_command(struct child_process *);
 int finish_command(struct child_process *);
 int run_command(struct child_process *);
+int check_command(struct child_process *cmd);
 
 extern int run_hook(const char *index_file, const char *name, ...);
 
diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index e7dc668..d4b17ae 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -145,4 +145,10 @@ test_expect_failure 'push new branch with old:new refspec' '
 	compare_refs clone HEAD server refs/heads/new-refspec
 '
 
+test_expect_success 'proper failure checks' '
+	export GIT_REMOTE_TESTGIT_FAILURE=1 &&
+	! git clone "testgit::$PWD/server" failure 2> errors &&
+	grep -q "Error while running helper" errors
+'
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index cfe0988..fbd923d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -441,6 +441,10 @@ static int fetch_with_import(struct transport *transport,
 
 	if (finish_command(&fastimport))
 		die("Error while running fast-import");
+
+	if (check_command(data->helper))
+		die("Error while running helper");
+
 	free(fastimport.argv);
 	fastimport.argv = NULL;
 
@@ -784,6 +788,10 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
+
+	if (check_command(data->helper))
+		die("Error while running helper");
+
 	push_update_refs_status(data, remote_refs);
 	return 0;
 }
-- 
1.8.0.rc2
