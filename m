From: "Theo Niessink" <theo@taletn.com>
Subject: [PATCH] help_unknown_command: disable auto correction
Date: Fri, 29 Jul 2011 17:20:15 +0200
Message-ID: <77D4710D485241B18B21CCA8A543700B@martinic.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 29 17:20:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmorR-00013t-LA
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 17:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802Ab1G2PUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 11:20:18 -0400
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:4764 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751486Ab1G2PUR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 11:20:17 -0400
Received: from cpsps-ews27.kpnxchange.com ([10.94.84.193]) by cpsmtpb-ews05.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 29 Jul 2011 17:19:45 +0200
Received: from CPSMTPM-CMT105.kpnxchange.com ([195.121.3.21]) by cpsps-ews27.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 29 Jul 2011 17:19:45 +0200
Received: from pc0003 ([77.168.115.212]) by CPSMTPM-CMT105.kpnxchange.com with Microsoft SMTPSVC(7.0.6002.18264);
	 Fri, 29 Jul 2011 17:20:15 +0200
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcxOAwRw5886q8liSsGIS2QUdEUC4A==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
X-OriginalArrivalTime: 29 Jul 2011 15:20:15.0610 (UTC) FILETIME=[049BF5A0:01CC4E03]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178153>

Hi,

This is a very minor nitpick, but since it bothers me I thought I'd patch it
anyway. If it doesn't bother anyone else, then please ignore this patch.

I am a fast but rather inaccurate typer, so now and then I mistype a Git
command. The first time this happens I have to wait up to 15 seconds before
Git returns with an error. It takes my brain only 0.15 seconds to see the
typo, but I still have the wait the remaining 14.45 seconds before I can
retry.

I have patched help_unknown_command(), so you can disable auto correction
with help.autocorrect == -2.

Beware that this is not 100% backward compatible, because before this patch
_any_ negative value (including -2) would set the auto correction delay to
zero.

- Theo

-- >8 --
Subject: [PATCH] help_unknown_command: disable auto correction

Auto correction can be rather slow (because it searches the path), so
disable it with "git config help.autocorrect -2".

Signed-off-by: Theo Niessink <theo@taletn.com>
---
 Documentation/config.txt |    5 +++--
 help.c                   |    8 ++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0658ffb..452e3a8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1188,10 +1188,11 @@ help.autocorrect::
 	Automatically correct and execute mistyped commands after
 	waiting for the given number of deciseconds (0.1 sec). If more
 	than one command can be deduced from the entered text, nothing
-	will be executed.  If the value of this option is negative,
+	will be executed.  If the value of this option is -1,
 	the corrected command will be executed immediately. If the
 	value is 0 - the command will be just shown but not executed.
-	This is the default.
+	This is the default. If the value is -2, auto correction is disabled
+	altogether.
 
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy'
diff --git a/help.c b/help.c
index cbbe966..31a6d54 100644
--- a/help.c
+++ b/help.c
@@ -320,6 +320,13 @@ const char *help_unknown_cmd(const char *cmd)
 
 	git_config(git_unknown_cmd_config, NULL);
 
+	if (autocorrect == -2)
+	{
+		/* No similarity */
+		best_similarity = SIMILARITY_FLOOR;
+		goto skip_autocorrect;
+	}
+
 	load_command_list("git-", &main_cmds, &other_cmds);
 
 	add_cmd_list(&main_cmds, &aliases);
@@ -396,6 +403,7 @@ const char *help_unknown_cmd(const char *cmd)
 		return assumed;
 	}
 
+skip_autocorrect:
 	fprintf(stderr, "git: '%s' is not a git command. See 'git --help'.\n", cmd);
 
 	if (SIMILAR_ENOUGH(best_similarity)) {
-- 
1.7.6.msysgit.0
