From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH 4/5] Make --raw option available for all diff commands
Date: Sat, 24 Jun 2006 01:00:34 +0300
Message-ID: <20060624010034.a7355905.tihirvon@gmail.com>
References: <20060624003315.804a1796.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 00:17:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fttxf-0004P0-2q
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 00:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbWFWWRE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 18:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbWFWWRE
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 18:17:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:45557 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752121AbWFWWRB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 18:17:01 -0400
Received: by nf-out-0910.google.com with SMTP id m19so277746nfc
        for <git@vger.kernel.org>; Fri, 23 Jun 2006 15:17:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=PQab1eo/lz7X4qL9Ejf0Xxw7hwQPV+ZVacBKWQCrwiL6HjHJ/gIT57LzCm7FKOYAU3zTSC/K6J6aAHHAO/kRL9Wd3FiqF0p/oan3QJ2Bd7zBI2+Z4kzs0vRZv0lc5QHWuwLNz0Rqky6/d3nWA4qJarpiUFxqRshUc3hRmKDxV/U=
Received: by 10.48.233.18 with SMTP id f18mr2853527nfh;
        Fri, 23 Jun 2006 15:17:00 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id r33sm3395655nfc.2006.06.23.15.16.59;
        Fri, 23 Jun 2006 15:17:00 -0700 (PDT)
To: junkio@cox.net
In-Reply-To: <20060624003315.804a1796.tihirvon@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22444>

Makes --raw a global diff output format option.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 builtin-diff.c |   48 ++++++++++++------------------------------------
 diff.c         |    2 ++
 2 files changed, 14 insertions(+), 36 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index b6f7727..8fd91b8 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -39,8 +39,6 @@ static int builtin_diff_files(struct rev
 			revs->max_count = 3;
 		else if (!strcmp(arg, "-q"))
 			silent = 1;
-		else if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_fmt |= OUTPUT_FMT_RAW;
 		else
 			usage(builtin_diff_usage);
 		argv++; argc--;
@@ -107,14 +105,9 @@ static int builtin_diff_b_f(struct rev_i
 	/* Blob vs file in the working tree*/
 	struct stat st;
 
-	while (1 < argc) {
-		const char *arg = argv[1];
-		if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_fmt |= OUTPUT_FMT_RAW;
-		else
-			usage(builtin_diff_usage);
-		argv++; argc--;
-	}
+	if (argc > 1)
+		usage(builtin_diff_usage);
+
 	if (lstat(path, &st))
 		die("'%s': %s", path, strerror(errno));
 	if (!(S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)))
@@ -137,14 +130,9 @@ static int builtin_diff_blobs(struct rev
 	 */
 	unsigned mode = canon_mode(S_IFREG | 0644);
 
-	while (1 < argc) {
-		const char *arg = argv[1];
-		if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_fmt |= OUTPUT_FMT_RAW;
-		else
-			usage(builtin_diff_usage);
-		argv++; argc--;
-	}
+	if (argc > 1)
+		usage(builtin_diff_usage);
+
 	stuff_change(&revs->diffopt,
 		     mode, mode,
 		     blob[1].sha1, blob[0].sha1,
@@ -162,8 +150,6 @@ static int builtin_diff_index(struct rev
 		const char *arg = argv[1];
 		if (!strcmp(arg, "--cached"))
 			cached = 1;
-		else if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_fmt |= OUTPUT_FMT_RAW;
 		else
 			usage(builtin_diff_usage);
 		argv++; argc--;
@@ -185,14 +171,9 @@ static int builtin_diff_tree(struct rev_
 {
 	const unsigned char *(sha1[2]);
 	int swap = 0;
-	while (1 < argc) {
-		const char *arg = argv[1];
-		if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_fmt |= OUTPUT_FMT_RAW;
-		else
-			usage(builtin_diff_usage);
-		argv++; argc--;
-	}
+
+	if (argc > 1)
+		usage(builtin_diff_usage);
 
 	/* We saw two trees, ent[0] and ent[1].
 	 * if ent[1] is unintesting, they are swapped
@@ -214,14 +195,9 @@ static int builtin_diff_combined(struct 
 	const unsigned char (*parent)[20];
 	int i;
 
-	while (1 < argc) {
-		const char *arg = argv[1];
-		if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_fmt |= OUTPUT_FMT_RAW;
-		else
-			usage(builtin_diff_usage);
-		argv++; argc--;
-	}
+	if (argc > 1)
+		usage(builtin_diff_usage);
+
 	if (!revs->dense_combined_merges && !revs->combine_merges)
 		revs->dense_combined_merges = revs->combine_merges = 1;
 	parent = xmalloc(ents * sizeof(*parent));
diff --git a/diff.c b/diff.c
index 45c93c9..ab8aed7 100644
--- a/diff.c
+++ b/diff.c
@@ -1464,6 +1464,8 @@ int diff_opt_parse(struct diff_options *
 		options->output_fmt |= OUTPUT_FMT_PATCH;
 	else if (opt_arg(arg, 'U', "unified", &options->context))
 		options->output_fmt |= OUTPUT_FMT_PATCH;
+	else if (!strcmp(arg, "--raw"))
+		options->output_fmt |= OUTPUT_FMT_RAW;
 	else if (!strcmp(arg, "--patch-with-raw")) {
 		options->output_fmt |= OUTPUT_FMT_PATCH | OUTPUT_FMT_RAW;
 	}
-- 
1.4.1.rc1.gf603-dirty
