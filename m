From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/5] transport-helper: propagate recvline() error pushing
Date: Sat, 12 Apr 2014 15:33:30 -0500
Message-ID: <1397334812-12215-4-git-send-email-felipe.contreras@gmail.com>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 22:44:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ4mn-0004kX-04
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 22:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbaDLUoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 16:44:05 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:60375 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756249AbaDLUnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 16:43:42 -0400
Received: by mail-ob0-f182.google.com with SMTP id uz6so7648860obc.27
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 13:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NILl5vKk/3A5KxGqK4VXQswfFHO/y6bKtUiaX0bxl5g=;
        b=RKlbLaP0abD2a94i9a/A+5WPPVZ0rKp1NnyLtoUbjLJysOa3ppRT/MU+1Bo5gjiVYG
         /WZr1DExrCYCT2bdlksUs148MdmewP8yxY/UYl8u8sp+OrTpbSu0LXSbvViaCJUkxSQJ
         u5XJbn/+J6PXzdTFjL4M0wgqECgMgnJgITZgJlkix5AsqSEB1dkPoXla9sYOmRavO5CH
         oeDvhvZIbR7xpuTZ18NxwUnQPsOW/VRQWMY+Gu21WiSbKMqEHZJvT/dZe++o5X7GXpP7
         Tt77FdhUlcl8XuhruYQOWPvtWqQtg05eFnLMNILPOyuLcJ88SBaXm/6poKoa45hJlD2n
         gK/A==
X-Received: by 10.60.160.173 with SMTP id xl13mr26449644oeb.19.1397335421727;
        Sat, 12 Apr 2014 13:43:41 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ci10sm49183307oec.0.2014.04.12.13.43.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 13:43:40 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246192>

It's cleaner, and will allow us to do something sensible on errors
later.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 1432a6d..b068ea5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -733,16 +733,21 @@ static int push_update_ref_status(struct strbuf *buf,
 	return !(status == REF_STATUS_OK);
 }
 
-static void push_update_refs_status(struct helper_data *data,
+static int push_update_refs_status(struct helper_data *data,
 				    struct ref *remote_refs)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct ref *ref = remote_refs;
+	int ret = 0;
+
 	for (;;) {
 		char *private;
 
-		if (recvline(data, &buf))
-			exit(128);
+		if (recvline(data, &buf)) {
+			ret = 1;
+			break;
+		}
+
 		if (!buf.len)
 			break;
 
@@ -760,6 +765,7 @@ static void push_update_refs_status(struct helper_data *data,
 		free(private);
 	}
 	strbuf_release(&buf);
+	return ret;
 }
 
 static int push_refs_with_push(struct transport *transport,
@@ -840,8 +846,7 @@ static int push_refs_with_push(struct transport *transport,
 	sendline(data, &buf);
 	strbuf_release(&buf);
 
-	push_update_refs_status(data, remote_refs);
-	return 0;
+	return push_update_refs_status(data, remote_refs);
 }
 
 static int push_refs_with_export(struct transport *transport,
@@ -897,8 +902,7 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
-	push_update_refs_status(data, remote_refs);
-	return 0;
+	return push_update_refs_status(data, remote_refs);
 }
 
 static int push_refs(struct transport *transport,
-- 
1.9.1+fc3.9.gc73078e
