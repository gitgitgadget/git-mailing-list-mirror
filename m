From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] daemon/config: factor out duplicate xstrdup_tolower
Date: Thu, 22 May 2014 05:44:09 -0400
Message-ID: <20140522094358.GA15255@sigill.intra.peff.net>
References: <20140522094251.GA14994@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 11:44:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnPXw-0008Fn-VD
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 11:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbaEVJoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 05:44:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:57269 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751796AbaEVJoR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 05:44:17 -0400
Received: (qmail 13074 invoked by uid 102); 22 May 2014 09:44:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 04:44:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 05:44:09 -0400
Content-Disposition: inline
In-Reply-To: <20140522094251.GA14994@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249895>

We have two implementations of the same function; let's drop
that to one. We take the name from daemon.c, but the
implementation (which is just slightly more efficient) from
the config code.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c | 15 +--------------
 daemon.c         |  8 --------
 strbuf.c         | 13 +++++++++++++
 strbuf.h         |  2 ++
 4 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 5677c94..fcd8474 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -395,19 +395,6 @@ static int urlmatch_collect_fn(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static char *dup_downcase(const char *string)
-{
-	char *result;
-	size_t len, i;
-
-	len = strlen(string);
-	result = xmalloc(len + 1);
-	for (i = 0; i < len; i++)
-		result[i] = tolower(string[i]);
-	result[i] = '\0';
-	return result;
-}
-
 static int get_urlmatch(const char *var, const char *url)
 {
 	char *section_tail;
@@ -422,7 +409,7 @@ static int get_urlmatch(const char *var, const char *url)
 	if (!url_normalize(url, &config.url))
 		die("%s", config.url.err);
 
-	config.section = dup_downcase(var);
+	config.section = xstrdup_tolower(var);
 	section_tail = strchr(config.section, '.');
 	if (section_tail) {
 		*section_tail = '\0';
diff --git a/daemon.c b/daemon.c
index eba1255..f9c63e9 100644
--- a/daemon.c
+++ b/daemon.c
@@ -475,14 +475,6 @@ static void make_service_overridable(const char *name, int ena)
 	die("No such service %s", name);
 }
 
-static char *xstrdup_tolower(const char *str)
-{
-	char *p, *dup = xstrdup(str);
-	for (p = dup; *p; p++)
-		*p = tolower(*p);
-	return dup;
-}
-
 static void parse_host_and_port(char *hostport, char **host,
 	char **port)
 {
diff --git a/strbuf.c b/strbuf.c
index ee96dcf..854c725 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -570,3 +570,16 @@ int fprintf_ln(FILE *fp, const char *fmt, ...)
 		return -1;
 	return ret + 1;
 }
+
+char *xstrdup_tolower(const char *string)
+{
+	char *result;
+	size_t len, i;
+
+	len = strlen(string);
+	result = xmalloc(len + 1);
+	for (i = 0; i < len; i++)
+		result[i] = tolower(string[i]);
+	result[i] = '\0';
+	return result;
+}
diff --git a/strbuf.h b/strbuf.h
index 39c14cf..4de7531 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -183,4 +183,6 @@ extern int printf_ln(const char *fmt, ...);
 __attribute__((format (printf,2,3)))
 extern int fprintf_ln(FILE *fp, const char *fmt, ...);
 
+char *xstrdup_tolower(const char *);
+
 #endif /* STRBUF_H */
-- 
2.0.0.rc1.436.g03cb729
