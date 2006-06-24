From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH 3/7] Make --raw option available for all diff commands
Date: Sat, 24 Jun 2006 20:23:06 +0300
Message-ID: <20060624202306.f540ac83.tihirvon@gmail.com>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 19:30:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuBxn-0001XZ-5n
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 19:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWFXRaW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 13:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWFXRaW
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 13:30:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:17675 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750955AbWFXRaU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 13:30:20 -0400
Received: by nf-out-0910.google.com with SMTP id m19so402614nfc
        for <git@vger.kernel.org>; Sat, 24 Jun 2006 10:30:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=EmmtrkfEjPy/a0Jf+XXA23veqbEcSlhrZdrK9web8xqI6OjRfKQW+3CQ1fbn9EA2Sg6o8nR/XxqAe5yIuSqPH3FGfOYRwHQHm1+J6o6tCeuUNIHw3INygFocDzqLAXpbNxc58qQO3ESA21h15nZNrduMQ+WiGcnltwWaTbof6XM=
Received: by 10.49.55.18 with SMTP id h18mr3537591nfk;
        Sat, 24 Jun 2006 10:30:19 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id p72sm2585799nfc.2006.06.24.10.30.18;
        Sat, 24 Jun 2006 10:30:19 -0700 (PDT)
To: junkio@cox.net
In-Reply-To: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22526>


Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 builtin-diff.c |   48 ++++++++++++------------------------------------
 diff.c         |    2 ++
 2 files changed, 14 insertions(+), 36 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 3b44296..91235a1 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -39,8 +39,6 @@ static int builtin_diff_files(struct rev
 			revs->max_count = 3;
 		else if (!strcmp(arg, "-q"))
 			silent = 1;
-		else if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_format = DIFF_FORMAT_RAW;
 		else
 			usage(builtin_diff_usage);
 		argv++; argc--;
@@ -107,14 +105,9 @@ static int builtin_diff_b_f(struct rev_i
 	/* Blob vs file in the working tree*/
 	struct stat st;
 
-	while (1 < argc) {
-		const char *arg = argv[1];
-		if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_format = DIFF_FORMAT_RAW;
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
-			revs->diffopt.output_format = DIFF_FORMAT_RAW;
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
-			revs->diffopt.output_format = DIFF_FORMAT_RAW;
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
-			revs->diffopt.output_format = DIFF_FORMAT_RAW;
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
-			revs->diffopt.output_format = DIFF_FORMAT_RAW;
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
index bfed79c..6e5ae77 100644
--- a/diff.c
+++ b/diff.c
@@ -1467,6 +1467,8 @@ int diff_opt_parse(struct diff_options *
 		options->output_format |= DIFF_FORMAT_PATCH;
 	else if (opt_arg(arg, 'U', "unified", &options->context))
 		options->output_format |= DIFF_FORMAT_PATCH;
+	else if (!strcmp(arg, "--raw"))
+		options->output_format |= DIFF_FORMAT_RAW;
 	else if (!strcmp(arg, "--patch-with-raw")) {
 		options->output_format |= DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW;
 	}
-- 
1.4.1.rc1.g8637
