From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 3/3] Use simpler relative_path when set_git_dir
Date: Fri, 13 Sep 2013 13:08:14 +0800
Message-ID: <c7675369e45b7bc2b3e99047f0386be5e05825e6.1379048276.git.worldhello.net@gmail.com>
References: <cover.1379048276.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 07:11:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKLez-00077T-NV
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 07:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459Ab3IMFLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 01:11:08 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:36902 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386Ab3IMFLG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 01:11:06 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so753068pbb.14
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 22:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=SCKPgZb284aYsy9XJXdfetrxVbfIpaY1QWwUK3K+o98=;
        b=HpOEOZQzip+0e6KqIeX78uG3gACAn3l5DQUar1/xrX66D0QVQoTlWXoGsuqi/QFqyC
         z3bYlUekFD/RDn7q+MxDmh64njLCuNg5ccXRzUlvYmVyu3tIC3Nz00XNE6poFyIGeU7I
         210aPHdn9PcMGa0LpREF9pWfbJOmMGi4C+qnm9QGhP7v7pJGD8+GRGQBHU+gr0wy905d
         SznBDTu8Pf2XfZLAknj0MfelwLrrOvIhWyExlOodD5hf4bVl9am6Ix7LCPtHEaAhlok6
         PKz3ojtsIMDIsP4Bbe20TASofVl6LyLbZtVhsq7RX4VirfZm7hd92QcCmK2S2dC4ZVve
         D2Cw==
X-Received: by 10.68.33.100 with SMTP id q4mr3989084pbi.119.1379049066274;
        Thu, 12 Sep 2013 22:11:06 -0700 (PDT)
Received: from localhost.localdomain ([114.248.145.187])
        by mx.google.com with ESMTPSA id qa9sm8985593pbc.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 22:11:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.459.gd80d422
In-Reply-To: <cover.1379048276.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1379048276.git.worldhello.net@gmail.com>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com> <cover.1379048276.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234729>

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
index a47b9c0..73fa334 100644
--- a/cache.h
+++ b/cache.h
@@ -747,6 +747,7 @@ int is_directory(const char *);
 const char *real_path(const char *path);
 const char *real_path_if_valid(const char *path);
 const char *absolute_path(const char *path);
+const char *remove_leading_path(const char *in, const char *prefix);
 const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
 int normalize_path_copy_len(char *dst, const char *src, int *prefix_len);
 int normalize_path_copy(char *dst, const char *src);
diff --git a/path.c b/path.c
index 65d376d..24594c4 100644
--- a/path.c
+++ b/path.c
@@ -551,6 +551,51 @@ const char *relative_path(const char *in, const char *prefix,
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
index f08dd64..dbf4138 100644
--- a/setup.c
+++ b/setup.c
@@ -227,7 +227,6 @@ int is_inside_work_tree(void)
 
 void setup_work_tree(void)
 {
-	struct strbuf sb = STRBUF_INIT;
 	const char *work_tree, *git_dir;
 	static int initialized = 0;
 
@@ -247,10 +246,8 @@ void setup_work_tree(void)
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
1.8.4.459.gd80d422
