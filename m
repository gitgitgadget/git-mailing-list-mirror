From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 7/7] sha1_name: simplify track finding
Date: Sat,  7 Dec 2013 23:57:00 -0600
Message-ID: <1386482220-18558-8-git-send-email-felipe.contreras@gmail.com>
References: <1386482220-18558-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 08 07:06:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpXVE-0004iR-Lb
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 07:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463Ab3LHGFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 01:05:54 -0500
Received: from mail-oa0-f50.google.com ([209.85.219.50]:42869 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab3LHGEu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 01:04:50 -0500
Received: by mail-oa0-f50.google.com with SMTP id n16so2591630oag.9
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 22:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xLDyWQ4Ns0n2lLmfJO/GzrVa3oBn6SXKRFHpyiaDZXY=;
        b=yOw0CkHnOByB5d3VgQsX0Z49jtdKtgfb5RffuDxCj8G5wd2jXDSoiwpLOuR7bxIGEQ
         6SbsLROGOBMpUSPTEyrMqg0hHmk/wiYAPOjdlEm+hzBJKmuw3hzmnh4MvncKjJWCMY7G
         zdtzGdeU987Cggdeso1p2bJXGYzFbwo5KWs/7/GjDeUbrP16IrQznZM2L4uVOG5z6ZWR
         VNGE6gezkStpGovT2JOvTq9qpIPmTrjipmqtWvamt9XZuM5tMAV+0AxOZ/WrhYPt7tOA
         F/NlzlDVNLX33MBEa7mGYpKMbNaGTapvpe/UKoJtiiz7gyq1zJ2HGhMukSXZimQLUm2V
         xyKw==
X-Received: by 10.60.98.239 with SMTP id el15mr8699929oeb.45.1386482690468;
        Sat, 07 Dec 2013 22:04:50 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u9sm10737293oey.0.2013.12.07.22.04.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 22:04:49 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1+fc1.2.gebd1fb1
In-Reply-To: <1386482220-18558-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239037>

It's more efficient to check for the braces first, and we already have
the length of the whole thing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index e27db88..1a68103 100644
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
@@ -1074,7 +1074,6 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 	char *cp;
 	struct branch *branch;
 	int len = interpret_nth_prior_checkout(name, buf);
-	int tmp_len;
 
 	if (!namelen)
 		namelen = strlen(name);
@@ -1096,11 +1095,13 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 	if (len > 0)
 		return reinterpret(name, namelen, len, buf);
 
-	tmp_len = upstream_mark(cp, namelen - (cp - name));
-	if (!tmp_len)
+	len = namelen - (cp - name);
+	if (cp[1] != '{' && cp[len - 1] != '}')
+		return -1;
+
+	if (!upstream_mark(cp + 2, len - 3))
 		return -1;
 
-	len = cp + tmp_len - name;
 	cp = xstrndup(name, cp - name);
 	branch = branch_get(*cp ? cp : NULL);
 	/*
@@ -1125,7 +1126,7 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 	strbuf_reset(buf);
 	strbuf_addstr(buf, cp);
 	free(cp);
-	return len;
+	return namelen;
 }
 
 int strbuf_branchname(struct strbuf *sb, const char *name)
-- 
1.8.5.1+fc1.2.gebd1fb1
