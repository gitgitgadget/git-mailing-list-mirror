From: Edmundo Carmona <eantoranz@gmail.com>
Subject: [PATCH 1/2] checkout: progress on non-tty. progress with lf
Date: Sat, 24 Oct 2015 08:59:46 -0600
Message-ID: <1445698786-22673-1-git-send-email-eantoranz@gmail.com>
Cc: Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 24 17:00:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zq0Il-0006cc-5h
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 17:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbbJXPAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 11:00:05 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:36635 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbbJXPAD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2015 11:00:03 -0400
Received: by ykba4 with SMTP id a4so140891573ykb.3
        for <git@vger.kernel.org>; Sat, 24 Oct 2015 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=FUgYEsbAK2kfRSN16SBHRTnAZv7rdMe3CUoSjFWlYk8=;
        b=hMBd7G8RzJ1rz1S9sikO46X+y+Pl24Qn/oymLO48/MdB8fFY9cXV2ybnF49ID98O2O
         W+athqSfPc38w5wcrj12uFT20+mYw1k2iosMg+AQj5FJNgCVdgvAozZgq0SPVNONXwe4
         226mImnyDzBH4jQ3EO6Y3pfFcxECOj3IB3UAO0Cnpk4dZfysW8ww1hplwqrojhqPTPGX
         rnGlXUdlUCNC1OOXB38XC6loqmOdP13K/SpubbGKcmnpRcuGy6eqTWyLDZYKeurZlxoz
         RJtxzaNNNElLyXo1qlq9ZzoFREawvYTr4iOBRPqjCvHp2NBeQlSpd2F888aZTW7B9AGv
         B7cA==
X-Received: by 10.13.235.13 with SMTP id u13mr10498840ywe.270.1445698803180;
        Sat, 24 Oct 2015 08:00:03 -0700 (PDT)
Received: from linuxerio.cabletica.com (ip14-190-15-186.ct.co.cr. [186.15.190.14])
        by smtp.gmail.com with ESMTPSA id m11sm13842915ywb.53.2015.10.24.08.00.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Oct 2015 08:00:02 -0700 (PDT)
X-Mailer: git-send-email 2.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280124>

From: Edmundo Carmona Antoranz <eantoranz@gmail.com>

--progress-no-tty: option to write progress even if not working on a TTY
--progress-lf: option to print progress using LF instead of CR
Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 builtin/checkout.c | 12 ++++++++++--
 progress.c         |  8 +++++++-
 progress.h         |  1 +
 unpack-trees.c     |  3 +++
 unpack-trees.h     |  2 ++
 5 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index bc703c0..2c86a9a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -37,6 +37,8 @@ struct checkout_opts {
 	int overwrite_ignore;
 	int ignore_skipworktree;
 	int ignore_other_worktrees;
+	int progress_lf;
+	int progress_notty;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -417,7 +419,8 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.reset = 1;
 	opts.merge = 1;
 	opts.fn = oneway_merge;
-	opts.verbose_update = !o->quiet && isatty(2);
+	opts.verbose_update = !o->quiet && (o->progress_notty || isatty(2));
+	opts.eol = o->progress_lf ? _("\n") : NULL;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	parse_tree(tree);
@@ -501,7 +504,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		topts.update = 1;
 		topts.merge = 1;
 		topts.gently = opts->merge && old->commit;
-		topts.verbose_update = !opts->quiet && isatty(2);
+		topts.verbose_update = !opts->quiet && (opts->progress_notty || isatty(2));
+		topts.eol = opts->progress_lf ? _("\n") : NULL;
 		topts.fn = twoway_merge;
 		if (opts->overwrite_ignore) {
 			topts.dir = xcalloc(1, sizeof(*topts.dir));
@@ -1156,6 +1160,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 				N_("second guess 'git checkout <no-such-branch>'")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
+		OPT_BOOL(0, "progress-lf", &opts.progress_lf,
+			 N_("write progress using lf instead of cr")),
+		OPT_BOOL(0, "progress-no-tty", &opts.progress_notty,
+			 N_("write progress info even if not using a TTY")),
 		OPT_END(),
 	};
 
diff --git a/progress.c b/progress.c
index 353bd37..3af0594 100644
--- a/progress.c
+++ b/progress.c
@@ -36,6 +36,7 @@ struct progress {
 	unsigned delay;
 	unsigned delayed_percent_treshold;
 	struct throughput *throughput;
+	const char *eol;
 };
 
 static volatile sig_atomic_t progress_update;
@@ -99,7 +100,7 @@ static int display(struct progress *progress, unsigned n, const char *done)
 
 	progress->last_value = n;
 	tp = (progress->throughput) ? progress->throughput->display.buf : "";
-	eol = done ? done : "   \r";
+	eol = done ? done : (progress->eol ? progress->eol : "   \r");
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
 		if (percent != progress->last_percent || progress_update) {
@@ -221,6 +222,7 @@ struct progress *start_progress_delay(const char *title, unsigned total,
 	progress->delayed_percent_treshold = percent_treshold;
 	progress->delay = delay;
 	progress->throughput = NULL;
+	progress->eol = NULL;
 	set_progress_signal();
 	return progress;
 }
@@ -230,6 +232,10 @@ struct progress *start_progress(const char *title, unsigned total)
 	return start_progress_delay(title, total, 0, 0);
 }
 
+void set_progress_eol(struct progress *p_progress, const char *eol) {
+	p_progress->eol = eol;
+}
+
 void stop_progress(struct progress **p_progress)
 {
 	stop_progress_msg(p_progress, _("done"));
diff --git a/progress.h b/progress.h
index 611e4c4..dbde34e 100644
--- a/progress.h
+++ b/progress.h
@@ -8,6 +8,7 @@ int display_progress(struct progress *progress, unsigned n);
 struct progress *start_progress(const char *title, unsigned total);
 struct progress *start_progress_delay(const char *title, unsigned total,
 				       unsigned percent_treshold, unsigned delay);
+void set_progress_eol(struct progress *p_progress, const char *eol);
 void stop_progress(struct progress **progress);
 void stop_progress_msg(struct progress **progress, const char *msg);
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 8e2032f..250482b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -202,6 +202,9 @@ static int check_updates(struct unpack_trees_options *o)
 
 		progress = start_progress_delay(_("Checking out files"),
 						total, 50, 1);
+		if (o->eol) {
+			set_progress_eol(progress, o->eol);
+		}
 		cnt = 0;
 	}
 
diff --git a/unpack-trees.h b/unpack-trees.h
index 36a73a6..3e4bc47 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -71,6 +71,8 @@ struct unpack_trees_options {
 	struct index_state *src_index;
 	struct index_state result;
 
+	const char *eol;
+
 	struct exclude_list *el; /* for internal use */
 };
 
-- 
2.6.1
