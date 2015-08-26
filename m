From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 1/4] refs: clean up common_list
Date: Wed, 26 Aug 2015 15:46:02 -0400
Message-ID: <1440618365-20628-2-git-send-email-dturner@twopensource.com>
References: <1440618365-20628-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com,
	sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Wed Aug 26 21:46:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUgeI-00041t-LU
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 21:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932838AbbHZTqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 15:46:14 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33782 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbbHZTqN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 15:46:13 -0400
Received: by qgeh99 with SMTP id h99so404925qge.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 12:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zgp2VgYz1VeGaQRq6iqHPq/5zlgQWDDI23R+62DEwPw=;
        b=lI0STw2DbvlKIEdmEgGe5HxJxAd7I/M6vzkufcCkUUpRbF1Bd7oal39vNHMm1vb2O1
         7Y0e02zwSuC/SUqBVBxHSVqdJCPYOIQmjaI71uZZsPGJBGMlBoWeDWhYLHUMOxCbq6Ys
         90GIOqv4ZeqJ0LxoAoi4fLGI6oU7lo39/cm/3sAibi9IQ8eWiccmPsCRC140fS4ivH3j
         DWRNWNKnRZUYxIzSaNoLKvFPzLoA54IY2sZz1RLArfF/6fbSSqHqPXzvYfjokLA08BSJ
         uEmNKSBR8NDcWlcXUqnq3u3WEWozO4SLX+DxOy9me7uMzqbIEjZ3d9j1m016NOW2JsBJ
         OumQ==
X-Gm-Message-State: ALoCoQmIJIq9eV+vmDtDoKoqdwQeOQh5Jx5Z7cHNs3bv1BUw2F/I6hLOEeyF+XsHlg4JiH50TzU2
X-Received: by 10.140.151.22 with SMTP id 22mr916510qhx.0.1440618373014;
        Wed, 26 Aug 2015 12:46:13 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id t23sm8049326qkt.18.2015.08.26.12.46.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Aug 2015 12:46:11 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.622.gac67c30-twtrsrc
In-Reply-To: <1440618365-20628-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276627>

Instead of common_list having formatting like ! and /, use a struct to
hold common_list data in a structured form.

We don't use 'exclude' yet; instead, we keep the old codepath that
handles info/sparse-checkout and logs/HEAD.  Later, we will use exclude.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 path.c | 58 +++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/path.c b/path.c
index 10f4cbf..d24bfa2 100644
--- a/path.c
+++ b/path.c
@@ -91,35 +91,51 @@ static void replace_dir(struct strbuf *buf, int len, const char *newdir)
 		buf->buf[newlen] = '/';
 }
 
-static const char *common_list[] = {
-	"/branches", "/hooks", "/info", "!/logs", "/lost-found",
-	"/objects", "/refs", "/remotes", "/worktrees", "/rr-cache", "/svn",
-	"config", "!gc.pid", "packed-refs", "shallow",
-	NULL
+struct common_dir {
+	/* Not considered garbage for report_linked_checkout_garbage */
+	unsigned ignore_garbage:1;
+	unsigned is_dir:1;
+	/* Not common even though its parent is */
+	unsigned exclude:1;
+	const char *dirname;
+};
+
+struct common_dir common_list[] = {
+	{ 0, 1, 0, "branches" },
+	{ 0, 1, 0, "hooks" },
+	{ 0, 1, 0, "info" },
+	{ 0, 0, 1, "info/sparse-checkout" },
+	{ 1, 1, 0, "logs" },
+	{ 1, 1, 1, "logs/HEAD" },
+	{ 0, 1, 0, "lost-found" },
+	{ 0, 1, 0, "objects" },
+	{ 0, 1, 0, "refs" },
+	{ 0, 1, 0, "remotes" },
+	{ 0, 1, 0, "worktrees" },
+	{ 0, 1, 0, "rr-cache" },
+	{ 0, 1, 0, "svn" },
+	{ 0, 0, 0, "config" },
+	{ 1, 0, 0, "gc.pid" },
+	{ 0, 0, 0, "packed-refs" },
+	{ 0, 0, 0, "shallow" },
+	{ 0, 0, 0, NULL }
 };
 
 static void update_common_dir(struct strbuf *buf, int git_dir_len)
 {
 	char *base = buf->buf + git_dir_len;
-	const char **p;
+	const struct common_dir *p;
 
 	if (is_dir_file(base, "logs", "HEAD") ||
 	    is_dir_file(base, "info", "sparse-checkout"))
 		return;	/* keep this in $GIT_DIR */
-	for (p = common_list; *p; p++) {
-		const char *path = *p;
-		int is_dir = 0;
-		if (*path == '!')
-			path++;
-		if (*path == '/') {
-			path++;
-			is_dir = 1;
-		}
-		if (is_dir && dir_prefix(base, path)) {
+	for (p = common_list; p->dirname; p++) {
+		const char *path = p->dirname;
+		if (p->is_dir && dir_prefix(base, path)) {
 			replace_dir(buf, git_dir_len, get_git_common_dir());
 			return;
 		}
-		if (!is_dir && !strcmp(base, path)) {
+		if (!p->is_dir && !strcmp(base, path)) {
 			replace_dir(buf, git_dir_len, get_git_common_dir());
 			return;
 		}
@@ -129,16 +145,16 @@ static void update_common_dir(struct strbuf *buf, int git_dir_len)
 void report_linked_checkout_garbage(void)
 {
 	struct strbuf sb = STRBUF_INIT;
-	const char **p;
+	const struct common_dir *p;
 	int len;
 
 	if (!git_common_dir_env)
 		return;
 	strbuf_addf(&sb, "%s/", get_git_dir());
 	len = sb.len;
-	for (p = common_list; *p; p++) {
-		const char *path = *p;
-		if (*path == '!')
+	for (p = common_list; p->dirname; p++) {
+		const char *path = p->dirname;
+		if (p->ignore_garbage)
 			continue;
 		strbuf_setlen(&sb, len);
 		strbuf_addstr(&sb, path);
-- 
2.4.2.622.gac67c30-twtrsrc
