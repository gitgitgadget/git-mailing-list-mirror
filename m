From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 4/4] reset: handle submodule with trailing slash
Date: Thu, 12 Sep 2013 20:25:01 +0100
Message-ID: <46340e653ef24dec3dcb51e4d88c5ec46f197d82.1379013786.git.john@keeping.me.uk>
References: <cover.1379013786.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>, Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 21:26:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKCWz-0002GT-6W
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 21:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755704Ab3ILT0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 15:26:17 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:42793 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612Ab3ILT0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 15:26:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 5D4BB606516;
	Thu, 12 Sep 2013 20:26:16 +0100 (BST)
X-Quarantine-ID: <IsxtL3CNokWN>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IsxtL3CNokWN; Thu, 12 Sep 2013 20:26:15 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id DFF5960651D;
	Thu, 12 Sep 2013 20:26:15 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 6E11B161E4EE;
	Thu, 12 Sep 2013 20:26:15 +0100 (BST)
X-Quarantine-ID: <aHNi4bD5uhkK>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aHNi4bD5uhkK; Thu, 12 Sep 2013 20:26:14 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 2F1E3161E4AA;
	Thu, 12 Sep 2013 20:26:04 +0100 (BST)
X-Mailer: git-send-email 1.8.4.277.gfbd6843.dirty
In-Reply-To: <cover.1379013786.git.john@keeping.me.uk>
In-Reply-To: <cover.1379013786.git.john@keeping.me.uk>
References: <cover.1378840318.git.john@keeping.me.uk> <cover.1379013786.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234680>

When using tab-completion, a directory path will often end with a
trailing slash which currently confuses "git reset" when dealing with
submodules.  Now that we have parse_pathspec we can easily handle this
by simply adding the PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP flag.

To do this, we need to move the read_cache() call before the
parse_pathspec() call.  All of the existing paths through cmd_reset()
that do not die early already call read_cache() at some point, so there
is no performance impact to doing this in the common case.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 builtin/reset.c            | 8 ++++++--
 t/t7400-submodule-basic.sh | 6 ++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 5e4c551..800117f 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -143,7 +143,6 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.output_format = DIFF_FORMAT_CALLBACK;
 	opt.format_callback = update_index_from_diff;
 
-	read_cache();
 	if (do_diff_cache(tree_sha1, &opt))
 		return 1;
 	diffcore_std(&opt);
@@ -169,7 +168,7 @@ static void set_reflog_message(struct strbuf *sb, const char *action,
 
 static void die_if_unmerged_cache(int reset_type)
 {
-	if (is_merge() || read_cache() < 0 || unmerged_cache())
+	if (is_merge() || unmerged_cache())
 		die(_("Cannot do a %s reset in the middle of a merge."),
 		    _(reset_type_names[reset_type]));
 
@@ -220,8 +219,13 @@ static void parse_args(struct pathspec *pathspec,
 		}
 	}
 	*rev_ret = rev;
+
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
 	parse_pathspec(pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
+		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP |
 		       (patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0),
 		       prefix, argv);
 }
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 4192fe0..c268d3c 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -481,7 +481,7 @@ test_expect_success 'do not add files from a submodule' '
 
 '
 
-test_expect_success 'gracefully add submodule with a trailing slash' '
+test_expect_success 'gracefully add/reset submodule with a trailing slash' '
 
 	git reset --hard &&
 	git commit -m "commit subproject" init &&
@@ -495,7 +495,9 @@ test_expect_success 'gracefully add submodule with a trailing slash' '
 	git add init/ &&
 	test_must_fail git diff --exit-code --cached init &&
 	test $commit = $(git ls-files --stage |
-		sed -n "s/^160000 \([^ ]*\).*/\1/p")
+		sed -n "s/^160000 \([^ ]*\).*/\1/p") &&
+	git reset init/ &&
+	git diff --exit-code --cached init
 
 '
 
-- 
1.8.4.277.gfbd6843.dirty
