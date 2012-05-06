From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 4/4] allow recovery from command name typos
Date: Sun,  6 May 2012 14:55:30 +0800
Message-ID: <1336287330-7215-5-git-send-email-rctay89@gmail.com>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1336287330-7215-2-git-send-email-rctay89@gmail.com>
 <1336287330-7215-3-git-send-email-rctay89@gmail.com>
 <1336287330-7215-4-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 06 08:56:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQvOM-0004ih-CU
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 08:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948Ab2EFG4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 02:56:11 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33800 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab2EFGzw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 02:55:52 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so5453735pbb.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 23:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IrfdLt1SwySB0M2h9K2cHz2HsjXBw0hxjVgamChia9g=;
        b=HSHK95Utt1T/9apUwNMoUgPkPpnfeuT6WWuTUhk8x48l8dOv5SrGOja1d+oCLZ9D0X
         cGfXc5oPaeAdjdIfZZCKKVls4uY6uNt4TRaz8o55oZ9Ec39cSBuOb3fhsq7DNBTVIYE+
         AK816UxyQqf4RBzMT8rgCsu37ScDdOkf+zy/TBadCORCLAYo1WkuBg8M3hScI1hGUpRX
         iVi4slkjD3NBkgm8P/mKCAMULdu/uEs2tfOpptE494zdLvbF8ajidWl7TqD1w7jy1cRD
         ckqkckZZGbmQpmwp61rK7MLZK3RmgeMySMFYqS4pWnDSP7T2Q5UF1HV3N0ucQnbRDqcs
         gmTw==
Received: by 10.68.218.228 with SMTP id pj4mr11960441pbc.167.1336287352290;
        Sat, 05 May 2012 23:55:52 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (cm32.beta238.maxonline.com.sg. [116.86.238.32])
        by mx.google.com with ESMTPS id wn3sm14086094pbc.74.2012.05.05.23.55.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 May 2012 23:55:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.611.g8a79d96
In-Reply-To: <1336287330-7215-4-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197154>

If suggestions are available (based on Levenshtein distance) and if the
terminal isatty(), present a prompt to the user to select one of the
computed suggestions.

In the case where there is a single suggestion, present the prompt
"[Y/n]", such that "", "y" and "Y" as input leads git to proceed
executing the suggestion, while everything else (possibly "n") leads git
to terminate.

In the case where there are multiple suggestions, number the suggestions
1 to n, and accept as input one of the numbers, while everything else
(possibly "n") leads git to terminate. In this case there is no default;
that is, an empty input leads git to terminate. A sample run:

  $ git sh --pretty=oneline
  git: 'sh' is not a git command. See 'git --help'.

  Did you mean one of these?
  1:	show
  2:	push
  [1/2/.../n] 1

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 help.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index f296d95..4aa1d88 100644
--- a/help.c
+++ b/help.c
@@ -6,6 +6,7 @@
 #include "common-cmds.h"
 #include "string-list.h"
 #include "column.h"
+#include "compat/terminal.h"
 
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
@@ -383,8 +384,40 @@ const char *help_unknown_cmd(const char *cmd)
 			      "\nDid you mean one of these?",
 			   n));
 
-		for (i = 0; i < n; i++)
-			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
+		if (!isatty(2))
+			for (i = 0; i < n; i++)
+				fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
+		else if (n == 1) {
+			char *in;
+			const char *ret;
+			fprintf(stderr, "\t%s\n", main_cmds.names[0]->name);
+			in = git_terminal_prompt("[Y/n] ", 1);
+			switch (in[0]) {
+			case 'y': case 'Y': case 0:
+				ret = xstrdup(main_cmds.names[0]->name);
+				clean_cmdnames(&main_cmds);
+				return ret;
+			/* otherwise, don't do anything */
+			}
+		} else {
+			char *in;
+			const char *ret;
+			int opt;
+			for (i = 0; i < n; i++)
+				fprintf(stderr, "%d:\t%s\n", i + 1, main_cmds.names[i]->name);
+			in = git_terminal_prompt("[1/2/.../n] ", 1);
+			switch (in[0]) {
+				case 'n': case 'N': case 0:
+					;
+				default:
+					opt = atoi(in);
+					if (0 < opt && opt <= n) {
+						ret = xstrdup(main_cmds.names[opt - 1]->name);
+						clean_cmdnames(&main_cmds);
+						return ret;
+					}
+			}
+		}
 	}
 
 	exit(1);
-- 
1.7.10.1.611.g8a79d96
