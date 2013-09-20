From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 3/3] Use simpler relative_path when set_git_dir
Date: Fri, 20 Sep 2013 10:38:48 +0800
Message-ID: <a323d5582ec9e09a91ef6f2ad1827547a5335c62.1379644482.git.worldhello.net@gmail.com>
References: <cover.1379644482.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 04:41:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMqfF-0002xW-Ie
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 04:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968Ab3ITCln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 22:41:43 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:55700 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab3ITClm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 22:41:42 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so157955pad.16
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 19:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1RNmW+wxTStm4xBb2hSddM90sbQhVKx7hcm0gicvgaw=;
        b=rWVfMrqJorbxTfPlp5utHaEwa4G9db4LYFbvfVK2kuj3KG2LIMQ/XA9/SMRTcVTmNI
         F5Va+L95E+08iA4WZpX5zOe9lejPi8OTUG42MndMBbWL9LPwzU8hJ7ngrB4byqXvpZxx
         Prg3zOJEBu91GCD1GOHwvb6lTF8c4op6EuwP8Yt1rvcQpf3PXuGGcmdxqYZUjhBbdS91
         0rRjMyrOX6MpPTwlZaDRiN9t5E9ZSrK3CGu68HKhOqKr3mMhZFud4C8DE74C5VoqK9da
         /4K/SMlHZxfouNZepU2XjsODugtzSDRZlY+WMl01llgi4mvsE+Be/FGTXdtAu/A7M+63
         5/lA==
X-Received: by 10.68.212.37 with SMTP id nh5mr5375388pbc.16.1379644901618;
        Thu, 19 Sep 2013 19:41:41 -0700 (PDT)
Received: from localhost.localdomain ([114.248.149.94])
        by mx.google.com with ESMTPSA id wp8sm12412723pbc.26.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 19 Sep 2013 19:41:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.460.gbed9cb4
In-Reply-To: <cover.1379644482.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1379644482.git.worldhello.net@gmail.com>
References: <CANYiYbGK_KdF5Yvcus5C_cGz3EyGTaFvirsUH5q4Eu=3VC4=Wg@mail.gmail.com> <cover.1379644482.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235050>

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
1.8.4.460.gbed9cb4
