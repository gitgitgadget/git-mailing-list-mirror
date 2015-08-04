From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 2/3] am: let command-line options override saved options
Date: Tue,  4 Aug 2015 22:08:50 +0800
Message-ID: <1438697331-29948-3-git-send-email-pyokagan@gmail.com>
References: <20150728164311.GA1948@yoshi.chippynet.com>
 <1438697331-29948-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 16:09:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcu1-0001O0-1R
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 16:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934360AbbHDOJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 10:09:08 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:32820 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934275AbbHDOJF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 10:09:05 -0400
Received: by pdbnt7 with SMTP id nt7so4973766pdb.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s4C/EfWooClK8JOls0aGHzljMzOMniaI92y3vHyjLIE=;
        b=yYKaVHnMAUxGCR+roIJWeVCRdZhVKkkzMi3dn3KlcoGBrEy7CCv2MhNA0DLJ6JHf1+
         N8kK/KY0eJ9eUrd/DqH4J1j0CwPbzDEsKrGNmu+wDOEHI4FoqbS2KYO5ArSycg8opoQn
         pohMcEKuOLe6FPcDZiePFtGlSxGi/p+h3Ad57F6+pR4ozAwUWFlR0qYcK51NPZte0rG7
         zVGYXvEWgxzGkoPLWRHjerkxLvI0rvp7upXy8HdJdplSVG31PRSAiLVemPHhCY2Cbodc
         +IeCpKezG2EYmyF6GXUvogHNCz1n68FF12EyhLhA0n31IKOgd78xHbM8a6/p1dUsUHUT
         GqJA==
X-Received: by 10.70.64.162 with SMTP id p2mr8394138pds.54.1438697345127;
        Tue, 04 Aug 2015 07:09:05 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id qc9sm561141pab.18.2015.08.04.07.09.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 07:09:04 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438697331-29948-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275324>

When resuming, git-am mistakenly ignores command-line options.

For instance, when a patch fails to apply with "git am patch",
subsequently running "git am --3way" would not cause git-am to fall
back on attempting a threeway merge.  This occurs because by default
the --3way option is saved as "false", and the saved am options are
loaded after the command-line options are parsed, thus overwriting
the command-line options when resuming.

Fix this by moving the am_load() function call before parse_options(),
so that command-line options will override the saved am options.

The purpose of supporting this use case is to enable users to "wiggle"
that one conflicting patch. As such, it is expected that the
command-line options do not affect subsequent applied patches. Implement
this by calling am_load() once we apply the conflicting patch
successfully.

Noticed-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c                       | 16 ++++++--
 t/t4153-am-resume-override-opts.sh | 82 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 4 deletions(-)
 create mode 100755 t/t4153-am-resume-override-opts.sh

diff --git a/builtin/am.c b/builtin/am.c
index 84d57d4..0961304 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1777,7 +1777,6 @@ static void am_run(struct am_state *state, int resume)
 
 		if (resume) {
 			validate_resume_state(state);
-			resume = 0;
 		} else {
 			int skip;
 
@@ -1839,6 +1838,10 @@ static void am_run(struct am_state *state, int resume)
 
 next:
 		am_next(state);
+
+		if (resume)
+			am_load(state);
+		resume = 0;
 	}
 
 	if (!is_empty_file(am_path(state, "rewritten"))) {
@@ -1893,6 +1896,7 @@ static void am_resolve(struct am_state *state)
 
 next:
 	am_next(state);
+	am_load(state);
 	am_run(state, 0);
 }
 
@@ -2020,6 +2024,7 @@ static void am_skip(struct am_state *state)
 		die(_("failed to clean index"));
 
 	am_next(state);
+	am_load(state);
 	am_run(state, 0);
 }
 
@@ -2130,6 +2135,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	int keep_cr = -1;
 	int patch_format = PATCH_FORMAT_UNKNOWN;
 	enum resume_mode resume = RESUME_FALSE;
+	int in_progress;
 
 	const char * const usage[] = {
 		N_("git am [options] [(<mbox>|<Maildir>)...]"),
@@ -2225,6 +2231,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	am_state_init(&state, git_path("rebase-apply"));
 
+	in_progress = am_in_progress(&state);
+	if (in_progress)
+		am_load(&state);
+
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (binary >= 0)
@@ -2237,7 +2247,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	if (read_index_preload(&the_index, NULL) < 0)
 		die(_("failed to read the index"));
 
-	if (am_in_progress(&state)) {
+	if (in_progress) {
 		/*
 		 * Catch user error to feed us patches when there is a session
 		 * in progress:
@@ -2255,8 +2265,6 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 		if (resume == RESUME_FALSE)
 			resume = RESUME_APPLY;
-
-		am_load(&state);
 	} else {
 		struct argv_array paths = ARGV_ARRAY_INIT;
 		int i;
diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-override-opts.sh
new file mode 100755
index 0000000..39fac79
--- /dev/null
+++ b/t/t4153-am-resume-override-opts.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+test_description='git-am command-line options override saved options'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
+
+format_patch () {
+	git format-patch --stdout -1 "$1" >"$1".eml
+}
+
+test_expect_success 'setup' '
+	test_commit initial file &&
+	test_commit first file &&
+
+	git checkout initial &&
+	git mv file file2 &&
+	test_tick &&
+	git commit -m renamed-file &&
+	git tag renamed-file &&
+
+	git checkout -b side initial &&
+	test_commit side1 file &&
+	test_commit side2 file &&
+
+	format_patch side1 &&
+	format_patch side2
+'
+
+test_expect_success TTY '--3way overrides --no-3way' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout renamed-file &&
+
+	# Applying side1 will fail as the file has been renamed.
+	test_must_fail git am --no-3way side[12].eml &&
+	test_path_is_dir .git/rebase-apply &&
+	test_cmp_rev renamed-file HEAD &&
+	test -z "$(git ls-files -u)" &&
+
+	# Applying side1 with am --3way will succeed due to the threeway-merge.
+	# Applying side2 will fail as --3way does not apply to it.
+	test_must_fail test_terminal git am --3way </dev/zero &&
+	test_path_is_dir .git/rebase-apply &&
+	test side1 = "$(cat file2)"
+'
+
+test_expect_success '--no-quiet overrides --quiet' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+
+	# Applying side1 will be quiet.
+	test_must_fail git am --quiet side[123].eml >out &&
+	test_path_is_dir .git/rebase-apply &&
+	! test_i18ngrep "^Applying: " out &&
+	echo side1 >file &&
+	git add file &&
+
+	# Applying side1 will not be quiet.
+	# Applying side2 will be quiet.
+	git am --no-quiet --continue >out &&
+	echo "Applying: side1" >expected &&
+	test_i18ncmp expected out
+'
+
+test_expect_success TTY '--reject overrides --no-reject' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	rm -f file.rej &&
+
+	test_must_fail git am --no-reject side1.eml &&
+	test_path_is_dir .git/rebase-apply &&
+	test_path_is_missing file.rej &&
+
+	test_must_fail test_terminal git am --reject </dev/zero &&
+	test_path_is_dir .git/rebase-apply &&
+	test_path_is_file file.rej
+'
+
+test_done
-- 
2.5.0.280.gd88bd6e
