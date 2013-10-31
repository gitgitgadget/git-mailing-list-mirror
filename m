From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 04/10] transport-helper: check for 'forced update' message
Date: Thu, 31 Oct 2013 03:36:36 -0600
Message-ID: <1383212197-14259-10-git-send-email-felipe.contreras@gmail.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:43:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbonB-0003uF-Ow
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814Ab3JaJnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:43:41 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:41596 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756Ab3JaJnk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:43:40 -0400
Received: by mail-oa0-f48.google.com with SMTP id m17so2785458oag.35
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=quKXJBK0MToZGDOHhEBkIV4h5fUV/9O86xKIXFTheZY=;
        b=UpzKZzWL1A1pm3MSOXRBtxJkH7nFNyN8i3xP+UHqiVhv6/Q/ilfNb+nOyB9KC9DLcj
         cYyzXbERNiN+ehdYBUjEy0Dvm72fi6YJM5cYv6/LFoMDH0IDyP9Gl5yaZoOq0sks3nzn
         mxJKqxa9uuic6syBqfXwF9/C3umOUaFTqNKkRblYeVhKoeCwdA/OthE+abCiPYLLQn//
         0rJyxkrpE8UztT18fKemrfp9BGp4C67qK3PIjotoBeoY9uqA0Lk+zu6l6kQZn/QBoRjl
         J7Xt5sy3a83If6xGtsm2mrF8R/d+3x61dbvgnBYryi5WqIX6XynDlC7y44k4TSYEtcwR
         u5yg==
X-Received: by 10.182.102.2 with SMTP id fk2mr1195468obb.69.1383212619591;
        Thu, 31 Oct 2013 02:43:39 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm5493207oeb.0.2013.10.31.02.43.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:43:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237108>

So the remote-helpers can tell us when a forced push was needed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index ed238e5..5aba15c 100644
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
1.8.4.2+fc1
