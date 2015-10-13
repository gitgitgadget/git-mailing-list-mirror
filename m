From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/26] mailinfo: move global "line" into mailinfo() function
Date: Tue, 13 Oct 2015 16:16:28 -0700
Message-ID: <1444778207-859-8-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:18:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8pe-00079E-HX
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbbJMXRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:17:19 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34015 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbbJMXQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:16:58 -0400
Received: by pabws5 with SMTP id ws5so3472325pab.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=E07L0MUetyk95C5oraGzO1Aj9IyXYyd8PIDvpLdRT64=;
        b=dumwf8jBab/VTFJ1f+Y/hZsaAX030UPLdbXo7EI7MqMQDfEwQW7BxQX9gRXaKGx7Y3
         yV2zUUi67STUhoiCg1dbPBHC2s2GIEUjXi4o+PuxQjDT6avjbiykY9GA6pM18nrC3bAP
         SeYXlkNC8taGbrildNk4H2eqo3j9gMULfXUjpJJz0N/Pxy56oNdX94RNIX75nUFh9Nyj
         yxlxJbHyopqzd87OZvMsqTTj8J97OomGo0rQLfjPCjVWx2xdjzVLJ+aKk32dKMSAhW1C
         QCLlVqR5+jzOi69tRdjsp3BX3HNKDECBgq2kTww7TO5Wz48Y4FVxrFZ6CHBercDWTw2/
         ORBA==
X-Received: by 10.66.120.80 with SMTP id la16mr24909pab.1.1444778218476;
        Tue, 13 Oct 2015 16:16:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id ih4sm5844137pbc.28.2015.10.13.16.16.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:16:57 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279553>

The mailinfo() function is the only one that wants the "line_global"
to be directly touchable.  Note that handle_body() has to be passed
this strbuf so that it sees the "first line of the input" after the
loop in this function processes the headers.  It feels a bit dirty
that handle_body() then keeps reusing this strbuf to read more lines
and does its processing, but that is how the code is structured now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index c3c7d67..6c671fb 100644
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
@@ -995,6 +994,8 @@ static void handle_info(void)
 static int mailinfo(FILE *in, FILE *out, const char *msg, const char *patch)
 {
 	int peek;
+	struct strbuf line = STRBUF_INIT;
+
 	fin = in;
 	fout = out;
 
@@ -1019,10 +1020,10 @@ static int mailinfo(FILE *in, FILE *out, const char *msg, const char *patch)
 	ungetc(peek, in);
 
 	/* process the email header */
-	while (read_one_header_line(&line_global, fin))
-		check_header(&line_global, p_hdr_data, 1);
+	while (read_one_header_line(&line, fin))
+		check_header(&line, p_hdr_data, 1);
 
-	handle_body(&line_global);
+	handle_body(&line);
 	handle_info();
 
 	return 0;
-- 
2.6.1-320-g86a1181
