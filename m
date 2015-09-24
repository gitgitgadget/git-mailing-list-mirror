From: Jeff King <peff@peff.net>
Subject: [PATCH 10/68] mailsplit: make PATH_MAX buffers dynamic
Date: Thu, 24 Sep 2015 17:05:51 -0400
Message-ID: <20150924210551.GG30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:06:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDiU-0000bI-Hk
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbbIXVFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:05:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:35918 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752523AbbIXVFx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:05:53 -0400
Received: (qmail 11828 invoked by uid 102); 24 Sep 2015 21:05:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:05:53 -0500
Received: (qmail 28926 invoked by uid 107); 24 Sep 2015 21:06:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:06:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:05:51 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278571>

There are several PATH_MAX-sized buffers in mailsplit, along
with some questionable uses of sprintf.  These are not
really of security interest, as local mailsplit pathnames
are not typically under control of an attacker, and you
could generally only overflow a few numbers at the end of a
path that approaches PATH_MAX (a longer path would choke
mailsplit long before). But it does not hurt to be careful,
and as a bonus we lift some limits for systems with
too-small PATH_MAX varibles.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/mailsplit.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 9de06e3..104277a 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -98,30 +98,37 @@ static int populate_maildir_list(struct string_list *list, const char *path)
 {
 	DIR *dir;
 	struct dirent *dent;
-	char name[PATH_MAX];
+	char *name = NULL;
 	char *subs[] = { "cur", "new", NULL };
 	char **sub;
+	int ret = -1;
 
 	for (sub = subs; *sub; ++sub) {
-		snprintf(name, sizeof(name), "%s/%s", path, *sub);
+		free(name);
+		name = xstrfmt("%s/%s", path, *sub);
 		if ((dir = opendir(name)) == NULL) {
 			if (errno == ENOENT)
 				continue;
 			error("cannot opendir %s (%s)", name, strerror(errno));
-			return -1;
+			goto out;
 		}
 
 		while ((dent = readdir(dir)) != NULL) {
 			if (dent->d_name[0] == '.')
 				continue;
-			snprintf(name, sizeof(name), "%s/%s", *sub, dent->d_name);
+			free(name);
+			name = xstrfmt("%s/%s", *sub, dent->d_name);
 			string_list_insert(list, name);
 		}
 
 		closedir(dir);
 	}
 
-	return 0;
+	ret = 0;
+
+out:
+	free(name);
+	return ret;
 }
 
 static int maildir_filename_cmp(const char *a, const char *b)
@@ -148,8 +155,7 @@ static int maildir_filename_cmp(const char *a, const char *b)
 static int split_maildir(const char *maildir, const char *dir,
 	int nr_prec, int skip)
 {
-	char file[PATH_MAX];
-	char name[PATH_MAX];
+	char *file = NULL;
 	FILE *f = NULL;
 	int ret = -1;
 	int i;
@@ -161,7 +167,11 @@ static int split_maildir(const char *maildir, const char *dir,
 		goto out;
 
 	for (i = 0; i < list.nr; i++) {
-		snprintf(file, sizeof(file), "%s/%s", maildir, list.items[i].string);
+		char *name;
+
+		free(file);
+		file = xstrfmt("%s/%s", maildir, list.items[i].string);
+
 		f = fopen(file, "r");
 		if (!f) {
 			error("cannot open mail %s (%s)", file, strerror(errno));
@@ -173,8 +183,9 @@ static int split_maildir(const char *maildir, const char *dir,
 			goto out;
 		}
 
-		sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
+		name = xstrfmt("%s/%0*d", dir, nr_prec, ++skip);
 		split_one(f, name, 1);
+		free(name);
 
 		fclose(f);
 		f = NULL;
@@ -184,6 +195,7 @@ static int split_maildir(const char *maildir, const char *dir,
 out:
 	if (f)
 		fclose(f);
+	free(file);
 	string_list_clear(&list, 1);
 	return ret;
 }
@@ -191,7 +203,6 @@ out:
 static int split_mbox(const char *file, const char *dir, int allow_bare,
 		      int nr_prec, int skip)
 {
-	char name[PATH_MAX];
 	int ret = -1;
 	int peek;
 
@@ -218,8 +229,9 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 	}
 
 	while (!file_done) {
-		sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
+		char *name = xstrfmt("%s/%0*d", dir, nr_prec, ++skip);
 		file_done = split_one(f, name, allow_bare);
+		free(name);
 	}
 
 	if (f != stdin)
-- 
2.6.0.rc3.454.g204ad51
