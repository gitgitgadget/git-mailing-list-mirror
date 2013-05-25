From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/9] transport-helper: check for 'forced update' message
Date: Fri, 24 May 2013 21:47:34 -0500
Message-ID: <1369450060-19011-4-git-send-email-felipe.contreras@gmail.com>
References: <1369450060-19011-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:50:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Yr-0005Kq-CP
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946Ab3EYCuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:50:18 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:56243 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755755Ab3EYCuP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:50:15 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so6953925oag.5
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=k8UTYTkJaLUqMQEb6OD7qR3s6mtA+YkTNJQMEJCyjS8=;
        b=bDdB+fGfBDABAJ3NGIdYZ8E0dG8Vg0f7dmW764z2fx2TdhA3d32jhTR1a7izRMUINX
         tp7pbDuKB1rurN7l3Xk4nJ4xf2ypH9lC72jdHmBxx0CyixRk1WVipthtGN2Xhpmd9MKS
         CvGbK81c3XvK5MMvsgFirmp0RINpMwMqCVzeNB0buJeQJpnLBqwSg/V+E4xY8cmr1r/v
         8CPzBSOB+z15x5XJKCT1laXTg0wY/6IhMtEAdT56QBsW6N6FbIaPbAadz63mqLu1tsJ/
         PJqjGMDDtsq6lpKTelQ3fBJ5XfHCWkWVireDRHiVIejXgpxaCDRSsGlGluuZwnCNcNhM
         p+Qw==
X-Received: by 10.182.246.198 with SMTP id xy6mr13546805obc.1.1369450215482;
        Fri, 24 May 2013 19:50:15 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x10sm20618414oes.6.2013.05.24.19.50.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:50:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369450060-19011-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225478>

So the remote-helpers can tell us when a forced push was needed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 22f31a2..e461764 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -630,7 +630,7 @@ static int push_update_ref_status(struct strbuf *buf,
 				   struct ref *remote_refs)
 {
 	char *refname, *msg;
-	int status;
+	int status, forced = 0;
 
 	if (!prefixcmp(buf->buf, "ok ")) {
 		status = REF_STATUS_OK;
@@ -683,6 +683,11 @@ static int push_update_ref_status(struct strbuf *buf,
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
@@ -704,6 +709,7 @@ static int push_update_ref_status(struct strbuf *buf,
 	}
 
 	(*ref)->status = status;
+	(*ref)->forced_update = forced;
 	(*ref)->remote_status = msg;
 	return !(status == REF_STATUS_OK);
 }
-- 
1.8.3.rc3.312.g47657de
