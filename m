From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 03/10] transport-helper: check for 'forced update' message
Date: Sun, 27 Oct 2013 01:05:12 -0600
Message-ID: <1382857521-7005-2-git-send-email-felipe.contreras@gmail.com>
References: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 08:12:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaKWF-0006in-Jg
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 08:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942Ab3J0HMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 03:12:06 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:63441 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab3J0HME (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 03:12:04 -0400
Received: by mail-oa0-f52.google.com with SMTP id n10so2421175oag.25
        for <git@vger.kernel.org>; Sun, 27 Oct 2013 00:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1ylzNT92k4h3RbFqD1pCj5c4FOGmLWEke19HLZ818zQ=;
        b=WRkfeK2ER/C/9tFXt1fdfQTSM/nxipdkNaVuJikvGq43THkt4AS1B7mib4x18sYnfx
         /QjXH2IxNQwLLFde+WPCaVBeigXOSnYmxE1q55s90hS29NHkl7R+WivatCacnI/hKv4r
         SwXoDUn1w3tJMkxrtX0wQhZjs4l5mTs+GPOIDGFWWLmMBptAJs0r1gY5BcCFQ498gEoH
         wfwA5QK9VdQ8rhguBzV4rB9hjK4mgOB1hGkMH9OZoHqfG/RrJdyugpBnXfeTv8LsKASO
         jIIeDFEN0sbQd/ywLKUOE0VIZnqjFGtdsxwmoZoIUEnh253kWhSeXhRD+DUsfGt1gk84
         PHtw==
X-Received: by 10.182.215.202 with SMTP id ok10mr25080obc.62.1382857923639;
        Sun, 27 Oct 2013 00:12:03 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ee7sm22403920oeb.5.2013.10.27.00.12.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2013 00:12:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236780>

So the remote-helpers can tell us when a forced push was needed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 707351d..f8eb143 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -643,7 +643,7 @@ static int push_update_ref_status(struct strbuf *buf,
 				   struct ref *remote_refs)
 {
 	char *refname, *msg;
-	int status;
+	int status, forced = 0;
 
 	if (!prefixcmp(buf->buf, "ok ")) {
 		status = REF_STATUS_OK;
@@ -701,6 +701,11 @@ static int push_update_ref_status(struct strbuf *buf,
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
@@ -722,6 +727,7 @@ static int push_update_ref_status(struct strbuf *buf,
 	}
 
 	(*ref)->status = status;
+	(*ref)->forced_update = forced;
 	(*ref)->remote_status = msg;
 	return !(status == REF_STATUS_OK);
 }
-- 
1.8.4-fc
