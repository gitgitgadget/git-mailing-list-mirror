From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/6] receive-pack: default receive.denyDeleteCurrent to
 refuse
Date: Mon,  9 Feb 2009 01:09:25 -0800
Message-ID: <1234170565-6740-7-git-send-email-gitster@pobox.com>
References: <1234170565-6740-1-git-send-email-gitster@pobox.com>
 <1234170565-6740-2-git-send-email-gitster@pobox.com>
 <1234170565-6740-3-git-send-email-gitster@pobox.com>
 <1234170565-6740-4-git-send-email-gitster@pobox.com>
 <1234170565-6740-5-git-send-email-gitster@pobox.com>
 <1234170565-6740-6-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 10:11:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWSAw-0004Zb-GF
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 10:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbZBIJJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 04:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbZBIJJs
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 04:09:48 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61140 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbZBIJJn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 04:09:43 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BB4A9984CC
	for <git@vger.kernel.org>; Mon,  9 Feb 2009 04:09:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EF70F984CB for
 <git@vger.kernel.org>; Mon,  9 Feb 2009 04:09:41 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc0.28.g2593d
In-Reply-To: <1234170565-6740-6-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6345A386-F689-11DD-A1E5-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109057>

This is for a future release that switches the default to refuse.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-receive-pack.c |   30 ++++++++++++------------------
 t/t5400-send-pack.sh   |    2 +-
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index f7e04c4..44163ac 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -247,30 +247,24 @@ static void warn_unconfigured_deny(void)
 		warning(warn_unconfigured_deny_msg[i]);
 }
 
-static char *warn_unconfigured_deny_delete_current_msg[] = {
-	"Deleting the current branch can cause confusion by making the next",
-	"'git clone' not check out any file.",
+static char *refuse_unconfigured_deny_delete_current_msg[] = {
+	"By default, deleting the current branch is denied, because the next",
+	"'git clone' won't result in any file checked out, causing confusion.",
 	"",
 	"You can set 'receive.denyDeleteCurrent' configuration variable to",
-	"'refuse' in the remote repository to disallow deleting the current",
-	"branch.",
+	"'warn' or 'ignore' in the remote repository to allow deleting the",
+	"current branch, with or without a warning message.",
 	"",
-	"You can set it to 'ignore' to allow such a delete without a warning.",
-	"",
-	"To make this warning message less loud, you can set it to 'warn'.",
-	"",
-	"Note that the default will change in a future version of git",
-	"to refuse deleting the current branch unless you have the",
-	"configuration variable set to either 'ignore' or 'warn'."
+	"To squelch this message, you can set it to 'refuse'."
 };
 
-static void warn_unconfigured_deny_delete_current(void)
+static void refuse_unconfigured_deny_delete_current(void)
 {
 	int i;
 	for (i = 0;
-	     i < ARRAY_SIZE(warn_unconfigured_deny_delete_current_msg);
+	     i < ARRAY_SIZE(refuse_unconfigured_deny_delete_current_msg);
 	     i++)
-		warning(warn_unconfigured_deny_delete_current_msg[i]);
+		error(refuse_unconfigured_deny_delete_current_msg[i]);
 }
 
 static const char *update(struct command *cmd)
@@ -319,12 +313,12 @@ static const char *update(struct command *cmd)
 			case DENY_IGNORE:
 				break;
 			case DENY_WARN:
-			case DENY_UNCONFIGURED:
-				if (deny_delete_current == DENY_UNCONFIGURED)
-					warn_unconfigured_deny_delete_current();
 				warning("deleting the current branch");
 				break;
 			case DENY_REFUSE:
+			case DENY_UNCONFIGURED:
+				if (deny_delete_current == DENY_UNCONFIGURED)
+					refuse_unconfigured_deny_delete_current();
 				error("refusing to delete the current branch: %s", name);
 				return "deletion of the current branch prohibited";
 			}
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 7b21f5f..6ef1f03 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -196,7 +196,7 @@ test_expect_success 'pushing wildcard refspecs respects forcing' '
 test_expect_success 'deny pushing to delete current branch' '
     (
 	rewound_push_setup &&
-	git send-pack ../parent/.git :refs/heads/master 2>errs
+	test_must_fail git send-pack ../parent/.git :refs/heads/master 2>errs
     )
 '
 
-- 
1.6.2.rc0.28.g2593d
