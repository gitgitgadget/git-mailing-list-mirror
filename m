From: Max Kirillov <max@max630.net>
Subject: [PATCH v9 1/2] submodule refactor: use strbuf_git_path_submodule() in add_submodule_odb()
Date: Mon, 14 Sep 2015 01:17:41 +0300
Message-ID: <1442182662-28834-2-git-send-email-max@max630.net>
References: <1442182662-28834-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 00:18:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbFbB-0005Ro-AS
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 00:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbbIMWSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 18:18:08 -0400
Received: from p3plsmtpa07-08.prod.phx3.secureserver.net ([173.201.192.237]:50585
	"EHLO p3plsmtpa07-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751893AbbIMWSH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2015 18:18:07 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-08.prod.phx3.secureserver.net with 
	id GmHx1r0035B68XE01mJ57d; Sun, 13 Sep 2015 15:18:07 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1442182662-28834-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277796>

Functions which directly operate submodule's object database do not
handle the case when the submodule is linked worktree (which are
introduced in c7b3a3d2fe). Instead of fixing the path calculation use
already existing strbuf_git_path_submodule() function without changing
overall behaviour. Then it will be possible to modify only that function
whenever we need to change real location of submodule's repository
content.

Edited-by: Jeff King <peff@peff.net>
Signed-off-by: Max Kirillov <max@max630.net>
---
 submodule.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/submodule.c b/submodule.c
index 245ed4d..16b7c35 100644
--- a/submodule.c
+++ b/submodule.c
@@ -124,13 +124,7 @@ static int add_submodule_odb(const char *path)
 	int ret = 0;
 	const char *git_dir;
 
-	strbuf_addf(&objects_directory, "%s/.git", path);
-	git_dir = read_gitfile(objects_directory.buf);
-	if (git_dir) {
-		strbuf_reset(&objects_directory);
-		strbuf_addstr(&objects_directory, git_dir);
-	}
-	strbuf_addstr(&objects_directory, "/objects/");
+	strbuf_git_path_submodule(&objects_directory, path, "objects/");
 	if (!is_directory(objects_directory.buf)) {
 		ret = -1;
 		goto done;
-- 
2.3.4.2801.g3d0809b
