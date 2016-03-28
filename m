From: Hui Yiqun <huiyiqun@gmail.com>
Subject: [PATCH v2] path.c enter_repo(): fix unproper strbuf unwrapping and memory leakage
Date: Mon, 28 Mar 2016 23:56:10 +0800
Message-ID: <1459180570-5521-1-git-send-email-huiyiqun@gmail.com>
References: <20160325175947.GC10563@sigill.intra.peff.net>
Cc: gitster@pobox.com, pickfire@riseup.net, peff@peff.net,
	Hui Yiqun <huiyiqun@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 17:56:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akZWi-0000P4-V8
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 17:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618AbcC1P4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 11:56:21 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32810 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775AbcC1P4U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 11:56:20 -0400
Received: by mail-pf0-f193.google.com with SMTP id x3so21518418pfb.0
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 08:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UK2KOG+cKqgqgBYHPQ6rlpoyGIAPKfe5BrRD0U6ThSY=;
        b=uf5EhGsKYCIHXa5Zcrr09E0acsrm8KsX8I6I6krKXfzyeA1FOndSthYb7jPRCWl08j
         oQ/OyVIRT93YeRm0fm7TfYRkyLf2UBpYTIud9gQpkEvxS2YgBN4GLLoO1Ytd/Kv9laSi
         V63dZMBVPWzT7wXJuuJ/R3R25BCxQsVwwMDrjDBBRJEIDU1Oo86Jw0RyfiN77T45XXMd
         MrsvHpqgwDHFX8sVOhD49bNuXB5VbkBFc3zgpnucPOaXC1+kCRmmMZYvuKwwUkWuIpwj
         p0Z4kU7zrJh90bSTyE5GRkCS7BdQE3kHDd9LU3CU+RN8lyY0622wcx3KQIEr7QEkzdXh
         YPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UK2KOG+cKqgqgBYHPQ6rlpoyGIAPKfe5BrRD0U6ThSY=;
        b=YbYYW5eOmtpBGINJvcCuw9W6cnY64fj9OfXXqeIpT2qW/0OlH4d0sfAIdp34DijCLt
         tutd9Hu3JiU5919BRWDFcmWgXoqLM+pCSVHvKwAGpgkHZgkqHj/U/ObXYaxVoNjGMw//
         3law79JcPy/SGq/jU9lwKg5lU6nh38Fs2KGoWloOSFDt1RTOcM/1ADyM+y63U5YJhqrb
         sbbIibc6A1G97ih7swRaA9he1S8qfE/egKJWvhWPX+Z2sWf/GlubEjpqP6P9R/+sGwRf
         8ywlnxCXyz5snkOZ+PQdyq2KrmR2NXDo5ngiBdnjmWh+rUNYNnPdFgMOvH9IZz2sways
         DrlA==
X-Gm-Message-State: AD7BkJJnU/hHQuva4ryfoPyPNnFvp6/BUN9G2iG/Xox/aPsxFCxQOJ5YVIHZH2kDpcDH+w==
X-Received: by 10.98.86.146 with SMTP id h18mr44098074pfj.9.1459180579943;
        Mon, 28 Mar 2016 08:56:19 -0700 (PDT)
Received: from localhost.localdomain (hashi.inv.dotkrnl.com. [133.130.122.94])
        by smtp.gmail.com with ESMTPSA id wb7sm36790333pab.3.2016.03.28.08.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Mar 2016 08:56:19 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20160325175947.GC10563@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290042>

According to strbuf.h, strbuf_detach is the sole supported method
to unwrap a memory buffer from its strbuf shell.

So we should not return the pointer of strbuf.buf directly.

What's more, some memory leakages are solved.
---
 path.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/path.c b/path.c
index 969b494..b07e5a7 100644
--- a/path.c
+++ b/path.c
@@ -625,6 +625,7 @@ const char *enter_repo(const char *path, int strict)
 {
 	static struct strbuf validated_path = STRBUF_INIT;
 	static struct strbuf used_path = STRBUF_INIT;
+	char * dbuf = NULL;
 
 	if (!path)
 		return NULL;
@@ -654,7 +655,7 @@ const char *enter_repo(const char *path, int strict)
 		if (used_path.buf[0] == '~') {
 			char *newpath = expand_user_path(used_path.buf);
 			if (!newpath)
-				return NULL;
+				goto return_null;
 			strbuf_attach(&used_path, newpath, strlen(newpath),
 				      strlen(newpath));
 		}
@@ -671,22 +672,22 @@ const char *enter_repo(const char *path, int strict)
 			strbuf_setlen(&used_path, baselen);
 		}
 		if (!suffix[i])
-			return NULL;
+			goto return_null;
 		gitfile = read_gitfile(used_path.buf);
 		if (gitfile) {
 			strbuf_reset(&used_path);
 			strbuf_addstr(&used_path, gitfile);
 		}
 		if (chdir(used_path.buf))
-			return NULL;
-		path = validated_path.buf;
+			goto return_null;
+		path = dbuf = strbuf_detach(&validated_path, NULL);
 	}
 	else {
 		const char *gitfile = read_gitfile(path);
 		if (gitfile)
 			path = gitfile;
 		if (chdir(path))
-			return NULL;
+			goto return_null;
 	}
 
 	if (is_git_directory(".")) {
@@ -695,6 +696,10 @@ const char *enter_repo(const char *path, int strict)
 		return path;
 	}
 
+return_null:
+    free(dbuf);
+	strbuf_release(&used_path);
+	strbuf_release(&validated_path);
 	return NULL;
 }
 
-- 
2.7.4
