From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH 2/5] add the ability to select more email header fields to output
Date: Wed, 14 Mar 2007 16:12:23 -0400
Message-ID: <11739031471426-git-send-email-dzickus@redhat.com>
References: <11739031463211-git-send-email-dzickus@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 21:14:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRZre-0003ZQ-Je
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 21:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933120AbXCNUOA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 16:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933152AbXCNUOA
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 16:14:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38253 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933120AbXCNUN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 16:13:58 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2EKDwx0014186
	for <git@vger.kernel.org>; Wed, 14 Mar 2007 16:13:58 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2EKDqfq025154
	for <git@vger.kernel.org>; Wed, 14 Mar 2007 16:13:52 -0400
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l2EKDqIC007057;
	Wed, 14 Mar 2007 16:13:52 -0400
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l2EKCRA0009147;
	Wed, 14 Mar 2007 16:12:27 -0400
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l2EKCRQU009145;
	Wed, 14 Mar 2007 16:12:27 -0400
X-Mailer: git-send-email 1.5.0.2.213.g18c8-dirty
In-Reply-To: <11739031463211-git-send-email-dzickus@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42224>

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
