From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/2] rm: re-use parse_pathspec's trailing-slash removal
Date: Tue, 10 Sep 2013 20:13:18 +0100
Message-ID: <b16901cdc3d433a8e0f7078475cb06f90b4590dd.1378840318.git.john@keeping.me.uk>
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
	id 1VJTNn-0000Yg-Ne
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 21:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098Ab3IJTNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 15:13:49 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:46686 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab3IJTNs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 15:13:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 871C36064EC;
	Tue, 10 Sep 2013 20:13:48 +0100 (BST)
X-Quarantine-ID: <RVSMgf4wLPio>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RVSMgf4wLPio; Tue, 10 Sep 2013 20:13:48 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 69D566064A7;
	Tue, 10 Sep 2013 20:13:40 +0100 (BST)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <cover.1378840318.git.john@keeping.me.uk>
In-Reply-To: <cover.1378840318.git.john@keeping.me.uk>
References: <cover.1378840318.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234471>

Instead of re-implementing the "remove trailing slashes" loop in
builtin/rm.c just pass PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP to
parse_pathspec.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 builtin/rm.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 9b59ab3..3a0e0ea 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -298,22 +298,10 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
-	/*
-	 * Drop trailing directory separators from directories so we'll find
-	 * submodules in the index.
-	 */
-	for (i = 0; i < argc; i++) {
-		size_t pathlen = strlen(argv[i]);
-		if (pathlen && is_dir_sep(argv[i][pathlen - 1]) &&
-		    is_directory(argv[i])) {
-			do {
-				pathlen--;
-			} while (pathlen && is_dir_sep(argv[i][pathlen - 1]));
-			argv[i] = xmemdupz(argv[i], pathlen);
-		}
-	}
-
-	parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD, prefix, argv);
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_CWD |
+		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
+		       prefix, argv);
 	refresh_index(&the_index, REFRESH_QUIET, &pathspec, NULL, NULL);
 
 	seen = xcalloc(pathspec.nr, 1);
-- 
1.8.2
