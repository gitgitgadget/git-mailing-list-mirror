From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/4] add strbuf_expand_dict_cb(), a helper for simple cases
Date: Sun, 23 Nov 2008 00:09:30 +0100
Message-ID: <4928912A.5050307@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jon Loeliger <jdl@freescale.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 23 00:12:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L41eO-0001Tq-Pt
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 00:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbYKVXJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2008 18:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbYKVXJi
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Nov 2008 18:09:38 -0500
Received: from india601.server4you.de ([85.25.151.105]:41744 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbYKVXJh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2008 18:09:37 -0500
Received: from [10.0.1.101] (p57B7B890.dip.t-dialin.net [87.183.184.144])
	by india601.server4you.de (Postfix) with ESMTPSA id 05FF42F8057;
	Sun, 23 Nov 2008 00:09:33 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101560>

The new callback function strbuf_expand_dict_cb() can be used together
with strbuf_expand() if there is only a small number of placeholders
for static replacement texts.  It expects its dictionary as an array of
placeholder+value pairs as context parameter, terminated by an entry
with the placeholder member set to NULL.

The new helper is intended to aid converting the remaining calls of
interpolate().  strbuf_expand() is smaller, more flexible and can be
used to go faster than interpolate(), so it should replace the latter.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/technical/api-strbuf.txt |    7 +++++++
 strbuf.c                               |   16 ++++++++++++++++
 strbuf.h                               |    5 +++++
 3 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index a9668e5..519c63b 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -205,6 +205,13 @@ In order to facilitate caching and to make it possible to give
 parameters to the callback, `strbuf_expand()` passes a context pointer,
 which can be used by the programmer of the callback as she sees fit.
 
+`strbuf_expand_dict_cb`::
+
+	Used as callback for `strbuf_expand()`, expects an array of
+	struct strbuf_expand_dict_entry as context, i.e. pairs of
+	placeholder and replacement string.  The array needs to be
+	terminated by an entry with placeholder set to NULL.
+
 `strbuf_addf`::
 
 	Add a formatted string to the buffer.
diff --git a/strbuf.c b/strbuf.c
index 720737d..860748f 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -237,6 +237,22 @@ void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn,
 	}
 }
 
+size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder,
+		void *context)
+{
+	struct strbuf_expand_dict_entry *e = context;
+	size_t len;
+
+	for (; e->placeholder && (len = strlen(e->placeholder)); e++) {
+		if (!strncmp(placeholder, e->placeholder, len)) {
+			if (e->value)
+				strbuf_addstr(sb, e->value);
+			return len;
+		}
+	}
+	return 0;
+}
+
 size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f)
 {
 	size_t res;
diff --git a/strbuf.h b/strbuf.h
index eba7ba4..b1670d9 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -111,6 +111,11 @@ extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);
 
 typedef size_t (*expand_fn_t) (struct strbuf *sb, const char *placeholder, void *context);
 extern void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn, void *context);
+struct strbuf_expand_dict_entry {
+	const char *placeholder;
+	const char *value;
+};
+extern size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder, void *context);
 
 __attribute__((format(printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
-- 
1.6.0.4.755.g6e139
