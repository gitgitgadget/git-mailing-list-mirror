From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 10/10] transport-helper: don't update refs in dry-run
Date: Sat, 12 Oct 2013 02:05:31 -0500
Message-ID: <1381561533-20381-9-git-send-email-felipe.contreras@gmail.com>
References: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtMx-0004bU-DB
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110Ab3JLHL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:11:56 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:56333 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab3JLHLy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:11:54 -0400
Received: by mail-oa0-f49.google.com with SMTP id j10so494083oah.22
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=skt764SyoluIoR5MofZS401r5Lf6O9C8/V44jivGnXg=;
        b=fXyteFhHxjwQGON4amZ/jnSAmcMv7s1bZorwNfJf/VdChLUiD0st6+ayFtCsL3kiEi
         GHAdN0l/m/j/wZgny4rSnLIFBslLDhlweQDbChWPMIwq9xG1W27JwwcvUrAC7feqIBAj
         X4lJPZR3TXGJKzgeZJC2bsO8iCFSmyQUAUBK4BgbU5EeFHvuMA6VsZDyF8VkbQ74D3as
         aMUe8uwm2xLmUIx3m6Lx+SdXgoev6V7PoGs/MReJ24iwTEVTzM+mywNEhiBtVZCTARgd
         1DIXdqMT9Ns4+Oc997f+n6kTaytV/NKdjIzG42XxVyVckLFv1u9/Dzyd9AmaiLhoihIA
         6Zww==
X-Received: by 10.60.142.8 with SMTP id rs8mr17999827oeb.34.1381561914477;
        Sat, 12 Oct 2013 00:11:54 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm28625176obb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235985>

The remote helper namespace should not be updated.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index ddb3309..d94eaf4 100644
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
 
@@ -869,7 +870,7 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
-	push_update_refs_status(data, remote_refs);
+	push_update_refs_status(data, remote_refs, flags);
 	return 0;
 }
 
-- 
1.8.4-fc
