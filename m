From: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Subject: [PATCH v5 1/2] reset: enable '-' short-hand for previous branch
Date: Fri, 13 Mar 2015 23:48:35 +0530
Message-ID: <1426270716-22405-1-git-send-email-sudshekhar02@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com, davvid@gmail.com,
	sunshine@sunshineco.com, Sudhanshu Shekhar <sudshekhar02@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 19:20:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWUBj-0003UE-Fb
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 19:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbbCMSTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 14:19:54 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34900 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbbCMSTl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 14:19:41 -0400
Received: by pdbfp1 with SMTP id fp1so30677479pdb.2
        for <git@vger.kernel.org>; Fri, 13 Mar 2015 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jgQBVsrxIPRCpRljR7eNZRmtqb1V8lTGV7lLEXlCUxY=;
        b=UjM1/HPByeABGvhtBVShZJv6xcq0TExn1PXo7jWG+Yb1eqZFfv4VX9+OvRA3qLOGYf
         KIz5PhbF5dP2YNj4T1kTToplgoDAiIKYwdMGfBbVXp4n+gioK9H0NAmkFcQCjirR1rEd
         1XF8Gp40bniHRrsYF2wtQeMH35wLMFmgRmMiFjtImKyRdAnqr+vM12T1IUZ7WXGpX2UL
         3yFITGEiUEP/Jackpux5gV8071h+ejPjkOfeEIdEg+kHpiwLNqHP8beh425QWA4SjPh5
         EjpSSVD1Hu2Jh3AD5e79VAWSKB6qxE7f+u+L4nV3/KVONq8JRu1ScwOsgToG34/II7Se
         CA2A==
X-Received: by 10.66.234.2 with SMTP id ua2mr83728185pac.137.1426270780528;
        Fri, 13 Mar 2015 11:19:40 -0700 (PDT)
Received: from shekhar-Inspiron-N5110.iiit.ac.in ([14.139.82.6])
        by mx.google.com with ESMTPSA id g10sm4611117pdm.29.2015.03.13.11.19.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Mar 2015 11:19:38 -0700 (PDT)
X-Mailer: git-send-email 2.3.1.279.ga2b2924
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265417>

git reset '-' will reset to the previous branch. To reset a file named
"-" use either "git reset ./-" or "git reset -- -".

Change error message to treat single "-" as an ambigous revision or
path rather than a bad flag.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
---
I have changed the logic to ensure argv[0] isn't changed at any point.
Creating a modified_argv0 variable let's me do that.

I couldn't think of any other way to achieve this, apart from changing things
directly in the sha1_name.c file (like Junio's changes). Please let me know
if some further changes are needed.

 builtin/reset.c | 17 +++++++++++++----
 setup.c         |  2 +-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 4c08ddc..bc50e14 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -192,6 +192,7 @@ static void parse_args(struct pathspec *pathspec,
 {
 	const char *rev = "HEAD";
 	unsigned char unused[20];
+	const char *modified_argv0 = argv[0];
 	/*
 	 * Possible arguments are:
 	 *
@@ -205,10 +206,17 @@ static void parse_args(struct pathspec *pathspec,
 	 */
 
 	if (argv[0]) {
+		if (!strcmp(argv[0], "-")) {
+			modified_argv0 = "@{-1}";
+		}
+		else {
+			modified_argv0 = argv[0];
+		}
+
 		if (!strcmp(argv[0], "--")) {
 			argv++; /* reset to HEAD, possibly with paths */
 		} else if (argv[1] && !strcmp(argv[1], "--")) {
-			rev = argv[0];
+			rev = modified_argv0;
 			argv += 2;
 		}
 		/*
@@ -216,14 +224,15 @@ static void parse_args(struct pathspec *pathspec,
 		 * has to be unambiguous. If there is a single argument, it
 		 * can not be a tree
 		 */
-		else if ((!argv[1] && !get_sha1_committish(argv[0], unused)) ||
-			 (argv[1] && !get_sha1_treeish(argv[0], unused))) {
+		else if ((!argv[1] && !get_sha1_committish(modified_argv0, unused)) ||
+			 (argv[1] && !get_sha1_treeish(modified_argv0, unused))) {
 			/*
 			 * Ok, argv[0] looks like a commit/tree; it should not
 			 * be a filename.
 			 */
 			verify_non_filename(prefix, argv[0]);
-			rev = *argv++;
+			rev = modified_argv0;
+			argv++;
 		} else {
 			/* Otherwise we treat this as a filename */
 			verify_filename(prefix, argv[0], 1);
diff --git a/setup.c b/setup.c
index 979b13f..b621b62 100644
--- a/setup.c
+++ b/setup.c
@@ -200,7 +200,7 @@ void verify_filename(const char *prefix,
 		     int diagnose_misspelt_rev)
 {
 	if (*arg == '-')
-		die("bad flag '%s' used after filename", arg);
+		die("ambiguous argument '%s': unknown revision or path", arg);
 	if (check_filename(prefix, arg))
 		return;
 	die_verify_filename(prefix, arg, diagnose_misspelt_rev);
-- 
2.3.1.277.gd67f9d5.dirty
