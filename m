From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH 2/5] add the ability to select more email header fields to output
Date: Tue,  6 Mar 2007 16:57:40 -0500
Message-ID: <11732182643385-git-send-email-dzickus@redhat.com>
References: <1173218263315-git-send-email-dzickus@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 22:59:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOhhH-0007Zu-Nq
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 22:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbXCFV7N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 16:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbXCFV7M
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 16:59:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49725 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030334AbXCFV7K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 16:59:10 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l26Lx9Mi006997
	for <git@vger.kernel.org>; Tue, 6 Mar 2007 16:59:09 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l26Lx8Uq013040
	for <git@vger.kernel.org>; Tue, 6 Mar 2007 16:59:09 -0500
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l26Lx7S5007406;
	Tue, 6 Mar 2007 16:59:07 -0500
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l26LviFw007890;
	Tue, 6 Mar 2007 16:57:44 -0500
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l26LviJW007889;
	Tue, 6 Mar 2007 16:57:44 -0500
X-Mailer: git-send-email 1.5.0.2.212.gd52f-dirty
In-Reply-To: <1173218263315-git-send-email-dzickus@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41598>

This is useful when scripts need more than just the basic email headers to
parse.  By specifying the "-x=" option, one can search and output any header
field they want.

Signed-off-by: Don Zickus <dzickus@redhat.com>
---
 builtin-mailinfo.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 7456d8a..0532003 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -848,11 +848,12 @@ int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,
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
@@ -862,6 +863,8 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	def_charset = (git_commit_encoding ? git_commit_encoding : "utf-8");
 	metainfo_charset = def_charset;
 
+	for (top=0; header[top]; top++){ ; }
+
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-k"))
 			keep_subject = 1;
@@ -871,7 +874,10 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
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
1.5.0.2.212.gd52f-dirty
