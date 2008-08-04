From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH] Add output flushing before fork()
Date: Mon,  4 Aug 2008 12:18:40 +0200
Message-ID: <1217845120-28134-1-git-send-email-mail@cup.kalibalik.dk>
References: <alpine.LFD.1.10.0808032241260.3668@nehalem.linux-foundation.org>
Cc: git@vger.kernel.org, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 04 12:19:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPxAH-0003Oe-9u
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 12:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbYHDKSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 06:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbYHDKSo
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 06:18:44 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:57896 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752190AbYHDKSn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 06:18:43 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 9025014062;
	Mon,  4 Aug 2008 12:18:40 +0200 (CEST)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 648941405A;
	Mon,  4 Aug 2008 12:18:40 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <alpine.LFD.1.10.0808032241260.3668@nehalem.linux-foundation.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91339>

This adds fflush(NULL) before fork() in start_command(), to keep
the generic interface safe.

A remaining use of fork() with no flushing is in a comment in
show_tree(). Rewrite that comment to use start_command().

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---

This fixes up the remaining two spots that Linus suggested.


 builtin-ls-tree.c |   13 ++++++-------
 run-command.c     |    1 +
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index d25767a..cb61717 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -66,17 +66,16 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
 		/*
 		 * Maybe we want to have some recursive version here?
 		 *
-		 * Something like:
+		 * Something similar to this incomplete example:
 		 *
 		if (show_subprojects(base, baselen, pathname)) {
-			if (fork()) {
-				chdir(base);
-				exec ls-tree;
-			}
-			waitpid();
+			struct child_process ls_tree;
+
+			ls_tree.dir = base;
+			ls_tree.argv = ls-tree;
+			start_command(&ls_tree);
 		}
 		 *
-		 * ..or similar..
 		 */
 		type = commit_type;
 	} else if (S_ISDIR(mode)) {
diff --git a/run-command.c b/run-command.c
index 6af83c5..bbb9c77 100644
--- a/run-command.c
+++ b/run-command.c
@@ -68,6 +68,7 @@ int start_command(struct child_process *cmd)
 	trace_argv_printf(cmd->argv, "trace: run_command:");
 
 #ifndef __MINGW32__
+	fflush(NULL);
 	cmd->pid = fork();
 	if (!cmd->pid) {
 		if (cmd->no_stdin)
-- 
1.5.6.4
