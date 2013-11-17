From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 01/86] strbuf: add starts_with() to be used instead of
 prefixcmp()
Date: Sun, 17 Nov 2013 23:05:53 +0100
Message-ID: <20131117220719.4386.5213.chriscool@tuxfamily.org>
References: <20131117215732.4386.19345.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 19 22:05:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VisUK-0002XY-Gy
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 22:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730Ab3KSVFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 16:05:32 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:59002 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058Ab3KSVFb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 16:05:31 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 8B03052;
	Tue, 19 Nov 2013 22:05:30 +0100 (CET)
X-git-sha1: 47d1e34239ade1f11bf3724a8c911aa7f8549a4c 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131117215732.4386.19345.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238043>

prefixcmp() cannot be really used as a comparison function as
it is not antisymmetric:

	prefixcmp("foo", "foobar") < 0
	prefixcmp("foobar", "foo") == 0

So it is not suitable as a function for passing to qsort.
And in fact it is used nowhere as a comparison function.

So we should replace it with a function that just checks for
equality.

As a first step toward this goal, this patch introduces
starts_with().

Some popular programming languages have functions or methods
called using "start" and "with" that are doing what we want.
Therefore it makes sense to use starts_with() as a function
name to replace prefixcmp().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-compat-util.h | 1 +
 strbuf.c          | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 37f0ba0..e441a6b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -351,6 +351,7 @@ extern void set_error_routine(void (*routine)(const char *err, va_list params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
 
 extern int prefixcmp(const char *str, const char *prefix);
+extern int starts_with(const char *str, const char *prefix);
 extern int ends_with(const char *str, const char *suffix);
 
 static inline const char *skip_prefix(const char *str, const char *prefix)
diff --git a/strbuf.c b/strbuf.c
index 2a14fdb..933d998 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -10,6 +10,15 @@ int prefixcmp(const char *str, const char *prefix)
 			return (unsigned char)*prefix - (unsigned char)*str;
 }
 
+int starts_with(const char *str, const char *prefix)
+{
+	for (; ; str++, prefix++)
+		if (!*prefix)
+			return 1;
+		else if (*str != *prefix)
+			return 0;
+}
+
 int ends_with(const char *str, const char *suffix)
 {
 	int len = strlen(str), suflen = strlen(suffix);
-- 
1.8.4.1.561.g12affca
