From: Hui Yiqun <huiyiqun@gmail.com>
Subject: [PATCH] path.c enter_repo(): fix unproper strbuf unwrapping and memory leakage
Date: Mon, 28 Mar 2016 23:51:32 +0800
Message-ID: <1459180292-3475-1-git-send-email-huiyiqun@gmail.com>
References: <20160325175947.GC10563@sigill.intra.peff.net>
Cc: gitster@pobox.com, pickfire@riseup.net, peff@peff.net,
	Hui Yiqun <huiyiqun@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 17:53:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akZTe-00072y-IO
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 17:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbcC1PxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 11:53:10 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36679 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbcC1PxI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 11:53:08 -0400
Received: by mail-pf0-f193.google.com with SMTP id q129so21819855pfb.3
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UK2KOG+cKqgqgBYHPQ6rlpoyGIAPKfe5BrRD0U6ThSY=;
        b=ZFzi0dk5yfqwZm+h5P9FrmnFqsBY1gpunoYhOVwFqDxI6vO2x/XjiqWzobJxkt+4sf
         9U9bMOG+bto9EaZYSo7/k6VsBF0UTk1CbbC5Ib9eb86cY8LnHKjdzd6ZRZ1M16XhIpKy
         Mu+N4hchN24W+SOuwwEs7IjQD2At+ZMyM/37/VsRKK+qu/+8CScypa34G4dC7cywUtB/
         U89j3SmmfBaTGisT7EMIHLVDlvCPfZsR45rrB5dNoGPKmK7k2xEzHY1FOCrmc5qeAGw7
         xaBGTkvQNWfuSjz/+0iHT5FSJTuePYSYJ4+bcwQlSRMTyz3LtOPu2r1SyPYaOA/LOGkd
         muJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UK2KOG+cKqgqgBYHPQ6rlpoyGIAPKfe5BrRD0U6ThSY=;
        b=aytSpBZSf8FI+HeOfMRiWRuz5/UykpnCVF6m978JLFVPZIIGTLwv6J4XwqeHoSXyfd
         PQ/v6MCxNYH0FTKcMjWYgg6juJn2+XMmgEh7nUF9TExzoedrM64D/CWYMYpch0XL4Ob3
         07pdR0CDntRHlEfCG6+AhTOPGwEO5+3PuBZpv2cJdCfSLqaAmj/qhdJ49yUf2d4B4pSR
         fwQJjjuTQvTMk4Qjgjj9d68odsqWk+QMPBj25JInHyqtjAEOlpKhBo/6MyO1ZXS+XEox
         HUbeRx7JS5AxyLHYSxUNgDZF7lDfLpDmS+um/w12f651N0LaAhMZUtBMxtJizjqk7fa0
         FuJw==
X-Gm-Message-State: AD7BkJLv8tmwtSxF0XuGxamsN0uGxcYYp5A4IuWQtXTdZUuzt22FPcANqAs2VGofNATTAw==
X-Received: by 10.98.33.203 with SMTP id o72mr44014222pfj.96.1459180387658;
        Mon, 28 Mar 2016 08:53:07 -0700 (PDT)
Received: from localhost.localdomain (hashi.inv.dotkrnl.com. [133.130.122.94])
        by smtp.gmail.com with ESMTPSA id g28sm36692518pfd.25.2016.03.28.08.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Mar 2016 08:53:07 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20160325175947.GC10563@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290041>

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
