From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 15/34] mailinfo: move patch_lines to struct mailinfo
Date: Mon, 19 Oct 2015 00:28:32 -0700
Message-ID: <1445239731-10677-16-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:30:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4tx-0003Uj-T0
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbbJSHaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:30:30 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33992 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbbJSH3M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:12 -0400
Received: by padhk11 with SMTP id hk11so21771949pad.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=9g0n/Iv4pDCrGrfkz92oZdqGu//oZMjDUsDcq6Wxm78=;
        b=bRtzfxBmNPcuS0+ydq79pg3XgjH9LfN3Mp2qqdqJ/bybVA3D/l4OCIDdPPI7lC45j2
         Xbf495SP5rM6k62IIXOObVPr657ExEKqBgg3N0FQc7ILVI/1Uf/XdXhMgQqn5P1BG+P2
         kLs/ldor5aG1mdKsmKF4IEVDvPh+Y5QNkqAlpDTDvQPE5c6WtIl15kJiYA7jrnvDuJSU
         kw2sBRDqFDJD2XBudWjrujMy0+kEieCQ0+Q7/EnSMAX4bgFvi4GzB6B0EUwu6PKI2Dyo
         /ckndmvovA+DvN6WTjLmsQvA+/9rLZRfcg+lcAAkccBVWY8nc/bhSx8PT0HcvLlanXfq
         QsWg==
X-Received: by 10.66.233.70 with SMTP id tu6mr29393045pac.83.1445239751980;
        Mon, 19 Oct 2015 00:29:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id yi8sm34826444pab.22.2015.10.19.00.29.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:11 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279860>

This one is trivial thanks to previous steps that started passing
the structure throughout the input codepaths.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 5823ae5..8bd76c6 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -20,6 +20,7 @@ struct mailinfo {
 	int keep_subject;
 	int keep_non_patch_brackets_in_subject;
 
+	int patch_lines;
 	int filter_stage; /* still reading log or are we copying patch? */
 	int header_stage; /* still checking in-body headers? */
 };
@@ -30,7 +31,6 @@ static enum  {
 } transfer_encoding;
 
 static struct strbuf charset = STRBUF_INIT;
-static int patch_lines;
 
 static struct strbuf **p_hdr_data, **s_hdr_data;
 static int use_scissors;
@@ -778,10 +778,10 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	return 0;
 }
 
-static void handle_patch(const struct strbuf *line)
+static void handle_patch(struct mailinfo *mi, const struct strbuf *line)
 {
 	fwrite(line->buf, 1, line->len, patchfile);
-	patch_lines++;
+	mi->patch_lines++;
 }
 
 static void handle_filter(struct mailinfo *mi, struct strbuf *line)
@@ -792,7 +792,7 @@ static void handle_filter(struct mailinfo *mi, struct strbuf *line)
 			break;
 		mi->filter_stage++;
 	case 1:
-		handle_patch(line);
+		handle_patch(mi, line);
 		break;
 	}
 }
@@ -944,7 +944,7 @@ static void handle_info(struct mailinfo *mi)
 
 	for (i = 0; header[i]; i++) {
 		/* only print inbody headers if we output a patch file */
-		if (patch_lines && s_hdr_data[i])
+		if (mi->patch_lines && s_hdr_data[i])
 			hdr = s_hdr_data[i];
 		else if (p_hdr_data[i])
 			hdr = p_hdr_data[i];
-- 
2.6.2-383-g144b2e6
