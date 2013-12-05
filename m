From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v4] commit -v: strip diffs and submodule shortlogs from the
 commit message
Date: Thu, 05 Dec 2013 20:44:14 +0100
Message-ID: <52A0D78E.4030509@web.de>
References: <528D385F.2070906@web.de>	<xmqqpppu65fs.fsf@gitster.dls.corp.google.com>	<528E7A6E.8080603@web.de> <xmqqsiup2y3u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Ari Pollak <ari@debian.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 20:44:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoeqU-0000Rl-00
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 20:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221Ab3LEToR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 14:44:17 -0500
Received: from mout.web.de ([212.227.17.11]:61940 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab3LEToQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 14:44:16 -0500
Received: from [192.168.178.41] ([84.132.154.249]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MDP6H-1VnqyJ3qZB-00Gqbt for <git@vger.kernel.org>;
 Thu, 05 Dec 2013 20:44:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <xmqqsiup2y3u.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:Hoigl3heN/iNPClQmgqb0khG53nFpLFjPsMzrjDkoitzkxTy4B0
 1a6GW4hLItmmJv66WaVvO6Y0lzdzUNvpCD4awmB5lqrfZoFWeuNUL02IWIrjEza9IOVwGv5
 oSyz/zYRxQCe6hGWBOqOK3V6KkllcBDWpHfoFXkVWAP3xCwoPIcipScG8NUM1L5H/aq7gPI
 6x7TquxUxckktXcbgrgtg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238901>

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

Changes to v3:

- separating comment_line_char from the cut_line

- using strbuf_add_commented_lines() for the comment

All issues raised should be addressed with this version.


 builtin/commit.c          |  9 +++------
 t/t7507-commit-verbose.sh | 28 +++++++++++++++++++++++++++-
 wt-status.c               | 29 +++++++++++++++++++++++++++--
 wt-status.h               |  1 +
 4 files changed, 58 insertions(+), 9 deletions(-)

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
index b4e44ba..99c3d1c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -16,6 +16,9 @@
 #include "column.h"
 #include "strbuf.h"

+static char cut_line[] =
+"------------------------ >8 ------------------------\n";
+
 static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
 	GIT_COLOR_GREEN,  /* WT_STATUS_UPDATED */
@@ -767,6 +770,18 @@ conclude:
 	status_printf_ln(s, GIT_COLOR_NORMAL, "");
 }

+void wt_status_truncate_message_at_cut_line(struct strbuf *buf)
+{
+	const char *p;
+	struct strbuf pattern = STRBUF_INIT;
+
+	strbuf_addf(&pattern, "%c %s", comment_line_char, cut_line);
+	p = strstr(buf->buf, pattern.buf);
+	if (p && (p == buf->buf || p[-1] == '\n'))
+		strbuf_setlen(buf, p - buf->buf);
+	strbuf_release(&pattern);
+}
+
 static void wt_status_print_verbose(struct wt_status *s)
 {
 	struct rev_info rev;
@@ -787,10 +802,20 @@ static void wt_status_print_verbose(struct wt_status *s)
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
+		const char *explanation = _("Do not touch the line above.\nEverything below will be removed.");
+		struct strbuf buf = STRBUF_INIT;
+
 		rev.diffopt.use_color = 0;
+		fprintf(s->fp, "%c %s", comment_line_char, cut_line);
+		strbuf_add_commented_lines(&buf, explanation, strlen(explanation));
+		fprintf(s->fp, buf.buf);
+		strbuf_release(&buf);
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
1.8.5.4.g9a09ec7
