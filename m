From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 2/2] Use simpler relative_path when set_git_dir
Date: Thu, 12 Sep 2013 17:12:43 +0800
Message-ID: <121215a0837321e57c3918784d3de9597c9fc292.1378977052.git.worldhello.net@gmail.com>
References: <0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 11:13:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK2xZ-0005zQ-Dp
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 11:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab3ILJNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 05:13:04 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:39854 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab3ILJNC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 05:13:02 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so10306714pbc.29
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 02:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=EBuN8qVKDpLZGHqC1qMRs485zzR7F6PiLdyR9YgNKec=;
        b=BN/SfQTq9MDsuU2NzsBH67nIxbpka5mokil9c+kEIJno9ecOa1BHZsY3VHoMwWaImf
         YE0USJJjNhdosDef4AC6YiHbVx15F7F+PE59Mg+xjPK86IRPZSUnqpEdbKHuz5f7Qq7C
         IZ4gAeHcwVTzQxERdBQkhlc4C36YPNR6oVznP5Co+DHweAkgHAFN5/eM4YXnUdG8+KKZ
         A4KCTbCakjMmAEjm/XymhqAQHVJogZljX90jWECJ1ObVhhy/H3DaBtXRSjiwuZRkkTyR
         muKRVhS78Bzk1XhDgaM2D+5rAU6FsKbqC/wWr8w6Cx8pkY0lXn6nUuFN83SWsK1l1E0i
         1ilQ==
X-Received: by 10.68.17.230 with SMTP id r6mr6497388pbd.112.1378977178564;
        Thu, 12 Sep 2013 02:12:58 -0700 (PDT)
Received: from localhost.localdomain ([114.248.145.187])
        by mx.google.com with ESMTPSA id ry4sm9391271pab.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 02:12:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.14.g5ac1b82
In-Reply-To: <0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com>
In-Reply-To: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234631>

Using a relative_path as git_dir first appears in v1.5.6-1-g044bbbc.
It will make git_dir shorter only if git_dir is inside work_tree,
and this will increase performance. But my last refactor effort on
relative_path function (commit v1.8.3-rc2-12-ge02ca72) changed that.
Always use relative_path as git_dir may bring troubles like
$gmane/234434.

Because new relative_path is a combination of original relative_path
from path.c and original path_relative from quote.c, so in order to
restore the origin implementation, save the original relative_path
to simple_relative_path, and call it in setup.c.

Suggested-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 cache.h |  1 +
 path.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
 setup.c |  5 +----
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 8e42256..ab17f1d 100644
--- a/cache.h
+++ b/cache.h
@@ -738,6 +738,7 @@ const char *real_path(const char *path);
 const char *real_path_if_valid(const char *path);
 const char *absolute_path(const char *path);
 const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
+const char *simple_relative_path(const char *in, const char *prefix);
 int normalize_path_copy(char *dst, const char *src);
 int longest_ancestor_length(const char *path, struct string_list *prefixes);
 char *strip_path_suffix(const char *path, const char *suffix);
diff --git a/path.c b/path.c
index ffcdea1..0f0c92f 100644
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
+const char *simple_relative_path(const char *in, const char *prefix)
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
index 0d9ea62..f4be6ff 100644
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
+	set_git_dir(simple_relative_path(git_dir, work_tree));
 	initialized = 1;
-
-	strbuf_release(&sb);
 }
 
 static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
-- 
1.8.3.rc2.14.g5ac1b82
