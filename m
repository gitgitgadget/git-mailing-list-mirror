From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 3/3] builtin/grep: allow implicit --no-index
Date: Sun, 10 Jan 2016 15:19:57 +0100
Message-ID: <1452435597-12099-4-git-send-email-t.gummerer@gmail.com>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
Cc: Thomas Gummerer <t.gummerer@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 10 15:20:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIGqp-0004dY-GN
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jan 2016 15:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757641AbcAJOTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2016 09:19:52 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34287 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757418AbcAJOTv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2016 09:19:51 -0500
Received: by mail-wm0-f68.google.com with SMTP id b14so22678398wmb.1
        for <git@vger.kernel.org>; Sun, 10 Jan 2016 06:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GaCQEwTyDHXvZp1qAro+GUiupKQu/FRQ+R1r8cbXK3k=;
        b=d9kSp3r8O10xjshiigx8ib/+N0TPhKz3sPc3uA9cybxJLI4RH3yLMpCCo5FoqcQmTv
         3THXyyRoH7wg2Rdn8HSuOkn2i6z3RLXKFOO8su4ie0sWi26kezNwqePrarDGCPcH4gX9
         0fPvxiRpA8ycaMZRE/aivR9/eObnJoR8oO4PgOZ8IL3f5eSnwc044pxdHXX5osAjdXgF
         CkRt8ajHXLMgCKeLHCgRt5guxMu3CHsy79W2ckdddqeyp9UnkHJpqyA49quNdgBUxCWI
         4O5etDijLbX8PtW4zb5YYtFE07ZgYqtt8/kRC8GhKMu/iQyJ/Fo2BHUCIutdGQ+LLfvu
         B4Mw==
X-Received: by 10.194.236.6 with SMTP id uq6mr129181508wjc.126.1452435589896;
        Sun, 10 Jan 2016 06:19:49 -0800 (PST)
Received: from localhost (host251-54-dynamic.20-79-r.retail.telecomitalia.it. [79.20.54.251])
        by smtp.gmail.com with ESMTPSA id e77sm8413471wma.18.2016.01.10.06.19.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2016 06:19:48 -0800 (PST)
X-Mailer: git-send-email 2.6.3.387.g749a69c.dirty
In-Reply-To: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283620>

Currently when git grep is used outside of a git repository without the
--no-index option git simply dies.  For convenience, implicitly make git
grep behave like git grep --no-index when it is called outside of a git
repository.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/grep.c  | 32 ++++++++++++++++++++++++--------
 t/t7810-grep.sh | 41 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 3a27bd5..a886af1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -19,6 +19,9 @@
 #include "dir.h"
 #include "pathspec.h"
 
+#define GREP_NO_INDEX_EXPLICIT 1
+#define GREP_NO_INDEX_IMPLICIT 2
+
 static char const * const grep_usage[] = {
 	N_("git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]"),
 	NULL
@@ -632,7 +635,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "cached", &cached,
 			N_("search in index instead of in the work tree")),
 		OPT_BIT(0, "no-index", &no_index,
-			N_("find in contents not managed by git"), 1),
+			N_("find in contents not managed by git"),
+			GREP_NO_INDEX_EXPLICIT),
 		OPT_BOOL(0, "untracked", &untracked,
 			N_("search in both tracked and untracked files")),
 		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
@@ -755,9 +759,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	grep_commit_pattern_type(pattern_type_arg, &opt);
 
-	if (!no_index && !startup_info->have_repository)
-		/* die the same way as if we did it at the beginning */
-		setup_git_directory();
+	if (!no_index && !startup_info->have_repository) {
+		int nongit = 0;
+
+		setup_git_directory_gently(&nongit);
+		if (nongit)
+			no_index = GREP_NO_INDEX_IMPLICIT;
+	}
 
 	/*
 	 * skip a -- separator; we know it cannot be
@@ -873,13 +881,21 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (!show_in_pager && !opt.status_only)
 		setup_pager();
 
-	if (no_index && (untracked || cached))
-		die(_("--cached or --untracked cannot be used with --no-index."));
+	if (untracked || cached) {
+		if (no_index == GREP_NO_INDEX_EXPLICIT)
+			die(_("--cached or --untracked cannot be used with --no-index."));
+		else if (no_index == GREP_NO_INDEX_IMPLICIT)
+			die(_("--cached or --untracked cannot be used outside a git repository."));
+	}
 
 	if (no_index || untracked) {
 		int use_exclude = (opt_exclude < 0) ? !no_index : !!opt_exclude;
-		if (list.nr)
-			die(_("--no-index or --untracked cannot be used with revs."));
+		if (list.nr) {
+			if (no_index == GREP_NO_INDEX_IMPLICIT)
+				die(_("cannot use revs outside of a git repository."));
+			else
+				die(_("--no-index or --untracked cannot be used with revs."));
+		}
 		hit = grep_directory(&opt, &pathspec, use_exclude);
 	} else if (0 <= opt_exclude) {
 		die(_("--[no-]exclude-standard cannot be used for tracked contents."));
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index ab94716..4ba955d 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -794,11 +794,9 @@ test_expect_success 'outside of git repository' '
 		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
-		test_must_fail git grep o &&
 		git grep --no-index o >../actual.full &&
 		test_cmp ../expect.full ../actual.full
 		cd sub &&
-		test_must_fail git grep o &&
 		git grep --no-index o >../../actual.sub &&
 		test_cmp ../../expect.sub ../../actual.sub
 	) &&
@@ -808,7 +806,6 @@ test_expect_success 'outside of git repository' '
 		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
-		test_must_fail git grep o &&
 		git grep --no-index --exclude-standard o >../actual.full &&
 		test_cmp ../expect.full ../actual.full &&
 
@@ -821,6 +818,44 @@ test_expect_success 'outside of git repository' '
 	)
 '
 
+test_expect_success 'outside of git repository without --no-index' '
+	rm -fr non &&
+	mkdir -p non/git/sub &&
+	echo hello >non/git/file1 &&
+	echo world >non/git/sub/file2 &&
+	{
+		echo file1:hello &&
+		echo sub/file2:world
+	} >non/expect.full &&
+	echo file2:world >non/expect.sub &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		git grep o >../actual.full &&
+		test_cmp ../expect.full ../actual.full
+		cd sub &&
+		git grep o >../../actual.sub &&
+		test_cmp ../../expect.sub ../../actual.sub
+	) &&
+
+	echo ".*o*" >non/git/.gitignore &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		git grep --exclude-standard o >../actual.full &&
+		test_cmp ../expect.full ../actual.full &&
+
+		{
+			echo ".gitignore:.*o*"
+			cat ../expect.full
+		} >../expect.with.ignored &&
+		git grep --no-exclude o >../actual.full &&
+		test_cmp ../expect.with.ignored ../actual.full
+	)
+'
+
 test_expect_success 'inside git repository but with --no-index' '
 	rm -fr is &&
 	mkdir -p is/git/sub &&
-- 
2.6.3.387.g749a69c.dirty
