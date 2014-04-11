From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 7/8] sha1_name: simplify track finding
Date: Fri, 11 Apr 2014 12:59:10 -0500
Message-ID: <1397239151-2391-8-git-send-email-felipe.contreras@gmail.com>
References: <1397239151-2391-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 20:09:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYftb-0007BA-Rf
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 20:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbaDKSJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 14:09:45 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:37118 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816AbaDKSJb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 14:09:31 -0400
Received: by mail-oa0-f43.google.com with SMTP id eb12so6557601oac.2
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 11:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wBFM7UUTwzOpGi5Mg+LHTrCtBRBkXpcTH8VzMmZD0Og=;
        b=ytcVHqN7uuSfOYpZmCAtdKG4x1vWMfwWhiM424/MQPhMmkjvCpXgVOlhsqBmEzxrlT
         SqJfwNEUrkXlPVS/tMgCcbe65V7Pu4BDCZxYEfmDas0unXnSe+ULrC+hbIK4AkTr42bd
         x6VCb1NItfA8cC16m2TJQZu4S7f2ZRFtFkA+RJWYb6K3NvfIHcEp6rjzIZCbck7n691T
         sG78r4uhWPSwljvwC4N5Y/yMhKJO/Ul/AphS0sy9KFf/RJA/fY4LV8yfGGh3LJ2KsilP
         r/f6r4ljJ/DgSsu8JUqDL+9ZorbTJJfgIJsrhCrMo3R0p+7WSapxePj4KabUeHyMyCgl
         Z8gQ==
X-Received: by 10.60.162.7 with SMTP id xw7mr20557778oeb.13.1397239771463;
        Fri, 11 Apr 2014 11:09:31 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id wy2sm13443261obc.21.2014.04.11.11.09.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 11:09:30 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397239151-2391-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246121>

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
