From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 9/9] transport-helper: don't update refs in dry-run
Date: Thu, 29 Aug 2013 10:23:28 -0500
Message-ID: <1377789808-2213-10-git-send-email-felipe.contreras@gmail.com>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 17:29:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF4AC-0000um-Ug
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 17:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341Ab3H2P3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 11:29:32 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:55647 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862Ab3H2P3c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 11:29:32 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so760609oah.37
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 08:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SkN44XEGKusuFqV8B8SmB37exHDr0Xyx/t13zMH3LkQ=;
        b=rbpIl3gYmohPWsDZEvfcmJiMDb/C6nkXGDTNhW4ALZ81aqW0ATelaeQEQgBvoBWmA+
         FNnGgxz9cbsnHGHywfixk9YuYL2mvVue9DJohzKkKgH09XDr3VUaN3OnMS6Z7Ej3ae6A
         5NhEUy7q6ggzO+EI/E9QvUWVvYM+fetSpVWxld/fyXWzmHmjKusq0gHDdcvfMZ2qtV8v
         +NygXx5kTmzewVbc17c87A4ZXdcBJXoPiS8+Zcz2NXAN2fpSMeVJ51Me5QIwGcjC8DfP
         apRdpWOW3juC5S4V7XFdQ7ABYOVeHOePfzE3Ky9n4Whz4lgv8wKNNZA3Twae/KrKv7qt
         BtcA==
X-Received: by 10.182.110.164 with SMTP id ib4mr2842583obb.87.1377790171892;
        Thu, 29 Aug 2013 08:29:31 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm31935320obg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 08:29:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233276>

The remote helper namespace should not be updated.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 5490796..9bbf209 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -715,7 +715,8 @@ static int push_update_ref_status(struct strbuf *buf,
 }
 
 static void push_update_refs_status(struct helper_data *data,
-				    struct ref *remote_refs)
+				    struct ref *remote_refs,
+				    int flags)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct ref *ref = remote_refs;
@@ -729,7 +730,7 @@ static void push_update_refs_status(struct helper_data *data,
 		if (push_update_ref_status(&buf, &ref, remote_refs))
 			continue;
 
-		if (!data->refspecs)
+		if (flags & TRANSPORT_PUSH_DRY_RUN || !data->refspecs)
 			continue;
 
 		/* propagate back the update to the remote namespace */
@@ -799,7 +800,7 @@ static int push_refs_with_push(struct transport *transport,
 	sendline(data, &buf);
 	strbuf_release(&buf);
 
-	push_update_refs_status(data, remote_refs);
+	push_update_refs_status(data, remote_refs, flags);
 	return 0;
 }
 
@@ -867,7 +868,7 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
-	push_update_refs_status(data, remote_refs);
+	push_update_refs_status(data, remote_refs, flags);
 	return 0;
 }
 
-- 
1.8.4-fc
