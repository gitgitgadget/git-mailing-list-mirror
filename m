From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 23/24] introduce GIT_INDEX_VERSION environment variable
Date: Sun, 18 Aug 2013 21:42:12 +0200
Message-ID: <1376854933-31241-24-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:49:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8yk-0004Sm-8Z
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117Ab3HRTt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:49:29 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:36653 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098Ab3HRTt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:49:29 -0400
Received: by mail-we0-f169.google.com with SMTP id n5so3196904wev.0
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0WYPSUMpt5M+P69Lr7FckvAYqUq1pWuA0IAuj1sALoQ=;
        b=FafQB42j+ZKsQbSkXWJzyYSxKtQvF9cbzt6+IeBF4vBcJzo/+3RmG76cRH2EY0mBz6
         +dtq2SWLk2eBqnfj9xueASnnC5e8DD1z5szveFDjKURoYGBpU2ONLnbLcd4nEM8QBco5
         FIgpCgr8NQjInX4HJzQLIZqzTP4jxFarB6qXuwvzSWAwhm3Hr3UBtiQ7NEckB2XmQL+5
         x+Xfr2TpSaPfj3tyYMPlkffpso6mD7zPx811n1ZdjeDlk4qkNWOViTJP1HOIVlOM/VzC
         Ir81yloJ3sFMWQwPxf1FUzBS9VLebvO5iUeH+LHrikcLwAiX4VksbCqQSTaGf0Uz2N9L
         qkGg==
X-Received: by 10.180.9.66 with SMTP id x2mr5447658wia.35.1376855367915;
        Sun, 18 Aug 2013 12:49:27 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id ff5sm6923156wib.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:49:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232511>

Respect a GIT_INDEX_VERSION environment variable, when a new index is
initialized.  Setting the environment variable will not cause existing
index files to be converted to another format for additional safety.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 1d9b615..f820d8a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1235,8 +1235,13 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
 void initialize_index(struct index_state *istate, int version)
 {
 	istate->initialized = 1;
-	if (!version)
-		version = INDEX_FORMAT_DEFAULT;
+	if (!version) {
+		char *envversion = getenv("GIT_INDEX_VERSION");
+		if (!envversion)
+			version = INDEX_FORMAT_DEFAULT;
+		else
+			version = atoi(envversion);
+	}
 	istate->version = version;
 	set_istate_ops(istate);
 }
-- 
1.8.3.4.1231.g9fbf354.dirty
