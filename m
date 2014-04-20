From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 7/8] sha1_name: simplify track finding
Date: Sun, 20 Apr 2014 14:45:05 -0500
Message-ID: <1398023106-25958-8-git-send-email-felipe.contreras@gmail.com>
References: <1398023106-25958-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:56:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbxqf-0006hB-8F
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 21:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755551AbaDTT4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 15:56:07 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:49846 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755530AbaDTTzs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 15:55:48 -0400
Received: by mail-yh0-f47.google.com with SMTP id 29so2932701yhl.6
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 12:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aB7oYujYK6pg33G/yj/JMuGazA1l5HOQm5F6/c+a9cs=;
        b=Qqqr9pWFlUshxuXi11svUkXpYGaFul8/gRIqBoFyIKNsDe5rFInp7KNmWUTTr8hEuQ
         VDo7Pp2rX6cNmWcFVaJ9cDb7eRQkltNBUFkrsHJQRXb1lZbItJm+dcPaEU5L0mYSN2nC
         zvE8q75/ThJQYjm2s+BhpaXDX+XTvRvQe6qUSoAE1hrFYe3QyZsp5PoRapWZDaaLajqO
         gKOmXLq77uf5fPvXsQYpk5PEsaO7AjCDsWEW2PKxOjWBKMUkW07BiwrpuHtHi6J5slJ9
         WVaqpdEsYnxH9VKMjZqeBLtR3M8Pwmc8zckdKxIZ5DkANggYZMmUkF+BnmsByAAyTuiO
         5BLg==
X-Received: by 10.236.101.198 with SMTP id b46mr12562022yhg.68.1398023747609;
        Sun, 20 Apr 2014 12:55:47 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c66sm65579144yhk.23.2014.04.20.12.55.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 12:55:46 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1398023106-25958-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246575>

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
1.9.1+fc3.9.gc73078e
