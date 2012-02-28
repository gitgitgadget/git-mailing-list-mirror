From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] commit: allow {--amend|-c foo} when {HEAD|foo} has empty message
Date: Tue, 28 Feb 2012 09:57:05 +0100
Message-ID: <8529824c8569a8a0b4c4caf3a562750925758e74.1330419275.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 09:57:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Is0-0005FG-4n
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 09:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860Ab2B1I5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 03:57:10 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:5528 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756566Ab2B1I5J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 03:57:09 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 09:57:04 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 09:57:05 +0100
X-Mailer: git-send-email 1.7.9.2.467.g7fee4
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191701>

Because --amend (-c foo) internally load the message from HEAD (foo,
resp.) using the same code paths as -C, they erroneously refuse to
work at all when the message of HEAD (foo) is empty.

Remove the corresponding check under --amend and -c.

None of this behavior was ever tested (not even for -C empty_message),
so we add a whole batch of new tests.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Noticed while helping "starlays" on IRC.  It's possible to work around
the bug by first giving HEAD a non-empty commit message from the
command line, as in

  git commit --amend -mfoo
  git commit --amend

I haven't really checked, but from an irresponsibly quick glance it
looks like this bug has always been there in the C version (that is,
since f5bbc322).


 builtin/commit.c  |    2 +-
 t/t7501-commit.sh |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 3714582..45a57af 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -690,7 +690,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		hook_arg1 = "message";
 	} else if (use_message) {
 		buffer = strstr(use_message_buffer, "\n\n");
-		if (!buffer || buffer[2] == '\0')
+		if (!amend && !edit_message && (!buffer || buffer[2] == '\0'))
 			die(_("commit has empty message"));
 		strbuf_add(&sb, buffer + 2, strlen(buffer + 2));
 		hook_arg1 = "commit";
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 8bb3833..6ab7712 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -473,4 +473,70 @@ test_expect_success 'amend can copy notes' '
 
 '
 
+test_expect_success 'amend on empty commit message' '
+
+	echo bar > bar &&
+	git add bar &&
+	test_tick &&
+	git commit --allow-empty-message -m "" &&
+	git tag empty_message &&
+	git commit --amend -mnonempty &&
+	git cat-file commit HEAD | grep nonempty
+
+'
+
+test_expect_success 'amend with editor on empty commit message' '
+
+	git reset --hard empty_message &&
+	cat >editor <<-\EOF &&
+	#!/bin/sh
+	echo nonempty_one >"$1"
+	EOF
+	chmod 755 editor &&
+	EDITOR=./editor git commit --amend &&
+	git cat-file commit HEAD | grep nonempty_one
+
+'
+
+test_expect_success '--amend -C empty_message fails' '
+
+	test_commit nonempty &&
+	test_must_fail git commit --amend -C empty_message
+
+'
+
+test_expect_success '-C empty_message fails' '
+
+	echo 1 > bar &&
+	git add bar &&
+	test_must_fail git commit --amend -C empty_message
+
+'
+
+test_expect_success '--amend -c empty_message works' '
+
+	cat >editor <<-\EOF &&
+	#!/bin/sh
+	echo nonempty_two >"$1"
+	EOF
+	chmod 755 editor &&
+	EDITOR=./editor git commit --amend -c empty_message &&
+	git cat-file commit HEAD | grep nonempty_two
+
+'
+
+test_expect_success '-c empty_message works' '
+
+	echo 2 > bar &&
+	git add bar &&
+	cat >editor <<-\EOF &&
+	#!/bin/sh
+	echo nonempty_three >"$1"
+	EOF
+	chmod 755 editor &&
+	EDITOR=./editor git commit -c empty_message &&
+	git cat-file commit HEAD | grep nonempty_three
+
+'
+
 test_done
-- 
1.7.9.2.467.g7fee4
