From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 02/11] transport-helper: don't update refs in dry-run
Date: Tue, 12 Nov 2013 14:56:55 -0600
Message-ID: <1384289830-5471-3-git-send-email-felipe.contreras@gmail.com>
References: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 22:04:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgL8R-0007dt-DY
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217Ab3KLVEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:04:20 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:63404 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203Ab3KLVEI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:04:08 -0500
Received: by mail-ob0-f169.google.com with SMTP id wn1so6045514obc.28
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fal2OPO0Uj3DBvt7hRDMkBK1OJb3f8k7dKNWqk6WE3s=;
        b=BYyCbT6tIP2tnYrOY2ZtmOTmq+ie5fHsivK+Jw+zfka3OwOySr//Lic0HktEM8bgeI
         vx/pBFwI/+HJWAVJrCLeSJTYlxQ64uxnbA4pDuvDP92QMbr8zm0twOUxe3h8nyrt911G
         2hrEOIt2oK9Qnz/aXq8W1+99fWo458elYuNSoeHEsaxN0HLdbNT/dt0W2XgTZc3lZcy9
         BZgLED8Mpf6CqYeqDr3+abk+lz5rtn+ECgRBfdIeHQDySxxdvZh+Y2ysYZ7UW79fRYTQ
         c9Y/u6LHhGAETdqP6TGnSqbvpMMrfcRfJl+Hx95CipOdWQ/a7pqQH4Wc862ni4wIe1Zp
         Eh/g==
X-Received: by 10.60.142.8 with SMTP id rs8mr26198234oeb.34.1384290248315;
        Tue, 12 Nov 2013 13:04:08 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hs4sm35389276obb.5.2013.11.12.13.04.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 13:04:07 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237740>

The remote helper namespace should not be updated.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index b66c7fd..9558a0d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -728,7 +728,8 @@ static int push_update_ref_status(struct strbuf *buf,
 }
 
 static void push_update_refs_status(struct helper_data *data,
-				    struct ref *remote_refs)
+				    struct ref *remote_refs,
+				    int flags)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct ref *ref = remote_refs;
@@ -742,7 +743,7 @@ static void push_update_refs_status(struct helper_data *data,
 		if (push_update_ref_status(&buf, &ref, remote_refs))
 			continue;
 
-		if (!data->refspecs || data->no_private_update)
+		if (flags & TRANSPORT_PUSH_DRY_RUN || !data->refspecs || data->no_private_update)
 			continue;
 
 		/* propagate back the update to the remote namespace */
@@ -833,7 +834,7 @@ static int push_refs_with_push(struct transport *transport,
 	sendline(data, &buf);
 	strbuf_release(&buf);
 
-	push_update_refs_status(data, remote_refs);
+	push_update_refs_status(data, remote_refs, flags);
 	return 0;
 }
 
@@ -887,7 +888,7 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
-	push_update_refs_status(data, remote_refs);
+	push_update_refs_status(data, remote_refs, flags);
 	return 0;
 }
 
-- 
1.8.4.2+fc1
