From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 21/21] Provide 'git notes get-ref' to easily retrieve current notes ref
Date: Sat,  9 Oct 2010 03:16:44 +0200
Message-ID: <1286587004-3765-22-git-send-email-johan@herland.net>
References: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 03:18:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4O4k-0004dN-QD
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 03:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760142Ab0JIBSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 21:18:00 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:50352 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759990Ab0JIBSA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 21:18:00 -0400
Received: from pd9587e9f.dip.t-dialin.net ([217.88.126.159] helo=localhost.localdomain)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P4O4U-00028k-ID; Sat, 09 Oct 2010 03:17:58 +0200
X-Mailer: git-send-email 1.7.3.1.104.g92b87a
In-Reply-To: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158571>

Script may use 'git notes get-ref' to easily retrieve the current notes ref.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |    5 +++++
 builtin/notes.c             |   23 +++++++++++++++++++++++
 t/t3301-notes.sh            |   19 +++++++++++++++++++
 3 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 466885a..58dc378 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -19,6 +19,7 @@ SYNOPSIS
 'git notes' merge --reset [-v | -q]
 'git notes' remove [<object>]
 'git notes' prune [-n | -v]
+'git notes' get-ref
 
 
 DESCRIPTION
@@ -109,6 +110,10 @@ remove::
 prune::
 	Remove all notes for non-existing/unreachable objects.
 
+get-ref::
+	Print the current notes ref. This provides an easy way to
+	retrieve the current notes ref (e.g. from scripts).
+
 OPTIONS
 -------
 -f::
diff --git a/builtin/notes.c b/builtin/notes.c
index abf26e5..5d8c8e8 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -31,6 +31,7 @@ static const char * const git_notes_usage[] = {
 	"git notes merge --reset [-v | -q]",
 	"git notes [--ref <notes_ref>] remove [<object>]",
 	"git notes [--ref <notes_ref>] prune [-n | -v]",
+	"git notes [--ref <notes_ref>] get-ref",
 	NULL
 };
 
@@ -82,6 +83,11 @@ static const char * const git_notes_prune_usage[] = {
 	NULL
 };
 
+static const char * const git_notes_get_ref_usage[] = {
+	"git notes get-ref",
+	NULL
+};
+
 static const char note_template[] =
 	"\n"
 	"#\n"
@@ -1002,6 +1008,21 @@ static int prune(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int get_ref(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = { OPT_END() };
+	argc = parse_options(argc, argv, prefix, options,
+			     git_notes_get_ref_usage, 0);
+
+	if (argc) {
+		error("too many parameters");
+		usage_with_options(git_notes_get_ref_usage, options);
+	}
+
+	puts(default_notes_ref());
+	return 0;
+}
+
 int cmd_notes(int argc, const char **argv, const char *prefix)
 {
 	int result;
@@ -1040,6 +1061,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		result = remove_cmd(argc, argv, prefix);
 	else if (!strcmp(argv[0], "prune"))
 		result = prune(argc, argv, prefix);
+	else if (!strcmp(argv[0], "get-ref"))
+		result = get_ref(argc, argv, prefix);
 	else {
 		result = error("Unknown subcommand: %s", argv[0]);
 		usage_with_options(git_notes_usage, options);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 4bf4e52..f5b72c7 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1058,4 +1058,23 @@ test_expect_success 'git notes copy diagnoses too many or too few parameters' '
 	test_must_fail git notes copy one two three
 '
 
+test_expect_success 'git notes get-ref (no overrides)' '
+	git config --unset core.notesRef &&
+	unset GIT_NOTES_REF &&
+	test "$(git notes get-ref)" = "refs/notes/commits"
+'
+
+test_expect_success 'git notes get-ref (core.notesRef)' '
+	git config core.notesRef refs/notes/foo &&
+	test "$(git notes get-ref)" = "refs/notes/foo"
+'
+
+test_expect_success 'git notes get-ref (GIT_NOTES_REF)' '
+	test "$(GIT_NOTES_REF=refs/notes/bar git notes get-ref)" = "refs/notes/bar"
+'
+
+test_expect_success 'git notes get-ref (--ref)' '
+	test "$(GIT_NOTES_REF=refs/notes/bar git notes --ref=baz get-ref)" = "refs/notes/baz"
+'
+
 test_done
-- 
1.7.3.1.104.g92b87a
