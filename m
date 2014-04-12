From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v9 4/6] transport-helper: check for 'forced update' message
Date: Sat, 12 Apr 2014 15:12:53 -0500
Message-ID: <1397333575-11614-5-git-send-email-felipe.contreras@gmail.com>
References: <1397333575-11614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 22:23:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ4Sx-0007aI-5I
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 22:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234AbaDLUXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 16:23:44 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:36326 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715AbaDLUXN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 16:23:13 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so7655103oah.38
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 13:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wq6soKgujI5g4EtZuFArVCQmA0wl1LRIxcrxdaytziY=;
        b=OBRBf2ctFVecfe3mNOzk8OMZDjouQNgV0e/BKE9u3FZkWxG4qPqp+0XbcBjCme+jWQ
         nLRWRgsPTipGCnYaZX6BddbRp4ztLdzZ8saRienDmA1cdzyfXff/UW7Kfpq8zdq8Z6Qm
         Oh3ulSAet1ISqyuV1NaJ+SpY00CoeWEtGz45z5ZD3z+5taakPwzVtG1vwbUH+o7R8L3p
         k18Efk6eQ8L8GiZe79D4y22bUZ9nIWGtLSqcl5PYFgzNvJJEnmJ2LGtIkS615KqlJYe6
         ZcR1lzVo25TP4DHu4xdxu2haX2cI9xHqRWetRoBO/X7vfff6HxCh0p3kSDNkQ1xW6Mc+
         j38w==
X-Received: by 10.60.76.194 with SMTP id m2mr3543532oew.47.1397334192799;
        Sat, 12 Apr 2014 13:23:12 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c9sm19160391obq.20.2014.04.12.13.23.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 13:23:11 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1397333575-11614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246184>

So the remote-helpers can tell us when a forced push was needed.

Helped-by: Max Horn <max@quendi.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport-helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index f50e84f..86e1679 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -650,7 +650,7 @@ static int push_update_ref_status(struct strbuf *buf,
 				   struct ref *remote_refs)
 {
 	char *refname, *msg;
-	int status;
+	int status, forced = 0;
 
 	if (starts_with(buf->buf, "ok ")) {
 		status = REF_STATUS_OK;
@@ -708,6 +708,11 @@ static int push_update_ref_status(struct strbuf *buf,
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
@@ -729,6 +734,7 @@ static int push_update_ref_status(struct strbuf *buf,
 	}
 
 	(*ref)->status = status;
+	(*ref)->forced_update |= forced;
 	(*ref)->remote_status = msg;
 	return !(status == REF_STATUS_OK);
 }
-- 
1.9.1+fc3.9.gc73078e
