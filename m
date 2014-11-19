From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFD/PATCH] add: ignore only ignored files
Date: Wed, 19 Nov 2014 15:52:33 +0100
Message-ID: <3f78d6c1e35c87049daaac6cb1257ea8310a90bb.1416408015.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 15:52:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xr6ca-0003ut-NN
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 15:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080AbaKSOwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 09:52:36 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33009 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754004AbaKSOwg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Nov 2014 09:52:36 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 54AAE206F9
	for <git@vger.kernel.org>; Wed, 19 Nov 2014 09:52:35 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 19 Nov 2014 09:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:subject:date
	:message-id; s=smtpout; bh=LwVjvmSPk5+N9kMzCltFnHJ8EO0=; b=U18aA
	WWT/j4EAD2pHLLwpS3kdnNTURpQriVrMjFiM1SEkGojK9ATyrWRFRALmnUrIiECW
	61pQo0FarepinxHPzbJA1RwyBWK9OqiaA0h9aDcnndoULukL+CVx7sdi5tBcHEgk
	+R7QQ2wnDYc1+I5gAXVjoJTg4ABoZlf8uli9fg=
X-Sasl-enc: ISb67wE54hbzXwBR2Y7UZ63JuB21MxmjMuF6W3vgmfYh 1416408754
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E3369C0000E;
	Wed, 19 Nov 2014 09:52:34 -0500 (EST)
X-Mailer: git-send-email 2.2.0.rc2.293.gc05a35d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git add foo bar" adds neither foo nor bar when bar is ignored, but dies
to let the user recheck their command invocation. This becomes less
helpful when "git add foo.*" is subject to shell expansion and some of
the expanded files are ignored.

"git add --ignore-errors" is supposed to ignore errors when indexing
some files and adds the others. It does ignore errors from actual
indexing attempts, but does not ignore the error "file is ignored" as
outlined above.

Change "git add --ignore-errors foo bar" to add foo when bar is ignored,
i.e. to ignore the ignore error.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Thus buggs me whenever I add a new TeX project when there are *.aux and
*.log around also[*]. Aside from that personal itch: For a user reading the
documentation, the difference between "thinking about indexing a file"
and "technically indexing a file" is probably irrelevant, and most would
expect "git add --ignore-errors" to ignore the "file is ignored" error
as well and continue adding the remaining files.

This is a behaviour change, though (albeit only for the option/config case),
so it's RFD. If the direction is OK a test would be in order.

We could add yet another ignore option, of course, which just screams to be called
--ignore-ignored, along with a config add.ignoreIgnored. I dunno...

[*] And who wants to quote their *, really? ;)

 builtin/add.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index ae6d3e2..8cadb71 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -284,7 +284,9 @@ static int add_files(struct dir_struct *dir, int flags)
 		for (i = 0; i < dir->ignored_nr; i++)
 			fprintf(stderr, "%s\n", dir->ignored[i]->name);
 		fprintf(stderr, _("Use -f if you really want to add them.\n"));
-		die(_("no files added"));
+		if (!ignore_add_errors)
+			die(_("no files added"));
+		exit_status = 1;
 	}
 
 	for (i = 0; i < dir->nr; i++)
-- 
2.2.0.rc2.293.gc05a35d
