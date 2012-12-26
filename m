From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] wt-status: Show ignored files in untracked dirs
Date: Wed, 26 Dec 2012 11:16:25 +0100
Message-ID: <1356516985-31068-1-git-send-email-apelisse@gmail.com>
References: <50DA91AF.1060200@alum.mit.edu>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 26 11:18:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tno46-0000o4-Vs
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 11:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225Ab2LZKQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 05:16:35 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38485 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984Ab2LZKQe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 05:16:34 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so7126780wib.1
        for <git@vger.kernel.org>; Wed, 26 Dec 2012 02:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=/dT4UxTBdrx8WBaiDklF3jfnp4lDcQPq0WGilj8RWHo=;
        b=y/SYtHfrJHK9NIDnRL2DT0TfKLlKmdGRIdIG9NgHEmXafiKT9sx8o+4uxvT/WeYrqv
         2NQ9VZh2b7vQnr8DT0tCeiFDINXuGdDKHOSfgjuHV5eZ6l3ROezQm6dsjebFVl5hHlfB
         MIwAAvGEIciun5RO9+aHssFd3EHS15DLTugylpeTOf32PVpJTQEsk7d3RzrzdzyK2tON
         W0nC8Ijfh+qGZrhJ5HbFeMqE5Ufet+JAp6TdXOkTP9zoD2nUaL1Z8VmjbNtWKDwSrDdU
         rFfCea7atFfGlz5tWximo/ryvETjtELgKHzkQO3Yzjpj5qGr3VBBKRiuNpoyqmMy0ouP
         dONg==
X-Received: by 10.180.86.39 with SMTP id m7mr41903545wiz.1.1356516992551;
        Wed, 26 Dec 2012 02:16:32 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id s16sm47616407wii.0.2012.12.26.02.16.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 26 Dec 2012 02:16:31 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.11.g86c3e6e.dirty
In-Reply-To: <50DA91AF.1060200@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212133>

When looking for ignored files, we do not recurse into untracked
directory, and simply consider the directory ignored status.
As a consequence, we don't see ignored files in those directories.

Change that behavior by recursing into untracked directories searching
for ignored files.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
I jumped in.

This seems to be broken since the creation of the --ignored option to
wt-status.

This fixes the issue and breaks none of the existing tests.
The behavior seems sane to me, giving something like that:

  ?? .gitignore
  ?? x
  ?? y/foo
  !! x.ignore-me
  !! y/foo.ignore-me

Cheers,
Antoine

 wt-status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 2a9658b..7c41488 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -516,7 +516,7 @@ static void wt_status_collect_untracked(struct wt_status *s)

 	if (s->show_ignored_files) {
 		dir.nr = 0;
-		dir.flags = DIR_SHOW_IGNORED | DIR_SHOW_OTHER_DIRECTORIES;
+		dir.flags = DIR_SHOW_IGNORED;
 		fill_directory(&dir, s->pathspec);
 		for (i = 0; i < dir.nr; i++) {
 			struct dir_entry *ent = dir.entries[i];
--
1.8.1.rc3.11.g86c3e6e.dirty
