From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 09/11] vcs-svn,svn-fe: allow to disable 'progress' lines
Date: Wed, 13 Jul 2011 18:21:11 +0600
Message-ID: <1310559673-5026-10-git-send-email-divanorama@gmail.com>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 14:21:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgyRd-0004ak-Qu
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 14:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab1GMMVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 08:21:12 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35552 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab1GMMVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 08:21:09 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so4787045bwd.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 05:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QXRNswF+pteufcBR8BP8VHWQvI9HO4dbu/kqjCNAZXQ=;
        b=OlW6YznJsIY+FM2cjFYKAX+IE4no8Ru9RQW+uUc3NtpXKEb3sVy5ED9I4jqpRIkgYd
         5L5qlBwkYXgoaxi4SaAJfry0G5UOB9N+6JaTfdUXH3WdBt79DT31nLTBRg/x8DDFYfJh
         7R2h34YhkkPe8SmL+6ZEEVR45gG0R9MzYkCMA=
Received: by 10.204.74.17 with SMTP id s17mr500393bkj.229.1310559668395;
        Wed, 13 Jul 2011 05:21:08 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id c8sm1653987bkc.15.2011.07.13.05.21.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 05:21:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177034>

vcs-svn/ writes a progress line after each processed revision. It
is too noisy for big imports. That's a stress for a terminal and
any other output can be lost or scrolled away among these lines.
If svn-fe is invoked by a remote helper the import stream with
progress lines in it will go directly to the git fast-import which
always prints every progress line met in the stream.

For now just add a switch to turn progress lines off:
$ svn-fe --no-progress ...

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/svn-fe.c   |    3 +++
 contrib/svn-fe/svn-fe.txt |    3 +++
 test-svn-fe.c             |    1 +
 vcs-svn/svndump.c         |    6 +++++-
 vcs-svn/svndump.h         |    1 +
 5 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index cd9e449..a388750 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -15,6 +15,9 @@ static const char * const svn_fe_usage[] = {
 static struct svndump_args args;
 
 static struct option svn_fe_options[] = {
+	{ OPTION_BIT, 0, "progress", &args.progress,
+		NULL, "don't write a progress line after each commit",
+		PARSE_OPT_NOARG | PARSE_OPT_NEGHELP, NULL, 1 },
 	OPT_STRING(0, "git-svn-id-url", &args.url, "url",
 		"append git-svn metadata line to commit messages"),
 	OPT_STRING(0, "ref", &args.ref, "dst_ref",
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index a7ad368..f1a459e 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -39,6 +39,9 @@ OPTIONS
 	Integer number of file descriptor from which
 	responses to 'ls' and 'cat-blob' requests will come.
 	Default is fd=3.
+--[no-]progress::
+	Write 'progress' lines to fast-import stream. These
+	can be displayed by fast-import.
 
 INPUT FORMAT
 ------------
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 43e19b2..f2711e6 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -57,6 +57,7 @@ int main(int argc, const char *argv[])
 {
 	args.ref = "refs/heads/master";
 	args.backflow_fd = 3;
+	args.progress = 1;
 	argc = parse_options(argc, argv, NULL, test_svnfe_options,
 						test_svnfe_usage, 0);
 
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 4194052..6ad9f63 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -37,6 +37,8 @@
 
 #define MAX_GITSVN_LINE_LEN 4096
 
+static int print_progress;
+
 static struct line_buffer input = LINE_BUFFER_INIT;
 
 static struct {
@@ -332,7 +334,8 @@ static void end_revision(void)
 {
 	if (rev_ctx.revision) {
 		fast_export_end_commit(rev_ctx.revision);
-		printf("progress Imported commit %"PRIu32".\n\n", rev_ctx.revision);
+		if (print_progress)
+			printf("progress Imported commit %"PRIu32".\n\n", rev_ctx.revision);
 		dump_ctx.first_commit_done = 1;
 	}
 }
@@ -482,6 +485,7 @@ int svndump_init(const struct svndump_args *args)
 {
 	if (buffer_init(&input, args->filename))
 		return error("cannot open %s: %s", args->filename, strerror(errno));
+	print_progress = args->progress;
 	fast_export_init(args->backflow_fd);
 	strbuf_init(&dump_ctx.uuid, 4096);
 	strbuf_init(&dump_ctx.url, 4096);
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index d266b68..af63edb 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -5,6 +5,7 @@ struct svndump_args {
 	const char *filename, *url;
 	const char *ref;
 	int backflow_fd;
+	int progress;
 };
 
 int svndump_init(const struct svndump_args *args);
-- 
1.7.3.4
