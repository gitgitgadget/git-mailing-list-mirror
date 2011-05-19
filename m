From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] notes remove: allow removing more than one
Date: Wed, 18 May 2011 17:14:19 -0700
Message-ID: <1305764061-21303-2-git-send-email-gitster@pobox.com>
References: <1305764061-21303-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 02:14:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMqso-0008S0-NT
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 02:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956Ab1ESAO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 20:14:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238Ab1ESAO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 20:14:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6935A5EAC
	for <git@vger.kernel.org>; Wed, 18 May 2011 20:16:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=jCMG
	L2V6eZtOnH3RO2hVQwh0M04=; b=sl+l4AFRRu1fRQKrvYNCguW7J1+oYH39q+1S
	E6N/sZWN1/MKDp18b91xFF5Cy6GDFBNPnGWsWT8hX8DStuoX2U6YzTvPvN5clcRx
	98uEx88u6nuVubqlzBwERElAmtLWlW6lDfn1gNljm530PWsydg3vAD9kI3wNBSgs
	IkhImaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=cqCa18
	qS1aQRffXlGOAPRf82F/NOyJvJWGwa8g9k6I9f/DmsvK9H+MIUzl2EpZLVB3eJuP
	h1FUrJw//kCgdQGjK+/A5lHqWo1ZIYQMgzUnUo2bg0jSR0Ep93WYynjhdMab/XIt
	bOq8kRfk8ZZeJKSfmXONCJ1sXa+qvUY7jHAPE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 569205EAB
	for <git@vger.kernel.org>; Wed, 18 May 2011 20:16:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 71A435EAA for
 <git@vger.kernel.org>; Wed, 18 May 2011 20:16:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.414.gb4910
In-Reply-To: <1305764061-21303-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 411A0F48-81AD-11E0-B6C1-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173921>

While "xargs -n1 git notes rm" is certainly a possible way to remove notes
from many objects, this would create one notes "commit" per removal, which
is not quite suitable for seasonal housekeeping.

Allow taking more than one on the command line, and record their removal
as a single atomic event if everthing goes well.

Even though the old code insisted that "git notes rm" must be given only
one object (or zero, in which case it would default to HEAD), this
condition was not tested. Add tests to handle the new case where we feed
multiple objects, and also make sure if there is a bad input, no change
is recorded.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-notes.txt |    7 +++--
 builtin/notes.c             |   47 ++++++++++++++++++++++--------------------
 t/t3301-notes.sh            |   19 +++++++++++++++++
 3 files changed, 48 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 913ecd8..e2e1c4c 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -17,7 +17,7 @@ SYNOPSIS
 'git notes' merge [-v | -q] [-s <strategy> ] <notes_ref>
 'git notes' merge --commit [-v | -q]
 'git notes' merge --abort [-v | -q]
-'git notes' remove [<object>]
+'git notes' remove [<object>...]
 'git notes' prune [-n | -v]
 'git notes' get-ref
 
@@ -106,8 +106,9 @@ When done, the user can either finalize the merge with
 'git notes merge --abort'.
 
 remove::
-	Remove the notes for a given object (defaults to HEAD).
-	This is equivalent to specifying an empty note message to
+	Remove the notes for given objects (defaults to HEAD). When
+	giving zero or one object from the command line, this is
+	equivalent to specifying an empty note message to
 	the `edit` subcommand.
 
 prune::
diff --git a/builtin/notes.c b/builtin/notes.c
index 1fb1f73..30cee0f 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -29,7 +29,7 @@ static const char * const git_notes_usage[] = {
 	"git notes [--ref <notes_ref>] merge [-v | -q] [-s <strategy> ] <notes_ref>",
 	"git notes merge --commit [-v | -q]",
 	"git notes merge --abort [-v | -q]",
-	"git notes [--ref <notes_ref>] remove [<object>]",
+	"git notes [--ref <notes_ref>] remove [<object>...]",
 	"git notes [--ref <notes_ref>] prune [-n | -v]",
 	"git notes [--ref <notes_ref>] get-ref",
 	NULL
@@ -953,40 +953,43 @@ static int merge(int argc, const char **argv, const char *prefix)
 	return result < 0; /* return non-zero on conflicts */
 }
 
+static int remove_one_note(struct notes_tree *t, const char *name)
+{
+	int status;
+	unsigned char sha1[20];
+	if (get_sha1(name, sha1))
+		return error(_("Failed to resolve '%s' as a valid ref."), name);
+	status = remove_note(t, sha1);
+	if (status)
+		fprintf(stderr, _("Object %s has no note\n"), name);
+	else
+		fprintf(stderr, _("Removing note for object %s\n"), name);
+	return status;
+}
+
 static int remove_cmd(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
 		OPT_END()
 	};
-	const char *object_ref;
 	struct notes_tree *t;
-	unsigned char object[20];
-	int retval;
+	int retval = 0;
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_notes_remove_usage, 0);
 
-	if (1 < argc) {
-		error(_("too many parameters"));
-		usage_with_options(git_notes_remove_usage, options);
-	}
-
-	object_ref = argc ? argv[0] : "HEAD";
-
-	if (get_sha1(object_ref, object))
-		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
-
 	t = init_notes_check("remove");
 
-	retval = remove_note(t, object);
-	if (retval)
-		fprintf(stderr, _("Object %s has no note\n"), sha1_to_hex(object));
-	else {
-		fprintf(stderr, _("Removing note for object %s\n"),
-			sha1_to_hex(object));
-
-		commit_notes(t, "Notes removed by 'git notes remove'");
+	if (!argc) {
+		retval = remove_one_note(t, "HEAD");
+	} else {
+		while (*argv) {
+			retval |= remove_one_note(t, *argv);
+			argv++;
+		}
 	}
+	if (!retval)
+		commit_notes(t, "Notes removed by 'git notes remove'");
 	free_notes(t);
 	return retval;
 }
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 28e17c8..6a6daa9 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -435,6 +435,25 @@ test_expect_success 'removing non-existing note should not create new commit' '
 	test_cmp before_commit after_commit
 '
 
+test_expect_success 'removing more than one' '
+	before=$(git rev-parse --verify refs/notes/commits) &&
+	test_when_finished "git update-ref refs/notes/commits $before" &&
+	git notes remove HEAD^^ HEAD^^^ &&
+	git diff --name-only refs/notes/commits^ refs/notes/commits >actual &&
+	test 2 = $(wc -l <actual) &&
+	git ls-tree -r --name-only refs/notes/commits >actual &&
+	>empty &&
+	test_cmp empty actual
+'
+
+test_expect_success 'removing is atomic' '
+	before=$(git rev-parse --verify refs/notes/commits) &&
+	test_when_finished "git update-ref refs/notes/commits $before" &&
+	test_must_fail git notes remove HEAD^^ HEAD^^^ HEAD^ &&
+	after=$(git rev-parse --verify refs/notes/commits) &&
+	test "$before" = "$after"
+'
+
 test_expect_success 'list notes with "git notes list"' '
 	git notes list > output &&
 	test_cmp expect output
-- 
1.7.5.1.414.gb4910
