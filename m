From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/9] commit: split off a function to fetch the default log
 message
Date: Sat, 24 Jul 2010 19:58:08 -0500
Message-ID: <20100725005808.GC18420@burratino>
References: <20100725005443.GA18370@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 02:59:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcpYn-0007ne-Bs
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 02:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782Ab0GYA7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 20:59:17 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44608 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab0GYA7M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 20:59:12 -0400
Received: by gxk23 with SMTP id 23so546314gxk.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 17:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=oZaxeIy7j4iY0f7uvIUrl5BwSBqIwFT94SMoIWdd9FI=;
        b=SCU5h8UM9jxKwPpixGGPieQ8cUhNtpNqXAIFsn53rcHXRwIpwX7xlTBZo2lj5zujFR
         3yQkUMRVdWv9Irjq8mR1CCZVtcq4lwwFFRAS2RFP9liZ55x0+z2T0LqhMyWqXplMyBfM
         Q6bDY4jTtsbVcQnr455ighd6Zp+pR3RJ9iQoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uaoGN3NjqeZ4x1xc2NnPHPuEz00RK0rz8KlMp7caR/VA5Z4jQpoFVccz+AQ5QNeMGK
         30KRb0bCotlZB/8Fn+neAkbK2v5bLjlxohv9h1IldUnHKTTV4Yh3nFXlyq52uVlHbUDU
         RYk/kHQjiJNuGY7ZFDAfuaYCl/P+uwGrARj4g=
Received: by 10.101.144.4 with SMTP id w4mr5854450ann.196.1280019551689;
        Sat, 24 Jul 2010 17:59:11 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id i25sm3317329anh.37.2010.07.24.17.59.10
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 17:59:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100725005443.GA18370@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151695>

The details of how the default message template is grabbed from
MERGE_MSG will be irrelevant to most people reading the commit
preparation code.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/commit.c |   94 +++++++++++++++++++++++++++++++----------------------
 1 files changed, 55 insertions(+), 39 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a78dbd8..6774180 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -549,62 +549,78 @@ static int ends_rfc2822_footer(struct strbuf *sb)
 	return 1;
 }
 
-static int prepare_to_commit(const char *index_file, const char *prefix,
-			     struct wt_status *s)
+/*
+ * Return value is the "source" argument for hooks/prepare-commit-msg.
+ */
+static const char *get_template_message(struct strbuf *sb,
+					const char **hook_arg2)
 {
 	struct stat statbuf;
-	int commitable, saved_color_setting;
-	struct strbuf sb = STRBUF_INIT;
-	char *buffer;
-	FILE *fp;
-	const char *hook_arg1 = NULL;
-	const char *hook_arg2 = NULL;
-	int ident_shown = 0;
-
-	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
-		return 0;
-
 	if (message.len) {
-		strbuf_addbuf(&sb, &message);
-		hook_arg1 = "message";
-	} else if (logfile && !strcmp(logfile, "-")) {
+		strbuf_addbuf(sb, &message);
+		return "message";
+	}
+	if (logfile && !strcmp(logfile, "-")) {
 		if (isatty(0))
 			fprintf(stderr, "(reading log message from standard input)\n");
-		if (strbuf_read(&sb, 0, 0) < 0)
+		if (strbuf_read(sb, 0, 0) < 0)
 			die_errno("could not read log from standard input");
-		hook_arg1 = "message";
-	} else if (logfile) {
-		if (strbuf_read_file(&sb, logfile, 0) < 0)
-			die_errno("could not read log file '%s'",
-				  logfile);
-		hook_arg1 = "message";
-	} else if (use_message) {
-		buffer = strstr(use_message_buffer, "\n\n");
+		return "message";
+	}
+	if (logfile) {
+		if (strbuf_read_file(sb, logfile, 0) < 0)
+			die_errno("could not read log file '%s'", logfile);
+		return "message";
+	}
+	if (use_message) {
+		char *buffer = strstr(use_message_buffer, "\n\n");
 		if (!buffer || buffer[2] == '\0')
 			die("commit has empty message");
-		strbuf_add(&sb, buffer + 2, strlen(buffer + 2));
-		hook_arg1 = "commit";
-		hook_arg2 = use_message;
-	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
-		if (strbuf_read_file(&sb, git_path("MERGE_MSG"), 0) < 0)
+		strbuf_add(sb, buffer + 2, strlen(buffer + 2));
+		*hook_arg2 = use_message;
+		return "commit";
+	}
+	if (!stat(git_path("MERGE_MSG"), &statbuf)) {
+		if (strbuf_read_file(sb, git_path("MERGE_MSG"), 0) < 0)
 			die_errno("could not read MERGE_MSG");
-		hook_arg1 = "merge";
-	} else if (!stat(git_path("SQUASH_MSG"), &statbuf)) {
-		if (strbuf_read_file(&sb, git_path("SQUASH_MSG"), 0) < 0)
+		return "merge";
+	}
+	if (!stat(git_path("SQUASH_MSG"), &statbuf)) {
+		if (strbuf_read_file(sb, git_path("SQUASH_MSG"), 0) < 0)
 			die_errno("could not read SQUASH_MSG");
-		hook_arg1 = "squash";
-	} else if (template_file && !stat(template_file, &statbuf)) {
-		if (strbuf_read_file(&sb, template_file, 0) < 0)
+		return "squash";
+	}
+	if (template_file && !stat(template_file, &statbuf)) {
+		if (strbuf_read_file(sb, template_file, 0) < 0)
 			die_errno("could not read '%s'", template_file);
-		hook_arg1 = "template";
+		return "template";
 	}
 
 	/*
 	 * This final case does not modify the template message,
 	 * it just sets the argument to the prepare-commit-msg hook.
 	 */
-	else if (in_merge)
-		hook_arg1 = "merge";
+	if (in_merge)
+		return "merge";
+
+	return NULL;
+}
+
+
+static int prepare_to_commit(const char *index_file, const char *prefix,
+			     struct wt_status *s)
+{
+	int commitable, saved_color_setting;
+	struct strbuf sb = STRBUF_INIT;
+	FILE *fp;
+	const char *hook_arg1 = NULL;
+	const char *hook_arg2 = NULL;
+	int ident_shown = 0;
+
+	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
+		return 0;
+
+	hook_arg1 = get_template_message(&sb, &hook_arg2);
 
 	fp = fopen(git_path(commit_editmsg), "w");
 	if (fp == NULL)
-- 
1.7.2.9.ge3789.dirty
