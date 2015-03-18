From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 1/8] strbuf: add and use strbuf_read_file_or_die()
Date: Wed, 18 Mar 2015 16:55:40 +0700
Message-ID: <1426672547-11369-2-git-send-email-pclouds@gmail.com>
References: <1426672547-11369-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 10:56:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYAi9-0002e3-FG
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 10:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933185AbbCRJ4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 05:56:17 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33267 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933181AbbCRJ4M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 05:56:12 -0400
Received: by pdnc3 with SMTP id c3so38511469pdn.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lj7uxVr56pzHDVOZyjE4vkfedlbLCZV/79exVjmLxho=;
        b=rgH1ErYGCOATsDDSgoEqMPr80KUTdlSdCmvndHz4J3Z72FMy9Bbvlo7z52bPwxSh5E
         xSeSC0Vz+49I+hWRYR5aMe8bU07ZNa0jakrm+9YEb+S78p9eDJT9GEIr5lN+QzsX6CUF
         FB6SogG1pA67CqVrWnxokk7q27MfxO9eORB3TMC+4CujgpjO+5wGhmcBlWsg2dX+vT4r
         LyHUZwhay/UQQDrzE/pD/RGoGHPy85EKnC4Vz4lc+g8mFLhUEZhADNIhHmsmsETusN5w
         f6AUGgV02kinxF//iJrO7CTzUqoQjTHCvQc+ownJVYqKoGxnlESvqwzPb8GUI581Xrla
         vGPg==
X-Received: by 10.66.164.98 with SMTP id yp2mr85207105pab.114.1426672571755;
        Wed, 18 Mar 2015 02:56:11 -0700 (PDT)
Received: from lanh ([115.73.252.85])
        by mx.google.com with ESMTPSA id z4sm26627503pdn.46.2015.03.18.02.56.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 02:56:10 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Mar 2015 16:56:07 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1426672547-11369-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265703>

---
 builtin/blame.c  |  4 ++--
 builtin/commit.c | 16 +++++-----------
 builtin/merge.c  |  3 +--
 builtin/notes.c  |  4 ++--
 builtin/tag.c    |  7 ++-----
 strbuf.c         |  8 ++++++++
 strbuf.h         |  1 +
 7 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index bc6c899..503595c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2193,8 +2193,8 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 			if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
 			    textconv_object(read_from, mode, null_sha1, 0, &buf_ptr, &buf_len))
 				strbuf_attach(&buf, buf_ptr, buf_len, buf_len + 1);
-			else if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
-				die_errno("cannot open or read '%s'", read_from);
+			else
+				strbuf_read_file_or_die(&buf, read_from, st.st_size);
 			break;
 		case S_IFLNK:
 			if (strbuf_readlink(&buf, read_from, st.st_size) < 0)
diff --git a/builtin/commit.c b/builtin/commit.c
index d6dd3df..dad9acf 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -612,9 +612,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			die_errno(_("could not read log from standard input"));
 		hook_arg1 = "message";
 	} else if (logfile) {
-		if (strbuf_read_file(&sb, logfile, 0) < 0)
-			die_errno(_("could not read log file '%s'"),
-				  logfile);
+		strbuf_read_file_or_die(&sb, logfile, 0);
 		hook_arg1 = "message";
 	} else if (use_message) {
 		buffer = strstr(use_message_buffer, "\n\n");
@@ -634,16 +632,13 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				      &sb, &ctx);
 		hook_arg1 = "message";
 	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
-		if (strbuf_read_file(&sb, git_path("MERGE_MSG"), 0) < 0)
-			die_errno(_("could not read MERGE_MSG"));
+		strbuf_read_file_or_die(&sb, git_path("MERGE_MSG"), 0);
 		hook_arg1 = "merge";
 	} else if (!stat(git_path("SQUASH_MSG"), &statbuf)) {
-		if (strbuf_read_file(&sb, git_path("SQUASH_MSG"), 0) < 0)
-			die_errno(_("could not read SQUASH_MSG"));
+		strbuf_read_file_or_die(&sb, git_path("SQUASH_MSG"), 0);
 		hook_arg1 = "squash";
 	} else if (template_file) {
-		if (strbuf_read_file(&sb, template_file, 0) < 0)
-			die_errno(_("could not read '%s'"), template_file);
+		strbuf_read_file_or_die(&sb, template_file, 0);
 		hook_arg1 = "template";
 		clean_message_contents = 0;
 	}
@@ -1497,8 +1492,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		fclose(fp);
 		strbuf_release(&m);
 		if (!stat(git_path("MERGE_MODE"), &statbuf)) {
-			if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
-				die_errno(_("could not read MERGE_MODE"));
+			strbuf_read_file_or_die(&sb, git_path("MERGE_MODE"), 0);
 			if (!strcmp(sb.buf, "no-ff"))
 				allow_fast_forward = 0;
 		}
diff --git a/builtin/merge.c b/builtin/merge.c
index 9307e9c..6babf39 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -769,8 +769,7 @@ static void read_merge_msg(struct strbuf *msg)
 {
 	const char *filename = git_path("MERGE_MSG");
 	strbuf_reset(msg);
-	if (strbuf_read_file(msg, filename, 0) < 0)
-		die_errno(_("Could not read from '%s'"), filename);
+	strbuf_read_file_or_die(msg, filename, 0);
 }
 
 static void write_merge_state(struct commit_list *);
diff --git a/builtin/notes.c b/builtin/notes.c
index 453457a..3210c7f 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -252,8 +252,8 @@ static int parse_file_arg(const struct option *opt, const char *arg, int unset)
 	if (!strcmp(arg, "-")) {
 		if (strbuf_read(&(msg->buf), 0, 1024) < 0)
 			die_errno(_("cannot read '%s'"), arg);
-	} else if (strbuf_read_file(&(msg->buf), arg, 1024) < 0)
-		die_errno(_("could not open or read '%s'"), arg);
+	} else
+		strbuf_read_file_or_die(&(msg->buf), arg, 0);
 	stripspace(&(msg->buf), 0);
 
 	msg->given = 1;
diff --git a/builtin/tag.c b/builtin/tag.c
index 9c3e067..69f4ea3 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -540,11 +540,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			if (!strcmp(msgfile, "-")) {
 				if (strbuf_read(&buf, 0, 1024) < 0)
 					die_errno(_("cannot read '%s'"), msgfile);
-			} else {
-				if (strbuf_read_file(&buf, msgfile, 1024) < 0)
-					die_errno(_("could not open or read '%s'"),
-						msgfile);
-			}
+			} else
+				strbuf_read_file_or_die(&buf, msgfile, 0);
 		}
 	}
 
diff --git a/strbuf.c b/strbuf.c
index 9a373be..9f50478 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -411,6 +411,14 @@ int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 	return len;
 }
 
+void strbuf_read_file_or_die(struct strbuf *sb, const char *path, size_t size)
+{
+	int ret;
+	ret = strbuf_read_file(sb, path, size);
+	if (ret < 0 || (size && ret != size))
+		die_errno(_("could not open or read '%s'"), path);
+}
+
 void strbuf_add_lines(struct strbuf *out, const char *prefix,
 		      const char *buf, size_t size)
 {
diff --git a/strbuf.h b/strbuf.h
index ecae4e2..c1f012d 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -152,6 +152,7 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 /* XXX: if read fails, any partial read is undone */
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
 extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
+extern void strbuf_read_file_or_die(struct strbuf *sb, const char *path, size_t size);
 extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
 
 extern int strbuf_getwholeline(struct strbuf *, FILE *, int);
-- 
2.3.0.rc1.137.g477eb31
