From: Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH 1/3] tag: Do not allow to call "git tag" in more than one
	operating mode
Date: Tue, 04 Nov 2008 13:42:07 +0100
Message-ID: <20081104124207.18273.31679.stgit@arrakis.enst.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 13:43:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxLFt-0000wg-Rl
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 13:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbYKDMmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 07:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752915AbYKDMmP
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 07:42:15 -0500
Received: from revol2.enst.fr ([137.194.2.14]:57220 "EHLO smtp2.enst.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694AbYKDMmN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 07:42:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp2.enst.fr (Postfix) with ESMTP id 9BB28B8247;
	Tue,  4 Nov 2008 13:42:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at enst.fr
Received: from arrakis.enst.fr (arrakis.enst.fr [137.194.161.143])
	by smtp2.enst.fr (Postfix) with ESMTP id 6CF8DB8272;
	Tue,  4 Nov 2008 13:42:07 +0100 (CET)
Received: from arrakis.enst.fr (localhost [127.0.0.1])
	by arrakis.enst.fr (Postfix) with ESMTP id 63825203DF;
	Tue,  4 Nov 2008 13:42:07 +0100 (CET)
User-Agent: StGIT/unknown-version
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100071>

If "git tag -d -l -v ..." is called, only "-l" is honored, which is
arbitrary and wrong.

This patch checks that "git tag" knows in what mode it operates before
performing any operation.

Signed-Off-By: Samuel Tardieu <sam@rfc1149.net>
---
 builtin-tag.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 84db156..5ce0e21 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -380,7 +380,11 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	}
 	if (sign)
 		annotate = 1;
+	if (argc == 0 && !(delete || verify))
+		list = 1;
 
+	if (list + delete + verify > 1)
+		usage_with_options(git_tag_usage, options);
 	if (list)
 		return list_tags(argv[0], lines);
 	if (delete)
@@ -406,11 +410,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (argc == 0) {
-		if (annotate)
-			usage_with_options(git_tag_usage, options);
-		return list_tags(NULL, lines);
-	}
 	tag = argv[0];
 
 	object_ref = argc == 2 ? argv[1] : "HEAD";
