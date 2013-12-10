From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 1/2] diff: move no-index detection to builtin/diff.c
Date: Tue, 10 Dec 2013 18:52:14 +0100
Message-ID: <1386697935-18635-1-git-send-email-t.gummerer@gmail.com>
References: <xmqqwqjdydga.fsf@gitster.dls.corp.google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Tim Henigan <tim.henigan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alexey Borzenkov <snaury@gmail.com>,
	Bobby Powers <bobbypowers@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 10 18:53:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqRUi-0007Pj-Ai
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 18:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376Ab3LJRxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 12:53:08 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:50146 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026Ab3LJRxF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 12:53:05 -0500
Received: by mail-yh0-f50.google.com with SMTP id b6so4077037yha.23
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 09:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SNiaz2/YoAwfjTgvykz6SCKFYsL6hvvS69SvKVD9PVE=;
        b=I6lxVWElnR0+8wcTnI4hlRapo8H4NiIHNv6xvahCttvC/cxURv0X7WEG1F89SRYe67
         kIBMPRonAas07nps9pIff3eIKpGYQU8Cky4WHMEU24wTsJa3xCDU/3QOwai5aAdf7NyI
         2idxkM8XgL7hdZroOSjx4U2btLXTgCA0wkuAOvYQj4zR7GOfH6oNqIo2qwNWoDe5bYMC
         CPre2z8lyenv/v0tyDSWFWjUKiOnjqIRgF4ktM9dV5YFsFd+5wE7Elk0TyHyrkDFb5wZ
         QaFSIyCnOCqLTDn6+kJR2RbHuV5F9HSAuJzqmYRn9SHOMfQgA+kjZZit4kVVzQbHXTYs
         wlJg==
X-Received: by 10.236.102.200 with SMTP id d48mr20469563yhg.38.1386697984099;
        Tue, 10 Dec 2013 09:53:04 -0800 (PST)
Received: from localhost ([2001:5c0:1400:a::f5b])
        by mx.google.com with ESMTPSA id x9sm5612648yhd.13.2013.12.10.09.53.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2013 09:53:03 -0800 (PST)
X-Mailer: git-send-email 1.8.5.4.g8639e57
In-Reply-To: <xmqqwqjdydga.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239140>

Currently the --no-index option is parsed in diff_no_index().  Move the
detection if a no-index diff should be executed to builtin/diff.c, where
we can use it for executing diff_no_index() conditionally.  This will
also allow us to execute other operations conditionally, which will be
done in the next patch.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

Thanks to Junio, Torsten and Eric for comments on the previous round.
I've added this refactoring patch, to avoid the partial duplication of
the logic.  I've also fixed the tests, that now use a sub-shell for
executing and fix the stray && at the end of the test.

 builtin/diff.c  | 45 ++++++++++++++++++++++++++++++++++++++++++---
 diff-no-index.c | 48 +++---------------------------------------------
 diff.h          |  2 +-
 3 files changed, 46 insertions(+), 49 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index adb93a9..7220b2c 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -257,7 +257,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	int blobs = 0, paths = 0;
 	const char *path = NULL;
 	struct blobinfo blob[2];
-	int nongit;
+	int nongit, no_index = 0;
 	int result = 0;
 
 	/*
@@ -283,14 +283,53 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	 * Other cases are errors.
 	 */
 
+	/* Were we asked to do --no-index explicitly? */
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "--")) {
+			i++;
+			break;
+		}
+		if (!strcmp(argv[i], "--no-index"))
+			no_index = 1;
+		if (argv[i][0] != '-')
+			break;
+	}
+
 	prefix = setup_git_directory_gently(&nongit);
+	/*
+	 * Treat git diff with at least one path outside of the
+	 * repo the same as if the command would have been executed
+	 * outside of a git repository.  In this case it behaves
+	 * the same way as "git diff --no-index <a> <b>", which acts
+	 * as a colourful "diff" replacement.
+	 */
+	nongit |= (argc == i + 2) && !(path_inside_repo(prefix, argv[i]) &&
+				       path_inside_repo(prefix, argv[i + 1]));
 	gitmodules_config();
 	git_config(git_diff_ui_config, NULL);
 
 	init_revisions(&rev, prefix);
 
-	/* If this is a no-index diff, just run it and exit there. */
-	diff_no_index(&rev, argc, argv, nongit, prefix);
+	if (no_index || nongit) {
+		if (argc != i + 2) {
+			if (!no_index) {
+				/*
+				 * There was no --no-index and there were not two
+				 * paths. It is possible that the user intended
+				 * to do an inside-repository operation.
+				 */
+				fprintf(stderr, "Not a git repository\n");
+				fprintf(stderr,
+					"To compare two paths outside a working tree:\n");
+			}
+			/* Give the usage message for non-repository usage and exit. */
+			usagef("git diff %s <path> <path>",
+			       no_index ? "--no-index" : "[--no-index]");
+
+		}
+		/* If this is a no-index diff, just run it and exit there. */
+		diff_no_index(&rev, argc, argv, nongit, no_index, prefix);
+	}
 
 	/* Otherwise, we are doing the usual "git" diff */
 	rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
diff --git a/diff-no-index.c b/diff-no-index.c
index 00a8eef..78e3090 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -181,56 +181,14 @@ static int queue_diff(struct diff_options *o,
 	}
 }
 
-void diff_no_index(struct rev_info *revs,
-		   int argc, const char **argv,
-		   int nongit, const char *prefix)
+int diff_no_index(struct rev_info *revs,
+		  int argc, const char **argv,
+		  int nongit, int no_index, const char *prefix)
 {
 	int i, prefixlen;
-	int no_index = 0;
 	unsigned deprecated_show_diff_q_option_used = 0;
 	const char *paths[2];
 
-	/* Were we asked to do --no-index explicitly? */
-	for (i = 1; i < argc; i++) {
-		if (!strcmp(argv[i], "--")) {
-			i++;
-			break;
-		}
-		if (!strcmp(argv[i], "--no-index"))
-			no_index = 1;
-		if (argv[i][0] != '-')
-			break;
-	}
-
-	if (!no_index && !nongit) {
-		/*
-		 * Inside a git repository, without --no-index.  Only
-		 * when a path outside the repository is given,
-		 * e.g. "git diff /var/tmp/[12]", or "git diff
-		 * Makefile /var/tmp/Makefile", allow it to be used as
-		 * a colourful "diff" replacement.
-		 */
-		if ((argc != i + 2) ||
-		    (path_inside_repo(prefix, argv[i]) &&
-		     path_inside_repo(prefix, argv[i+1])))
-			return;
-	}
-	if (argc != i + 2) {
-		if (!no_index) {
-			/*
-			 * There was no --no-index and there were not two
-			 * paths. It is possible that the user intended
-			 * to do an inside-repository operation.
-			 */
-			fprintf(stderr, "Not a git repository\n");
-			fprintf(stderr,
-				"To compare two paths outside a working tree:\n");
-		}
-		/* Give the usage message for non-repository usage and exit. */
-		usagef("git diff %s <path> <path>",
-		       no_index ? "--no-index" : "[--no-index]");
-	}
-
 	diff_setup(&revs->diffopt);
 	for (i = 1; i < argc - 2; ) {
 		int j;
diff --git a/diff.h b/diff.h
index e342325..3e1828a 100644
--- a/diff.h
+++ b/diff.h
@@ -330,7 +330,7 @@ extern int diff_flush_patch_id(struct diff_options *, unsigned char *);
 
 extern int diff_result_code(struct diff_options *, int);
 
-extern void diff_no_index(struct rev_info *, int, const char **, int, const char *);
+extern int diff_no_index(struct rev_info *, int, const char **, int, int, const char *);
 
 extern int index_differs_from(const char *def, int diff_flags);
 
-- 
1.8.5.4.g8639e57
