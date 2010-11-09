From: Johan Herland <johan@herland.net>
Subject: [PATCHv6 21/23] Provide 'git notes get-ref' to easily retrieve current
 notes ref
Date: Tue, 09 Nov 2010 22:49:57 +0100
Message-ID: <1289339399-4733-22-git-send-email-johan@herland.net>
References: <1289339399-4733-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 09 22:51:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFw6D-0000yR-D5
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 22:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490Ab0KIVui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 16:50:38 -0500
Received: from smtp.getmail.no ([84.208.15.66]:61168 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755457Ab0KIVub (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 16:50:31 -0500
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBN005XL0NOCV30@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 09 Nov 2010 22:50:19 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 885AF1799210_CD9C21BB	for <git@vger.kernel.org>; Tue,
 09 Nov 2010 21:50:19 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 4EA1F17990C2_CD9C21BF	for <git@vger.kernel.org>; Tue,
 09 Nov 2010 21:50:18 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBN00HVN0NLS730@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 09 Nov 2010 22:50:15 +0100 (MET)
X-Mailer: git-send-email 1.7.3.2.173.gab1c9.dirty
In-reply-to: <1289339399-4733-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161089>

Script may use 'git notes get-ref' to easily retrieve the current notes ref.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |    5 +++++
 builtin/notes.c             |   23 +++++++++++++++++++++++
 t/t3301-notes.sh            |   19 +++++++++++++++++++
 3 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 1de1417..296f314 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -19,6 +19,7 @@ SYNOPSIS
 'git notes' merge --abort [-v | -q]
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
index 79783a5..ef52ffd 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -31,6 +31,7 @@ static const char * const git_notes_usage[] = {
 	"git notes merge --abort [-v | -q]",
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
1.7.3.2.173.gab1c9.dirty
