From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] clone: fix repo name when cloning a server's root
Date: Mon, 27 Jul 2015 13:48:28 +0200
Message-ID: <1437997708-10732-1-git-send-email-ps@pks.im>
Cc: peff@peff.net, pclouds@gmail.com, ps@pks.im
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 13:58:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJh2g-0001er-T2
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 13:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbbG0L57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 07:57:59 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58214 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752188AbbG0L55 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jul 2015 07:57:57 -0400
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jul 2015 07:57:57 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id CAAFC201E2
	for <git@vger.kernel.org>; Mon, 27 Jul 2015 07:48:30 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 27 Jul 2015 07:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=K1qgkygRePm+q12JJXqP/xpVzc
	w=; b=gJ/2UgK/l0CLohcqFOrNOl4cHqPL+RiQzT4LKP+zViUNK2lxqq6zRLXuqG
	flnzFCxNaj5p/akanf/cTrb2oUYN03GJIx5gRtptDwhyV8ncfRH9hNkIwpbW2DWd
	Cozb61vkB+/PzpnJr3byL9kk/5bjya1Mfh8DD5WVvXMLBfLUE=
X-Sasl-enc: gTHQ8o6BQv/ILNptmlppaRoxcMDVoVH83i3I7H3Ubddp 1437997710
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 588346800B9;
	Mon, 27 Jul 2015 07:48:30 -0400 (EDT)
X-Mailer: git-send-email 2.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274669>

When cloning a repository from a server's root, that is the URL's
path component is a '/' only, we fail to generate a sensible
repository name when the URL contains authentication data. This
is especially bad when cloning URLs like
'ssh://user:passwd@example.com/', which results in a repository
'passwd@example.com' being created.

Improve the behavior by also regarding '@'-signs as a separator
when scanning the URL. In the mentioned case this would instead
result in a directory 'example.com' being created.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
I was not able to come by with a useful test as that would
require being able to clone a root directory. I couldn't find
anything in the current tests that looks like what I want to do.
Does anybody have an idea on how to achieve this?

 builtin/clone.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a72ff7e..aaf38b2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -164,11 +164,13 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 
 	/*
 	 * Find last component, but be prepared that repo could have
-	 * the form  "remote.example.com:foo.git", i.e. no slash
-	 * in the directory part.
+	 * the form  "remote.example.com:foo.git", i.e. no slash in
+	 * the directory part, or "user:password@remote.example.com/",
+	 * that is the path component may be empty.
 	 */
 	start = end;
-	while (repo < start && !is_dir_sep(start[-1]) && start[-1] != ':')
+	while (repo < start && !is_dir_sep(start[-1]) && start[-1] != ':'
+			&& start[-1] != '@')
 		start--;
 
 	/*
-- 
2.4.6
