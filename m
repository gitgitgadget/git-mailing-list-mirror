From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 2/2] make commit --verbose work with --no-status
Date: Fri,  5 Jun 2015 01:56:31 +0800
Message-ID: <1433440591-30917-3-git-send-email-rctay89@gmail.com>
References: <1433440591-30917-1-git-send-email-rctay89@gmail.com>
 <1433440591-30917-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, Jeff King <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 04 19:57:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0ZOD-0000aU-2s
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 19:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbbFDR5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 13:57:08 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33735 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbbFDR5C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 13:57:02 -0400
Received: by padj3 with SMTP id j3so34054444pad.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 10:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UtiAcQjNZHQ5LGRWJVXyES4PRrkjZ8j6nQZbMuYSsSk=;
        b=o3B8eWqasf45VlwUwqadN6QQpzgdVaDrd0BkYnmNolmZmLWbi+Bdn5gjDa4T99uXYH
         LPKbXuqEiu3bR6Jx7gVh+HfNIrDTd4GXvGDx13X1fugiaemCjadGB/URrAbZBVI8rvv3
         80oHwKNk/GujNIsqhCNt8bK9/cK/80bcIa0A2oVmXvBIHwTbA1kklzdYfnFsTSLsS75W
         B1cS+mMH0Ixns/Bmw5q5b6xMAY0T0Q4yVuBk1kadmXeS2gQLb8QcE1xARYjQgLkGW0Gz
         jjAJQ/d+5SZm63/CcwLGxIHBPnpXwXdHA1LcoMn81y9dfXapoYd6CpWTEa/TQ1Nxe4QI
         JI2Q==
X-Received: by 10.70.119.36 with SMTP id kr4mr72001857pdb.39.1433440621910;
        Thu, 04 Jun 2015 10:57:01 -0700 (PDT)
Received: from localhost.localdomain ([202.156.104.43])
        by mx.google.com with ESMTPSA id j9sm4453566pdm.53.2015.06.04.10.57.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 04 Jun 2015 10:57:01 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.581.g64f2558
In-Reply-To: <1433440591-30917-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270790>

When running git-commit`, --verbose appends a diff to the prepared
message, while --no-status omits git-status output; thus, one would
expect --verbose --no-status to give a commit message with a diff of
the commit without git-status output.

However, this is not what happens - the prepared commit message body is
empty, entirely. (Needless to say, no diff is appended.) This is because
internally the git-status machinery is used to provide both the diff and
status output, but this machinery is skipped over entirely due to
--no-status.

We introduce a new status_format, STATUS_FORMAT_DIFFONLY, which triggers
the setting of the commitable flag, and the printing of the diff. This
is set only by git-commit, and when it detects that --verbose and
--no-status have been used.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changed since v1: adopted peff's suggestion in
20140224083312.GB32594@sigill.intra.peff.net, added tests.

 builtin/commit.c          | 12 +++++++++++-
 t/t7507-commit-verbose.sh | 34 +++++++++++++++++++++++++++++++++-
 wt-status.c               |  2 +-
 wt-status.h               |  3 +++
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 254477f..d752899 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -144,6 +144,7 @@ static enum status_format {
 	STATUS_FORMAT_LONG,
 	STATUS_FORMAT_SHORT,
 	STATUS_FORMAT_PORCELAIN,
+	STATUS_FORMAT_DIFFONLY,
 
 	STATUS_FORMAT_UNSPECIFIED
 } status_format = STATUS_FORMAT_UNSPECIFIED;
@@ -510,6 +511,10 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	case STATUS_FORMAT_UNSPECIFIED:
 		die("BUG: finalize_deferred_config() should have been called");
 		break;
+	case STATUS_FORMAT_DIFFONLY:
+		wt_status_mark_commitable(s);
+		wt_status_print_verbose(s);
+		break;
 	case STATUS_FORMAT_NONE:
 	case STATUS_FORMAT_LONG:
 		wt_status_print(s);
@@ -1213,7 +1218,12 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (all && argc > 0)
 		die(_("Paths with -a does not make sense."));
 
-	if (status_format != STATUS_FORMAT_NONE)
+	if (status_format == STATUS_FORMAT_NONE) {
+		if (verbose && !include_status) {
+			include_status = 1;
+			status_format = STATUS_FORMAT_DIFFONLY;
+		}
+	} else
 		dry_run = 1;
 
 	return argc;
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 2ddf28c..9027dd4 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -26,7 +26,39 @@ test_expect_success 'initial commit shows verbose diff' '
 	git commit --amend -v
 '
 
-test_expect_success 'second commit' '
+test_expect_success '--verbose appends diff' '
+	cat >expected <<-\EOF &&
+	# ------------------------ >8 ------------------------
+	# Do not touch the line above.
+	# Everything below will be removed.
+	diff --git a/file b/file
+	index d95f3ad..94ab063 100644
+	--- a/file
+	+++ b/file
+	@@ -1 +1,2 @@
+	 content
+	+content content
+	EOF
+	cat >editor <<-\EOF &&
+	#!/bin/sh
+	awk "/^# -+ >8 -+$/ { p=1 } p" "$1" >actual
+	echo commit > "$1"
+	EOF
+	chmod 755 editor &&
+	echo content content >> file &&
+	git add file &&
+	test_tick &&
+	EDITOR=./editor git commit --verbose &&
+	test_cmp expected actual
+'
+
+test_expect_success '--verbose --no-status appends diff' '
+	git reset --soft HEAD^ &&
+	EDITOR=./editor git commit --verbose --no-status &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit' '
 	echo content modified >file &&
 	git add file &&
 	git commit -F message
diff --git a/wt-status.c b/wt-status.c
index 87550ae..c4f7e48 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -857,7 +857,7 @@ void wt_status_add_cut_line(FILE *fp)
 	strbuf_release(&buf);
 }
 
-static void wt_status_print_verbose(struct wt_status *s)
+void wt_status_print_verbose(struct wt_status *s)
 {
 	struct rev_info rev;
 	struct setup_revision_opt opt;
diff --git a/wt-status.h b/wt-status.h
index e0a99f7..4388296 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -98,8 +98,11 @@ void wt_status_add_cut_line(FILE *fp);
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
+void wt_status_mark_commitable(struct wt_status *state);
 void wt_status_get_state(struct wt_status_state *state, int get_detached_from);
 
+void wt_status_print_verbose(struct wt_status *s);
+
 void wt_shortstatus_print(struct wt_status *s);
 void wt_porcelain_print(struct wt_status *s);
 
-- 
2.0.0.581.g64f2558
