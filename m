From: Anders Waldenborg <anders.waldenborg@gmail.com>
Subject: [PATCH] diff: Add diff.orderfile configuration variable
Date: Mon, 21 Oct 2013 12:31:59 +0200
Message-ID: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 21 12:32:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYCmT-0004ob-SW
	for gcvg-git-2@plane.gmane.org; Mon, 21 Oct 2013 12:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006Ab3JUKcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Oct 2013 06:32:00 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:47458 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858Ab3JUKb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Oct 2013 06:31:59 -0400
Received: by mail-ie0-f178.google.com with SMTP id to1so15275619ieb.9
        for <git@vger.kernel.org>; Mon, 21 Oct 2013 03:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=7UQ7XtDoo7eQLDbdcGOff3PfNtMwWko5M1KyNXSdkjE=;
        b=dBMwF4XbgOUUp2gEIMXHfY5f00llqP1ORCq/Bpso0JzgsY7I0KedUMQzF88qduf/u7
         /4ltKfi4RzycP6w9TVGIp0eVbDsdvAvkZGIyXHKiZ2lezuEQzhBzmoWKvNleTlS2A/Yh
         /tGJ23pYnogBWEVyIqLOVigl9N0G4g3pUman5eDg+iVBdscPvU5lpy3ZOQOboeJz/Ng3
         kbWo25WsJGMeeYMncyigbN8OJpf8T7ZCbo0MiS4/5SAw+BmS4PsVEmJ735U/fhndlKCH
         SkfzfCzPr7nKB9bomDKnMwHrdInb9XcaZXxTzTzi6M7ARN2haDKt+bzsevVHxbaaRTxE
         qgDg==
X-Received: by 10.50.61.179 with SMTP id q19mr8718351igr.33.1382351519250;
 Mon, 21 Oct 2013 03:31:59 -0700 (PDT)
Received: by 10.64.59.33 with HTTP; Mon, 21 Oct 2013 03:31:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236427>

diff.orderfile acts as a default for the -O command line option.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---

 Documentation/diff-config.txt |  4 +++
 diff.c                        |  5 +++
 t/t4056-diff-order.sh         | 74 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100755 t/t4056-diff-order.sh

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 223b931..51f9190 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -98,6 +98,10 @@ diff.mnemonicprefix::
 diff.noprefix::
  If set, 'git diff' does not show any source or destination prefix.

+diff.orderfile::
+ Path to file to use for ordering the files in the diff, each line
+ is a shell glob pattern; equivalent to the 'git diff' option '-O'.
+
 diff.renameLimit::
  The number of files to consider when performing the copy/rename
  detection; equivalent to the 'git diff' option '-l'.
diff --git a/diff.c b/diff.c
index a04a34d..e66f031 100644
--- a/diff.c
+++ b/diff.c
@@ -30,6 +30,7 @@ static int diff_use_color_default = -1;
 static int diff_context_default = 3;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
+static const char *diff_order_file_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
@@ -201,6 +202,8 @@ int git_diff_ui_config(const char *var, const char
*value, void *cb)
  return git_config_string(&external_diff_cmd_cfg, var, value);
  if (!strcmp(var, "diff.wordregex"))
  return git_config_string(&diff_word_regex_cfg, var, value);
+ if (!strcmp(var, "diff.orderfile"))
+ return git_config_string(&diff_order_file_cfg, var, value);

  if (!strcmp(var, "diff.ignoresubmodules"))
  handle_ignore_submodules_arg(&default_diff_options, value);
@@ -3207,6 +3210,8 @@ void diff_setup(struct diff_options *options)
  options->detect_rename = diff_detect_rename_default;
  options->xdl_opts |= diff_algorithm;

+ options->orderfile = diff_order_file_cfg;
+
  if (diff_no_prefix) {
  options->a_prefix = options->b_prefix = "";
  } else if (!diff_mnemonic_prefix) {
diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
new file mode 100755
index 0000000..fd005d6
--- /dev/null
+++ b/t/t4056-diff-order.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+
+test_description='diff order'
+
+. ./test-lib.sh
+
+_test_create_files () {
+ mkdir c
+ echo "$1" >a.h
+ echo "$1" >b.c
+ echo "$1" >c/Makefile
+ echo "$1" >d.txt
+ git add a.h b.c c/Makefile d.txt && \
+ git commit -m"$1"
+}
+
+cat >order_file_1 <<EOF
+*Makefile
+*.txt
+*.h
+*
+EOF
+cat >order_file_2 <<EOF
+*.h
+*.c
+*Makefile
+*
+EOF
+
+cat >expect_diff_headers_none <<EOF
+diff --git a/a.h b/a.h
+diff --git a/b.c b/b.c
+diff --git a/c/Makefile b/c/Makefile
+diff --git a/d.txt b/d.txt
+EOF
+
+cat >expect_diff_headers_1 <<EOF
+diff --git a/c/Makefile b/c/Makefile
+diff --git a/d.txt b/d.txt
+diff --git a/a.h b/a.h
+diff --git a/b.c b/b.c
+EOF
+
+cat >expect_diff_headers_2 <<EOF
+diff --git a/a.h b/a.h
+diff --git a/b.c b/b.c
+diff --git a/c/Makefile b/c/Makefile
+diff --git a/d.txt b/d.txt
+EOF
+
+test_expect_success "setup" '_test_create_files 1 && _test_create_files 2'
+
+test_expect_success "no order (=tree object order)" '
+ git diff HEAD^..HEAD | grep ^diff >actual_diff_headers &&
+ test_debug actual_diff_headers
+ test_cmp expect_diff_headers_none actual_diff_headers'
+
+test_expect_success "orderfile using option" '
+ git diff -Oorder_file_1 HEAD^..HEAD | grep ^diff >actual_diff_headers &&
+ test_debug actual_diff_headers
+ test_cmp expect_diff_headers_1 actual_diff_headers &&
+ git diff -Oorder_file_2 HEAD^..HEAD | grep ^diff >actual_diff_headers &&
+ test_debug actual_diff_headers
+ test_cmp expect_diff_headers_2 actual_diff_headers'
+
+test_expect_success "orderfile using config" '
+ git -c diff.orderfile=order_file_1 diff HEAD^..HEAD | grep ^diff
>actual_diff_headers &&
+ test_debug actual_diff_headers
+ test_cmp expect_diff_headers_1 actual_diff_headers &&
+ git -c diff.orderfile=order_file_2 diff HEAD^..HEAD | grep ^diff
>actual_diff_headers &&
+ test_debug actual_diff_headers
+ test_cmp expect_diff_headers_2 actual_diff_headers'
+
+test_done
-- 
1.8.4.1.559.gdb9bdfb.dirty
