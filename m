From: Jeff King <peff@peff.net>
Subject: [PATCH 10/67] mailsplit: make PATH_MAX buffers dynamic
Date: Tue, 15 Sep 2015 11:28:07 -0400
Message-ID: <20150915152806.GJ29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:28:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbs9x-00043d-2u
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbbIOP2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:28:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:59294 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753049AbbIOP2J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:28:09 -0400
Received: (qmail 11285 invoked by uid 102); 15 Sep 2015 15:28:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:28:09 -0500
Received: (qmail 6886 invoked by uid 107); 15 Sep 2015 15:28:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:28:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:28:07 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277911>

There are several static PATH_MAX-sized buffers in
mailsplit, along with some questionable uses of sprintf.
These are not really of security interest, as local
mailsplit pathnames are not typically under control of an
attacker.  But it does not hurt to be careful, and as a
bonus we lift some limits for systems with too-small
PATH_MAX varibles.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/mailsplit.c | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 9de06e3..fb0bc08 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -98,30 +98,37 @@ static int populate_maildir_list(struct string_list *list, const char *path)
 {
 	DIR *dir;
 	struct dirent *dent;
-	char name[PATH_MAX];
+	struct strbuf name = STRBUF_INIT;
 	char *subs[] = { "cur", "new", NULL };
 	char **sub;
+	int ret = -1;
 
 	for (sub = subs; *sub; ++sub) {
-		snprintf(name, sizeof(name), "%s/%s", path, *sub);
-		if ((dir = opendir(name)) == NULL) {
+		strbuf_reset(&name);
+		strbuf_addf(&name, "%s/%s", path, *sub);
+		if ((dir = opendir(name.buf)) == NULL) {
 			if (errno == ENOENT)
 				continue;
-			error("cannot opendir %s (%s)", name, strerror(errno));
-			return -1;
+			error("cannot opendir %s (%s)", name.buf, strerror(errno));
+			goto out;
 		}
 
 		while ((dent = readdir(dir)) != NULL) {
 			if (dent->d_name[0] == '.')
 				continue;
-			snprintf(name, sizeof(name), "%s/%s", *sub, dent->d_name);
-			string_list_insert(list, name);
+			strbuf_reset(&name);
+			strbuf_addf(&name, "%s/%s", *sub, dent->d_name);
+			string_list_insert(list, name.buf);
 		}
 
 		closedir(dir);
 	}
 
-	return 0;
+	ret = 0;
+
+out:
+	strbuf_release(&name);
+	return ret;
 }
 
 static int maildir_filename_cmp(const char *a, const char *b)
@@ -148,8 +155,7 @@ static int maildir_filename_cmp(const char *a, const char *b)
 static int split_maildir(const char *maildir, const char *dir,
 	int nr_prec, int skip)
 {
-	char file[PATH_MAX];
-	char name[PATH_MAX];
+	struct strbuf file = STRBUF_INIT;
 	FILE *f = NULL;
 	int ret = -1;
 	int i;
@@ -161,20 +167,25 @@ static int split_maildir(const char *maildir, const char *dir,
 		goto out;
 
 	for (i = 0; i < list.nr; i++) {
-		snprintf(file, sizeof(file), "%s/%s", maildir, list.items[i].string);
-		f = fopen(file, "r");
+		char *name;
+
+		strbuf_reset(&file);
+		strbuf_addf(&file, "%s/%s", maildir, list.items[i].string);
+
+		f = fopen(file.buf, "r");
 		if (!f) {
-			error("cannot open mail %s (%s)", file, strerror(errno));
+			error("cannot open mail %s (%s)", file.buf, strerror(errno));
 			goto out;
 		}
 
 		if (strbuf_getwholeline(&buf, f, '\n')) {
-			error("cannot read mail %s (%s)", file, strerror(errno));
+			error("cannot read mail %s (%s)", file.buf, strerror(errno));
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
+	strbuf_release(&file);
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
2.6.0.rc2.408.ga2926b9
