From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] diff: fix "git show -C -C" output when renaming a binary file
Date: Wed, 26 May 2010 04:50:12 +0200
Message-ID: <20100526025013.25696.26816.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Greg Bacon <gbacon@dbresearch.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 26 04:55:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH6mC-0007WO-Im
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 04:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933557Ab0EZCzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 22:55:17 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:55602 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933501Ab0EZCzP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 22:55:15 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6E996818057;
	Wed, 26 May 2010 04:55:08 +0200 (CEST)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP;
	Wed, 26 May 2010 04:55:06 +0200 (CEST)
X-git-sha1: c85669bcd5802829602d15a88396981f12c7fd93 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147732>

A bug was introduced in 3e97c7c6af2901cec63bf35fcd43ae3472e24af8
(No diff -b/-w output for all-whitespace changes, Nov 19 2009)
that made the lines:

diff --git a/bar b/sub/bar
similarity index 100%
rename from bar
rename to sub/bar

disappear from "git show -C -C" output when file bar is a binary
file.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 diff.c                        |    4 +++
 t/t4043-diff-rename-binary.sh |   45 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 0 deletions(-)
 create mode 100755 t/t4043-diff-rename-binary.sh

diff --git a/diff.c b/diff.c
index 494f560..0b00271 100644
--- a/diff.c
+++ b/diff.c
@@ -1737,6 +1737,10 @@ static void builtin_diff(const char *name_a,
 						textconv_one, textconv_two, o);
 			o->found_changes = 1;
 			goto free_ab_and_return;
+		} else if (diff_filespec_is_binary(one) &&
+			   diff_filespec_is_binary(two)) {
+			fprintf(o->file, "%s", header.buf);
+			strbuf_reset(&header);
 		}
 	}
 
diff --git a/t/t4043-diff-rename-binary.sh b/t/t4043-diff-rename-binary.sh
new file mode 100755
index 0000000..0601281
--- /dev/null
+++ b/t/t4043-diff-rename-binary.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Jakub Narebski, Christian Couder
+#
+
+test_description='Move a binary file'
+
+. ./test-lib.sh
+
+
+test_expect_success 'prepare repository' '
+	git init &&
+	echo foo > foo &&
+	echo "barQ" | q_to_nul > bar &&
+	git add . &&
+	git commit -m "Initial commit"
+'
+
+test_expect_success 'move the files into a "sub" directory' '
+	mkdir sub &&
+	git mv bar foo sub/ &&
+	git commit -m "Moved to sub/"
+'
+
+cat > expected <<\EOF
+ bar => sub/bar |  Bin 5 -> 5 bytes
+ foo => sub/foo |    0
+ 2 files changed, 0 insertions(+), 0 deletions(-)
+
+diff --git a/bar b/sub/bar
+similarity index 100%
+rename from bar
+rename to sub/bar
+diff --git a/foo b/sub/foo
+similarity index 100%
+rename from foo
+rename to sub/foo
+EOF
+
+test_expect_success 'git show -C -C report renames' '
+	git show -C -C --raw --binary --stat | tail -n 12 > current &&
+	test_cmp expected current
+'
+
+test_done
-- 
1.7.1.226.g770c5.dirty
