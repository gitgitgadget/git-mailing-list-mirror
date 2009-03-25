From: Michael Hendricks <michael@ndrix.org>
Subject: [PATCH] format-patch: add arbitrary email headers
Date: Wed, 25 Mar 2009 09:58:32 -0600
Message-ID: <1237996712-61859-1-git-send-email-michael@ndrix.org>
Cc: Michael Hendricks <michael@ndrix.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 25 17:00:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmVX1-0005gY-3n
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 17:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555AbZCYP7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 11:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757807AbZCYP7J
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 11:59:09 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:43792 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754345AbZCYP7I (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 11:59:08 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 436092FC525;
	Wed, 25 Mar 2009 11:58:59 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 25 Mar 2009 11:58:59 -0400
X-Sasl-enc: nVdKlfxeIMDjRWxJlEzlpu9nVqQV3krt/ckO7FOryQXQ 1237996738
Received: from ginosko.ndrix.org (unknown [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CA0032772A;
	Wed, 25 Mar 2009 11:58:58 -0400 (EDT)
Received: by ginosko.ndrix.org (Postfix, from userid 501)
	id 736B9EF7484; Wed, 25 Mar 2009 09:58:47 -0600 (MDT)
X-Mailer: git-send-email 1.6.2.1.318.ged85d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114611>

format-patch supports the format.headers configuration for adding
arbitrary email headers to the patches it outputs.  This patch adds
support for a --header argument which makes the same feature available
from the command line.  This is useful when the content of custom
email headers must change from branch to branch.

This patch has been sponsored by Grant Street Group

Signed-off-by: Michael Hendricks <michael@ndrix.org>
---
 Documentation/git-format-patch.txt |    5 +++++
 builtin-log.c                      |    2 ++
 t/t4014-format-patch.sh            |   15 +++++++++++++++
 3 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index c2eb5fa..e6fe7f3 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -161,6 +161,11 @@ if that is not set.
 	Add a "Cc:" header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times.
 
+--header=<header>::
+	Add an arbitrary header to the email headers.  This is in addition
+	to any configured headers, and may be used multiple times.
+	For example, --header="Organization: git-foo"
+
 --cover-letter::
 	In addition to the patches, generate a cover letter file
 	containing the shortlog and the overall diffstat.  You can
diff --git a/builtin-log.c b/builtin-log.c
index c7a5772..35701a7 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -918,6 +918,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			cover_letter = 1;
 		else if (!strcmp(argv[i], "--no-binary"))
 			no_binary_diff = 1;
+		else if (!prefixcmp(argv[i], "--header="))
+			add_header( argv[i] + 9 );
 		else
 			argv[j++] = argv[i];
 	}
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index f187d15..5f8d9b4 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -128,6 +128,21 @@ test_expect_success 'additional command line cc' '
 	grep "^ *S. E. Cipient <scipient@example.com>$" patch5
 '
 
+test_expect_success 'command line headers' '
+
+	git config --unset-all format.headers &&
+	git format-patch --header="Cc: R. E. Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^$/q" >patch6 &&
+	grep "^Cc: R. E. Cipient <rcipient@example.com>$" patch6
+'
+
+test_expect_success 'configuration headers and command line headers' '
+
+	git config --replace-all format.headers "Cc: R. E. Cipient <rcipient@example.com>" &&
+	git format-patch --header="Cc: S. E. Cipient <scipient@example.com>" --stdout master..side | sed -e "/^$/q" >patch7 &&
+	grep "^Cc: R. E. Cipient <rcipient@example.com>,$" patch7 &&
+	grep "^ *S. E. Cipient <scipient@example.com>$" patch7
+'
+
 test_expect_success 'multiple files' '
 
 	rm -rf patches/ &&
-- 
1.6.2.1.318.ged85d
