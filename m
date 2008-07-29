From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] format-patch: Produce better output with --inline or --attach
Date: Tue, 29 Jul 2008 16:49:16 -0700
Message-ID: <1217375356-80287-1-git-send-email-kevin@sb.org>
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 01:50:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNyxR-0007zl-Cu
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 01:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbYG2XtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 19:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753591AbYG2XtU
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 19:49:20 -0400
Received: from mailbigip.dreamhost.com ([208.97.132.5]:60964 "EHLO
	randymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753397AbYG2XtT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2008 19:49:19 -0400
Received: from localhost.localdomain (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	by randymail-a12.g.dreamhost.com (Postfix) with ESMTP id BA67BA8C86;
	Tue, 29 Jul 2008 16:49:16 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.166.gbbfa8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90712>

This patch makes two small changes to improve the output of --inline and --attach.

The first is to write a newline preceding the boundary. This is needed because
MIME defines the encapsulation boundary as including the preceding CRLF (or in
this case, just LF), so we should be writing one. Without this, the last newline
in the pre-diff content is consumed instead.

The second change is to always write the line termination character (default: newline)
even when using --inline or --attach. This is simply to improve the aesthetics of
the resulting message. When using --inline an email client should render the
resulting message identically to the non-inline version. And when using --attach
this adds a blank line preceding the attachment in the email, which is visually
attractive.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 diff.c                                             |    3 +--
 log-tree.c                                         |    2 +-
 ....format-patch_--attach_--stdout_initial..master |    6 ++++++
 ...format-patch_--attach_--stdout_initial..master^ |    4 ++++
 ...ff.format-patch_--attach_--stdout_initial..side |    2 ++
 ...tdout_--subject-prefix=TESTCASE_initial..master |    6 ++++++
 ....format-patch_--inline_--stdout_initial..master |    6 ++++++
 ...format-patch_--inline_--stdout_initial..master^ |    4 ++++
 ...ormat-patch_--inline_--stdout_initial..master^^ |    2 ++
 ...ff.format-patch_--inline_--stdout_initial..side |    2 ++
 10 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index a07812c..cbf2547 100644
--- a/diff.c
+++ b/diff.c
@@ -3223,11 +3223,10 @@ void diff_flush(struct diff_options *options)
 
 	if (output_format & DIFF_FORMAT_PATCH) {
 		if (separator) {
+			putc(options->line_termination, options->file);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
 				fputs(options->stat_sep, options->file);
-			} else {
-				putc(options->line_termination, options->file);
 			}
 		}
 
diff --git a/log-tree.c b/log-tree.c
index 5505606..bd8b9e4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -198,7 +198,7 @@ void log_write_email_headers(struct rev_info *opt, const char *name,
 		extra_headers = subject_buffer;
 
 		snprintf(buffer, sizeof(buffer) - 1,
-			 "--%s%s\n"
+			 "\n--%s%s\n"
 			 "Content-Type: text/x-patch;"
 			 " name=\"%s.diff\"\n"
 			 "Content-Transfer-Encoding: 8bit\n"
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
index cf6891f..43346b9 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
@@ -19,6 +19,8 @@ This is the second commit.
  file2   |    3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
+
+
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
 Content-Transfer-Encoding: 8bit
@@ -75,6 +77,8 @@ Content-Transfer-Encoding: 8bit
  file1   |    3 +++
  2 files changed, 5 insertions(+), 0 deletions(-)
  create mode 100644 file1
+
+
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
 Content-Transfer-Encoding: 8bit
@@ -122,6 +126,8 @@ Content-Transfer-Encoding: 8bit
  file3   |    4 ++++
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
+
+
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
 Content-Transfer-Encoding: 8bit
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
index fe02587..d7490a9 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
@@ -19,6 +19,8 @@ This is the second commit.
  file2   |    3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
+
+
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
 Content-Transfer-Encoding: 8bit
@@ -75,6 +77,8 @@ Content-Transfer-Encoding: 8bit
  file1   |    3 +++
  2 files changed, 5 insertions(+), 0 deletions(-)
  create mode 100644 file1
+
+
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
 Content-Transfer-Encoding: 8bit
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..side b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
index 9ff828e..38f7902 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
@@ -17,6 +17,8 @@ Content-Transfer-Encoding: 8bit
  file3   |    4 ++++
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
+
+
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
 Content-Transfer-Encoding: 8bit
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
index a8093be..fca5cce 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
@@ -19,6 +19,8 @@ This is the second commit.
  file2   |    3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
+
+
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
 Content-Transfer-Encoding: 8bit
@@ -75,6 +77,8 @@ Content-Transfer-Encoding: 8bit
  file1   |    3 +++
  2 files changed, 5 insertions(+), 0 deletions(-)
  create mode 100644 file1
+
+
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
 Content-Transfer-Encoding: 8bit
@@ -122,6 +126,8 @@ Content-Transfer-Encoding: 8bit
  file3   |    4 ++++
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
+
+
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
 Content-Transfer-Encoding: 8bit
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
index aa110c0..6d6fac3 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
@@ -19,6 +19,8 @@ This is the second commit.
  file2   |    3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
+
+
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
 Content-Transfer-Encoding: 8bit
@@ -75,6 +77,8 @@ Content-Transfer-Encoding: 8bit
  file1   |    3 +++
  2 files changed, 5 insertions(+), 0 deletions(-)
  create mode 100644 file1
+
+
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
 Content-Transfer-Encoding: 8bit
@@ -122,6 +126,8 @@ Content-Transfer-Encoding: 8bit
  file3   |    4 ++++
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
+
+
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
 Content-Transfer-Encoding: 8bit
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
index 95e9ea4..18a1110 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
@@ -19,6 +19,8 @@ This is the second commit.
  file2   |    3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
+
+
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
 Content-Transfer-Encoding: 8bit
@@ -75,6 +77,8 @@ Content-Transfer-Encoding: 8bit
  file1   |    3 +++
  2 files changed, 5 insertions(+), 0 deletions(-)
  create mode 100644 file1
+
+
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
 Content-Transfer-Encoding: 8bit
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
index b8e81e1..4f258b8 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
@@ -19,6 +19,8 @@ This is the second commit.
  file2   |    3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
+
+
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
 Content-Transfer-Encoding: 8bit
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..side b/t/t4013/diff.format-patch_--inline_--stdout_initial..side
index 86ae923..e86dce6 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..side
@@ -17,6 +17,8 @@ Content-Transfer-Encoding: 8bit
  file3   |    4 ++++
  3 files changed, 9 insertions(+), 0 deletions(-)
  create mode 100644 file3
+
+
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
 Content-Transfer-Encoding: 8bit
-- 
1.6.0.rc1.166.gbbfa8.dirty
