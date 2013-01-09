From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 05/19] reset.c: extract function for parsing arguments
Date: Wed,  9 Jan 2013 00:16:02 -0800
Message-ID: <1357719376-16406-6-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:17:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsqr9-0002P4-5K
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757361Ab3AIIR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:17:26 -0500
Received: from mail-vb0-f74.google.com ([209.85.212.74]:64382 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757322Ab3AIIRG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:17:06 -0500
Received: by mail-vb0-f74.google.com with SMTP id s24so190932vbi.3
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=9t3cz6lxAU7R9C0opPLbTjNfsYVJYNhgvW3hoEPunlk=;
        b=H+fGW9Gu6yYwyHMSSF+4YMgTJVLy0waW0wuEuTf/oGUmvFQHXbo2yDb0kjYLvTarhP
         OwB7Qm5VndDxLWXc+xD2WWR4kbDgUuS/9iXBcRtP+AWUWFlJc4WVyIyZLfUVsrJPoi5y
         M/9i7vpXGviLFS+/TCIqx3mkMA0KH1jD7tlJVCk2wgrQ5IfoEFBDLUcKU/eANnYqNwFK
         By2LgUW2QKfnPepRWYo+KfWBPE9hfbRWJI9MNmMuJTyvSHy1NsynnjKEqOrYkdowIQ9h
         FDV1JWFRH361jjopVVpEuL5cmBCaVmGEbo1sLWIbREiMXbPo/NEsYU1yA+proX3o13nf
         5uxA==
X-Received: by 10.101.176.10 with SMTP id d10mr9616830anp.12.1357719424518;
        Wed, 09 Jan 2013 00:17:04 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id s58si5737966yhi.6.2013.01.09.00.17.04
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:04 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 47843820055;
	Wed,  9 Jan 2013 00:17:04 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id F34FA102E2E; Wed,  9 Jan 2013 00:17:03 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQm05Gj9gKRwxiOPeoN4OvJ+kVHh3SJjW+vF5rGJ2OKmbsNNOiZLZLP7fms6cuRKoN4n/0F+lNHIZTXnWlNrOuZHPOOFG6gA6UKU3qOLULiV5nwpmYJwQyXcCuXkhDR9f6vnscwCC26/LNVojrQ4sUKkyW/4eT/BXWcO3DtF5Cg4467gBiBbLDY7d6urpE+znthjtjl3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213036>

Declutter cmd_reset() a bit by moving out the argument parsing to its
own function.
---
 builtin/reset.c | 71 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 664fad9..9473725 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -198,36 +198,10 @@ static void die_if_unmerged_cache(int reset_type)
 
 }
 
-int cmd_reset(int argc, const char **argv, const char *prefix)
-{
-	int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0;
-	int patch_mode = 0;
+const char **parse_args(int argc, const char **argv, const char *prefix, const char **rev_ret) {
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
@@ -250,7 +224,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		 * Otherwise, argv[i] could be either <rev> or <paths> and
 		 * has to be unambiguous.
 		 */
-		else if (!get_sha1_committish(argv[i], sha1)) {
+		else if (!get_sha1_committish(argv[i], unused)) {
 			/*
 			 * Ok, argv[i] looks like a rev; it should not
 			 * be a filename.
@@ -262,6 +236,40 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
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
@@ -277,9 +285,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		die(_("Could not parse object '%s'."), rev);
 	hashcpy(sha1, commit->object.sha1);
 
-	if (i < argc)
-		pathspec = get_pathspec(prefix, argv + i);
-
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
-- 
1.8.1.rc3.331.g1ef2165
