From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 03/10] transport-helper: check for 'forced update' message
Date: Sat, 12 Oct 2013 02:05:24 -0500
Message-ID: <1381561533-20381-2-git-send-email-felipe.contreras@gmail.com>
References: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:11:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtMb-0004MJ-B8
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844Ab3JLHLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:11:39 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:54097 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab3JLHLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:11:37 -0400
Received: by mail-oa0-f54.google.com with SMTP id n5so3150520oag.13
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mIJl9jSQ9pP8BtKoM5CxguCUK0US6fd7eJ5lw+wG1Kk=;
        b=WckuKh+uI+wvlQnRJ0hLia39IFJgS/SpHEU3sZxVurNkw5no2oBHlOKtPf9r3MeT5I
         MLeMKiqd3OJp0TrxpaYnU+puOcFoAcg3TI2WPcFPDh5g5BsS3roHahX8Irh+ejfaa/5d
         Ubc8tma8KnnBSe/m6zDJ4ki4P4ELWMEHjRscDWz5B+pq2Hy4EcKhwFswaYOE1F6VoJwZ
         e4jvoM9yh5N6R0KQj/3XTi3+ZYMjJHW5N5egXOjeaiJWKWLP6ITeYAYs/lI0AJytFDa+
         RCFtXkGEW3Co0bPdxhFdlNBOcz1yXkcHgKAlm/509P6Q1+HQpMURFcPsXSJeN7YlK7Gb
         j+Ew==
X-Received: by 10.60.40.67 with SMTP id v3mr18202601oek.16.1381561896766;
        Sat, 12 Oct 2013 00:11:36 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm101375836oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235972>

So the remote-helpers can tell us when a forced push was needed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index ed3384e..46b3e57 100644
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
1.8.4-fc
