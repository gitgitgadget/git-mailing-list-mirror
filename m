From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/31] mailinfo: move global "line" into mailinfo() function
Date: Wed, 14 Oct 2015 13:45:34 -0700
Message-ID: <1444855557-2127-9-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:46:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSwj-0001mB-3x
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932884AbbJNUqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:31 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33383 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358AbbJNUqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:09 -0400
Received: by pabrc13 with SMTP id rc13so64152451pab.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=kXgM7xWGkbzyEXSMudoStHgocOGYJu4X02OlhXquLNo=;
        b=pLmwba2L4WUdU1EMtNNeI/B03okJgBqexn+fRJD17TyHycpQN3sJmRCXFh96SjokeL
         /oLUFs3y3HDzPyeKJz/jATtC3KZM0w9i0qlXgrrZ4rQLbYKSEhvkGsXPFAsbhz4fBwNG
         hnIzyrzcRYhbw5t51Kc8kTog03hL1JwFzvkpxKHExZPujh+GMTUqDLA7gR0V46qF5DVL
         e+An/tzzfptvdeWYRAOA9mHdb83VhB+5IY91wWAZdRhmPK939LQRRWvrIef16eGUWVQd
         /zQAOQuJ+9oXkolRMpDvNjYkaFRH5ZnrRmu1I+W7teeJzBHhAVRIQ3Qm85k74wA5AfvR
         FRQw==
X-Received: by 10.66.251.136 with SMTP id zk8mr5701889pac.143.1444855569111;
        Wed, 14 Oct 2015 13:46:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id j16sm11288853pbq.23.2015.10.14.13.46.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:08 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279602>

With the pregvious step, it becomes clear that the mailinfo()
function is the only one that wants the "line_global" to be directly
touchable.

Logically, this strbuf belongs to handle_body().  It passes the line
to its helper functions for processing, and keeps one line at a time
into the variable in the loop to drive that process.  It would have
been even nicer looking if we could make the variable local to the
function.  But the function has to be passed its initial value
(i.e. the first line is read by its caller), and that is why its
sole caller owns it in the resulting code structure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 721d999..c8dc73f 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -12,7 +12,6 @@ static FILE *cmitmsg, *patchfile, *fin, *fout;
 static int keep_subject;
 static int keep_non_patch_brackets_in_subject;
 static const char *metainfo_charset;
-static struct strbuf line_global = STRBUF_INIT;
 static struct strbuf name = STRBUF_INIT;
 static struct strbuf email = STRBUF_INIT;
 static char *message_id;
@@ -966,6 +965,8 @@ static void handle_info(void)
 static int mailinfo(FILE *in, FILE *out, const char *msg, const char *patch)
 {
 	int peek;
+	struct strbuf line = STRBUF_INIT;
+
 	fin = in;
 	fout = out;
 
@@ -990,10 +991,10 @@ static int mailinfo(FILE *in, FILE *out, const char *msg, const char *patch)
 	ungetc(peek, in);
 
 	/* process the email header */
-	while (read_one_header_line(&line_global, fin))
-		check_header(&line_global, p_hdr_data, 1);
+	while (read_one_header_line(&line, fin))
+		check_header(&line, p_hdr_data, 1);
 
-	handle_body(&line_global);
+	handle_body(&line);
 	fclose(patchfile);
 
 	handle_info();
-- 
2.6.1-320-g86a1181
