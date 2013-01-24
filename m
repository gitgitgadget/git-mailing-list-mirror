From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v4 4/4] pretty: user format ignores i18n.logOutputEncoding setting
Date: Thu, 24 Jan 2013 13:10:28 +0400
Message-ID: <4abd10a4e24ba7af54fba77177219f44d39f6db7.1359018188.git.Alex.Crezoff@gmail.com>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <zapped@mail.ru>,
	Junio C Hamano <gitster@pobox.com>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 10:12:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyIr1-0003LK-6G
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 10:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab3AXJLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 04:11:55 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:36698 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab3AXJLs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 04:11:48 -0500
Received: by mail-la0-f50.google.com with SMTP id ec20so5519299lab.23
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 01:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=TrGa7peb7uWg9HeThpKw1WAgx063LvS4Ly8A+X6TxNA=;
        b=cF6oErhGaR3weaY0hAGMgYTTnsRJjEdxvl2y0HomNirpg9Mtzpbq7Hx3l8R7Oy9tSL
         PvKtR60OM7W8MJCMIZtD7N/FR57BR+f4H24i5w3YMxxt61EB3vAW8p2SnWXDtpIeN/J9
         95PVvqKjJhEMXTowrp7hwuEi6XuzZ0bqcN3wgJg4tNwPdUB7i+a0AIGMygroYAas2X2l
         EsOIqyZNDmTlSWpoVp0CHVQMlaxJ/4SL86hHH8mFTntS8AdEZp1JX2hULgoe8xXFSCXk
         gCPbbYetQb+C9X+nyz9dRqfFvS/YkzEBTjL7PeAPjJKt6bGyxO0QYwKzM6VHSv25RWYG
         awRg==
X-Received: by 10.112.41.202 with SMTP id h10mr498754lbl.20.1359018706091;
        Thu, 24 Jan 2013 01:11:46 -0800 (PST)
Received: from ds212plus (ppp91-77-44-105.pppoe.mtu-net.ru. [91.77.44.105])
        by mx.google.com with ESMTPS id b3sm9309854lbl.0.2013.01.24.01.11.44
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 01:11:45 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by ds212plus (Postfix) with ESMTP id 7AAEE60017;
	Thu, 24 Jan 2013 13:12:08 +0400 (MSK)
X-Mailer: git-send-email 1.8.1.1.10.g9255f3f
In-Reply-To: <cover.1359018188.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1359018188.git.Alex.Crezoff@gmail.com>
References: <20110921004602.3d59bed4@zappedws> <cover.1359018188.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214423>

From: Alexey Shumkin <zapped@mail.ru>

The following two commands are expected to give the same output to a terminal:

	$ git log --oneline --no-color
	$ git log --pretty=format:'%h %s'

However, the former pays attention to i18n.logOutputEncoding
configuration, while the latter does not when it format "%s".
Log messages written in an encoding i18n.commitEncoding which differs
from terminal encoding are shown corrupted with the latter even
when i18n.logOutputEncoding and terminal encoding are the same.

The same corruption is true for
	$ git diff --submodule=log
and
	$ git rev-list --pretty=format:%s HEAD
and
	$ git reset --hard

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 builtin/reset.c                  |  8 ++++++--
 builtin/rev-list.c               |  1 +
 builtin/shortlog.c               |  1 +
 log-tree.c                       |  1 +
 submodule.c                      |  3 +++
 t/t4041-diff-submodule-option.sh | 10 +++++-----
 t/t4205-log-pretty-formats.sh    |  8 ++++----
 t/t6006-rev-list-format.sh       | 10 +++++-----
 t/t7102-reset.sh                 |  2 +-
 9 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 915cc9f..11c0aa4 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -100,11 +100,15 @@ static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet
 
 static void print_new_head_line(struct commit *commit)
 {
-	const char *hex, *body;
+	const char *hex, *body, *encoding;
 
 	hex = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
 	printf(_("HEAD is now at %s"), hex);
-	body = strstr(commit->buffer, "\n\n");
+	encoding = get_log_output_encoding();
+	body = logmsg_reencode(commit, encoding);
+	if (!body)
+		body = commit->buffer;
+	body = strstr(body, "\n\n");
 	if (body) {
 		const char *eol;
 		size_t len;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 67701be..a5ec30d 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -111,6 +111,7 @@ static void show_commit(struct commit *commit, void *data)
 		ctx.date_mode = revs->date_mode;
 		ctx.date_mode_explicit = revs->date_mode_explicit;
 		ctx.fmt = revs->commit_format;
+		ctx.output_encoding = get_log_output_encoding();
 		pretty_print_commit(&ctx, commit, &buf);
 		if (revs->graph) {
 			if (buf.len) {
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 8360514..23c05cd 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -163,6 +163,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		ctx.subject = "";
 		ctx.after_subject = "";
 		ctx.date_mode = DATE_NORMAL;
+		ctx.output_encoding = get_log_output_encoding();
 		pretty_print_commit(&ctx, commit, &ufbuf);
 		buffer = ufbuf.buf;
 	} else if (*buffer) {
diff --git a/log-tree.c b/log-tree.c
index 4f86def..e1ff3a5 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -671,6 +671,7 @@ void show_log(struct rev_info *opt)
 	ctx.preserve_subject = opt->preserve_subject;
 	ctx.reflog_info = opt->reflog_info;
 	ctx.fmt = opt->commit_format;
+	ctx.output_encoding = get_log_output_encoding();
 	pretty_print_commit(&ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
diff --git a/submodule.c b/submodule.c
index 2f55436..8e42750 100644
--- a/submodule.c
+++ b/submodule.c
@@ -222,10 +222,13 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 	static const char format[] = "  %m %s";
 	struct strbuf sb = STRBUF_INIT;
 	struct commit *commit;
+	const char *log_output_encoding;
 
+	log_output_encoding = get_log_output_encoding();
 	while ((commit = get_revision(rev))) {
 		struct pretty_print_context ctx = {0};
 		ctx.date_mode = rev->date_mode;
+		ctx.output_encoding = log_output_encoding;
 		strbuf_setlen(&sb, 0);
 		if (commit->object.flags & SYMMETRIC_LEFT) {
 			if (del)
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index e7d6363..39f0609 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -92,7 +92,7 @@ test_expect_success 'diff.submodule does not affect plumbing' '
 commit_file sm1 &&
 head2=$(add_file sm1 foo3)
 
-test_expect_failure 'modified submodule(forward)' '
+test_expect_success 'modified submodule(forward)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
@@ -101,7 +101,7 @@ test_expect_failure 'modified submodule(forward)' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'modified submodule(forward)' '
+test_expect_success 'modified submodule(forward)' '
 	git diff --submodule=log >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
@@ -110,7 +110,7 @@ test_expect_failure 'modified submodule(forward)' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'modified submodule(forward) --submodule' '
+test_expect_success 'modified submodule(forward) --submodule' '
 	git diff --submodule >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
@@ -141,7 +141,7 @@ head3=$(
 	git rev-parse --short --verify HEAD
 )
 
-test_expect_failure 'modified submodule(backward)' '
+test_expect_success 'modified submodule(backward)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2..$head3 (rewind):
@@ -152,7 +152,7 @@ test_expect_failure 'modified submodule(backward)' '
 '
 
 head4=$(add_file sm1 foo4 foo5)
-test_expect_failure 'modified submodule(backward and forward)' '
+test_expect_success 'modified submodule(backward and forward)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2...$head4:
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 76ffa0d..54a9704 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -57,7 +57,7 @@ test_expect_success 'alias user-defined tformat with %s (cp1251 encoding)' '
 	test_cmp expected-s actual-s
 '
 
-test_expect_failure 'alias user-defined tformat with %s (utf-8 encoding)' '
+test_expect_success 'alias user-defined tformat with %s (utf-8 encoding)' '
 	git log --oneline >expected-s &&
 	git log --pretty="tformat:%h %s" >actual-s &&
 	test_cmp expected-s actual-s
@@ -96,19 +96,19 @@ test_expect_success 'alias loop' '
 	test_must_fail git log --pretty=test-foo
 '
 
-test_expect_failure 'NUL separation' '
+test_expect_success 'NUL separation' '
 	printf "add bar\0$(commit_msg)" >expected &&
 	git log -z --pretty="format:%s" >actual &&
 	test_cmp expected actual
 '
 
-test_expect_failure 'NUL termination' '
+test_expect_success 'NUL termination' '
 	printf "add bar\0$(commit_msg)\0" >expected &&
 	git log -z --pretty="tformat:%s" >actual &&
 	test_cmp expected actual
 '
 
-test_expect_failure 'NUL separation with --stat' '
+test_expect_success 'NUL separation with --stat' '
 	stat0_part=$(git diff --stat HEAD^ HEAD) &&
 	stat1_part=$(git diff-tree --no-commit-id --stat --root HEAD^) &&
 	printf "add bar\n$stat0_part\n\0$(commit_msg)\n$stat1_part\n" >expected &&
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 4db43a4..006e6ab 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -116,12 +116,12 @@ Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
 EOF
 
-test_format failure encoding %e <<EOF
+test_format encoding %e <<EOF
 commit $head2
 commit $head1
 EOF
 
-test_format failure subject %s <<EOF
+test_format subject %s <<EOF
 commit $head2
 $changed
 commit $head1
@@ -133,7 +133,7 @@ commit $head2
 commit $head1
 EOF
 
-test_format failure raw-body %B <<EOF
+test_format raw-body %B <<EOF
 commit $head2
 $changed
 
@@ -185,7 +185,7 @@ EOF
 # and following test fails
 git config --unset i18n.commitencoding
 
-test_format failure complex-subject %s <<EOF
+test_format complex-subject %s <<EOF
 commit $head3
 Test printing of complex bodies
 commit $head2
@@ -194,7 +194,7 @@ commit $head1
 $added
 EOF
 
-test_format failure complex-body %b <<EOF
+test_format complex-body %b <<EOF
 commit $head3
 This commit message is much longer than the others,
 and it will be encoded in cp1251. We should therefore
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 699c824..ea14c97 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -52,7 +52,7 @@ check_changes () {
 	done | test_cmp .cat_expect -
 }
 
-test_expect_failure 'reset --hard message' '
+test_expect_success 'reset --hard message' '
 	hex=$(git log -1 --format="%h") &&
 	git reset --hard > .actual &&
 	echo HEAD is now at $hex $(commit_msg) > .expected &&
-- 
1.8.1.1.10.g9255f3f
