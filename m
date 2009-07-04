From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/7] Truncate result of run_command that is used in exit() to lowest 8 bits
Date: Sat,  4 Jul 2009 21:26:37 +0200
Message-ID: <b73cf4b4cd09f4225098e71182044f64e12380aa.1246734159.git.j6t@kdbg.org>
References: <cover.1246734159.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 21:27:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNAtl-00052P-BJ
	for gcvg-git-2@gmane.org; Sat, 04 Jul 2009 21:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbZGDT1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jul 2009 15:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbZGDT1f
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 15:27:35 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:17697 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551AbZGDT1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jul 2009 15:27:31 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1F90CA7EBA;
	Sat,  4 Jul 2009 21:27:33 +0200 (CEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7F22742784;
	Sat,  4 Jul 2009 21:27:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.17.g1665f
In-Reply-To: <cover.1246734159.git.j6t@kdbg.org>
In-Reply-To: <cover.1246734159.git.j6t@kdbg.org>
References: <cover.1246734159.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122724>

On Windows, negative return values are not detected reliably by the parent
process as failure. This fixes it.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 bisect.c      |    4 ++--
 builtin-add.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index 52220df..b395c47 100644
--- a/bisect.c
+++ b/bisect.c
@@ -760,7 +760,7 @@ static int bisect_checkout(char *bisect_rev_hex)
 	argv_checkout[2] = bisect_rev_hex;
 	res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
 	if (res)
-		exit(res);
+		exit(res & 0xff);
 
 	argv_show_branch[1] = bisect_rev_hex;
 	return run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
@@ -850,7 +850,7 @@ static void check_merge_bases(void)
 			handle_skipped_merge_base(mb);
 		} else {
 			printf("Bisecting: a merge base must be tested\n");
-			exit(bisect_checkout(sha1_to_hex(mb)));
+			exit(bisect_checkout(sha1_to_hex(mb)) & 0xff);
 		}
 	}
 
diff --git a/builtin-add.c b/builtin-add.c
index 4e44148..d83e67e 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -305,7 +305,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (patch_interactive)
 		add_interactive = 1;
 	if (add_interactive)
-		exit(interactive_add(argc - 1, argv + 1, prefix));
+		exit(interactive_add(argc - 1, argv + 1, prefix) & 0xff);
 
 	if (edit_interactive)
 		return(edit_patch(argc, argv, prefix));
-- 
1.6.3.17.g1665f
