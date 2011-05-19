From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] notes remove: --stdin reads from the standard input
Date: Wed, 18 May 2011 17:14:21 -0700
Message-ID: <1305764061-21303-4-git-send-email-gitster@pobox.com>
References: <1305764061-21303-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 02:14:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMqt1-00006Q-04
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 02:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109Ab1ESAOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 20:14:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab1ESAOb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 20:14:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EC2725EB2
	for <git@vger.kernel.org>; Wed, 18 May 2011 20:16:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=W+xN
	RdyE9irdHTUHYLVSYk9GDCo=; b=xmCXFByiYQmEGKCf0ngokV0A/1/R1Ri7jA8O
	bENfY8hrjN2fs75xNyH6dADxgsfHhvczlKRrc0UX4hvucktrkQ9myaq8c2t1Rmco
	6cGpgjwV5U4oMEqBGPeC0dLbRt6ETHG0rGvPbQQpTLcWq9Lz+i6GwLvK5WCePGQc
	/jpasGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=t6g0Hq
	aWghz11MlVj+mcWu+cmezhuSEEwrVu2B9F6nCV8W9NmAwocYHeE4KfTcib6P4v7Z
	l8DbqvF32KSw8r3JMkY+4Z5e7VrAd76pus/Q/UrPKxc7o0d9Fi66jriWyH6R5fXZ
	mjqOtJynG5VUqWMWftjCHRCeWfpXbVu+bV0xg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E92BB5EB1
	for <git@vger.kernel.org>; Wed, 18 May 2011 20:16:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3FA9D5EB0 for
 <git@vger.kernel.org>; Wed, 18 May 2011 20:16:38 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.414.gb4910
In-Reply-To: <1305764061-21303-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 43D6972E-81AD-11E0-8EBC-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173922>

Teach the command to read object names to remove from the standard
input, in addition to the object names given from the command line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The logical conclusion of the series.
---
 Documentation/git-notes.txt |    7 ++++++-
 builtin/notes.c             |   14 +++++++++++++-
 t/t3301-notes.sh            |   33 +++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 6b92060..42e4823 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -17,7 +17,7 @@ SYNOPSIS
 'git notes' merge [-v | -q] [-s <strategy> ] <notes_ref>
 'git notes' merge --commit [-v | -q]
 'git notes' merge --abort [-v | -q]
-'git notes' remove [--missing-ok] [<object>...]
+'git notes' remove [--missing-ok] [--stdin] [<object>...]
 'git notes' prune [-n | -v]
 'git notes' get-ref
 
@@ -159,6 +159,11 @@ OPTIONS
 	Do not consider it an error to request removing notes from an
 	object that does not have notes attached to it.
 
+--stdin::
+	Also read the object names to remove notes from from the standard
+	input (there is no reason you cannot combine this with object
+	names from the command line).
+
 -n::
 --dry-run::
 	Do not remove anything; just report the object names whose notes
diff --git a/builtin/notes.c b/builtin/notes.c
index ca045f8..23954e0 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -972,10 +972,13 @@ static int remove_one_note(struct notes_tree *t, const char *name, unsigned flag
 static int remove_cmd(int argc, const char **argv, const char *prefix)
 {
 	unsigned flag = 0;
+	int from_stdin = 0;
 	struct option options[] = {
 		OPT_BIT(0, "missing-ok", &flag,
 			"attempt to remove non-existent note is not an error",
 			MISSING_OK),
+		OPT_BOOLEAN(0, "stdin", &from_stdin,
+			    "read object names from the standard input"),
 		OPT_END()
 	};
 	struct notes_tree *t;
@@ -986,7 +989,7 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
 
 	t = init_notes_check("remove");
 
-	if (!argc) {
+	if (!argc && !from_stdin) {
 		retval = remove_one_note(t, "HEAD", flag);
 	} else {
 		while (*argv) {
@@ -994,6 +997,15 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
 			argv++;
 		}
 	}
+	if (from_stdin) {
+		struct strbuf sb = STRBUF_INIT;
+		while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
+			int len = sb.len;
+			if (len && sb.buf[len - 1] == '\n')
+				sb.buf[--len] = '\0';
+			retval |= remove_one_note(t, sb.buf, flag);
+		}
+	}
 	if (!retval)
 		commit_notes(t, "Notes removed by 'git notes remove'");
 	free_notes(t);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index bdd4036..2c52f21 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -473,6 +473,39 @@ test_expect_success 'removing with --missing-ok but bogus ref' '
 	test "$before" = "$after"
 '
 
+test_expect_success 'remove reads from --stdin' '
+	before=$(git rev-parse --verify refs/notes/commits) &&
+	test_when_finished "git update-ref refs/notes/commits $before" &&
+	git rev-parse HEAD^^ HEAD^^^ >input &&
+	git notes remove --stdin <input &&
+	git diff --name-only refs/notes/commits^ refs/notes/commits >actual &&
+	test 2 = $(wc -l <actual) &&
+	git ls-tree -r --name-only refs/notes/commits >actual &&
+	>empty &&
+	test_cmp empty actual
+'
+
+test_expect_success 'remove --stdin is also atomic' '
+	before=$(git rev-parse --verify refs/notes/commits) &&
+	test_when_finished "git update-ref refs/notes/commits $before" &&
+	git rev-parse HEAD^^ HEAD^^^ HEAD^ >input &&
+	test_must_fail git notes remove --stdin <input &&
+	after=$(git rev-parse --verify refs/notes/commits) &&
+	test "$before" = "$after"
+'
+
+test_expect_success 'removing with --stdin --missing-ok' '
+	before=$(git rev-parse --verify refs/notes/commits) &&
+	test_when_finished "git update-ref refs/notes/commits $before" &&
+	git rev-parse HEAD^^ HEAD^^^ HEAD^ >input &&
+	git notes remove --missing-ok --stdin <input &&
+	git diff --name-only refs/notes/commits^ refs/notes/commits >actual &&
+	test 2 = $(wc -l <actual) &&
+	git ls-tree -r --name-only refs/notes/commits >actual &&
+	>empty &&
+	test_cmp empty actual
+'
+
 test_expect_success 'list notes with "git notes list"' '
 	git notes list > output &&
 	test_cmp expect output
-- 
1.7.5.1.414.gb4910
