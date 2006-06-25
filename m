From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] Add msg_sep to diff_options
Date: Sun, 25 Jun 2006 13:54:14 +0300
Message-ID: <20060625135414.425580d1.tihirvon@gmail.com>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
	<20060624202153.1001a66c.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 12:54:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuSFx-0001gH-Ug
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 12:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWFYKyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 06:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWFYKyT
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 06:54:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:14268 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932338AbWFYKyS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 06:54:18 -0400
Received: by nf-out-0910.google.com with SMTP id m19so458978nfc
        for <git@vger.kernel.org>; Sun, 25 Jun 2006 03:54:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Fro8C0Y2erFS/glN5IR63mx5ibHWCqTpulcH5vMkdFWigYUq19CeUcooFUe6n5l9YW3HPGoz4BbgoEeq+ZSp1nM8doOxQrUyqlhzLyPGtlZnOMyibKfdwC4WGoBTPtu587N2BDNB/3esRFXa/5PaGStxMWypDBp9sz8kMCnOfrE=
Received: by 10.49.19.11 with SMTP id w11mr3985781nfi;
        Sun, 25 Jun 2006 03:54:16 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id p72sm3282325nfc.2006.06.25.03.54.15;
        Sun, 25 Jun 2006 03:54:16 -0700 (PDT)
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060624202153.1001a66c.tihirvon@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22609>

Add msg_sep variable to struct diff_options.  msg_sep is printed after
commit message.  Default is "\n", format-patch sets it to "---\n".

This also removes the second argument from show_log() because all
callers derived it from the first argument:

    show_log(rev, rev->loginfo, ...

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---

  I'm not 100% sure if format-patch is the only one wanting "---\n".
  But I think "\n" should be used for every command that doesn't create
  patches.

 builtin-log.c  |    1 +
 combine-diff.c |    7 ++++---
 diff.c         |    1 +
 diff.h         |    1 +
 log-tree.c     |   15 ++++++---------
 log-tree.h     |    2 +-
 6 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index f173070..5b3fadc 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -175,6 +175,7 @@ int cmd_format_patch(int argc, const cha
 	rev.diff = 1;
 	rev.combine_merges = 0;
 	rev.ignore_merges = 1;
+	rev.diffopt.msg_sep = "---\n";
 
 	git_config(git_format_config);
 	rev.extra_headers = extra_headers;
diff --git a/combine-diff.c b/combine-diff.c
index 3daa8cb..39fb10c 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -701,7 +701,7 @@ static int show_patch_diff(struct combin
 		const char *abb;
 
 		if (rev->loginfo)
-			show_log(rev, rev->loginfo, "\n");
+			show_log(rev, opt->msg_sep);
 		dump_quoted_path(dense ? "diff --cc " : "diff --combined ", elem->path);
 		printf("index ");
 		for (i = 0; i < num_parent; i++) {
@@ -769,7 +769,7 @@ static void show_raw_diff(struct combine
 		inter_name_termination = 0;
 
 	if (rev->loginfo)
-		show_log(rev, rev->loginfo, "\n");
+		show_log(rev, opt->msg_sep);
 
 	if (opt->output_format & DIFF_FORMAT_RAW) {
 		offset = strlen(COLONS) - num_parent;
@@ -855,7 +855,8 @@ void diff_tree_combined(const unsigned c
 		paths = intersect_paths(paths, i, num_parent);
 
 		if (opt->output_format & DIFF_FORMAT_DIFFSTAT && rev->loginfo)
-			show_log(rev, rev->loginfo, "---\n");
+			show_log(rev, opt->msg_sep);
+
 		diff_flush(&diffopts);
 		if (opt->output_format & DIFF_FORMAT_DIFFSTAT)
 			putchar('\n');
diff --git a/diff.c b/diff.c
index 4b1b4eb..cc2af30 100644
--- a/diff.c
+++ b/diff.c
@@ -1359,6 +1359,7 @@ void diff_setup(struct diff_options *opt
 	options->break_opt = -1;
 	options->rename_limit = -1;
 	options->context = 3;
+	options->msg_sep = "\n";
 
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
diff --git a/diff.h b/diff.h
index 2b6dc0c..729cd02 100644
--- a/diff.h
+++ b/diff.h
@@ -57,6 +57,7 @@ struct diff_options {
 	int rename_limit;
 	int setup;
 	int abbrev;
+	const char *msg_sep;
 	const char *stat_sep;
 	long xdl_opts;
 
diff --git a/log-tree.c b/log-tree.c
index 7d4c51f..ab6b682 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -43,9 +43,10 @@ static int append_signoff(char *buf, int
 	return at;
 }
 
-void show_log(struct rev_info *opt, struct log_info *log, const char *sep)
+void show_log(struct rev_info *opt, const char *sep)
 {
 	static char this_header[16384];
+	struct log_info *log = opt->loginfo;
 	struct commit *commit = log->commit, *parent = log->parent;
 	int abbrev = opt->diffopt.abbrev;
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
@@ -163,13 +164,9 @@ int log_tree_diff_flush(struct rev_info 
 		return 0;
 	}
 
-	if (opt->loginfo && !opt->no_commit_id) {
-		if (opt->diffopt.output_format & DIFF_FORMAT_DIFFSTAT) {
-			show_log(opt, opt->loginfo,  "---\n");
-		} else {
-			show_log(opt, opt->loginfo,  "\n");
-		}
-	}
+	if (opt->loginfo && !opt->no_commit_id)
+		show_log(opt, opt->diffopt.msg_sep);
+
 	diff_flush(&opt->diffopt);
 	return 1;
 }
@@ -266,7 +263,7 @@ int log_tree_commit(struct rev_info *opt
 	shown = log_tree_diff(opt, commit, &log);
 	if (!shown && opt->loginfo && opt->always_show_header) {
 		log.parent = NULL;
-		show_log(opt, opt->loginfo, "");
+		show_log(opt, "");
 		shown = 1;
 	}
 	opt->loginfo = NULL;
diff --git a/log-tree.h b/log-tree.h
index a26e484..e82b56a 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -11,6 +11,6 @@ void init_log_tree_opt(struct rev_info *
 int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
 int log_tree_opt_parse(struct rev_info *, const char **, int);
-void show_log(struct rev_info *opt, struct log_info *log, const char *sep);
+void show_log(struct rev_info *opt, const char *sep);
 
 #endif
-- 
1.4.1.rc1.g35ee-dirty
