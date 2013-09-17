From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 3/3] Use simpler relative_path when set_git_dir
Date: Tue, 17 Sep 2013 16:30:24 +0800
Message-ID: <2f083d1bc55db70bdc1692cdebcef8eadcceb521.1379406453.git.worldhello.net@gmail.com>
References: <1c0d845aca9a9ca65a7e1d481a75a0f6f4220a89.1379406453.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 10:32:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLqhy-0004id-QM
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 10:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434Ab3IQIcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 04:32:25 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36645 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab3IQIcW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 04:32:22 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so6492371pad.30
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 01:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=iqJmy+aBgLkfxX3LIlamfd84CMw3o896X/MBqg/HzZA=;
        b=A3rm39SGZwLdKDvpaVtaBFep70mpP180sME2w39TFCI9O/ir4OKLy8PiWuZTVaFYOK
         sIBs33zqo+KwZ6akzgrw5QXjskq9rnNOM1Ulz/m5VFlK/9ji92IcTomRrHdiVDQjApQZ
         6Et+vJakvobRZ+niwD2XgC17evHJEGg4MYQU0mRnTa5hvtvnqtjaFCTBsOFvxzs0Ju5p
         sxQui4v9tqvcYE0xMJe7avc0vpVXl3EcI3HuTT1Ix7RDqzM2VT4d/qb9UrAx1RFgCHeG
         aL7+owsO4bTUa56ce/lLG+qE6hQI8oAXtPlIDHkXFybYDWSM0nxpcMdjlojZsCKxi2BW
         V1MQ==
X-Received: by 10.67.30.100 with SMTP id kd4mr35950880pad.24.1379406742250;
        Tue, 17 Sep 2013 01:32:22 -0700 (PDT)
Received: from localhost.localdomain ([114.248.149.94])
        by mx.google.com with ESMTPSA id im2sm36572935pbd.31.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 01:32:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.460.g2f083d1
In-Reply-To: <1c0d845aca9a9ca65a7e1d481a75a0f6f4220a89.1379406453.git.worldhello.net@gmail.com>
In-Reply-To: <CANYiYbH9pLMx4gu1qONhy-+++ojUhPSd9F=sdRTmGWH3pSUTqQ@mail.gmail.com>
References: <CANYiYbH9pLMx4gu1qONhy-+++ojUhPSd9F=sdRTmGWH3pSUTqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234863>

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
index 544d10d..5ad3554 100644
--- a/path.c
+++ b/path.c
@@ -556,6 +556,51 @@ const char *relative_path(const char *in, const char *prefix,
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
1.8.4.460.g2f083d1
