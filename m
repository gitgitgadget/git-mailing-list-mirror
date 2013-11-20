From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3] commit -v: strip diffs and submodule shortlogs from the
 commit message
Date: Wed, 20 Nov 2013 23:31:59 +0100
Message-ID: <528D385F.2070906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Ari Pollak <ari@debian.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 20 23:32:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjGJc-0006tV-2v
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 23:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154Ab3KTWcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 17:32:04 -0500
Received: from mout.web.de ([212.227.15.4]:51065 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409Ab3KTWcC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 17:32:02 -0500
Received: from [192.168.178.41] ([91.3.183.35]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0MC1ho-1Vs1js0w52-008tJH for <git@vger.kernel.org>; Wed,
 20 Nov 2013 23:32:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:4b/N6YtYj6QavLoNcl7CEk+M7KnZMp0+MB/XHLYgwjXmeHDsiTu
 ffmTFGBNGc9U6hYmS+LDKvzpUiOdePF1pJe8lHqmgDSqsvMwl/m9yNBHdVQE1WUzFDGdxwS
 4cHYGfscinAfUlnDAHL1k307QmSr7v5cbXKE+IUyUrxr5VIkUaEtfujSTh8LH7T0WpRUtcd
 hTBuWu2Nkg+D6zAZIplBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238102>

When using the '-v' option of "git commit" the diff added to the commit
message temporarily for editing is stripped off after the user exited the
editor by searching for "\ndiff --git " and truncating the commmit message
there if it is found.

But this approach has two problems:

- when the commit message itself contains a line starting with
  "diff --git" it will be truncated there prematurely; and

- when the "diff.submodule" setting is set to "log", the diff may
  start with "Submodule <hash1>..<hash2>", which will be left in
  the commit message while it shouldn't.

Fix that by introducing a special scissor separator line starting with the
comment character ('#' or the core.commentChar config if set) followed by
two lines describing what it is for. The scissor line - which will not be
translated - is used to reliably detect the start of the diff so it can be
chopped off from the commit message, no matter what the user enters there.

Turn a known test failure fixed by this change into a successful test;
also add one for a diff starting with a submodule log and another one for
proper handling of the comment char.

Reported-by: Ari Pollak <ari@debian.org>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Changes since v2:

- Honor the core.commentChar setting and add a test for that.

- Fix the submodule test to set the editor in a portable way.

- Only print scissor and description lines when not going to stdout
  (otherwise a "git status -v" prints that on stdout too, which
  doesn't make much sense). Now we definitely do not have to care
  about coloring these lines either.

- Nicer formatting of the commit message.


 builtin/commit.c          |  9 +++------
 t/t7507-commit-verbose.sh | 28 +++++++++++++++++++++++++++-
 wt-status.c               | 23 +++++++++++++++++++++--
 wt-status.h               |  1 +
 4 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 6ab4605..fedb45a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1505,7 +1505,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf author_ident = STRBUF_INIT;
 	const char *index_file, *reflog_msg;
-	char *nl, *p;
+	char *nl;
 	unsigned char sha1[20];
 	struct ref_lock *ref_lock;
 	struct commit_list *parents = NULL, **pptr = &parents;
@@ -1601,11 +1601,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}

 	/* Truncate the message just before the diff, if any. */
-	if (verbose) {
-		p = strstr(sb.buf, "\ndiff --git ");
-		if (p != NULL)
-			strbuf_setlen(&sb, p - sb.buf + 1);
-	}
+	if (verbose)
+		wt_status_truncate_message_at_cut_line(&sb);

 	if (cleanup_mode != CLEANUP_NONE)
 		stripspace(&sb, cleanup_mode == CLEANUP_ALL);
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index da5bd3b..2ddf28c 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -65,9 +65,35 @@ test_expect_success 'diff in message is retained without -v' '
 	check_message diff
 '

-test_expect_failure 'diff in message is retained with -v' '
+test_expect_success 'diff in message is retained with -v' '
 	git commit --amend -F diff -v &&
 	check_message diff
 '

+test_expect_success 'submodule log is stripped out too with -v' '
+	git config diff.submodule log &&
+	git submodule add ./. sub &&
+	git commit -m "sub added" &&
+	(
+		cd sub &&
+		echo "more" >>file &&
+		git commit -a -m "submodule commit"
+	) &&
+	(
+		GIT_EDITOR=cat &&
+		export GIT_EDITOR &&
+		test_must_fail git commit -a -v 2>err
+	) &&
+	test_i18ngrep "Aborting commit due to empty commit message." err
+'
+
+test_expect_success 'verbose diff is stripped out with set core.commentChar' '
+	(
+		GIT_EDITOR=cat &&
+		export GIT_EDITOR &&
+		test_must_fail git -c core.commentchar=";" commit -a -v 2>err
+	) &&
+	test_i18ngrep "Aborting commit due to empty commit message." err
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index b4e44ba..734f94b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -16,6 +16,9 @@
 #include "column.h"
 #include "strbuf.h"

+static char wt_status_cut_line[] = /* 'X' is replaced with comment_line_char */
+"X ------------------------ >8 ------------------------\n";
+
 static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
 	GIT_COLOR_GREEN,  /* WT_STATUS_UPDATED */
@@ -767,6 +770,15 @@ conclude:
 	status_printf_ln(s, GIT_COLOR_NORMAL, "");
 }

+void wt_status_truncate_message_at_cut_line(struct strbuf *buf)
+{
+	const char *p;
+
+	p = strstr(buf->buf, wt_status_cut_line);
+	if (p && (p == buf->buf || p[-1] == '\n'))
+		strbuf_setlen(buf, p - buf->buf);
+}
+
 static void wt_status_print_verbose(struct wt_status *s)
 {
 	struct rev_info rev;
@@ -787,10 +799,17 @@ static void wt_status_print_verbose(struct wt_status *s)
 	 * If we're not going to stdout, then we definitely don't
 	 * want color, since we are going to the commit message
 	 * file (and even the "auto" setting won't work, since it
-	 * will have checked isatty on stdout).
+	 * will have checked isatty on stdout). But we then do want
+	 * to insert the scissor line here to reliably remove the
+	 * diff before committing.
 	 */
-	if (s->fp != stdout)
+	if (s->fp != stdout) {
 		rev.diffopt.use_color = 0;
+		wt_status_cut_line[0] = comment_line_char;
+		fprintf(s->fp, wt_status_cut_line);
+		fprintf(s->fp, _("%c Do not touch the line above.\n"), comment_line_char);
+		fprintf(s->fp, _("%c Everything below will be removed.\n"), comment_line_char);
+	}
 	run_diff_index(&rev, 1);
 }

diff --git a/wt-status.h b/wt-status.h
index 6c29e6f..30a4812 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -91,6 +91,7 @@ struct wt_status_state {
 	unsigned char cherry_pick_head_sha1[20];
 };

+void wt_status_truncate_message_at_cut_line(struct strbuf *);
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
-- 
1.8.5.rc2.7.g9470f78.dirty
