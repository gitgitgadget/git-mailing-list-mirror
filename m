From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] Fix start_command closing cmd->out/in regardless of cmd->close_out/in
Date: Tue, 20 Nov 2007 04:12:54 +0800
Message-ID: <1195503174-29387-1-git-send-email-pkufranky@gmail.com>
Cc: Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 21:17:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuD3T-0007xN-Ev
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 21:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbXKSUQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 15:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbXKSUQz
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 15:16:55 -0500
Received: from mail.qikoo.org ([60.28.205.235]:57197 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751375AbXKSUQy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 15:16:54 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id C499447067; Tue, 20 Nov 2007 04:12:54 +0800 (CST)
X-Mailer: git-send-email 1.5.3.5.1878.gb1da0-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65495>

When the file descriptor of 'FILE *fp' is assigned to child_process.out
and then start_command or run_command is run, the standard output of the
child process is expected to be outputed to fp.

start_command will always close fp in this case. However, sometimes fp is
not expected to be closed since further IO may be still performmed on fp.

This patch disables the auto closing behavious of start_command
and corrects all codes which depend on this kind of behaviour.

Following is a case that the auto closing behaviour is not expected.

When adding submodule summary feature to builtin-commit, in wt_status_print,
I want to output the submodule summary between changed and untracked files
as the following patch shows
        wt_status_print_changed(s);
+       wt_status_print_submodule_summary(s);
        wt_status_print_untracked(s);

All the three calls will output to s->fp (which points to a file instead of
standard output when doing committing). So I don't want s->fp to be closed after
wt_status_print_submodule_summary(s) which calls run_command.

+static void wt_status_print_submodule_summary(struct wt_status *s)
+{
+       struct child_process sm_summary;
+       memset(&sm_summary, 0, sizeof(sm_summary));
+       ...
+       sm_summary.out = fileno(s->fp);
+       ...
+       run_command(&sm_summary);
+}

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 bundle.c      |    1 +
 convert.c     |    1 +
 run-command.c |    4 ----
 upload-pack.c |    3 ++-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/bundle.c b/bundle.c
index e4d60cd..fc253fb 100644
--- a/bundle.c
+++ b/bundle.c
@@ -336,6 +336,7 @@ int unbundle(struct bundle_header *header, int bundle_fd)
 	memset(&ip, 0, sizeof(ip));
 	ip.argv = argv_index_pack;
 	ip.in = bundle_fd;
+	ip.close_in = 1;
 	ip.no_stdout = 1;
 	ip.git_cmd = 1;
 	if (run_command(&ip))
diff --git a/convert.c b/convert.c
index 4df7559..ce7bed0 100644
--- a/convert.c
+++ b/convert.c
@@ -212,6 +212,7 @@ static int filter_buffer(int fd, void *data)
 	child_process.argv = argv;
 	child_process.in = -1;
 	child_process.out = fd;
+	child_process.close_out = 1;
 
 	if (start_command(&child_process))
 		return error("cannot fork to run external filter %s", params->cmd);
diff --git a/run-command.c b/run-command.c
index 476d00c..4e5f58d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -115,13 +115,9 @@ int start_command(struct child_process *cmd)
 
 	if (need_in)
 		close(fdin[0]);
-	else if (cmd->in)
-		close(cmd->in);
 
 	if (need_out)
 		close(fdout[1]);
-	else if (cmd->out > 1)
-		close(cmd->out);
 
 	if (need_err)
 		close(fderr[1]);
diff --git a/upload-pack.c b/upload-pack.c
index 7e04311..7aeda80 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -163,7 +163,8 @@ static void create_pack_file(void)
 	argv[arg++] = NULL;
 
 	memset(&pack_objects, 0, sizeof(pack_objects));
-	pack_objects.in = rev_list.out;	/* start_command closes it */
+	pack_objects.in = rev_list.out;	
+	pack_objects.close_in = 1; /* finish_command closes rev_list.out */
 	pack_objects.out = -1;
 	pack_objects.err = -1;
 	pack_objects.git_cmd = 1;
-- 
1.5.3.5.1878.gb1da0-dirty
