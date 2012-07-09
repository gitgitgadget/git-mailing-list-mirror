From: Chris Webb <chris@arachsys.com>
Subject: [PATCH v2] Allow edit of empty message with commit --amend
Date: Mon, 9 Jul 2012 19:53:26 +0100
Message-ID: <20120709185326.GF23859@arachsys.com>
References: <20120709142437.GQ13885@arachsys.com>
 <7v7guclucl.fsf@alter.siamese.dyndns.org>
 <20120709181754.GE23859@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 20:53:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoJ5X-0000jX-Mb
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 20:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975Ab2GISxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 14:53:34 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:40890 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab2GISxd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 14:53:33 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SoJ5Q-0006gv-LE; Mon, 09 Jul 2012 19:53:33 +0100
Content-Disposition: inline
In-Reply-To: <20120709181754.GE23859@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201218>

If git commit --amend is used on a commit with an empty message, it fails
unless -m is given, whether or not --allow-empty-message is specified.

Instead, allow it to proceed to the editor with an empty commit message.
Unless --allow-empty-message is in force, it will still abort later if an
empty message is saved from the editor. (This check was already necessary
to prevent a non-empty commit message being edited to an empty one.)

Add a test for --amend --edit of an empty commit message which fails
without this fix, as it's a rare case that won't get frequently tested
otherwise.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 builtin/commit.c  |    2 +-
 t/t7501-commit.sh |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index f43eaaf..6515da2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -640,7 +640,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		hook_arg1 = "message";
 	} else if (use_message) {
 		buffer = strstr(use_message_buffer, "\n\n");
-		if (!buffer || buffer[2] == '\0')
+		if (!use_editor && (!buffer || buffer[2] == '\0'))
 			die(_("commit has empty message"));
 		strbuf_add(&sb, buffer + 2, strlen(buffer + 2));
 		hook_arg1 = "commit";
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index b20ca0e..5ad636b 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -138,6 +138,21 @@ test_expect_success '--amend --edit' '
 	test_cmp expect msg
 '
 
+test_expect_success '--amend --edit of empty message' '
+	cat >replace <<-\EOF &&
+	#!/bin/sh
+	echo "amended" >"$1"
+	EOF
+	chmod 755 replace &&
+	echo amended >expect &&
+	git commit --allow-empty --allow-empty-message -m "" &&
+	echo more bongo >file &&
+	git add file &&
+	EDITOR=./replace git commit --edit --amend &&
+	git diff-tree -s --format=%s HEAD >msg &&
+	test_cmp expect msg
+'
+
 test_expect_success '-m --edit' '
 	echo amended >expect &&
 	git commit --allow-empty -m buffer &&
-- 
1.7.10
