From: Hui Yiqun <huiyiqun@gmail.com>
Subject: [PATCH v3] path.c enter_repo(): fix unproper strbuf unwrapping and memory leakage
Date: Mon, 28 Mar 2016 23:57:18 +0800
Message-ID: <1459180638-6034-1-git-send-email-huiyiqun@gmail.com>
References: <20160325175947.GC10563@sigill.intra.peff.net>
Cc: gitster@pobox.com, pickfire@riseup.net, peff@peff.net,
	Hui Yiqun <huiyiqun@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 17:57:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akZY5-0001Gy-3C
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 17:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655AbcC1P5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 11:57:46 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34594 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782AbcC1P5o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 11:57:44 -0400
Received: by mail-pf0-f195.google.com with SMTP id n5so21478653pfn.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 08:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xuanp+W9vqXz92DAO3PF0JwxZw7Tt+ca8TBB/qjQynY=;
        b=p6HqTR40cS8JBJIUPbRla2g3Dr6tqWgHBy27HkLX6fwqUrCIywkVPXz+/O6hAucNCt
         Xb/Zd5Y7dLhzepdJaESImOW8GtjgR4Ck+InmufVpLdDm6AhNw+1VJvdKhq4lYkAri8OA
         sY4zpazaN9WEQgf4Nee+XBmBFxJOLm/2zEX7p6v6E807JWqDTimxZtRPdnHGWgJDJgYF
         zS36RUgW1WUcyXgOSKoMgEwCBMSK4m8/yGn+UJHWFnVJaYnCdrMPjVGHPfTH1345K7mG
         ilOWvjJd9dEHnThrVsGC3AKgRWYH+NXZ8/Kmj4kYbzCN1M6GND5yPbuSzDBv85e5M67P
         lKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xuanp+W9vqXz92DAO3PF0JwxZw7Tt+ca8TBB/qjQynY=;
        b=CnsBvGm98kNhmybgnw116DYKrcY8ujoGi6uvWXLEnyDeWK6qAZFv597sJgKhnIAc77
         bIdbMMm00leDTN4Uya8aR0/2URJnaeoC7I2q6kmGkcL9yTt+PUruORxhUGqksoVG2AzF
         JKnRS0ZpLzVVFdHqyoATJLkuRJNbqUluTZBEChLT9fuq8dZP6ayiad+0SR2Rtt+h4Hbf
         loeUbsUK0k/XbH6pZN61qhoEUcXB6xqjxabnGfucJShhIMAljXZYu8wbGEhcDG3DWA45
         eDQfsONrYH+vvy3a7WkaxR12x2WCzNEevn/LhJs7m3/qOz5gsDBLD+MYu04aGOdXuxut
         IjtA==
X-Gm-Message-State: AD7BkJK28J6KiPINtH0gcSp4tAQkR0GkVhOE6tLehUhZU7X2b5uNv0QRcwQiGTgnBvympA==
X-Received: by 10.98.31.21 with SMTP id f21mr42956477pff.134.1459180663731;
        Mon, 28 Mar 2016 08:57:43 -0700 (PDT)
Received: from localhost.localdomain (hashi.inv.dotkrnl.com. [133.130.122.94])
        by smtp.gmail.com with ESMTPSA id fa3sm36771982pab.45.2016.03.28.08.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Mar 2016 08:57:43 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20160325175947.GC10563@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290043>

According to strbuf.h, strbuf_detach is the sole supported method
to unwrap a memory buffer from its strbuf shell.

So we should not return the pointer of strbuf.buf directly.

What's more, some memory leakages are solved.
---
 path.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/path.c b/path.c
index 969b494..9801617 100644
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
+	free(dbuf);
+	strbuf_release(&used_path);
+	strbuf_release(&validated_path);
 	return NULL;
 }
 
-- 
2.7.4
