From: Robert Shearman <rob@codeweavers.com>
Subject: [PATCH] format-patch: Generate a newline between the subject header
 and the message body.
Date: Thu, 13 Jul 2006 13:03:41 +0100
Organization: CodeWeavers
Message-ID: <44B6369D.6070602@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020605010205020309070402"
X-From: git-owner@vger.kernel.org Thu Jul 13 14:04:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0zvW-0000LT-8M
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 14:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWGMMEP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 08:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWGMMEP
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 08:04:15 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:55174 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751427AbWGMMEO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 08:04:14 -0400
Received: from host86-141-83-116.range86-141.btcentralplus.com ([86.141.83.116] helo=[172.16.0.10])
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1G0zvR-0000e6-HU
	for git@vger.kernel.org; Thu, 13 Jul 2006 07:04:14 -0500
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23832>

This is a multi-part message in MIME format.
--------------020605010205020309070402
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


format-patch previously didn't generate a newline after a subject. This 
caused the diffstat to not be displayed in messages without a blank line 
and the first blank line to be eaten in messages with a blank line.

This patch inserts a newline in two places - once in the loop to 
separate the subject part of the commit message from the body part of 
the commit message and another after the loop to counteract the eating 
of whitespace at the end of the message.
---
  commit.c |   14 ++++++++++++--
  1 files changed, 12 insertions(+), 2 deletions(-)

--------------020605010205020309070402
Content-Type: text/x-patch;
 name="278bfe08daa6888b9dd7c0e5ca74ad4b3c10e4a4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="278bfe08daa6888b9dd7c0e5ca74ad4b3c10e4a4.diff"

diff --git a/commit.c b/commit.c
index 522a6f3..8869b0d 100644
--- a/commit.c
+++ b/commit.c
@@ -655,6 +655,9 @@ unsigned long pretty_print_commit(enum c
 			continue;
 		}
 
+		if (!subject)
+			body = 1;
+
 		if (is_empty_line(line, &linelen)) {
 			if (!body)
 				continue;
@@ -662,8 +665,6 @@ unsigned long pretty_print_commit(enum c
 				continue;
 			if (fmt == CMIT_FMT_SHORT)
 				break;
-		} else {
-			body = 1;
 		}
 
 		if (subject) {
@@ -694,6 +695,9 @@ unsigned long pretty_print_commit(enum c
 			memcpy(buf + offset, after_subject, slen);
 			offset += slen;
 			after_subject = NULL;
+		} else if (fmt == CMIT_FMT_EMAIL && subject) {
+			/* separate the headers from the body */
+			buf[offset++] = '\n';
 		}
 		subject = NULL;
 	}
@@ -702,6 +706,12 @@ unsigned long pretty_print_commit(enum c
 	/* Make sure there is an EOLN for the non-oneline case */
 	if (fmt != CMIT_FMT_ONELINE)
 		buf[offset++] = '\n';
+	/*
+	 * make sure there is another EOLN to separate the headers from whatever
+	 * body the caller appends if we haven't already written a body
+	 */
+	if (fmt == CMIT_FMT_EMAIL && !body)
+		buf[offset++] = '\n';
 	buf[offset] = '\0';
 	return offset;
 }


--------------020605010205020309070402--
