From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] notes remove: --missing-ok
Date: Wed, 18 May 2011 17:14:20 -0700
Message-ID: <1305764061-21303-3-git-send-email-gitster@pobox.com>
References: <1305764061-21303-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 02:14:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMqt0-00006Q-FZ
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 02:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab1ESAOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 20:14:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab1ESAO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 20:14:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A46615EAF
	for <git@vger.kernel.org>; Wed, 18 May 2011 20:16:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=1Jxg
	agZEqBTABFehKbdSVxOZY6g=; b=SLlRi/MjoZ4Hl+7iBwBqEW7iUJpC2JxT3mWa
	FZ2jgKuOdoyyO6+BHT3e6hiCfdGf7vWh9ZkPDo1lUOv31N9Se4XBBHVV0F5L/hQk
	wEM3qxA75LxAHCOnXzQoROLYSrIoXNXz/uU7EPOxmyiHwv2wkm7c54LwUsScNmSg
	wTjoRmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=fBOff0
	ucnoSYWjHTjdmQ52u9RxLqPIOHupDBWQUyCna0+WZ6p9mzUnNAJReZKDAKUgYKOd
	WkzxpFUXNcilIViTmaw+4VoNHiYMinpC6pePNEIIyAcw+H1pes8PatA/kFoxckNq
	RM9K3NsFSpCvs0AMx4Q3El2hIRQrqlAwgphS0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A00D05EAE
	for <git@vger.kernel.org>; Wed, 18 May 2011 20:16:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EAE3F5EAD for
 <git@vger.kernel.org>; Wed, 18 May 2011 20:16:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.414.gb4910
In-Reply-To: <1305764061-21303-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 427A6266-81AD-11E0-AA19-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173923>

Depending on the application, it is not necessarily an error for an object
to lack a note, especially if the only thing the caller wants to make sure
is that notes are cleared for an object.  By passing this option from the
command line, the "git notes remove" command considers it a success if the
object did not have any note to begin with.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * It may be that this should have been the default, I suspect.
---
 Documentation/git-notes.txt |    6 +++++-
 builtin/notes.c             |   14 ++++++++++----
 t/t3301-notes.sh            |   19 +++++++++++++++++++
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index e2e1c4c..6b92060 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -17,7 +17,7 @@ SYNOPSIS
 'git notes' merge [-v | -q] [-s <strategy> ] <notes_ref>
 'git notes' merge --commit [-v | -q]
 'git notes' merge --abort [-v | -q]
-'git notes' remove [<object>...]
+'git notes' remove [--missing-ok] [<object>...]
 'git notes' prune [-n | -v]
 'git notes' get-ref
 
@@ -155,6 +155,10 @@ OPTIONS
 	'GIT_NOTES_REF' and the "core.notesRef" configuration.  The ref
 	is taken to be in `refs/notes/` if it is not qualified.
 
+--missing-ok::
+	Do not consider it an error to request removing notes from an
+	object that does not have notes attached to it.
+
 -n::
 --dry-run::
 	Do not remove anything; just report the object names whose notes
diff --git a/builtin/notes.c b/builtin/notes.c
index 30cee0f..ca045f8 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -953,7 +953,9 @@ static int merge(int argc, const char **argv, const char *prefix)
 	return result < 0; /* return non-zero on conflicts */
 }
 
-static int remove_one_note(struct notes_tree *t, const char *name)
+#define MISSING_OK 1
+
+static int remove_one_note(struct notes_tree *t, const char *name, unsigned flag)
 {
 	int status;
 	unsigned char sha1[20];
@@ -964,12 +966,16 @@ static int remove_one_note(struct notes_tree *t, const char *name)
 		fprintf(stderr, _("Object %s has no note\n"), name);
 	else
 		fprintf(stderr, _("Removing note for object %s\n"), name);
-	return status;
+	return (flag & MISSING_OK) ? 0 : status;
 }
 
 static int remove_cmd(int argc, const char **argv, const char *prefix)
 {
+	unsigned flag = 0;
 	struct option options[] = {
+		OPT_BIT(0, "missing-ok", &flag,
+			"attempt to remove non-existent note is not an error",
+			MISSING_OK),
 		OPT_END()
 	};
 	struct notes_tree *t;
@@ -981,10 +987,10 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
 	t = init_notes_check("remove");
 
 	if (!argc) {
-		retval = remove_one_note(t, "HEAD");
+		retval = remove_one_note(t, "HEAD", flag);
 	} else {
 		while (*argv) {
-			retval |= remove_one_note(t, *argv);
+			retval |= remove_one_note(t, *argv, flag);
 			argv++;
 		}
 	}
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 6a6daa9..bdd4036 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -454,6 +454,25 @@ test_expect_success 'removing is atomic' '
 	test "$before" = "$after"
 '
 
+test_expect_success 'removing with --missing-ok' '
+	before=$(git rev-parse --verify refs/notes/commits) &&
+	test_when_finished "git update-ref refs/notes/commits $before" &&
+	git notes remove --missing-ok HEAD^^ HEAD^^^ HEAD^ &&
+	git diff --name-only refs/notes/commits^ refs/notes/commits >actual &&
+	test 2 = $(wc -l <actual) &&
+	git ls-tree -r --name-only refs/notes/commits >actual &&
+	>empty &&
+	test_cmp empty actual
+'
+
+test_expect_success 'removing with --missing-ok but bogus ref' '
+	before=$(git rev-parse --verify refs/notes/commits) &&
+	test_when_finished "git update-ref refs/notes/commits $before" &&
+	test_must_fail git notes remove --missing-ok HEAD^^ HEAD^^^ NO-SUCH-COMMIT &&
+	after=$(git rev-parse --verify refs/notes/commits) &&
+	test "$before" = "$after"
+'
+
 test_expect_success 'list notes with "git notes list"' '
 	git notes list > output &&
 	test_cmp expect output
-- 
1.7.5.1.414.gb4910
