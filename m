From: Jeff King <peff@peff.net>
Subject: [PATCH 10/10] setup: drop GIT_REPO_VERSION constants
Date: Tue, 1 Mar 2016 09:45:38 -0500
Message-ID: <20160301144538.GJ12887@sigill.intra.peff.net>
References: <20160301143546.GA30806@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, mhagger@alum.mit.edu,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 15:45:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aalYd-00012o-2X
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 15:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419AbcCAOpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 09:45:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:52463 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754408AbcCAOpl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 09:45:41 -0500
Received: (qmail 27954 invoked by uid 102); 1 Mar 2016 14:45:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 09:45:40 -0500
Received: (qmail 8278 invoked by uid 107); 1 Mar 2016 14:45:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 09:45:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2016 09:45:38 -0500
Content-Disposition: inline
In-Reply-To: <20160301143546.GA30806@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288027>

As each constant is used in only one place, they are not
helping us avoid duplication. And they may be actively
misleading, as a version check is now much more complicated
than a simple integer comparison. The logic is in
verify_repository_format, and if you are thinking about
bumping the version, you _should_ have to go look at that
function.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/init-db.c | 5 +----
 cache.h           | 7 -------
 setup.c           | 6 +++---
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index d9934f3..ee2156e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -176,7 +176,6 @@ static int create_default_files(const char *template_path)
 	struct stat st1;
 	struct strbuf buf = STRBUF_INIT;
 	char *path;
-	char repo_version_string[10];
 	char junk[2];
 	int reinit;
 	int filemode;
@@ -228,9 +227,7 @@ static int create_default_files(const char *template_path)
 	}
 
 	/* This forces creation of new config file */
-	xsnprintf(repo_version_string, sizeof(repo_version_string),
-		  "%d", GIT_REPO_VERSION);
-	git_config_set("core.repositoryformatversion", repo_version_string);
+	git_config_set("core.repositoryformatversion", "0");
 
 	/* Check filemode trustability */
 	path = git_path_buf(&buf, "config");
diff --git a/cache.h b/cache.h
index ecefa00..d9c23d5 100644
--- a/cache.h
+++ b/cache.h
@@ -740,13 +740,6 @@ extern char *notes_ref_name;
 
 extern int grafts_replace_parents;
 
-/*
- * GIT_REPO_VERSION is the version we write by default. The
- * _READ variant is the highest number we know how to
- * handle.
- */
-#define GIT_REPO_VERSION 0
-#define GIT_REPO_VERSION_READ 1
 extern int repository_format_precious_objects;
 
 struct repository_format {
diff --git a/setup.c b/setup.c
index f52011e..75d5939 100644
--- a/setup.c
+++ b/setup.c
@@ -460,9 +460,9 @@ void read_repository_format(struct repository_format *format, const char *path)
 int verify_repository_format(const struct repository_format *format,
 			     struct strbuf *err)
 {
-	if (GIT_REPO_VERSION_READ < format->version) {
-		strbuf_addf(err, "Expected git repo version <= %d, found %d",
-			    GIT_REPO_VERSION_READ, format->version);
+	if (format->version > 1) {
+		strbuf_addf(err, "Expected git repo version <= 1, found %d",
+			    format->version);
 		return -1;
 	}
 
-- 
2.8.0.rc0.278.gfeb5644
