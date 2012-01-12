From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] diff --no-index: support more than one file pair
Date: Thu, 12 Jan 2012 16:09:31 +0700
Message-ID: <1326359371-13528-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 10:09:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlGfQ-00019z-51
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 10:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032Ab2ALJJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 04:09:47 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44168 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849Ab2ALJJo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 04:09:44 -0500
Received: by iabz25 with SMTP id z25so2452789iab.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 01:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ZQBMt2on463syW7jlGO/HAhNDa0ARw3lLxEyhT5DpII=;
        b=Zx5+Ev4CpBSCoPSyqB/DpzxgX3iwAUeZfQfnUdqxEyxWVmixwIVaxamXkoDToBuNY3
         wReqFS9q9OuH28yC+XeF6U5o7a2kR69nroiIhYmcbe1NZE5KSvMYWvhq+Ph+huIeKo3n
         ixacnMybg6uq+SZqqFeNFCeAnW5OcwjACbF+A=
Received: by 10.50.181.169 with SMTP id dx9mr11015419igc.0.1326359383360;
        Thu, 12 Jan 2012 01:09:43 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id 5sm15092261ibe.8.2012.01.12.01.09.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 01:09:42 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 12 Jan 2012 16:09:33 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188435>

This allows you to do

git diff --no-index file1.old file1.new file2.old file2.new...

It could be seen as an abuse of "git --no-index", but it's very
tempting considering many bells and whistles git's diff machinery
provides.

Signed-off-by: A Clearcase user who has had enough with "ct diff"
---
 Sorry I used git@vger as a personal archive, but this might benefit
 others as well, I think.

 diff-no-index.c |   38 +++++++++++++++++++++-----------------
 1 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 3a36144..b4f6d06 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -199,12 +199,8 @@ void diff_no_index(struct rev_info *revs,
 		     !path_outside_repo(argv[i+1])))
 			return;
 	}
-	if (argc != i + 2)
-		usagef("git diff %s <path> <path>",
-		       no_index ? "--no-index" : "[--no-index]");
-
 	diff_setup(&revs->diffopt);
-	for (i = 1; i < argc - 2; ) {
+	for (i = 1; i < argc; ) {
 		int j;
 		if (!strcmp(argv[i], "--no-index"))
 			i++;
@@ -214,13 +210,19 @@ void diff_no_index(struct rev_info *revs,
 		}
 		else if (!strcmp(argv[i], "--"))
 			i++;
-		else {
+		else if (argv[i][0] == '-') {
 			j = diff_opt_parse(&revs->diffopt, argv + i, argc - i);
 			if (!j)
 				die("invalid diff option/value: %s", argv[i]);
 			i += j;
 		}
+		else
+			break;
 	}
+	if ((argc - i) % 2)
+		usagef("git diff %s <path> <path>%s",
+		       no_index ? "--no-index" : "[--no-index]",
+		       no_index ? "[ <path> <path>...]" : "");
 
 	/*
 	 * If the user asked for our exit code then don't start a
@@ -229,13 +231,15 @@ void diff_no_index(struct rev_info *revs,
 	if (!DIFF_OPT_TST(&revs->diffopt, EXIT_WITH_STATUS))
 		setup_pager();
 
+	/* argv now only contains paths */
+	argv += i;
+	argc -= i;
+
 	if (prefix) {
 		int len = strlen(prefix);
-		const char *paths[3];
-		memset(paths, 0, sizeof(paths));
 
-		for (i = 0; i < 2; i++) {
-			const char *p = argv[argc - 2 + i];
+		for (i = 0; i < argc; i++) {
+			const char *p = argv[i];
 			/*
 			 * stdin should be spelled as '-'; if you have
 			 * path that is '-', spell it as ./-.
@@ -243,12 +247,10 @@ void diff_no_index(struct rev_info *revs,
 			p = (strcmp(p, "-")
 			     ? xstrdup(prefix_filename(prefix, len, p))
 			     : p);
-			paths[i] = p;
+			argv[i] = p;
 		}
-		diff_tree_setup_paths(paths, &revs->diffopt);
 	}
-	else
-		diff_tree_setup_paths(argv + argc - 2, &revs->diffopt);
+
 	revs->diffopt.skip_stat_unmatch = 1;
 	if (!revs->diffopt.output_format)
 		revs->diffopt.output_format = DIFF_FORMAT_PATCH;
@@ -260,9 +262,11 @@ void diff_no_index(struct rev_info *revs,
 	if (diff_setup_done(&revs->diffopt) < 0)
 		die("diff_setup_done failed");
 
-	if (queue_diff(&revs->diffopt, revs->diffopt.pathspec.raw[0],
-		       revs->diffopt.pathspec.raw[1]))
-		exit(1);
+	while (argv[0] && argv[1]) {
+		if (queue_diff(&revs->diffopt, argv[0], argv[1]))
+			exit(1);
+		argv += 2;
+	}
 	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
-- 
1.7.3.1.256.g2539c.dirty
