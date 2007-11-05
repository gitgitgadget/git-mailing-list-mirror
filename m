From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-mailsplit: with maildirs try to process new/ if cur/ is empty
Date: Mon, 5 Nov 2007 12:49:20 +0000
Message-ID: <20071105124920.17726.qmail@746e9cce42b49f.315fe32.mid.smarden.org>
References: <20071026141539.29928.qmail@d3691352d65cf2.315fe32.mid.smarden.org> <20071026160118.GA5076@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "Fernando J. Pereda" <ferdy@gentoo.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 13:49:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip1OI-0006BG-8F
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 13:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854AbXKEMtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 07:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754847AbXKEMtC
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 07:49:02 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:59647 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754791AbXKEMtB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 07:49:01 -0500
Received: (qmail 17727 invoked by uid 1000); 5 Nov 2007 12:49:20 -0000
Content-Disposition: inline
In-Reply-To: <20071026160118.GA5076@ferdyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63508>

When saving patches to a maildir with e.g. mutt, the files are put into
the new/ subdirectory of the maildir, not cur/.  This makes git-am state
"Nothing to do.".  This patch lets git-mailsplit additional check new/
after reading cur/.

This was reported by Joey Hess through
 http://bugs.debian.org/447396

Signed-off-by: Gerrit Pape <pape@smarden.org>
---

On Fri, Oct 26, 2007 at 06:01:18PM +0200, Fernando J. Pereda wrote:
> By that reasoning, you should make it parse both cur/ and new/.
Okay.

 builtin-mailsplit.c |   36 ++++++++++++++++++++----------------
 1 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 74b0470..79e8ee0 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -101,19 +101,26 @@ static int populate_maildir_list(struct path_list *list, const char *path)
 {
 	DIR *dir;
 	struct dirent *dent;
+	char name[PATH_MAX];
+	char *sub[] = { "cur", "new" };
+	int i;
 
-	if ((dir = opendir(path)) == NULL) {
-		error("cannot opendir %s (%s)", path, strerror(errno));
-		return -1;
-	}
+	for (i = 0; i < 2; ++i) {
+		snprintf(name, sizeof(name), "%s/%s", path, sub[i]);
+		if ((dir = opendir(name)) == NULL) {
+			error("cannot opendir %s (%s)", name, strerror(errno));
+			return -1;
+		}
 
-	while ((dent = readdir(dir)) != NULL) {
-		if (dent->d_name[0] == '.')
-			continue;
-		path_list_insert(dent->d_name, list);
-	}
+		while ((dent = readdir(dir)) != NULL) {
+			if (dent->d_name[0] == '.')
+				continue;
+			snprintf(name, sizeof(name), "%s/%s", sub[i], dent->d_name);
+			path_list_insert(name, list);
+		}
 
-	closedir(dir);
+		closedir(dir);
+	}
 
 	return 0;
 }
@@ -122,19 +129,17 @@ static int split_maildir(const char *maildir, const char *dir,
 	int nr_prec, int skip)
 {
 	char file[PATH_MAX];
-	char curdir[PATH_MAX];
 	char name[PATH_MAX];
 	int ret = -1;
 	int i;
 	struct path_list list = {NULL, 0, 0, 1};
 
-	snprintf(curdir, sizeof(curdir), "%s/cur", maildir);
-	if (populate_maildir_list(&list, curdir) < 0)
+	if (populate_maildir_list(&list, maildir) < 0)
 		goto out;
 
 	for (i = 0; i < list.nr; i++) {
 		FILE *f;
-		snprintf(file, sizeof(file), "%s/%s", curdir, list.items[i].path);
+		snprintf(file, sizeof(file), "%s/%s", maildir, list.items[i].path);
 		f = fopen(file, "r");
 		if (!f) {
 			error("cannot open mail %s (%s)", file, strerror(errno));
@@ -152,10 +157,9 @@ static int split_maildir(const char *maildir, const char *dir,
 		fclose(f);
 	}
 
-	path_list_clear(&list, 1);
-
 	ret = skip;
 out:
+	path_list_clear(&list, 1);
 	return ret;
 }
 
-- 
1.5.3.5
