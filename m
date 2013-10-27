From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 10/10] transport-helper: don't update refs in dry-run
Date: Sun, 27 Oct 2013 01:05:19 -0600
Message-ID: <1382857521-7005-9-git-send-email-felipe.contreras@gmail.com>
References: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 08:12:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaKWV-0006tM-KZ
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 08:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab3J0HM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 03:12:29 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:45539 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174Ab3J0HMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 03:12:20 -0400
Received: by mail-oa0-f42.google.com with SMTP id k14so2485138oag.1
        for <git@vger.kernel.org>; Sun, 27 Oct 2013 00:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P7KITjtZ6ms7b0fuYA1YH83OwG+g/QWCEicqMNFJ4qY=;
        b=JAJyGJO73lhPygVvY1FHheaCXwmJ4pDWAKGeLJdFPG3s29FZORQ3OV+sVlwoP447Kt
         jqB1YmHslyj7YGwPyTaAsUm96Iqt44I9Xz6WboX2hVFTDj7Trbo9yOjOPxdgKwk6Yuzd
         SK0he6gC7XcqvHjYgxeYQzWTd61tnUYQ0HlnyeXbFh8iO7L56qa8EElWBdqhcp8TEDCu
         X39O/CRRsReEjYIRxCU+UM7nBPEtYLjIfSg6A6Q/wmmN8fG21vm7Z4FnDuscDilUrAp6
         wUQv3ZviyEyYJsq3OuyxsGvlXIahiTDC91sUvCrGYI2nT1ue+uXKJukYwPakmunySLvR
         I7jQ==
X-Received: by 10.182.181.34 with SMTP id dt2mr9668960obc.30.1382857939831;
        Sun, 27 Oct 2013 00:12:19 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm18079935obu.4.2013.10.27.00.12.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2013 00:12:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236786>

The remote helper namespace should not be updated.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 4f47bdd..ef91882 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -733,7 +733,8 @@ static int push_update_ref_status(struct strbuf *buf,
 }
 
 static void push_update_refs_status(struct helper_data *data,
-				    struct ref *remote_refs)
+				    struct ref *remote_refs,
+				    int flags)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct ref *ref = remote_refs;
@@ -747,7 +748,7 @@ static void push_update_refs_status(struct helper_data *data,
 		if (push_update_ref_status(&buf, &ref, remote_refs))
 			continue;
 
-		if (!data->refspecs || data->no_private_update)
+		if (flags & TRANSPORT_PUSH_DRY_RUN || !data->refspecs || data->no_private_update)
 			continue;
 
 		/* propagate back the update to the remote namespace */
@@ -838,7 +839,7 @@ static int push_refs_with_push(struct transport *transport,
 	sendline(data, &buf);
 	strbuf_release(&buf);
 
-	push_update_refs_status(data, remote_refs);
+	push_update_refs_status(data, remote_refs, flags);
 	return 0;
 }
 
@@ -905,7 +906,7 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
-	push_update_refs_status(data, remote_refs);
+	push_update_refs_status(data, remote_refs, flags);
 	return 0;
 }
 
-- 
1.8.4-fc
