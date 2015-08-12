From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 1/4] refs: clean up common_list
Date: Wed, 12 Aug 2015 17:57:22 -0400
Message-ID: <1439416645-19173-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, chriscool@tuxfamily.org,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Aug 12 23:57:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPe21-0003ZI-4e
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 23:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbbHLV5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 17:57:52 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36299 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbbHLV5v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 17:57:51 -0400
Received: by qgdd90 with SMTP id d90so20234049qgd.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 14:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F9CL+Csa84PgEmUlLiXE8bnQsZe9uE9JVrcPSxBLo+M=;
        b=PkRbPhJT8MIKpMuUdKVFlBdQRRUwUpEYyLGZBd4qEBcz8FH0eyWIOFylZk2EhjKKPE
         zHVH+0tnIhVt2qKTBQ7DNX+Zq6v/9S2dhzCO+zq/S26eQ5Re0vAJbwf3hzQhLamC9RJz
         pnSTWTWxzv1pcm19TJ/JW4wjCEf0QaUaJW/ePAdJ3G3Gi6M8MyzyamF0MYNvza3EP/CA
         SK3YHyMM4n0YFPk4KZUSMD1cz98eSgQmBvaUnZJc1OeAYRwCbpo9XqgFu8EwI//3LjaQ
         t2pZPKRPMkLdoei3gsYmRNwMMmtE8qUkvw2VkvBaWEr1Zn3yqgM+0vI2AgCm/uZ0DvxX
         JMFQ==
X-Gm-Message-State: ALoCoQn99osRH6IoFG6RZTZUa9FQCVkVJ1HN+d/YADj76JAJfnfWRolDtV9d/TFK5lOJpaMIQn1X
X-Received: by 10.140.20.37 with SMTP id 34mr191652qgi.88.1439416670643;
        Wed, 12 Aug 2015 14:57:50 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f71sm110289qhe.7.2015.08.12.14.57.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Aug 2015 14:57:49 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275816>

Instead of common_list having formatting like ! and /, use a struct to
hold common_list data in a structured form.

We don't use 'exclude' yet; instead, we keep the old codepath that
handles info/sparse-checkout and logs/HEAD.  Later, we will use exclude.

Signed-off-by: David Turner <dturner@twopensource.com>
---

Junio was worried about the performance of common_list and the weird
string parsing bits of update_common_dir, so this version of the patch
series begins by cleaning and optimizing those bits.

Additionally, I incorporated Junio's suggestion to use
is_per_worktree_ref, and his formatting suggestions.

There is now a hack so that git for-each-ref works on per-worktree
refs.

I also added git-bisect.sh, which I had overzealously reverted during
my proofreading step last time.

---
 path.c | 58 +++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/path.c b/path.c
index 10f4cbf..236f797 100644
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
+	const char *dirname;
+	/* Not considered garbage for report_linked_checkout_garbage */
+	unsigned ignore_garbage:1;
+	unsigned is_dir:1;
+	/* Not common even though its parent is */
+	unsigned exclude:1;
+};
+
+struct common_dir common_list[] = {
+	{ "branches", 0, 1, 0 },
+	{ "hooks", 0, 1, 0 },
+	{ "info", 0, 1, 0 },
+	{ "info/sparse-checkout", 0, 0, 1 },
+	{ "logs", 1, 1, 0 },
+	{ "logs/HEAD", 1, 1, 1 },
+	{ "lost-found", 0, 1, 0 },
+	{ "objects", 0, 1, 0 },
+	{ "refs", 0, 1, 0 },
+	{ "remotes", 0, 1, 0 },
+	{ "worktrees", 0, 1, 0 },
+	{ "rr-cache", 0, 1, 0 },
+	{ "svn", 0, 1, 0 },
+	{ "config", 0, 0, 0 },
+	{ "gc.pid", 1, 0, 0 },
+	{ "packed-refs", 0, 0, 0 },
+	{ "shallow", 0, 0, 0 },
+	{ NULL, 0, 0, 0 }
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
