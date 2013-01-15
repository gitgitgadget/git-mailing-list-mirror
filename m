From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 05/19] reset.c: extract function for parsing arguments
Date: Mon, 14 Jan 2013 21:47:37 -0800
Message-ID: <1358228871-7142-6-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 06:49:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzOg-0007Y3-44
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938Ab3AOFsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:48:52 -0500
Received: from mail-gg0-f202.google.com ([209.85.161.202]:50116 "EHLO
	mail-gg0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755557Ab3AOFs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 00:48:27 -0500
Received: by mail-gg0-f202.google.com with SMTP id k1so588144ggn.3
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=M4xPEN6U0pADHvyYXuL3667Vn5ovM7EEnPa42tkpuws=;
        b=WolLqEBhkdPnJnD32wdERaCyfll488uKA+YiNMbBd9PzZK6w9v71NeQDv68S7G16d4
         ODCHWqkMAImUJMepLnYaYbRQDH3Za5S9IziJf0KC+E/MNdP6/MoB0kLjde7QTYL8/cM6
         wxg3lnRb9FgL2sGh/l1wanx1BYuKzP3ngaCwj7ryBCBUP8BaqoN32mzEyxLrqS1ijS9X
         az75jm+FZmvrDYT3bxfxpJv4ufwd42tEwX2lahirlSekQxhQr7jTjXErpLuNcc4BuSsU
         0T5/LFTZBfcVSAowf8LEo2Ycz8uEAmuy+KtHCg9GHtoHV7jeUVRW8gzRsNo87LUuwFe7
         AiLA==
X-Received: by 10.236.116.10 with SMTP id f10mr48571259yhh.9.1358228906760;
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id i63si817944yhk.5.2013.01.14.21.48.26
        (version=TLSv1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 8180C82004A;
	Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 252EE101887; Mon, 14 Jan 2013 21:48:25 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQn3IJp+1uULilSuxj8aL+KGq0GZ2Uf4adpJYphS/PtYt+m1SRVrSqKYhUkyJOX9sl9/fYvTpXmAwu5IViNRltrld00g5wYqY4VzAFhvdTEP//43FpBk1F5s/iSgW0M0FgTgIeEBkjieiKT1ghASRKy2z2VUbK8dHSnoYBS2yB9CqKYk09a8P1FTkChm6QZ38EX0RzEO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213584>

Declutter cmd_reset() a bit by moving out the argument parsing to its
own function.

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 builtin/reset.c | 70 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 32 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 664fad9..58f0f61 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -198,36 +198,11 @@ static void die_if_unmerged_cache(int reset_type)
 
 }
 
-int cmd_reset(int argc, const char **argv, const char *prefix)
+static const char **parse_args(int argc, const char **argv, const char *prefix, const char **rev_ret)
 {
-	int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0;
-	int patch_mode = 0;
+	int i = 0;
 	const char *rev = "HEAD";
-	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
-				*old_orig = NULL, sha1_old_orig[20];
-	const char **pathspec = NULL;
-	struct commit *commit;
-	struct strbuf msg = STRBUF_INIT;
-	const struct option options[] = {
-		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
-		OPT_SET_INT(0, "mixed", &reset_type,
-						N_("reset HEAD and index"), MIXED),
-		OPT_SET_INT(0, "soft", &reset_type, N_("reset only HEAD"), SOFT),
-		OPT_SET_INT(0, "hard", &reset_type,
-				N_("reset HEAD, index and working tree"), HARD),
-		OPT_SET_INT(0, "merge", &reset_type,
-				N_("reset HEAD, index and working tree"), MERGE),
-		OPT_SET_INT(0, "keep", &reset_type,
-				N_("reset HEAD but keep local changes"), KEEP),
-		OPT_BOOLEAN('p', "patch", &patch_mode, N_("select hunks interactively")),
-		OPT_END()
-	};
-
-	git_config(git_default_config, NULL);
-
-	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
-						PARSE_OPT_KEEP_DASHDASH);
-
+	unsigned char unused[20];
 	/*
 	 * Possible arguments are:
 	 *
@@ -250,7 +225,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		 * Otherwise, argv[i] could be either <rev> or <paths> and
 		 * has to be unambiguous.
 		 */
-		else if (!get_sha1_committish(argv[i], sha1)) {
+		else if (!get_sha1_committish(argv[i], unused)) {
 			/*
 			 * Ok, argv[i] looks like a rev; it should not
 			 * be a filename.
@@ -262,6 +237,40 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			verify_filename(prefix, argv[i], 1);
 		}
 	}
+	*rev_ret = rev;
+	return i < argc ? get_pathspec(prefix, argv + i) : NULL;
+}
+
+int cmd_reset(int argc, const char **argv, const char *prefix)
+{
+	int reset_type = NONE, update_ref_status = 0, quiet = 0;
+	int patch_mode = 0;
+	const char *rev;
+	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
+				*old_orig = NULL, sha1_old_orig[20];
+	const char **pathspec = NULL;
+	struct commit *commit;
+	struct strbuf msg = STRBUF_INIT;
+	const struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_SET_INT(0, "mixed", &reset_type,
+						N_("reset HEAD and index"), MIXED),
+		OPT_SET_INT(0, "soft", &reset_type, N_("reset only HEAD"), SOFT),
+		OPT_SET_INT(0, "hard", &reset_type,
+				N_("reset HEAD, index and working tree"), HARD),
+		OPT_SET_INT(0, "merge", &reset_type,
+				N_("reset HEAD, index and working tree"), MERGE),
+		OPT_SET_INT(0, "keep", &reset_type,
+				N_("reset HEAD but keep local changes"), KEEP),
+		OPT_BOOLEAN('p', "patch", &patch_mode, N_("select hunks interactively")),
+		OPT_END()
+	};
+
+	git_config(git_default_config, NULL);
+
+	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
+						PARSE_OPT_KEEP_DASHDASH);
+	pathspec = parse_args(argc, argv, prefix, &rev);
 
 	if (get_sha1_committish(rev, sha1))
 		die(_("Failed to resolve '%s' as a valid ref."), rev);
@@ -277,9 +286,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		die(_("Could not parse object '%s'."), rev);
 	hashcpy(sha1, commit->object.sha1);
 
-	if (i < argc)
-		pathspec = get_pathspec(prefix, argv + i);
-
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
-- 
1.8.1.1.454.gce43f05
