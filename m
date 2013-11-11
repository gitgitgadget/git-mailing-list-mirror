From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 02/10] transport-helper: don't update refs in dry-run
Date: Mon, 11 Nov 2013 16:55:07 -0600
Message-ID: <1384210507-26561-11-git-send-email-felipe.contreras@gmail.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 00:02:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg0VE-0006ig-G0
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 00:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509Ab3KKXCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 18:02:33 -0500
Received: from mail-oa0-f45.google.com ([209.85.219.45]:58136 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516Ab3KKXC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 18:02:26 -0500
Received: by mail-oa0-f45.google.com with SMTP id m1so3053213oag.32
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 15:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fal2OPO0Uj3DBvt7hRDMkBK1OJb3f8k7dKNWqk6WE3s=;
        b=gXSoPwyel2DPD/yXuenVce6GTsLdVFVzG7G3kxGGaLALhdMwUkXNfWLEwvvwu/BbcX
         puiq3sEBPEbaItv7dNuNJTGskIsS4T5PXV3VEUmVApoqYqQhZrykse2xFswCnPcuBWWB
         rwjoTbGhM0UX9/49WXqlDgQ8M+CxQjlPRSpa2fRleIDhMq2gmgNGteUAgHpFAlw74XiV
         IsaAbwoz3yl4pV03jcrhTtfYFc1mVFmPh/hbTk/9ItuXioPdltQy5zzPFSPdRhMMMdDj
         55Qh1qMPpaGINoVqbMV2QQIOiPU6364zyhACG8zmN8uFEmPyxNGD8xR25SVD/oXnCrkX
         jCrQ==
X-Received: by 10.60.42.168 with SMTP id p8mr3572120oel.73.1384210944674;
        Mon, 11 Nov 2013 15:02:24 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm29259465obb.11.2013.11.11.15.02.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2013 15:02:23 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237673>

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
