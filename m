From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH] Make "git notes add" more user-friendly when there are
 existing notes
Date: Wed, 30 Mar 2011 02:02:55 +0200
Message-ID: <201103300202.55973.johan@herland.net>
References: <09668994f10284cfa5243789a627dce8c2325bc6.1301388217.git.git@drmicha.warpmail.net>
 <4D9226B4.20806@warpmail.net> <7vd3l9rbnq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Michael J Gruber <drmicha@warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 02:03:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4isN-0007fA-Kp
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 02:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab1C3ADA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 20:03:00 -0400
Received: from smtp.getmail.no ([84.208.15.66]:38756 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683Ab1C3ADA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 20:03:00 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIU006V8G4XQ450@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 30 Mar 2011 02:02:57 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 03FB91EEF0C4_D927331B	for <git@vger.kernel.org>; Wed,
 30 Mar 2011 00:02:57 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 985F91EEF013_D927330F	for <git@vger.kernel.org>; Wed,
 30 Mar 2011 00:02:56 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIU00I3AG4WU730@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 30 Mar 2011 02:02:56 +0200 (MEST)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.1; x86_64; ; )
In-reply-to: <7vd3l9rbnq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170340>

Currently, "notes add" (without -f/--force) will abort when the given object
already has existing notes. This makes sense for the modes of "git notes add"
that would necessarily overwrite the old message (when using the -m/-F/-C/-c
options). However, when no options are given (meaning the notes are created
from scratch in the editor) it is not very user-friendly to abort on existing
notes, and forcing the user to run "git notes edit".

Instead, it is better to simply "redirect" to "git notes edit" automatically,
i.e. open the existing notes in the editor and let the user edit them.
This patch does just that.

This changes the behavior of "git notes add" without options when notes
already exist for the given object, but I doubt that many users really depend
on the previous failure from "git notes add" in this case.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Tuesday 29 March 2011, Junio C Hamano wrote:
> Michael J Gruber <drmicha@warpmail.net> writes:
> > and while at it rename "add" to "edit"
> That one I think is older wart that may be harder to change.

Here's one attempt at giving Michael a nicer "git notes add" without
breaking too many existing users. It's not very pretty, but I hope it
gets the job done without inconveniencing current users too much.

After all, current (script) users of "git notes add" that depend on it
failing to overwrite existing notes, should already use -m/-F/-C/-c
instead of the default interactive mode, anyway.


Have fun! :)

...Johan


 Documentation/git-notes.txt |    7 +++++--
 builtin/notes.c             |   19 ++++++++++++++++---
 t/t3301-notes.sh            |   29 +++++++++++++++++++++++++++--
 3 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 296f314..913ecd8 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -57,8 +57,11 @@ list::
 
 add::
 	Add notes for a given object (defaults to HEAD). Abort if the
-	object already has notes (use `-f` to overwrite an
-	existing note).
+	object already has notes (use `-f` to overwrite existing notes).
+	However, if you're using `add` interactively (using an editor
+	to supply the notes contents), then - instead of aborting -
+	the existing notes will be opened in the editor (like the `edit`
+	subcommand).
 
 copy::
 	Copy the notes for the first object onto the second object.
diff --git a/builtin/notes.c b/builtin/notes.c
index 0aab150..4074ba1 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -527,6 +527,8 @@ static int list(int argc, const char **argv, const char *prefix)
 	return retval;
 }
 
+static int append_edit(int argc, const char **argv, const char *prefix);
+
 static int add(int argc, const char **argv, const char *prefix)
 {
 	int retval = 0, force = 0;
@@ -554,14 +556,14 @@ static int add(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options, git_notes_add_usage,
-			     0);
+			     PARSE_OPT_KEEP_ARGV0);
 
-	if (1 < argc) {
+	if (2 < argc) {
 		error("too many parameters");
 		usage_with_options(git_notes_add_usage, options);
 	}
 
-	object_ref = argc ? argv[0] : "HEAD";
+	object_ref = argc > 1 ? argv[1] : "HEAD";
 
 	if (get_sha1(object_ref, object))
 		die("Failed to resolve '%s' as a valid ref.", object_ref);
@@ -571,6 +573,17 @@ static int add(int argc, const char **argv, const char *prefix)
 
 	if (note) {
 		if (!force) {
+			if (!msg.given) /* redirect to "edit" subcommand */
+			{
+				/*
+				 * We only end up here if none of -m/-F/-c/-C
+				 * or -f are given. The original args are
+				 * therefore still in argv[0-1]
+				 */
+				argv[0] = "edit";
+				free_notes(t);
+				return append_edit(argc, argv, prefix);
+			}
 			retval = error("Cannot add notes. Found existing notes "
 				       "for object %s. Use '-f' to overwrite "
 				       "existing notes", sha1_to_hex(object));
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 1921ca3..3448c23 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -101,8 +101,8 @@ test_expect_success 'edit existing notes' '
 	test_must_fail git notes show HEAD^
 '
 
-test_expect_success 'cannot add note where one exists' '
-	! MSG=b2 git notes add &&
+test_expect_success 'cannot "git notes add -m" where notes already exists' '
+	test_must_fail git notes add -m "b2" &&
 	test ! -f .git/NOTES_EDITMSG &&
 	test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
 	test b3 = $(git notes show) &&
@@ -110,6 +110,24 @@ test_expect_success 'cannot add note where one exists' '
 	test_must_fail git notes show HEAD^
 '
 
+test_expect_success 'can overwrite existing note with "git notes add -f -m"' '
+	git notes add -f -m "b1" &&
+	test ! -f .git/NOTES_EDITMSG &&
+	test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
+	test b1 = $(git notes show) &&
+	git show HEAD^ &&
+	test_must_fail git notes show HEAD^
+'
+
+test_expect_success 'add w/no options on existing note morphs into edit' '
+	MSG=b2 git notes add &&
+	test ! -f .git/NOTES_EDITMSG &&
+	test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
+	test b2 = $(git notes show) &&
+	git show HEAD^ &&
+	test_must_fail git notes show HEAD^
+'
+
 test_expect_success 'can overwrite existing note with "git notes add -f"' '
 	MSG=b1 git notes add -f &&
 	test ! -f .git/NOTES_EDITMSG &&
@@ -194,6 +212,13 @@ test_expect_success 'show -F notes' '
 	test_cmp expect-F output
 '
 
+test_expect_success 'Re-adding -F notes without -f fails' '
+	echo "zyxxy" > note5 &&
+	test_must_fail git notes add -F note5 &&
+	git log -3 > output &&
+	test_cmp expect-F output
+'
+
 cat >expect << EOF
 commit 15023535574ded8b1a89052b32673f84cf9582b8
 tree e070e3af51011e47b183c33adf9736736a525709
-- 
1.7.4
