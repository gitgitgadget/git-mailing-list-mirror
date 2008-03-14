From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] shortlog: do not require to run from inside a git
	repository
Date: Fri, 14 Mar 2008 22:35:24 +0100
Message-ID: <20080314213524.GA10085@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 23:01:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaHxg-0003lF-9N
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 23:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbYCNWAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 18:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbYCNWAd
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 18:00:33 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:32808 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488AbYCNWAc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 18:00:32 -0400
X-Greylist: delayed 1504 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Mar 2008 18:00:31 EDT
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 5012819BE17;
	Fri, 14 Mar 2008 22:35:26 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14111-06; Fri, 14 Mar 2008 22:35:24 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id E3C6419BDFE;
	Fri, 14 Mar 2008 22:35:24 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id EF50E6DF8B9; Fri, 14 Mar 2008 22:34:36 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id CE55D1DC479; Fri, 14 Mar 2008 22:35:24 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77292>

Once upon a time shortlog could be run from a non-git directory
and still do its job. Fix this regression and add a small test
for it.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 builtin-shortlog.c  |    4 +++-
 git.c               |    2 +-
 t/t4201-shortlog.sh |    5 +++++
 3 files changed, 9 insertions(+), 2 deletions(-)

 On top of next.

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index b22b0ed..bd795b1 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -229,7 +229,9 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 {
 	struct shortlog log;
 	struct rev_info rev;
+	int nongit;
 
+	prefix = setup_git_directory_gently(&nongit);
 	shortlog_init(&log);
 
 	/* since -n is a shadowed rev argument, parse our args first */
@@ -259,7 +261,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 		die ("unrecognized argument: %s", argv[1]);
 
 	/* assume HEAD if from a tty */
-	if (!rev.pending.nr && isatty(0))
+	if (!nongit && !rev.pending.nr && isatty(0))
 		add_head_to_pending(&rev);
 	if (rev.pending.nr == 0) {
 		read_from_stdin(&log);
diff --git a/git.c b/git.c
index 1e3eb10..13de801 100644
--- a/git.c
+++ b/git.c
@@ -343,7 +343,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "send-pack", cmd_send_pack, RUN_SETUP },
-		{ "shortlog", cmd_shortlog, RUN_SETUP | USE_PAGER },
+		{ "shortlog", cmd_shortlog, USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
 		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 91ea696..405b971 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -47,4 +47,9 @@ EOF
 
 test_expect_success 'shortlog wrapping' 'test_cmp expect out'
 
+git log HEAD > log
+GIT_DIR=non-existing git shortlog -w < log > out
+
+test_expect_success 'shortlog from non-git directory' 'test_cmp expect out'
+
 test_done
-- 
1.5.4.4.684.g0e08.dirty

-- 
Jonas Fonseca
