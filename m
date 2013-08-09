From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] parse-options: fix clang opterror() -Wunused-value warning
Date: Fri,  9 Aug 2013 05:06:17 -0400
Message-ID: <1376039177-17560-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 11:06:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7iek-0005uA-6E
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 11:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965551Ab3HIJGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 05:06:42 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:43344 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965245Ab3HIJGl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 05:06:41 -0400
Received: by mail-ie0-f181.google.com with SMTP id x14so3774437ief.12
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 02:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=APArPYlL9js91Q2wvhcXX/JA+5ZAPlx58+X6fXhuK6Q=;
        b=Slo/OiaBxG3+ZiMKD1tCzVza7UywDxN43XlTY6z0AqaNN2FRmvdOG+y+0FYKDJ9XRB
         4/5jZW7JweC3bJxPF//pjGZfTyLj48+1/LN6o3JSKjGFgMAcgX0Ocr6zHv7c2jLNzJng
         xhWJHfFOedf+OM0H0IMUczN8+lROFqRKVx8aDmFd2NmbSCi9Xo0NMNzQ4I5/fOaBPVcs
         +vdkQKqD+M+i09qtPSFHpOlp+xaHK5+esstBKswIeTS4VYeeT+h0+bmt86urcDMTkpAS
         TWXxx03hLdrhKjdUNlV/T++Ho9omMxxyxA9L4kC9WklbtOWmEe6//BisIXr0ThrgK9bo
         Hh6A==
X-Received: by 10.42.244.129 with SMTP id lq1mr4059684icb.98.1376039200788;
        Fri, 09 Aug 2013 02:06:40 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id y2sm2580737igl.10.2013.08.09.02.06.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 02:06:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.428.gcd48621
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231965>

a469a1019352b8ef (silence some -Wuninitialized false positives;
2012-12-15) triggered "unused value" warnings when the return value of
opterror() and several other error-related functions was not used.
5ded807f7c0be10e (fix clang -Wunused-value warnings for error functions;
2013-01-16) applied a fix by adding #if !defined(__clang__) in cache.h
and git-compat-util.h, but misspelled it as #if !defined(clang) in
parse-options.h. Fix this.

This mistake went unnoticed because existing callers of opterror()
utilize its return value.  1158826394e162c5 (parse-options: add
OPT_CMDMODE(); 2013-07-30), however, adds a new invocation of opterror()
which ignores the return value, thus triggering the "unused value"
warning.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index aeab9aa..8736006 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -182,7 +182,7 @@ extern NORETURN void usage_msg_opt(const char *msg,
 
 extern int optbug(const struct option *opt, const char *reason);
 extern int opterror(const struct option *opt, const char *reason, int flags);
-#if defined(__GNUC__) && ! defined(clang)
+#if defined(__GNUC__) && ! defined(__clang__)
 #define opterror(o,r,f) (opterror((o),(r),(f)), -1)
 #endif
 
-- 
1.8.4.rc1.428.gcd48621
