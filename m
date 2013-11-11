From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 04/10] transport-helper: check for 'forced update' message
Date: Mon, 11 Nov 2013 16:55:06 -0600
Message-ID: <1384210507-26561-10-git-send-email-felipe.contreras@gmail.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 00:02:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg0V9-0006dG-0M
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 00:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555Ab3KKXCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 18:02:31 -0500
Received: from mail-oa0-f41.google.com ([209.85.219.41]:62805 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510Ab3KKXCW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 18:02:22 -0500
Received: by mail-oa0-f41.google.com with SMTP id g12so4489979oah.14
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 15:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sqbrWQtI+pZiIv1OofzBjDz6zcM50PqCH8C+w5l63jM=;
        b=MbaBvHYaMmAWNFJOHMJEhhJcslyf9mzYaD7UBRs9sdfPbJQA43LIzBZJxqP3CJHjTn
         Atnu0AUevLDxjARdMK1Kwabg04I8cOP/o/7GRnik4F5JvJZMXmReRhRDrslMUDcpW2vW
         5wZMGWbDE9Sb/0ruGDEIh6WD9Fdugj3dzdu4f7zbBb/JaH8qhk7YRfhxVJmup8d4x+Iz
         JnjOd8qIJ0E3vYGRI0b7CQD1fjDWBzuTLpAY3RB/u1w+5cffVP+AH038ei2t53axDZtz
         QjNbY+6J5kMEJdtlfW9qXk9PRYpafJ5wjxrjEc2wAHCZEgej4LwyLqyhD2il03PJw/oI
         6+kA==
X-Received: by 10.60.44.193 with SMTP id g1mr8263561oem.47.1384210942118;
        Mon, 11 Nov 2013 15:02:22 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id m7sm29280946obo.7.2013.11.11.15.02.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2013 15:02:21 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237672>

So the remote-helpers can tell us when a forced push was needed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index bead9b9..9a5814d 100644
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
