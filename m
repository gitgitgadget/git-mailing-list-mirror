From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 01/86] strbuf: add has_prefix() to be used instead of
 prefixcmp()
Date: Sat, 09 Nov 2013 08:05:54 +0100
Message-ID: <20131109070720.18178.71603.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:08:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2el-0002P0-Fo
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933254Ab3KIHI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:08:27 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36248 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932785Ab3KIHIW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:22 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 4830E46;
	Sat,  9 Nov 2013 08:08:19 +0100 (CET)
X-git-sha1: e56ab92a43696b1f3e2d9c1035d5a62397d88754 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237483>

prefixcmp() cannot be really used as a comparison function as
it is not antisymmetric:

	prefixcmp("foo", "foobar") < 0
	prefixcmp("foobar", "foo") == 0

So it is not suitable as a function for passing to qsort.
And in fact it is used nowhere as a comparison function.

So we should replace it with a function that just checks for
equality.

As a first step toward this goal, this patch introduces
has_prefix().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-compat-util.h | 1 +
 strbuf.c          | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 0f6a31e..7930f49 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -351,6 +351,7 @@ extern void set_error_routine(void (*routine)(const char *err, va_list params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
 
 extern int prefixcmp(const char *str, const char *prefix);
+extern int has_prefix(const char *str, const char *prefix);
 extern int has_suffix(const char *str, const char *suffix);
 
 static inline const char *skip_prefix(const char *str, const char *prefix)
diff --git a/strbuf.c b/strbuf.c
index 0d784b5..748be6d 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -10,6 +10,15 @@ int prefixcmp(const char *str, const char *prefix)
 			return (unsigned char)*prefix - (unsigned char)*str;
 }
 
+int has_prefix(const char *str, const char *prefix)
+{
+	for (; ; str++, prefix++)
+		if (!*prefix)
+			return 1;
+		else if (*str != *prefix)
+			return 0;
+}
+
 int has_suffix(const char *str, const char *suffix)
 {
 	int len = strlen(str), suflen = strlen(suffix);
-- 
1.8.4.1.566.geca833c
