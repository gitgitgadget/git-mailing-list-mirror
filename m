From: Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH 2/3] tag: Check that options are only allowed in the
	appropriate mode
Date: Tue, 04 Nov 2008 13:42:12 +0100
Message-ID: <20081104124212.18273.5402.stgit@arrakis.enst.fr>
References: <20081104124207.18273.31679.stgit@arrakis.enst.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 13:43:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxLFv-0000wg-Vb
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 13:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbYKDMmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 07:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbYKDMmS
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 07:42:18 -0500
Received: from revol1.enst.fr ([137.194.2.7]:50087 "EHLO smtp2.enst.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864AbYKDMmP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 07:42:15 -0500
Received: from localhost (localhost.enst.fr [127.0.0.1])
	by smtp2.enst.fr (Postfix) with ESMTP id A83C184426;
	Tue,  4 Nov 2008 13:42:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at enst.fr
Received: from arrakis.enst.fr (arrakis.enst.fr [137.194.161.143])
	by smtp2.enst.fr (Postfix) with ESMTP id 744338441A;
	Tue,  4 Nov 2008 13:42:12 +0100 (CET)
Received: from arrakis.enst.fr (localhost [127.0.0.1])
	by arrakis.enst.fr (Postfix) with ESMTP id 6DA81203DF;
	Tue,  4 Nov 2008 13:42:12 +0100 (CET)
In-Reply-To: <20081104124207.18273.31679.stgit@arrakis.enst.fr>
User-Agent: StGIT/unknown-version
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100072>

"git tag" should not silently accept unrecognized options when operating
in a given mode. For example, "git tag -n 100", which may be a typo for
"git tag -n100", should not silently create a tag named "100".

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 builtin-tag.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 5ce0e21..d339971 100644
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
@@ -383,10 +383,16 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (argc == 0 && !(delete || verify))
 		list = 1;
 
+	if ((annotate || msg.given || msgfile || force) &&
+	    (list || delete || verify))
+		usage_with_options(git_tag_usage, options);
+
 	if (list + delete + verify > 1)
 		usage_with_options(git_tag_usage, options);
 	if (list)
-		return list_tags(argv[0], lines);
+		return list_tags(argv[0], lines == -1 ? 0 : lines);
+	if (lines != -1)
+		die("-n option is only allowed with -l.");
 	if (delete)
 		return for_each_tag_name(argv, delete_tag);
 	if (verify)
