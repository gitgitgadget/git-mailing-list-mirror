From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH amend] git-mailsplit: with maildirs not only process cur/, but also new/
Date: Tue, 6 Nov 2007 08:54:18 +0000
Message-ID: <20071106085418.14211.qmail@54d7c9212e25c5.315fe32.mid.smarden.org>
References: <20071026141539.29928.qmail@d3691352d65cf2.315fe32.mid.smarden.org> <20071026160118.GA5076@ferdyx.org> <20071105124920.17726.qmail@746e9cce42b49f.315fe32.mid.smarden.org> <20071105225258.GC4208@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Fernando J. Pereda" <ferdy@gentoo.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Alex Riesen <raa.lkml@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 09:54:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpKCK-0001Ox-Fu
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 09:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbXKFIx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 03:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbXKFIx6
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 03:53:58 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:35768 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751327AbXKFIx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 03:53:58 -0500
Received: (qmail 14212 invoked by uid 1000); 6 Nov 2007 08:54:18 -0000
Content-Disposition: inline
In-Reply-To: <20071105225258.GC4208@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63646>

When saving patches to a maildir with e.g. mutt, the files are put into
the new/ subdirectory of the maildir, not cur/.  This makes git-am state
"Nothing to do.".  This patch lets git-mailsplit additional check new/
after reading cur/.

This was reported by Joey Hess through
 http://bugs.debian.org/447396

Signed-off-by: Gerrit Pape <pape@smarden.org>
---

On Mon, Nov 05, 2007 at 01:58:50PM +0100, Jakub Narebski wrote:
> > +        for (i = 0; i < 2; ++i) {
> Wouldn't it be better to use sizeof(sub)/sizeof(sub[0]) or it's macro
> equivalent ARRAY_SIZE(sub) instead of hardcoding 2 to avoid errors?
I made the array NULL-terminated.

On Mon, Nov 05, 2007 at 04:26:24PM -0500, Jeff King wrote:
> Isn't the subject line now wrong?
Yes, thanks.

On Mon, Nov 05, 2007 at 11:52:58PM +0100, Alex Riesen wrote:
> Why is missing "cur" (or "new", for that matter) a fatal error?
> Why is it error at all? How about just ignoring the fact?
As suggested by Jeff, I made it ignore the error on ENOENT.

 builtin-mailsplit.c |   38 ++++++++++++++++++++++----------------
 1 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 74b0470..46b27cd 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -101,20 +101,29 @@ static int populate_maildir_list(struct path_list *list, const char *path)
 {
 	DIR *dir;
 	struct dirent *dent;
+	char name[PATH_MAX];
+	char *subs[] = { "cur", "new", NULL };
+	char **sub;
+
+	for (sub = subs; *sub; ++sub) {
+		snprintf(name, sizeof(name), "%s/%s", path, *sub);
+		if ((dir = opendir(name)) == NULL) {
+			if (errno == ENOENT)
+				continue;
+			error("cannot opendir %s (%s)", name, strerror(errno));
+			return -1;
+		}
 
-	if ((dir = opendir(path)) == NULL) {
-		error("cannot opendir %s (%s)", path, strerror(errno));
-		return -1;
-	}
+		while ((dent = readdir(dir)) != NULL) {
+			if (dent->d_name[0] == '.')
+				continue;
+			snprintf(name, sizeof(name), "%s/%s", *sub, dent->d_name);
+			path_list_insert(name, list);
+		}
 
-	while ((dent = readdir(dir)) != NULL) {
-		if (dent->d_name[0] == '.')
-			continue;
-		path_list_insert(dent->d_name, list);
+		closedir(dir);
 	}
 
-	closedir(dir);
-
 	return 0;
 }
 
@@ -122,19 +131,17 @@ static int split_maildir(const char *maildir, const char *dir,
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
@@ -152,10 +159,9 @@ static int split_maildir(const char *maildir, const char *dir,
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
