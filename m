From: Samuel Tardieu <sam@rfc1149.net>
Subject: [(v2) PATCH 1/2] tag: Check that options are only allowed in the
	appropriate mode
Date: Wed, 05 Nov 2008 00:20:31 +0100
Message-ID: <20081104232031.19090.47633.stgit@arrakis.enst.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 00:21:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxVDa-0004el-5c
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 00:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042AbYKDXUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 18:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753570AbYKDXUf
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 18:20:35 -0500
Received: from revol1.enst.fr ([137.194.2.7]:64206 "EHLO smtp2.enst.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753197AbYKDXUe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 18:20:34 -0500
Received: from localhost (localhost.enst.fr [127.0.0.1])
	by smtp2.enst.fr (Postfix) with ESMTP id 07CF184445;
	Wed,  5 Nov 2008 00:20:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at enst.fr
Received: from arrakis.enst.fr (arrakis.enst.fr [137.194.161.143])
	by smtp2.enst.fr (Postfix) with ESMTP id C8E9784415;
	Wed,  5 Nov 2008 00:20:31 +0100 (CET)
Received: from arrakis.enst.fr (localhost [127.0.0.1])
	by arrakis.enst.fr (Postfix) with ESMTP id 2895C203DF;
	Wed,  5 Nov 2008 00:20:31 +0100 (CET)
User-Agent: StGIT/unknown-version
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100117>

If "git tag -d -l -v ..." is called, only "-l" is honored, which is
arbitrary and wrong. Also, unrecognized options are accepted in the
wrong modes, causing for example "git tag -n 100" to create a tag
named "100" while the user may have wanted to type "git tag -n100".

This patch checks that "git tag" knows in what mode it operates before
performing any operation and accepts only the related options.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 builtin-tag.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 84db156..d339971 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -344,7 +344,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	const char *object_ref, *tag;
 	struct ref_lock *lock;
 
-	int annotate = 0, sign = 0, force = 0, lines = 0,
+	int annotate = 0, sign = 0, force = 0, lines = -1,
 		list = 0, delete = 0, verify = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
@@ -380,9 +380,19 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	}
 	if (sign)
 		annotate = 1;
+	if (argc == 0 && !(delete || verify))
+		list = 1;
 
+	if ((annotate || msg.given || msgfile || force) &&
+	    (list || delete || verify))
+		usage_with_options(git_tag_usage, options);
+
+	if (list + delete + verify > 1)
+		usage_with_options(git_tag_usage, options);
 	if (list)
-		return list_tags(argv[0], lines);
+		return list_tags(argv[0], lines == -1 ? 0 : lines);
+	if (lines != -1)
+		die("-n option is only allowed with -l.");
 	if (delete)
 		return for_each_tag_name(argv, delete_tag);
 	if (verify)
@@ -406,11 +416,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (argc == 0) {
-		if (annotate)
-			usage_with_options(git_tag_usage, options);
-		return list_tags(NULL, lines);
-	}
 	tag = argv[0];
 
 	object_ref = argc == 2 ? argv[1] : "HEAD";
