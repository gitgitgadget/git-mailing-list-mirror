From: "Fernando J. Pereda" <ferdy@gentoo.org>
Subject: [PATCH] Teach mailsplit about Maildir's
Date: Thu, 26 Apr 2007 21:24:39 +0200
Message-ID: <20070426192439.GA6976@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 21:16:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh9Rx-0002mL-2n
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 21:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbXDZTQM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 15:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbXDZTQM
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 15:16:12 -0400
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:48596
	"EHLO smtp.ferdyx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbXDZTQK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 15:16:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id A54078D315
	for <git@vger.kernel.org>; Thu, 26 Apr 2007 20:54:35 +0200 (CEST)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 03946-06 for <git@vger.kernel.org>;
	Thu, 26 Apr 2007 20:54:28 +0200 (CEST)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id CD4578D305
	for <git@vger.kernel.org>; Thu, 26 Apr 2007 20:54:27 +0200 (CEST)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Thu, 26 Apr 2007 21:24:40 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@gentoo.org>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45643>

Signed-off-by: Fernando J. Pereda <ferdy@gentoo.org>
---

 builtin-mailsplit.c |  107 ++++++++++++++++++++++++++++++++++++++++++---------
 builtin.h           |    2 +-
 2 files changed, 89 insertions(+), 20 deletions(-)

diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 3bca855..e0a283d 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -96,44 +96,93 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 	exit(1);
 }
 
-int split_mbox(const char **mbox, const char *dir, int allow_bare, int nr_prec, int skip)
+int split_maildir(const char *maildir, const char *dir, int nr_prec, int skip)
 {
-	char *name = xmalloc(strlen(dir) + 2 + 3 * sizeof(skip));
+	char file[PATH_MAX];
+	char curdir[PATH_MAX];
+	char name[PATH_MAX];
+	DIR *mddir;
+	struct dirent *maildent;
 	int ret = -1;
 
-	while (*mbox) {
-		const char *file = *mbox++;
-		FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "r");
-		int file_done = 0;
+	snprintf(curdir, sizeof(curdir), "%s/cur", maildir);
+	if ((mddir = opendir(curdir)) == NULL) {
+		error("cannot diropen %s (%s)", curdir, strerror(errno));
+		goto out;
+	}
+
+	while ((maildent = readdir(mddir)) != NULL) {
+		FILE *f;
+
+		snprintf(file, sizeof(file), "%s/%s",
+				curdir, maildent->d_name);
+
+		if (maildent->d_name[0] == '.')
+			continue;
 
-		if ( !f ) {
-			error("cannot open mbox %s", file);
+		f = fopen(file, "r");
+		if (!f) {
+			error("cannot open mail %s (%s)", file, strerror(errno));
 			goto out;
 		}
 
 		if (fgets(buf, sizeof(buf), f) == NULL) {
-			if (f == stdin)
-				break; /* empty stdin is OK */
-			error("cannot read mbox %s", file);
+			error("cannot read mail %s (%s)", file, strerror(errno));
 			goto out;
 		}
 
-		while (!file_done) {
-			sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
-			file_done = split_one(f, name, allow_bare);
+		sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
+		split_one(f, name, 1);
+
+		fclose(f);
+	}
+
+	closedir(mddir);
+
+	ret = skip;
+out:
+	return ret;
+}
+
+int split_mbox(const char *file, const char *dir, int allow_bare,
+		int nr_prec, int skip)
+{
+	char name[PATH_MAX];
+	int ret = -1;
+
+	FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "r");
+	int file_done = 0;
+
+	if (!f) {
+		error("cannot open mbox %s", file);
+		goto out;
+	}
+
+	if (fgets(buf, sizeof(buf), f) == NULL) {
+		/* empty stdin is OK */
+		if (f != stdin) {
+			error("cannot read mbox %s", file);
+			goto out;
 		}
+		file_done = 1;
+	}
 
-		if (f != stdin)
-			fclose(f);
+	while (!file_done) {
+		sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
+		file_done = split_one(f, name, allow_bare);
 	}
+
+	if (f != stdin)
+		fclose(f);
+
 	ret = skip;
 out:
-	free(name);
 	return ret;
 }
+
 int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 {
-	int nr = 0, nr_prec = 4, ret;
+	int nr = 0, nr_prec = 4, ret = 0;
 	int allow_bare = 0;
 	const char *dir = NULL;
 	const char **argp;
@@ -186,7 +235,27 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 			argp = stdin_only;
 	}
 
-	ret = split_mbox(argp, dir, allow_bare, nr_prec, nr);
+	while (*argp) {
+		const char *arg = *argp++;
+		struct stat argstat;
+
+		if (arg[0] == '-' && arg[1] == 0) {
+			ret |= split_mbox(arg, dir, allow_bare, nr_prec, nr);
+			continue;
+		}
+
+		if (stat(arg, &argstat) == -1) {
+			error("cannot stat %s (%s)", arg, strerror(errno));
+			return 1;
+		}
+
+		if (S_ISDIR(argstat.st_mode)) {
+			ret |= split_maildir(arg, dir, nr_prec, nr);
+		} else {
+			ret |= split_mbox(arg, dir, allow_bare, nr_prec, nr);
+		}
+	}
+
 	if (ret != -1)
 		printf("%d\n", ret);
 
diff --git a/builtin.h b/builtin.h
index d3f3a74..39290d1 100644
--- a/builtin.h
+++ b/builtin.h
@@ -8,7 +8,7 @@ extern const char git_usage_string[];
 
 extern void help_unknown_cmd(const char *cmd);
 extern int mailinfo(FILE *in, FILE *out, int ks, const char *encoding, const char *msg, const char *patch);
-extern int split_mbox(const char **mbox, const char *dir, int allow_bare, int nr_prec, int skip);
+extern int split_mbox(const char *file, const char *dir, int allow_bare, int nr_prec, int skip);
 extern void stripspace(FILE *in, FILE *out);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
 extern void prune_packed_objects(int);
-- 
1.5.1.2
