From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] commit: allow {--amend|-c foo} when {HEAD|foo} has empty message
Date: Tue, 28 Feb 2012 11:36:59 +0100
Message-ID: <010901fbfffe0f806bb19d556ebc1e512a4697f4.1330425111.git.trast@student.ethz.ch>
References: <20120228091422.GC5757@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 28 11:37:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2KQn-0007aX-Uo
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 11:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357Ab2B1KhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 05:37:06 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:27110 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271Ab2B1KhF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 05:37:05 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 11:37:01 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 11:37:01 +0100
X-Mailer: git-send-email 1.7.9.2.467.g7fee4
In-Reply-To: <20120228091422.GC5757@sigill.intra.peff.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191707>

Because --amend (-c foo) internally load the message from HEAD (foo,
resp.) using the same code paths as -C, they erroneously refuse to
work at all when the message of HEAD (foo) is empty.

Remove the corresponding check under --amend and -c.

None of this behavior was ever tested (not even for -C empty_message),
so we add a whole batch of new tests.

Reported-by: Lazar Florentin <florentin.lazar@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Like the last version, plus Peff's guard for the invalid commit
format.  I also received Lazar (starlay) 's identity for the
attribution.


 builtin/commit.c  |    4 +++-
 t/t7501-commit.sh |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 3714582..5e9a832 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -690,7 +690,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		hook_arg1 = "message";
 	} else if (use_message) {
 		buffer = strstr(use_message_buffer, "\n\n");
-		if (!buffer || buffer[2] == '\0')
+		if (!buffer)
+			die(_("commit object has invalid format"));
+		if (!amend && !edit_message && buffer[2] == '\0')
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
