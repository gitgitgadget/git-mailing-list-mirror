From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 04/11] transport-helper: check for 'forced update' message
Date: Tue, 12 Nov 2013 14:56:57 -0600
Message-ID: <1384289830-5471-5-git-send-email-felipe.contreras@gmail.com>
References: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 22:06:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgL9r-00015Q-Q6
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756582Ab3KLVFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:05:44 -0500
Received: from mail-oa0-f54.google.com ([209.85.219.54]:41590 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208Ab3KLVEP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:04:15 -0500
Received: by mail-oa0-f54.google.com with SMTP id o6so4090790oag.41
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1cNi5DfrhlaLqcABnMPMoQcD8DSJ29ibAjRyHBQLDgg=;
        b=aeBpEVisolvQSHhCTiGNJGuumena4cRsWJ8rrfLyz46FWyoL5ogbPRngDw1pn1h9+I
         gUiGBWdNf9tITD/3qwRmpY8kzyrxlz4Yhvwg+bhQ2gVw3VabcdYC1lXJVVrINSADtYuc
         NKco3QUYKm4J+DINApqjxNYjTB7tPn20qsrYaH1Lo7/GJSaCXEN4/U23XAMf8XT9QJFO
         Q2VRKzahbw4+XcuNHrR3IPECi1glJPNznxw0NKu3xyUvX49X05gRu2rcdfQ44M11OuGl
         4tz1Ff0A/QST0M3/gVuLAnA8FYkHZTOWq5rF2Ii4eICfcku2pfjXhrJmMr50x/3o2/cM
         t/nA==
X-Received: by 10.60.55.104 with SMTP id r8mr3397974oep.87.1384290254563;
        Tue, 12 Nov 2013 13:04:14 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xr8sm35388842obc.12.2013.11.12.13.04.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 13:04:13 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237755>

So the remote-helpers can tell us when a forced push was needed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
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
1.8.4.2+fc1
