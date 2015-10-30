From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH] checkout: add --progress option
Date: Thu, 29 Oct 2015 19:23:06 -0600
Message-ID: <1446168186-4730-1-git-send-email-eantoranz@gmail.com>
Cc: peff@peff.net, Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 30 02:23:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZryPx-0006qW-Ds
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 02:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757959AbbJ3BXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 21:23:41 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:35211 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbbJ3BXk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 21:23:40 -0400
Received: by ykek133 with SMTP id k133so61900119yke.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 18:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Smcla8//YUdaYm74gxY0HTqzVlPOpBF2qS8koy9mAYE=;
        b=1EN2qDr/u4SCNAQcARl8D9+0vByX9MUnQyjLeCyPiTrlwxTqrHKuCxg9/bJae3jrL3
         BovBRdAx5mqWvY+eY6TRYEDXvhFmlK5tDeub0z74yc4uWwwowLE1h5Lufyw4WRb2uBCS
         TT7i4iaMKPlgo8Vhcp+MyX6NLt3sVJlYsm/XtcFi7koOomdnDFfz+XAT8jAQnGwr1fG9
         iyLq4hVhyE++OsPr7BcXVkpj6nqTphXNRijIZW0l/JrzvyyDzX3YtUtp3Rhl+wJH4IB0
         3BuZVDh6FMBK4R9Q2gHYs9L8uFrqVeY4IJiCnpzAG57TagZcIJ1Gy/bwLhRCUJfC7JN8
         MJBg==
X-Received: by 10.129.154.141 with SMTP id r135mr4023691ywg.195.1446168219406;
        Thu, 29 Oct 2015 18:23:39 -0700 (PDT)
Received: from linuxerio.cabletica.com (ip157-11-15-186.ct.co.cr. [186.15.11.157])
        by smtp.gmail.com with ESMTPSA id q2sm2627218ywd.11.2015.10.29.18.23.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Oct 2015 18:23:38 -0700 (PDT)
X-Mailer: git-send-email 2.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280471>

Under normal circumstances, and like other git commands,
git checkout will write progress info to stderr if
attached to a terminal. This option allows progress
to be forced even if not using a terminal. Also,
progress can be skipped if using option --no-progress.

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 Documentation/git-checkout.txt |  6 ++++++
 builtin/checkout.c             | 17 ++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index e269fb1..93ba35a 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -107,6 +107,12 @@ OPTIONS
 --quiet::
 	Quiet, suppress feedback messages.
 
+--progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless -q
+	is specified. This flag forces progress status even if the
+	standard error stream is not directed to a terminal.
+
 -f::
 --force::
 	When switching branches, proceed even if the index or the
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bc703c0..e28c36b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -27,6 +27,8 @@ static const char * const checkout_usage[] = {
 	NULL,
 };
 
+static int option_progress = -1;
+
 struct checkout_opts {
 	int patch_mode;
 	int quiet;
@@ -417,7 +419,19 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.reset = 1;
 	opts.merge = 1;
 	opts.fn = oneway_merge;
-	opts.verbose_update = !o->quiet && isatty(2);
+	/**
+	 * Rules to display progress:
+	 * -q is selected
+	 *      no verbiage
+	 * -q is _not_ selected and --no-progress _is_ selected,
+	 *      progress will be skipped
+	 * -q is _not_ selected and --progress _is_ selected,
+	 *      progress will be printed to stderr
+	 * -q is _not_ selected and --progress is 'undefined'
+	 *      progress will be printed to stderr _if_ working on a terminal
+	 */
+	opts.verbose_update = !o->quiet && (option_progress > 0 ||
+					   (option_progress < 0 && isatty(2)));
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	parse_tree(tree);
@@ -1156,6 +1170,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 				N_("second guess 'git checkout <no-such-branch>'")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
+		OPT_BOOL(0, "progress", &option_progress, N_("force progress reporting")),
 		OPT_END(),
 	};
 
-- 
2.6.1
