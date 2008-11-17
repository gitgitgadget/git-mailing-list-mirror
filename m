From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/3] builtin-branch: use strbuf in delete_branches()
Date: Mon, 17 Nov 2008 21:48:35 +0100
Message-ID: <b3716161b2a3d508ec4306623c5c8889d9367e1d.1226954771.git.vmiklos@frugalware.org>
References: <cover.1226954771.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 21:48:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2B1d-00021v-Lu
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 21:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbYKQUre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 15:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbYKQUre
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 15:47:34 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:52934 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbYKQUrd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 15:47:33 -0500
Received: from vmobile.example.net (dsl5401C78D.pool.t-online.hu [84.1.199.141])
	by yugo.frugalware.org (Postfix) with ESMTPA id B7688446CD1;
	Mon, 17 Nov 2008 21:47:31 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 46D4C19D93D; Mon, 17 Nov 2008 21:48:37 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <cover.1226954771.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1226954771.git.vmiklos@frugalware.org>
References: <cover.1226954771.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101241>

In case the length of branch name is greather then PATH_MAX-7, we write
to unallocated memory otherwise.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-branch.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 2b3613f..b9149b7 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -97,7 +97,6 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 	unsigned char sha1[20];
 	char *name = NULL;
 	const char *fmt, *remote;
-	char section[PATH_MAX];
 	int i;
 	int ret = 0;
 
@@ -165,11 +164,12 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 			       argv[i]);
 			ret = 1;
 		} else {
+			struct strbuf buf = STRBUF_INIT;
 			printf("Deleted %sbranch %s.\n", remote, argv[i]);
-			snprintf(section, sizeof(section), "branch.%s",
-				 argv[i]);
-			if (git_config_rename_section(section, NULL) < 0)
+			strbuf_addf(&buf, "branch.%s", argv[i]);
+			if (git_config_rename_section(buf.buf, NULL) < 0)
 				warning("Update of config-file failed");
+			strbuf_release(&buf);
 		}
 	}
 
-- 
1.6.0.2
