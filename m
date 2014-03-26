From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 03/12] Move lower case functions into wrapper.c
Date: Wed, 26 Mar 2014 23:15:21 +0100
Message-ID: <20140326221531.11352.86408.chriscool@tuxfamily.org>
References: <20140326215858.11352.89243.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 23:16:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSw7Y-0001mb-TW
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 23:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbaCZWQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 18:16:24 -0400
Received: from [194.158.98.45] ([194.158.98.45]:48955 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756094AbaCZWQW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 18:16:22 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 1FB9538;
	Wed, 26 Mar 2014 23:16:01 +0100 (CET)
X-git-sha1: d8783a927f590fc96319366090352c3d06b1b784 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140326215858.11352.89243.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245235>

The lowercase() function from config.c and the xstrdup_tolower()
function from daemon.c can benefit from being moved to the same
place because this way the latter can use the former.

Also let's make them available globally so we can use them from
other places like trailer.c.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 config.c          |  6 ------
 daemon.c          |  8 --------
 git-compat-util.h |  4 ++++
 wrapper.c         | 14 ++++++++++++++
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/config.c b/config.c
index 314d8ee..dde128e 100644
--- a/config.c
+++ b/config.c
@@ -146,12 +146,6 @@ int git_config_include(const char *var, const char *value, void *data)
 	return ret;
 }
 
-static void lowercase(char *p)
-{
-	for (; *p; p++)
-		*p = tolower(*p);
-}
-
 void git_config_push_parameter(const char *text)
 {
 	struct strbuf env = STRBUF_INIT;
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
diff --git a/git-compat-util.h b/git-compat-util.h
index 614a5e9..2397706 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -727,4 +727,8 @@ void warn_on_inaccessible(const char *path);
 /* Get the passwd entry for the UID of the current process. */
 struct passwd *xgetpwuid_self(void);
 
+/* Lowercase strings */
+extern void lowercase(char *str);
+extern char *xstrdup_tolower(const char *str);
+
 #endif
diff --git a/wrapper.c b/wrapper.c
index 0cc5636..c46026a 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -455,3 +455,17 @@ struct passwd *xgetpwuid_self(void)
 		    errno ? strerror(errno) : _("no such user"));
 	return pw;
 }
+
+void lowercase(char *p)
+{
+	for (; *p; p++)
+		*p = tolower(*p);
+}
+
+char *xstrdup_tolower(const char *str)
+{
+	char *dup = xstrdup(str);
+	lowercase(dup);
+	return dup;
+}
+
-- 
1.9.0.164.g3aa33cd.dirty
