From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 2/3] mailinfo: support rfc3676 (format=flowed) text/plain messages
Date: Fri, 15 Feb 2008 16:53:37 -0500
Message-ID: <1203112418-25199-2-git-send-email-jaysoffian@gmail.com>
References: 1203042077-11385-1-git-send-email-jaysoffian@gmail.com
 <1203112418-25199-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 22:54:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ8Vg-0007Pw-1x
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 22:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758095AbYBOVxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 16:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757982AbYBOVxr
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 16:53:47 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:34814 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757340AbYBOVxp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 16:53:45 -0500
Received: by an-out-0708.google.com with SMTP id d31so183897and.103
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 13:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dJzFIurGzFmb3FEetPZLf6wApIhH+0ZqkELe2Xo4jeY=;
        b=lyqRU2GIhXMKJV4QdnJzAoh2oPxqEIS2t2K5JjPnwocZF/Tjua2xseeX5VRcltjwa8f/L/SUzrsTQIxJrIwZ9uokFPuSiElEyGJfg157Ki5z6R1KF913Dw4wIZ3m1nj57z2vtPhngm968msfyh7N0ycir9vFn+3Gtrm3wJSHK3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vilPMKXXe+DUMzt3r5635Tt+gzkOMQiWpeLalKbxLK5lNqmoWkNVfeRNXZrQb9bjWn9YUUyw0CIzvdhUOEjE+bu6Hym6jtjlzucgiYowUsJVRMHT45DtGAquRBaUV2Us/b4E0AVZgDnFboeUY/Tx0JtKsWHp8bix/HYKywEWpNw=
Received: by 10.100.94.14 with SMTP id r14mr4734176anb.62.1203112424599;
        Fri, 15 Feb 2008 13:53:44 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id c1sm8939352ana.36.2008.02.15.13.53.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Feb 2008 13:53:43 -0800 (PST)
X-Mailer: git-send-email 1.5.4.1.1281.g75df
In-Reply-To: <1203112418-25199-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73986>

RFC 3676 establishes two parameters (Format and DelSP) to be used with
the Text/Plain media type. In the presence of these parameters, trailing
whitespace is used to indicate flowed lines and a canonical quote
indicator is used to indicate quoted lines.

mailinfo now unfolds, unquotes, and un-space-stuffs such messages.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
This is a bit simpler than the previous patch and incorporates most of
Johannes' feedback. I also switched from enum's to int's since enum's
were really overkill.

 builtin-mailinfo.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 11f154b..0492baf 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -21,6 +21,10 @@ static enum  {
 	TYPE_TEXT, TYPE_OTHER,
 } message_type;
 
+/* RFC 3676 Text/Plain Format and DelSp Parameters */
+static int message_format_is_flowed;
+static int message_delsp_is_yes;
+
 static char charset[256];
 static int patch_lines;
 static char **p_hdr_data, **s_hdr_data;
@@ -193,6 +197,15 @@ static int handle_content_type(char *line)
 
 	if (strcasestr(line, "text/") == NULL)
 		 message_type = TYPE_OTHER;
+	else if (strcasestr(line, "text/plain")) {
+		char attr[256];
+		if ((message_format_is_flowed = (
+			slurp_attr(line, "format=", attr) &&
+			!strcasecmp(attr, "flowed"))))
+			message_delsp_is_yes = (
+				slurp_attr(line, "delsp=", attr) &&
+				!strcasecmp(attr, "yes"));
+	}
 	if (slurp_attr(line, "boundary=", boundary + 2)) {
 		memcpy(boundary, "--", 2);
 		if (content_top++ >= &content[MAX_BOUNDARIES]) {
@@ -681,6 +694,8 @@ again:
 	transfer_encoding = TE_DONTCARE;
 	charset[0] = 0;
 	message_type = TYPE_TEXT;
+	message_format_is_flowed = 0;
+	message_delsp_is_yes = 0;
 
 	/* slurp in this section's info */
 	while (read_one_header_line(line, sizeof(line), fin))
@@ -770,6 +785,22 @@ static int handle_filter(char *line, unsigned linesize)
 {
 	static int filter = 0;
 
+	if (message_format_is_flowed && strcmp(line, "-- \n")) {
+		/* strip quote markers */
+		while (*line && *line == '>')
+			line++;
+		/* undo space-stuffing */
+		if (*line == ' ')
+			line++;
+		if (strcmp(line, "-- \n")) {
+			char *cp = strchrnul(line, '\n');
+			if (cp > line && *(cp-1) == ' ' && *cp == '\n')
+				/* line is flowed (wrapped); remove
+				 * the \n or <space>\n if delsp is yes
+				 */
+				*(cp-(message_delsp_is_yes?1:0)) = '\0';
+		}
+	}
 	/* filter tells us which part we left off on
 	 * a non-zero return indicates we hit a filter point
 	 */
-- 
1.5.4.1.1281.g75df
