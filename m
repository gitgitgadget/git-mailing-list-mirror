From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 3/3] Use simpler relative_path when set_git_dir
Date: Mon, 14 Oct 2013 10:29:40 +0800
Message-ID: <f4c0808819d91003a90860b67e2b4121c673a5db.1381717700.git.worldhello.net@gmail.com>
References: <cover.1381717700.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 04:30:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVXvL-0002mj-Lf
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 04:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755718Ab3JNCaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 22:30:15 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:36601 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755675Ab3JNCaO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 22:30:14 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so6768222pbb.28
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 19:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ts/4JM+LR9rEN13wXMIGwHH9xdOkSL1tT8oOcqGX5E4=;
        b=O1uzp5t3GiJ1yTeLsdwBzXuHx62d7YL8LhxGso5dPYlzBLB5CvVr2LjSdyLrrqu2ob
         0c7brOXBUtUTX//GzGjB6/gQjzlh4eTWHVEFk4du+fBpjZzGbrdifwZqswTynf9zfR16
         P0TQEjVqZPiYJsAtfB0JK2y3TQb+X7VJiHlKFLUkW/BOUniKW1q/Ay2AVzjzgGyOKVgl
         FfdoXxCTyIDyhQz4eSsyRchAbntpJofwe3YcQ2Pa58A6V2e4k3T7YLkCQwZnuAe8MPJ1
         cBa13MjBIyCgjBG0nXP4oaruDcNbPLtt4BlsxA+buKXpO6X9rl/FgbyXdi/jixI1Mkak
         WdJQ==
X-Received: by 10.66.50.131 with SMTP id c3mr34564620pao.111.1381717813583;
        Sun, 13 Oct 2013 19:30:13 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.111])
        by mx.google.com with ESMTPSA id gh2sm74692626pbc.40.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 13 Oct 2013 19:30:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.4
In-Reply-To: <cover.1381717700.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1381717700.git.worldhello.net@gmail.com>
References: <52570EC8.3050207@gmail.com> <cover.1381717700.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236089>

Using a relative_path as git_dir first appears in v1.5.6-1-g044bbbc.
It will make git_dir shorter only if git_dir is inside work_tree,
and this will increase performance. But my last refactor effort on
relative_path function (commit v1.8.3-rc2-12-ge02ca72) changed that.
Always use relative_path as git_dir may bring troubles like
$gmane/234434.

Because new relative_path is a combination of original relative_path
from path.c and original path_relative from quote.c, so in order to
restore the origin implementation, save the original relative_path
as remove_leading_path, and call it in setup.c.

Suggested-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h |  1 +
 path.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
 setup.c |  5 +----
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 8e42256..94475bd 100644
--- a/cache.h
+++ b/cache.h
@@ -737,6 +737,7 @@ int is_directory(const char *);
 const char *real_path(const char *path);
 const char *real_path_if_valid(const char *path);
 const char *absolute_path(const char *path);
+const char *remove_leading_path(const char *in, const char *prefix);
 const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
 int normalize_path_copy(char *dst, const char *src);
 int longest_ancestor_length(const char *path, struct string_list *prefixes);
diff --git a/path.c b/path.c
index 0c16dc5..fa62da5 100644
--- a/path.c
+++ b/path.c
@@ -558,6 +558,51 @@ const char *relative_path(const char *in, const char *prefix,
 }
 
 /*
+ * A simpler implementation of relative_path
+ *
+ * Get relative path by removing "prefix" from "in". This function
+ * first appears in v1.5.6-1-g044bbbc, and makes git_dir shorter
+ * to increase performance when traversing the path to work_tree.
+ */
+const char *remove_leading_path(const char *in, const char *prefix)
+{
+	static char buf[PATH_MAX + 1];
+	int i = 0, j = 0;
+
+	if (!prefix || !prefix[0])
+		return in;
+	while (prefix[i]) {
+		if (is_dir_sep(prefix[i])) {
+			if (!is_dir_sep(in[j]))
+				return in;
+			while (is_dir_sep(prefix[i]))
+				i++;
+			while (is_dir_sep(in[j]))
+				j++;
+			continue;
+		} else if (in[j] != prefix[i]) {
+			return in;
+		}
+		i++;
+		j++;
+	}
+	if (
+	    /* "/foo" is a prefix of "/foo" */
+	    in[j] &&
+	    /* "/foo" is not a prefix of "/foobar" */
+	    !is_dir_sep(prefix[i-1]) && !is_dir_sep(in[j])
+	   )
+		return in;
+	while (is_dir_sep(in[j]))
+		j++;
+	if (!in[j])
+		strcpy(buf, ".");
+	else
+		strcpy(buf, in + j);
+	return buf;
+}
+
+/*
  * It is okay if dst == src, but they should not overlap otherwise.
  *
  * Performs the following normalizations on src, storing the result in dst:
diff --git a/setup.c b/setup.c
index 0d9ea62..dad39c1 100644
--- a/setup.c
+++ b/setup.c
@@ -360,7 +360,6 @@ int is_inside_work_tree(void)
 
 void setup_work_tree(void)
 {
-	struct strbuf sb = STRBUF_INIT;
 	const char *work_tree, *git_dir;
 	static int initialized = 0;
 
@@ -380,10 +379,8 @@ void setup_work_tree(void)
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT))
 		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
 
-	set_git_dir(relative_path(git_dir, work_tree, &sb));
+	set_git_dir(remove_leading_path(git_dir, work_tree));
 	initialized = 1;
-
-	strbuf_release(&sb);
 }
 
 static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
-- 
1.8.4
