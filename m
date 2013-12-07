From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 4/6] transport-helper: check for 'forced update' message
Date: Sat,  7 Dec 2013 15:08:10 -0600
Message-ID: <1386450492-22348-5-git-send-email-felipe.contreras@gmail.com>
References: <1386450492-22348-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 22:16:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpPEH-0002x8-Jf
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 22:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758916Ab3LGVP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 16:15:56 -0500
Received: from mail-oa0-f51.google.com ([209.85.219.51]:63913 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758757Ab3LGVPy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 16:15:54 -0500
Received: by mail-oa0-f51.google.com with SMTP id i7so2326456oag.24
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 13:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=36EQ2AoyxX2eOV8TCKta7gyhiZYVbBx1k1a1x7lQvsc=;
        b=kXmdiagyr4d8sQnRIm3vb4b0m6dKG3ijI5mTyXJZLEbhf65vxUE4pSpNC5+9GRJSUg
         Y/X25WljPkzz+g/ykG/xzm4/eF+zdlwnt97cAVKVFWMAMSURA5PIgtvUKJ5AtOxSzQWz
         qpv/dnTQjhi4pC94VQWkm3rZ6unU0nWSDVwkq7owLjihzDdG7CBqjlBu6TTDHVY87Atd
         ok3eMAMjMkw5P1vAhGhUhp17jD/tv4G1PN+GJzsA9hN7KuDMdYDeX3rkJg2z+2oho1B5
         6E7obCBFFfiEGdUajUx4FmQzmywVpszVebZr180fHGZGaztjGnaaOMZZACVyJitNgrCx
         bvCw==
X-Received: by 10.182.60.233 with SMTP id k9mr7480466obr.34.1386450953935;
        Sat, 07 Dec 2013 13:15:53 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id n3sm1057704oep.2.2013.12.07.13.15.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 13:15:53 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1+fc1
In-Reply-To: <1386450492-22348-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239023>

So the remote-helpers can tell us when a forced push was needed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport-helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 60fba99..23af747 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -644,7 +644,7 @@ static int push_update_ref_status(struct strbuf *buf,
 				   struct ref *remote_refs)
 {
 	char *refname, *msg;
-	int status;
+	int status, forced = 0;
 
 	if (!prefixcmp(buf->buf, "ok ")) {
 		status = REF_STATUS_OK;
@@ -702,6 +702,11 @@ static int push_update_ref_status(struct strbuf *buf,
 			free(msg);
 			msg = NULL;
 		}
+		else if (!strcmp(msg, "forced update")) {
+			forced = 1;
+			free(msg);
+			msg = NULL;
+		}
 	}
 
 	if (*ref)
@@ -723,6 +728,7 @@ static int push_update_ref_status(struct strbuf *buf,
 	}
 
 	(*ref)->status = status;
+	(*ref)->forced_update = forced;
 	(*ref)->remote_status = msg;
 	return !(status == REF_STATUS_OK);
 }
-- 
1.8.5.1+fc1
