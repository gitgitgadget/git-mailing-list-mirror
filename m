From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 6/6] sha1_name: allow @@{u} to work
Date: Tue, 30 Apr 2013 16:49:14 -0500
Message-ID: <1367358554-4257-7-git-send-email-felipe.contreras@gmail.com>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, "Duy Nguyen\"" <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 23:51:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXIRt-0003XS-WA
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 23:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933857Ab3D3Vu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 17:50:56 -0400
Received: from mail-ye0-f176.google.com ([209.85.213.176]:49652 "EHLO
	mail-ye0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933839Ab3D3Vux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 17:50:53 -0400
Received: by mail-ye0-f176.google.com with SMTP id r9so162594yen.7
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 14:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=mNaH+nI/ZNWdEj+BDuWXv1j+NCIuEkQ1KUPCzp/EU2g=;
        b=qn+1flxbrdKk2Yct4Xu5Q5U4xCsLpu/1by0wJDSPq5eKALkZOEFn/nfnyvRUfgH91q
         SVEZQrVD/IV388sWpRmo4ORvWzxEg8TDYUCVaUm1ACN6shlaMSd4Xv8rSDlcKtI9mL32
         +YlApLNot/JCd/f+w/EsBFMLo0kg0H7hCiIe+YCFqSR4VjvBzXPfebv4P+OMe9rUAXZu
         cWJBLaFL2g7lmGj040Q2cMJQ8xUwh9YQ/3iHE3VR21eEox2JdX/mSJ4jZkPmQu6Ekrjn
         siPwtFD8YlL1Q0e0r/If1BG9jA1UkzgucJViJWpETX0wyAoh/uIFXjjs5whpmpSlCheI
         1qvw==
X-Received: by 10.236.222.8 with SMTP id s8mr140208yhp.116.1367358652346;
        Tue, 30 Apr 2013 14:50:52 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i67sm291732yhq.25.2013.04.30.14.50.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 14:50:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.395.gfe9a10d
In-Reply-To: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223019>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c                | 21 +++++++++++++++++++++
 t/t1508-at-combinations.sh |  2 +-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 887de6c..8f65bad 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -969,6 +969,21 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
 	return st;
 }
 
+static int interpret_empty_at(const char *name, int namelen, int len, struct strbuf *buf)
+{
+	if (namelen - len <= 1 || name[len + 1] == '{')
+		return -1;
+
+	strbuf_reset(buf);
+	if (len == 0) {
+		strbuf_add(buf, "HEAD", 4);
+		return 1;
+	} else {
+		strbuf_add(buf, name, len);
+		return len + 1;
+	}
+}
+
 static int reinterpret(const char *name, int namelen, int len, struct strbuf *buf)
 {
 	/* we have extra data, which might need further processing */
@@ -1029,9 +1044,15 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 	cp = strchr(name, '@');
 	if (!cp)
 		return -1;
+
+	len = interpret_empty_at(name, namelen, cp - name, buf);
+	if (len > 0)
+		return reinterpret(name, namelen, len, buf);
+
 	tmp_len = upstream_mark(cp, namelen - (cp - name));
 	if (!tmp_len)
 		return -1;
+
 	len = cp + tmp_len - name;
 	cp = xstrndup(name, cp - name);
 	upstream = branch_get(*cp ? cp : NULL);
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 50035cd..65584c0 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -47,7 +47,7 @@ check "@{-1}@{u}" master-two
 check "@{-1}@{u}@{1}" master-one
 check "@" new-two
 check "HEAD@{u}" upstream-two
-check "@@{u}" upstream-two failure
+check "@@{u}" upstream-two
 nonsense "@{u}@{-1}"
 nonsense "@{1}@{u}"
 
-- 
1.8.3.rc0.395.gfe9a10d
