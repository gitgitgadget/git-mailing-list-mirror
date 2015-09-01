From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 1/3] refs: clean up common_list
Date: Mon, 31 Aug 2015 22:13:09 -0400
Message-ID: <1441073591-639-2-git-send-email-dturner@twopensource.com>
References: <1441073591-639-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu,
	Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 04:13:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWb4r-0005Rm-PS
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 04:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738AbbIACNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 22:13:33 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35209 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722AbbIACNc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 22:13:32 -0400
Received: by qkcj187 with SMTP id j187so26945321qkc.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 19:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s4cMhZPO6pkUUIt2y/p4cfU88kFqbqWYBf2PRhR+uzY=;
        b=mMyRgbvteLb1+3G3LHDa/jmcLxHHGao2xpqrDibbyYM9ewmb4ty9IQuxjZAFeDH5ds
         gLh1LaQjie/4tEgSaOQgMRjdpJKqCgi23GClmNBmA3nFavp9ED+bNgtvt+cnIb6fWsn0
         BADy3IhRX4ytKiNV5nzLzEMrxkpt69DNU+P46Lh1ctJNoAsnAxCcn4z0Z2SN8rfJ+dD9
         exiCIhCJdUxeZDkMxdm+asGkwjUfNQKOlZ6nWMslJrQWLZKlhpBwz91jvvNSPT4UoVeX
         L8DZpx0p50FS1Q1668ZOrLY3HXPz3iQHVV8XYtZWnubNzy4mPh/LDqFZOrtfV9zEI205
         +ozQ==
X-Gm-Message-State: ALoCoQnV6uHjURLGbZLUC2WSixQLwVK4b2DFEDTDYxryXNHBBqB2SJcAmnm2t120z7Kj8PlrxmoE
X-Received: by 10.55.31.213 with SMTP id n82mr15213592qkh.17.1441073611617;
        Mon, 31 Aug 2015 19:13:31 -0700 (PDT)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id j207sm9926375qhc.17.2015.08.31.19.13.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Aug 2015 19:13:30 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441073591-639-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276961>

Instead of common_list having formatting like ! and /, use a struct to
hold common_list data in a structured form.

We don't use 'exclude' yet; instead, we keep the old codepath that
handles info/sparse-checkout and logs/HEAD.  Later, we will use exclude.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 path.c | 58 +++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/path.c b/path.c
index 95acbaf..f1ffe37 100644
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
2.0.4.315.gad8727a-twtrsrc
