From: Michael Hendricks <michael@ndrix.org>
Subject: [PATCH] format-patch: add arbitrary email headers
Date: Thu, 26 Mar 2009 10:51:05 -0600
Message-ID: <1238086265-71476-1-git-send-email-michael@ndrix.org>
References: <20090326164212.GF29569@ginosko.ndrix.org>
Cc: Michael Hendricks <michael@ndrix.org>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 17:53:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmspE-0003bC-Fl
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 17:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756423AbZCZQvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 12:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755906AbZCZQve
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 12:51:34 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54936 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752583AbZCZQvd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 12:51:33 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 230E72FE3DD;
	Thu, 26 Mar 2009 12:51:29 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 26 Mar 2009 12:51:29 -0400
X-Sasl-enc: mqc2B1QzgD9UDdsJUFx9g0sI+u0gLDMZQQZiBavT+WDG 1238086288
Received: from ginosko.ndrix.org (unknown [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9F49E14E5E;
	Thu, 26 Mar 2009 12:51:28 -0400 (EDT)
Received: by ginosko.ndrix.org (Postfix, from userid 501)
	id 9066CF8D93F; Thu, 26 Mar 2009 10:51:17 -0600 (MDT)
X-Mailer: git-send-email 1.6.2.1.317.ga1cbc
In-Reply-To: <20090326164212.GF29569@ginosko.ndrix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114800>

format-patch supports the format.headers configuration for adding
arbitrary email headers to the patches it outputs.  This patch adds
support for an --add-header argument which makes the same feature
available from the command line.  This is useful when the content of
custom email headers must change from branch to branch.

This patch has been sponsored by Grant Street Group

Signed-off-by: Michael Hendricks <michael@ndrix.org>
---
 Documentation/git-format-patch.txt |    5 +++++
 builtin-log.c                      |    2 ++
 t/t4014-format-patch.sh            |   15 +++++++++++++++
 3 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index c2eb5fa..51fd716 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -161,6 +161,11 @@ if that is not set.
 	Add a "Cc:" header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times.
 
+--add-header=<header>::
+	Add an arbitrary header to the email headers.  This is in addition
+	to any configured headers, and may be used multiple times.
+	For example, --add-header="Organization: git-foo"
+
 --cover-letter::
 	In addition to the patches, generate a cover letter file
 	containing the shortlog and the overall diffstat.  You can
diff --git a/builtin-log.c b/builtin-log.c
index c7a5772..27bc0dc 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -918,6 +918,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			cover_letter = 1;
 		else if (!strcmp(argv[i], "--no-binary"))
 			no_binary_diff = 1;
+		else if (!prefixcmp(argv[i], "--add-header="))
+			add_header(argv[i] + 13);
 		else
 			argv[j++] = argv[i];
 	}
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index f187d15..11061dd 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -128,6 +128,21 @@ test_expect_success 'additional command line cc' '
 	grep "^ *S. E. Cipient <scipient@example.com>$" patch5
 '
 
+test_expect_success 'command line headers' '
+
+	git config --unset-all format.headers &&
+	git format-patch --add-header="Cc: R. E. Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^$/q" >patch6 &&
+	grep "^Cc: R. E. Cipient <rcipient@example.com>$" patch6
+'
+
+test_expect_success 'configuration headers and command line headers' '
+
+	git config --replace-all format.headers "Cc: R. E. Cipient <rcipient@example.com>" &&
+	git format-patch --add-header="Cc: S. E. Cipient <scipient@example.com>" --stdout master..side | sed -e "/^$/q" >patch7 &&
+	grep "^Cc: R. E. Cipient <rcipient@example.com>,$" patch7 &&
+	grep "^ *S. E. Cipient <scipient@example.com>$" patch7
+'
+
 test_expect_success 'multiple files' '
 
 	rm -rf patches/ &&
-- 
1.6.2.1.317.ga1cbc
