From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/2] mailinfo: support rfc3676 (format=flowed) text/plain messages
Date: Thu, 14 Feb 2008 21:21:16 -0500
Message-ID: <1203042077-11385-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 03:22:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPqD8-0003db-Bv
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 03:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758591AbYBOCVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 21:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759362AbYBOCVX
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 21:21:23 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:63343 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758168AbYBOCVW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 21:21:22 -0500
Received: by an-out-0708.google.com with SMTP id d31so109815and.103
        for <git@vger.kernel.org>; Thu, 14 Feb 2008 18:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=AjzZmFvewg0E9N8nrqFVq5Bk+Fcx6BoYdTzx2KNVr0U=;
        b=ac0YbPPNwnnaJmXtX3EFZEN3TwACY78wKnDDdryPDY94YMO9cUOp2OgUOoklzwnRercuFVM6ZM5gxkDmHABu+7ukWNq61jWkUAskYlWDtv5u0RoCdl3sYj77iTYrrKkH5g1YE6Dd+1TgpEiOUVxNyeuop01DIGfoP4NjQuh+IcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bNiJ4GDFfU4BYVVnzKYxCD9oiG+Q8phjUoAu9Kugj3bAECUZdabUpaybI2JL6/RYRueAa6ETamxsOEr358qRcRmkuX36IN/8VCuIeGuSr5SXGDSQdCocVgDGSO+pH7fQlj9mwpaJIntFN915SHstJtJC4BN+CtKX79sAYwZB//g=
Received: by 10.100.241.17 with SMTP id o17mr2364475anh.106.1203042081410;
        Thu, 14 Feb 2008 18:21:21 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id b19sm5494936ana.18.2008.02.14.18.21.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Feb 2008 18:21:20 -0800 (PST)
X-Mailer: git-send-email 1.5.4.1.1281.g75df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73939>

RFC 3676 establishes two parameters (Format and DelSP) to be used with
the Text/Plain media type. In the presence of these parameters, trailing
whitespace is used to indicate flowed lines and a canonical quote
indicator is used to indicate quoted lines.

mailinfo now unfolds, unquotes, and un-space-stuffs such messages.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
It's been a while since I hacked C, so mucho scrutiny appreciated. The
mailinfo testsuite still passes, and this patch is followed by one which
adds a new test for this code, which also passes.

This is based off next, but mailinfo hasn't changed in a while, so it should apply cleanly to master (didn't test that though).

 builtin-mailinfo.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 2600847..deaf92b 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -20,6 +20,13 @@ static enum  {
 static enum  {
 	TYPE_TEXT, TYPE_OTHER,
 } message_type;
+/* RFC 3676 Text/Plain Format and DelSp Parameters */
+static enum {
+	FORMAT_NONE, FORMAT_FIXED, FORMAT_FLOWED,
+} tp_format;
+static enum {
+	DELSP_NONE, DELSP_YES, DELSP_NO,
+} tp_delsp;
 
 static char charset[256];
 static int patch_lines;
@@ -193,6 +200,18 @@ static int handle_content_type(char *line)
 
 	if (strcasestr(line, "text/") == NULL)
 		 message_type = TYPE_OTHER;
+	else if (strcasestr(line, "text/plain")) {
+		char attr[256];
+		if (slurp_attr(line, "format=", attr) && !strcasecmp(attr, "flowed")) {
+			tp_format = FORMAT_FLOWED;
+			if (slurp_attr(line, "delsp=", attr) && !strcasecmp(attr, "yes"))
+				tp_delsp = DELSP_YES;
+			else
+				tp_delsp = DELSP_NO;
+		}
+		else
+			tp_format = FORMAT_FIXED;
+	}
 	if (slurp_attr(line, "boundary=", boundary + 2)) {
 		memcpy(boundary, "--", 2);
 		if (content_top++ >= &content[MAX_BOUNDARIES]) {
@@ -681,6 +700,8 @@ again:
 	transfer_encoding = TE_DONTCARE;
 	charset[0] = 0;
 	message_type = TYPE_TEXT;
+	tp_format = FORMAT_NONE;
+	tp_delsp = DELSP_NONE;
 
 	/* slurp in this section's info */
 	while (read_one_header_line(line, sizeof(line), fin))
@@ -770,6 +791,24 @@ static int handle_filter(char *line, unsigned linesize)
 {
 	static int filter = 0;
 
+	if (tp_format == FORMAT_FLOWED && !!strcmp(line, "-- \n")) {
+		char *cp = line;
+		while (*cp == '>' && *cp != 0)
+			cp++;
+		if (*cp == ' ')
+			cp++;
+		line = cp;
+		if (!!strcmp(line, "-- \n")) {
+			while (*cp != '\n' && *cp !=0)
+				cp++;
+			if (cp > line && *cp == '\n' && *(cp-1) == ' ') {
+				if (tp_delsp == DELSP_YES)
+					*(cp-1) = '\0';
+				else
+					*cp = '\0';
+			}
+		}
+	}
 	/* filter tells us which part we left off on
 	 * a non-zero return indicates we hit a filter point
 	 */
@@ -818,6 +857,7 @@ static void handle_body(void)
 
 		switch (transfer_encoding) {
 		case TE_BASE64:
+		case TE_QP:
 		{
 			char *op = line;
 
-- 
1.5.4.1.1281.g75df
