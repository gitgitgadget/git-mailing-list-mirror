From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] credential-cache--daemon: refactor check_socket_directory
Date: Tue, 23 Feb 2016 02:15:15 -0500
Message-ID: <20160223071515.GA8395@sigill.intra.peff.net>
References: <20160223071427.GA7489@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jon Griffiths <jon_p_griffiths@yahoo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 08:15:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY7Br-0000Yx-Fj
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 08:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757035AbcBWHPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 02:15:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:47355 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753007AbcBWHPS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 02:15:18 -0500
Received: (qmail 12212 invoked by uid 102); 23 Feb 2016 07:15:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 02:15:18 -0500
Received: (qmail 26289 invoked by uid 107); 23 Feb 2016 07:15:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 02:15:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Feb 2016 02:15:15 -0500
Content-Disposition: inline
In-Reply-To: <20160223071427.GA7489@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287030>

From: Jon Griffiths <jon_p_griffiths@yahoo.com>

This function does an early return, and therefore has to
repeat its cleanup. We can stick the later bit of the
function into an "else" and avoid duplicating the shared
part (which will get bigger in a future patch).

Let's also rename the function to init_socket_directory. It
not only checks the directory but also creates it. Saying
"init" is more accurate.

Signed-off-by: Jon Griffiths <jon_p_griffiths@yahoo.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 credential-cache--daemon.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index cc65a9c..3403f48 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -215,7 +215,7 @@ static const char permissions_advice[] =
 "users may be able to read your cached credentials. Consider running:\n"
 "\n"
 "	chmod 0700 %s";
-static void check_socket_directory(const char *path)
+static void init_socket_directory(const char *path)
 {
 	struct stat st;
 	char *path_copy = xstrdup(path);
@@ -224,20 +224,18 @@ static void check_socket_directory(const char *path)
 	if (!stat(dir, &st)) {
 		if (st.st_mode & 077)
 			die(permissions_advice, dir);
-		free(path_copy);
-		return;
+	} else {
+		/*
+		 * We must be sure to create the directory with the correct mode,
+		 * not just chmod it after the fact; otherwise, there is a race
+		 * condition in which somebody can chdir to it, sleep, then try to open
+		 * our protected socket.
+		 */
+		if (safe_create_leading_directories_const(dir) < 0)
+			die_errno("unable to create directories for '%s'", dir);
+		if (mkdir(dir, 0700) < 0)
+			die_errno("unable to mkdir '%s'", dir);
 	}
-
-	/*
-	 * We must be sure to create the directory with the correct mode,
-	 * not just chmod it after the fact; otherwise, there is a race
-	 * condition in which somebody can chdir to it, sleep, then try to open
-	 * our protected socket.
-	 */
-	if (safe_create_leading_directories_const(dir) < 0)
-		die_errno("unable to create directories for '%s'", dir);
-	if (mkdir(dir, 0700) < 0)
-		die_errno("unable to mkdir '%s'", dir);
 	free(path_copy);
 }
 
@@ -264,7 +262,7 @@ int main(int argc, const char **argv)
 	if (!socket_path)
 		usage_with_options(usage, options);
 
-	check_socket_directory(socket_path);
+	init_socket_directory(socket_path);
 	register_tempfile(&socket_file, socket_path);
 
 	if (ignore_sighup)
-- 
2.7.2.645.g4e1306c
