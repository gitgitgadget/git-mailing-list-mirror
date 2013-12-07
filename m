From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 2/6] transport-helper: don't update refs in dry-run
Date: Sat,  7 Dec 2013 15:08:08 -0600
Message-ID: <1386450492-22348-3-git-send-email-felipe.contreras@gmail.com>
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
	id 1VpPEG-0002x8-G5
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 22:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758854Ab3LGVPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 16:15:52 -0500
Received: from mail-oa0-f44.google.com ([209.85.219.44]:58186 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756025Ab3LGVPt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 16:15:49 -0500
Received: by mail-oa0-f44.google.com with SMTP id m1so2340296oag.17
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 13:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qtTaDdvq85cBrfQEJ4Y+Y08H6OnL9CGkh7hL2sm3Bns=;
        b=LLKBP2xEdTReGsp143h4kg9JupBGvTRlnedYgqR+Ap22IY+XCXqIfNZI7aR7CGkblB
         5pS0BUxNbxVvD6rjxKjEHom2qXaH5pHqgbzm/6OdFioHYEDmJyBjTu+RMvJ4sFoZeCyC
         8cuanwd1Dam4kt46mress7VOtM3u1FjblOjwkpVSYCtT2K0qdx6Y1BZDrhn0jzQK4Nn+
         n9SxVT2ZBcvHy2p1toHmBbKqMljgcVBFL+V7SldHc6bn4ZO+aDMq204W6EGf2lg6Et0E
         lTtGYAa5cOI4B93HSTIIPVJhcP3Y4j8FDmarnv/JPZCjsv+JYKVXL7bpA6LhFkjnwyQo
         AXrw==
X-Received: by 10.60.155.135 with SMTP id vw7mr7643106oeb.9.1386450948249;
        Sat, 07 Dec 2013 13:15:48 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id qe2sm5986910obc.1.2013.12.07.13.15.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 13:15:46 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1+fc1
In-Reply-To: <1386450492-22348-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239024>

The remote helper namespace should not be updated.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport-helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index b66c7fd..9558a0d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -728,7 +728,8 @@ static int push_update_ref_status(struct strbuf *buf,
 }
 
 static void push_update_refs_status(struct helper_data *data,
-				    struct ref *remote_refs)
+				    struct ref *remote_refs,
+				    int flags)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct ref *ref = remote_refs;
@@ -742,7 +743,7 @@ static void push_update_refs_status(struct helper_data *data,
 		if (push_update_ref_status(&buf, &ref, remote_refs))
 			continue;
 
-		if (!data->refspecs || data->no_private_update)
+		if (flags & TRANSPORT_PUSH_DRY_RUN || !data->refspecs || data->no_private_update)
 			continue;
 
 		/* propagate back the update to the remote namespace */
@@ -833,7 +834,7 @@ static int push_refs_with_push(struct transport *transport,
 	sendline(data, &buf);
 	strbuf_release(&buf);
 
-	push_update_refs_status(data, remote_refs);
+	push_update_refs_status(data, remote_refs, flags);
 	return 0;
 }
 
@@ -887,7 +888,7 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
-	push_update_refs_status(data, remote_refs);
+	push_update_refs_status(data, remote_refs, flags);
 	return 0;
 }
 
-- 
1.8.5.1+fc1
