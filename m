From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH 2/5] add the ability to select more email header fields to output
Date: Thu, 15 Mar 2007 10:36:39 -0400
Message-ID: <20070315143639.GC11029@redhat.com>
References: <11739031463211-git-send-email-dzickus@redhat.com> <11739031471426-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 15 15:38:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRr5o-0005O5-6V
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 15:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422740AbXCOOiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 10:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422741AbXCOOiJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 10:38:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38890 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422740AbXCOOiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 10:38:07 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2FEc5aK013430
	for <git@vger.kernel.org>; Thu, 15 Mar 2007 10:38:05 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2FEc5a6030582
	for <git@vger.kernel.org>; Thu, 15 Mar 2007 10:38:05 -0400
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l2FEc55L017010
	for <git@vger.kernel.org>; Thu, 15 Mar 2007 10:38:05 -0400
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l2FEadlV031579
	for <git@vger.kernel.org>; Thu, 15 Mar 2007 10:36:39 -0400
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l2FEadLo031578
	for git@vger.kernel.org; Thu, 15 Mar 2007 10:36:39 -0400
X-Authentication-Warning: drseuss.boston.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
In-Reply-To: <11739031471426-git-send-email-dzickus@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42285>

This is useful when scripts need more than just the basic email headers to
parse.  By specifying the "-x=" option, one can search and output any header
field they want.

Signed-off-by: Don Zickus <dzickus@redhat.com>
---

 Accidentally sent out the wrong patch yesterday.

---
 builtin-mailinfo.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index a5eea82..8ac6ef4 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -302,7 +302,7 @@ static int check_header(char *line, char **hdr_data)
 	int i;
 
 	/* search for the interesting parts */
-	for (i = 0; header[i]; i++) {
+	for (i = 0; header[i] && i < MAX_HDR_PARSED; i++) {
 		int len = strlen(header[i]);
 		if (!hdr_data[i] &&
 		    !strncasecmp(line, header[i], len) &&
@@ -338,8 +338,8 @@ static int check_header(char *line, char **hdr_data)
 	if (!memcmp(">From", line, 5) && isspace(line[5]))
 		return 1;
 	if (!memcmp("[PATCH]", line, 7) && isspace(line[7])) {
-		for (i = 0; header[i]; i++) {
-			if (!memcmp("Subject: ", header[i], 9)) {
+		for (i = 0; header[i] && i < MAX_HDR_PARSED; i++) {
+			if (!memcmp("Subject", header[i], 7)) {
 				if (! handle_header(line, hdr_data[i], 0)) {
 					return 1;
 				}
@@ -796,7 +796,7 @@ static void handle_info(void)
 	char *hdr;
 	int i;
 
-	for (i = 0; header[i]; i++) {
+	for (i = 0; header[i] && i < MAX_HDR_PARSED; i++) {
 
 		/* only print inbody headers if we output a patch file */
 		if (patch_lines && s_hdr_data[i])
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
 
+	for (top = 0; header[top] && top < MAX_HDR_PARSED; top++){ ; }
+
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-k"))
 			keep_subject = 1;
@@ -879,7 +882,14 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 			metainfo_charset = NULL;
 		else if (!prefixcmp(argv[1], "--encoding="))
 			metainfo_charset = argv[1] + 11;
-		else
+		else if (!prefixcmp(argv[1], "-x=")) {
+			if (top >= MAX_HDR_PARSED) {
+				fprintf(stderr, "too many headers to parse\n");
+				exit(1);
+			}
+			header[top] = xmalloc(256*sizeof(char));
+			strncpy(header[top++], argv[1]+3, 256);
+		} else
 			usage(mailinfo_usage);
 		argc--; argv++;
 	}
-- 
1.5.0.2.213.g18c8-dirty
