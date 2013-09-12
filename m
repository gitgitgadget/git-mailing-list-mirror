From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 3/4] rm: re-use parse_pathspec's trailing-slash removal
Date: Thu, 12 Sep 2013 20:25:00 +0100
Message-ID: <238adf049ede4f54baad1b78fceff4de8313c4a6.1379013786.git.john@keeping.me.uk>
References: <cover.1379013786.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>, Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 21:26:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKCWq-00028N-La
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 21:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618Ab3ILT0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 15:26:07 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:46893 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612Ab3ILT0G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 15:26:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 109C7CDA5F6;
	Thu, 12 Sep 2013 20:26:06 +0100 (BST)
X-Quarantine-ID: <0Bep1SjQroNO>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Bep1SjQroNO; Thu, 12 Sep 2013 20:26:05 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 852A1CDA5E1;
	Thu, 12 Sep 2013 20:26:05 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 1FE1B161E478;
	Thu, 12 Sep 2013 20:26:05 +0100 (BST)
X-Quarantine-ID: <o2ZFVZVBndhp>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o2ZFVZVBndhp; Thu, 12 Sep 2013 20:26:04 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 7650E161E582;
	Thu, 12 Sep 2013 20:25:54 +0100 (BST)
X-Mailer: git-send-email 1.8.4.277.gfbd6843.dirty
In-Reply-To: <cover.1379013786.git.john@keeping.me.uk>
In-Reply-To: <cover.1379013786.git.john@keeping.me.uk>
References: <cover.1378840318.git.john@keeping.me.uk> <cover.1379013786.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234679>

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
1.8.4.277.gfbd6843.dirty
