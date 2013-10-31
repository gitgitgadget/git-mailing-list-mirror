From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 02/10] transport-helper: don't update refs in dry-run
Date: Thu, 31 Oct 2013 03:36:37 -0600
Message-ID: <1383212197-14259-11-git-send-email-felipe.contreras@gmail.com>
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
	id 1VbonC-0003uF-Bm
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820Ab3JaJnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:43:43 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:57123 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750Ab3JaJnm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:43:42 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so2811347oag.31
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sA18jhsYHrezqQAAW/gl7wLU5xf6wGRUSLon4SBeRj0=;
        b=ZTwHGl8lDuDwJG3MGc+iWqC8LQmhRBBJLCdusmnN4/ZbldF/QUiNEduxb1spsWV+JF
         o8KBLUXLb/62A6QVlHwTK57NWe3Z8TtWPzvBzsPlumUFOPwSYlxPx09pJPtAHNIjyijS
         3scaNTh8hp9kUY65dO3wGxEgGr0lEcNxnZue0cXa0GEBa/Mh/0I8Eys+U6C+tYz9T7k+
         p80JwcxI3MkZQ1HMpfdxoffZHOXkdG1J2fQAsHaVK+70qCaJwtWPUpznisYDXBaWVT3c
         XgmXaDN4yS7+83cIY4bS3OplhfPAz/cQW23qfW+TwhRbK4jYLiNwTDLqu2oZo3i/GlPc
         LQzw==
X-Received: by 10.60.174.75 with SMTP id bq11mr1860478oec.17.1383212621863;
        Thu, 31 Oct 2013 02:43:41 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ee7sm5453274oeb.5.2013.10.31.02.43.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:43:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237110>

The remote helper namespace should not be updated.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 985eeea..d05fc7c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -727,7 +727,8 @@ static int push_update_ref_status(struct strbuf *buf,
 }
 
 static void push_update_refs_status(struct helper_data *data,
-				    struct ref *remote_refs)
+				    struct ref *remote_refs,
+				    int flags)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct ref *ref = remote_refs;
@@ -741,7 +742,7 @@ static void push_update_refs_status(struct helper_data *data,
 		if (push_update_ref_status(&buf, &ref, remote_refs))
 			continue;
 
-		if (!data->refspecs || data->no_private_update)
+		if (flags & TRANSPORT_PUSH_DRY_RUN || !data->refspecs || data->no_private_update)
 			continue;
 
 		/* propagate back the update to the remote namespace */
@@ -832,7 +833,7 @@ static int push_refs_with_push(struct transport *transport,
 	sendline(data, &buf);
 	strbuf_release(&buf);
 
-	push_update_refs_status(data, remote_refs);
+	push_update_refs_status(data, remote_refs, flags);
 	return 0;
 }
 
@@ -886,7 +887,7 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
-	push_update_refs_status(data, remote_refs);
+	push_update_refs_status(data, remote_refs, flags);
 	return 0;
 }
 
-- 
1.8.4.2+fc1
