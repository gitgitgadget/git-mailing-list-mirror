From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH] Show error for 'git merge' with unset merge.defaultToUpstream
Date: Mon, 21 Nov 2011 14:30:40 +0100
Message-ID: <1321882240-3783-1-git-send-email-vfr@lyx.org>
Cc: gitster@pobox.com, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 14:31:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSTxf-0007dT-N5
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 14:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111Ab1KUNa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 08:30:59 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48675 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610Ab1KUNa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 08:30:58 -0500
Received: by fagn18 with SMTP id n18so5933833fag.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 05:30:57 -0800 (PST)
Received: by 10.204.129.88 with SMTP id n24mr14213865bks.19.1321882256858;
        Mon, 21 Nov 2011 05:30:56 -0800 (PST)
Received: from localhost.localdomain (221-44.206-83.static-ip.oleane.fr. [83.206.44.221])
        by mx.google.com with ESMTPS id cc2sm7297534bkb.8.2011.11.21.05.30.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 05:30:55 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185743>

'git merge' can be called without any arguments if merge.defaultToUpstream
is set. However, when merge.defaultToUpstream is not set, the user will be
presented the usage information as if he entered a command with a wrong
syntaxis. Ironically, the usage information confirms that no arguments are
mandatory.

This adds a proper error message telling the user why the command failed. As
a side-effect this can help the user in discovering the possibility to merge
with the upstream branch by setting merge.defaultToUpstream.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 builtin/merge.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index dffd5ec..900a297 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1160,9 +1160,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		die(_("You cannot combine --no-ff with --ff-only."));
 
 	if (!abort_current_merge) {
-		if (!argc && default_to_upstream)
-			argc = setup_with_upstream(&argv);
-		else if (argc == 1 && !strcmp(argv[0], "-"))
+		if (!argc) {
+			if (default_to_upstream)
+				argc = setup_with_upstream(&argv);
+			else
+				die(_("No commit specified and merge.defaultToUpstream not set."));
+		} else if (argc == 1 && !strcmp(argv[0], "-"))
 			argv[0] = "@{-1}";
 	}
 	if (!argc)
-- 
1.7.4.1
