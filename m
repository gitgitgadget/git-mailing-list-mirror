From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/3] Revert "make error()'s constant return value more visible"
Date: Sun,  4 May 2014 01:12:53 -0500
Message-ID: <1399183975-2346-2-git-send-email-felipe.contreras@gmail.com>
References: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 08:23:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgpq1-0000vm-NU
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 08:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432AbaEDGXk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2014 02:23:40 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:38804 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbaEDGXj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 02:23:39 -0400
Received: by mail-ob0-f169.google.com with SMTP id vb8so777700obc.0
        for <git@vger.kernel.org>; Sat, 03 May 2014 23:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7iRVd/2PeL998UCdMg6VFKBVECx7QOo06ITQkBrHEYA=;
        b=d9NRu4HGLvPhZjvnPghBl+fY3awltacYScr5sG768r8g+LmIR3dgdtHDKXIvhdr8pg
         5m3CU5Am52qSFXXSYE4QupntBaK/Dva1/iZQlmHCRbnHnM+GUpklEhMqXnfwME2Mx/dq
         ujewEjHl4nEIx07Dke/aYM7BQqemaMgMSjZdPEAIhkhMZN8i78RMtbiZWq7RLSmq6maN
         B31RcAJuB4lnHs2o8c5kXV3oHrECIYWAdfoADSGJCLYnoQbLCF5VbL5+t6a7pKAo21zw
         /wyfEKLKKPvvcn+i84n2+AjTgDdZZwsGzfroaDKw2dpMHDrckscN41MtJRFBrlQSSOws
         d2+w==
X-Received: by 10.182.144.194 with SMTP id so2mr8448298obb.31.1399184619299;
        Sat, 03 May 2014 23:23:39 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id j9sm10148149obh.23.2014.05.03.23.23.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 May 2014 23:23:37 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.20.g204a630
In-Reply-To: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248078>

In recent versions of gcc (4.9.0), we get hundreds of these:

  advice.c: In function =E2=80=98error_resolve_conflict=E2=80=99:
  advice.c:79:69: warning: right-hand operand of comma expression has n=
o effect [-Wunused-value]
    error("'%s' is not possible because you have unmerged files.", me);
                                                                     ^
The original patch intended to help in situations like this:

  if (error(...))
    /* do stuff */

However, when there's no conditional statement this gets translated to:

  (error(..), 1);

And the right hand of the expression has no effect.

So it looks like gcc is smarter now, and in trying to fix a few warning=
s
we generated hundreds more.

This reverts commit e208f9cc7574f5980faba498d0aa30b4defeb34f.

Conflicts:
	git-compat-util.h
---
 git-compat-util.h | 11 -----------
 usage.c           |  1 -
 2 files changed, 12 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index f6d3a46..b4242e4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -323,17 +323,6 @@ extern void warning(const char *err, ...) __attrib=
ute__((format (printf, 1, 2)))
 #include <openssl/x509v3.h>
 #endif /* NO_OPENSSL */
=20
-/*
- * Let callers be aware of the constant return value; this can help
- * gcc with -Wuninitialized analysis. We restrict this trick to gcc, t=
hough,
- * because some compilers may not support variadic macros. Since we're=
 only
- * trying to help gcc, anyway, it's OK; other compilers will fall back=
 to
- * using the function as usual.
- */
-#if defined(__GNUC__) && ! defined(__clang__)
-#define error(...) (error(__VA_ARGS__), -1)
-#endif
-
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *e=
rr, va_list params));
 extern void set_error_routine(void (*routine)(const char *err, va_list=
 params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
diff --git a/usage.c b/usage.c
index ed14645..9d2961e 100644
--- a/usage.c
+++ b/usage.c
@@ -138,7 +138,6 @@ void NORETURN die_errno(const char *fmt, ...)
 	va_end(params);
 }
=20
-#undef error
 int error(const char *err, ...)
 {
 	va_list params;
--=20
1.9.2+fc1.20.g204a630
