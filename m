From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 8/9] sha1_name: simplify track finding
Date: Thu, 10 Apr 2014 14:04:45 -0500
Message-ID: <1397156686-31349-9-git-send-email-felipe.contreras@gmail.com>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 21:15:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYKRt-0006kc-BH
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 21:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161211AbaDJTPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 15:15:38 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:65103 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161185AbaDJTPd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 15:15:33 -0400
Received: by mail-oa0-f44.google.com with SMTP id n16so5043548oag.31
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wBFM7UUTwzOpGi5Mg+LHTrCtBRBkXpcTH8VzMmZD0Og=;
        b=bE4bf/03ljcUc1XsOx2yV4/WP9gH1RYQGh1bCsYRx57SlV/7cZBiyhmkO131GCwGDK
         vDSPlDieeWZIUahJZtwFAfhcijxOQcJH5nvN9eVz5wXd4U2LVwK/Q32RFOpBjZRAcIS5
         rh7NCjO1T6f1LbXba/g1/x//Wl18fK2nSB80y9Dwpqg1XIrA0CkT1wkAttXDQbi7bpVL
         QctuybwF1Bo4iphcPC6173Z6FfmkkYXzRTag1D26QqRJ00n677UMkxUa9BPJtdMSIRFt
         exp3menv7dDv4Nmlvq+wiaY7elEJM29JGyGIIe9FvJ4LiT4PHHcyeWmg1xhrsEk0bDsr
         A+UA==
X-Received: by 10.182.102.134 with SMTP id fo6mr15401264obb.10.1397157332647;
        Thu, 10 Apr 2014 12:15:32 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id oz15sm21216103oeb.13.2014.04.10.12.15.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 12:15:29 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246046>

It's more efficient to check for the braces first.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 906f09d..aa3f3e0 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -417,7 +417,7 @@ static int ambiguous_path(const char *path, int len)
 
 static inline int upstream_mark(const char *string, int len)
 {
-	const char *suffix[] = { "@{upstream}", "@{u}" };
+	const char *suffix[] = { "upstream", "u" };
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(suffix); i++) {
@@ -475,7 +475,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 					nth_prior = 1;
 					continue;
 				}
-				if (!upstream_mark(str + at, len - at)) {
+				if (!upstream_mark(str + at + 2, len - at - 3)) {
 					reflog_len = (len-1) - (at+2);
 					len = at;
 				}
@@ -1089,7 +1089,10 @@ static int interpret_upstream_mark(const char *name, int namelen,
 {
 	int len;
 
-	len = upstream_mark(name + at, namelen - at);
+	if (name[at + 1] != '{' || name[namelen - 1] != '}')
+		return -1;
+
+	len = upstream_mark(name + at + 2, namelen - at - 3);
 	if (!len)
 		return -1;
 
@@ -1097,7 +1100,7 @@ static int interpret_upstream_mark(const char *name, int namelen,
 		return -1;
 
 	set_shortened_ref(buf, get_upstream_branch(name, at));
-	return len + at;
+	return len + at + 3;
 }
 
 /*
-- 
1.9.1+fc1
