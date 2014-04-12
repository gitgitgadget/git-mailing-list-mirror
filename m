From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v9 2/6] transport-helper: don't update refs in dry-run
Date: Sat, 12 Apr 2014 15:12:51 -0500
Message-ID: <1397333575-11614-3-git-send-email-felipe.contreras@gmail.com>
References: <1397333575-11614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 22:24:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ4T2-0007ir-SZ
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 22:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756226AbaDLUXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 16:23:41 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:37034 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755200AbaDLUXG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 16:23:06 -0400
Received: by mail-ob0-f179.google.com with SMTP id va2so7543189obc.38
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 13:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4/aW3vnzu4EvNvaSZbufTWSoJHTOquTPUpUccBfH2v0=;
        b=Zpsu0dfNNDFjlxVIimcYV0AwdCSN6MnCbEwD6zfcKdMAYI7C0wKaimlnG2qKuK5Rlk
         X6s8PwylgOXXnmBbLMPlvqcqPfEgLyCXfNH0BNsWCo2x39tM4mJ7P/XH3+NBf6XwlBap
         M0j6ApKg1UoQUODk3lbWg0dV8mwr5rvBSF6a+9P/1bv8etCOYBeb0RYzIpmmBLiGfEQ/
         clTQaBRWjnV36z+9H1tt7Iryr7AjAxKgayo2Wv+2xb1PRf3BJ8NC75vPnh61+9gpkUph
         TFy/0RwA7893EtvCdOghxM11xyD0NJaa8Ri6AQoJvMOIjK2Dn33oNLwyG78KEf/gxyzX
         4h+Q==
X-Received: by 10.60.133.81 with SMTP id pa17mr26231180oeb.35.1397334185585;
        Sat, 12 Apr 2014 13:23:05 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id y10sm19183147obk.4.2014.04.12.13.23.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 13:23:04 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1397333575-11614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246185>

The remote helper namespace should not be updated.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport-helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index ea34d0c..4b3e38e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -734,7 +734,8 @@ static int push_update_ref_status(struct strbuf *buf,
 }
 
 static void push_update_refs_status(struct helper_data *data,
-				    struct ref *remote_refs)
+				    struct ref *remote_refs,
+				    int flags)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct ref *ref = remote_refs;
@@ -748,7 +749,7 @@ static void push_update_refs_status(struct helper_data *data,
 		if (push_update_ref_status(&buf, &ref, remote_refs))
 			continue;
 
-		if (!data->refspecs || data->no_private_update)
+		if (flags & TRANSPORT_PUSH_DRY_RUN || !data->refspecs || data->no_private_update)
 			continue;
 
 		/* propagate back the update to the remote namespace */
@@ -839,7 +840,7 @@ static int push_refs_with_push(struct transport *transport,
 	sendline(data, &buf);
 	strbuf_release(&buf);
 
-	push_update_refs_status(data, remote_refs);
+	push_update_refs_status(data, remote_refs, flags);
 	return 0;
 }
 
@@ -893,7 +894,7 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
-	push_update_refs_status(data, remote_refs);
+	push_update_refs_status(data, remote_refs, flags);
 	return 0;
 }
 
-- 
1.9.1+fc3.9.gc73078e
