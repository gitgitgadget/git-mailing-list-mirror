From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/2] reset: handle submodule with trailing slash
Date: Tue, 10 Sep 2013 20:13:17 +0100
Message-ID: <c7e026f44f9ccbf5736b72e728a360b31887a50f.1378840318.git.john@keeping.me.uk>
References: <cover.1378840318.git.john@keeping.me.uk>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 10 21:13:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJTNn-0000Yg-6X
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 21:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389Ab3IJTNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 15:13:42 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:46624 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab3IJTNl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 15:13:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 2C09E6064CC;
	Tue, 10 Sep 2013 20:13:41 +0100 (BST)
X-Quarantine-ID: <RYURCC5M0Ubg>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RYURCC5M0Ubg; Tue, 10 Sep 2013 20:13:40 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 11650606506;
	Tue, 10 Sep 2013 20:13:33 +0100 (BST)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <cover.1378840318.git.john@keeping.me.uk>
In-Reply-To: <cover.1378840318.git.john@keeping.me.uk>
References: <cover.1378840318.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234472>

When using tab-completion, a directory path will often end with a
trailing slash which currently confuses "git rm" when dealing with
submodules.  Now that we have parse_pathspec we can easily handle this
by simply adding the PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP flag.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 builtin/reset.c            | 5 +++++
 t/t7400-submodule-basic.sh | 6 ++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 5e4c551..9efac0f 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -220,8 +220,13 @@ static void parse_args(struct pathspec *pathspec,
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
1.8.2
