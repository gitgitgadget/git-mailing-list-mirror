From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH 2/5] add the ability to select more email header fields to output
Date: Mon, 12 Mar 2007 15:52:05 -0400
Message-ID: <11737291281648-git-send-email-dzickus@redhat.com>
References: <11737291282223-git-send-email-dzickus@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 20:54:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQqav-0002Ui-Pm
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 20:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbXCLTxk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 15:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbXCLTxk
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 15:53:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55929 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840AbXCLTxf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 15:53:35 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2CJrZJd022123
	for <git@vger.kernel.org>; Mon, 12 Mar 2007 15:53:35 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2CJrY0s020372
	for <git@vger.kernel.org>; Mon, 12 Mar 2007 15:53:34 -0400
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l2CJrX9F029972;
	Mon, 12 Mar 2007 15:53:33 -0400
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l2CJq8Y5019767;
	Mon, 12 Mar 2007 15:52:08 -0400
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l2CJq8Dw019766;
	Mon, 12 Mar 2007 15:52:08 -0400
X-Mailer: git-send-email 1.5.0.2.211.g2ca9-dirty
In-Reply-To: <11737291282223-git-send-email-dzickus@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42074>

This is useful when scripts need more than just the basic email headers to
parse.  By specifying the "-x=" option, one can search and output any header
field they want.

Signed-off-by: Don Zickus <dzickus@redhat.com>
---
 builtin-mailinfo.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index dacdf77..dd0f563 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -856,11 +856,12 @@ int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,
 }
 
 static const char mailinfo_usage[] =
-	"git-mailinfo [-k] [-u | --encoding=<encoding>] msg patch <mail >info";
+	"git-mailinfo [-k] [-u | --encoding=<encoding>] [-x=<field>] msg patch <mail >info";
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
 	const char *def_charset;
+	int top;
 
 	/* NEEDSWORK: might want to do the optional .git/ directory
 	 * discovery
@@ -870,6 +871,8 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	def_charset = (git_commit_encoding ? git_commit_encoding : "utf-8");
 	metainfo_charset = def_charset;
 
+	for (top=0; header[top]; top++){ ; }
+
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-k"))
 			keep_subject = 1;
@@ -879,7 +882,10 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 			metainfo_charset = NULL;
 		else if (!prefixcmp(argv[1], "--encoding="))
 			metainfo_charset = argv[1] + 11;
-		else
+		else if (!prefixcmp(argv[1], "-x=")) {
+			header[top] = xmalloc(256*sizeof(char));
+			strncpy(header[top++], argv[1]+3, 256);
+		} else
 			usage(mailinfo_usage);
 		argc--; argv++;
 	}
-- 
1.5.0.2.211.g2ca9-dirty
