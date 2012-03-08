From: Dominique Quatravaux <domq@google.com>
Subject: [PATCH 1/2] rebase -i: optimize the creation of the todo file
Date: Thu,  8 Mar 2012 11:42:37 +0100
Message-ID: <1331203358-28277-1-git-send-email-domq@google.com>
Cc: Dominique Quatravaux <domq@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 11:43:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5aoL-0004cZ-LI
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 11:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261Ab2CHKnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 05:43:00 -0500
Received: from mail-gx0-f202.google.com ([209.85.161.202]:51060 "EHLO
	mail-gx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab2CHKm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 05:42:59 -0500
Received: by ggnd2 with SMTP id d2so36142ggn.1
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 02:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=YB9zXbFftrn/3v5RbqFD5xK9+plX9v/cVqiqmkCZCm8=;
        b=ZVzGe9F8mmjYquRKLvBqTDCa0gncrzchD8wUV+I3Q5MXqw9cJId+C6olmqJUWPP+Mk
         B9PIJYL9zV/4p+zSne1M9HyK6QvRsbZEQvyh4Dpk1aMQrunGpuTRGEmh+rNoTRQO6TE7
         cOKGuIloBIXdNB465YfuRuHiCChpKTQav8I83lt4ECeaSzyVz8AJLfR7RWjbi3mxcQbu
         kw5/AO2gox35q3iXVhhQplvnMD9+RDgXtjaYKAEMSfVfwsEzaLdYjQHurDrslSPHgII9
         q0Wt1iuvPIma3PGzU40ZOlTK6buqncPPIXAyJmD21nU1mOKLcuzEyaiOfsdO4hMvhpXU
         OmwA==
Received: by 10.101.133.40 with SMTP id k40mr527659ann.17.1331203379271;
        Thu, 08 Mar 2012 02:42:59 -0800 (PST)
Received: by 10.101.133.40 with SMTP id k40mr527647ann.17.1331203379186;
        Thu, 08 Mar 2012 02:42:59 -0800 (PST)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id g49si802194yhe.6.2012.03.08.02.42.59
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 08 Mar 2012 02:42:59 -0800 (PST)
Received: from alliance-maui.zrh.corp.google.com (alliance-maui.zrh.corp.google.com [172.28.204.12])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 0D6C310004D;
	Thu,  8 Mar 2012 02:42:59 -0800 (PST)
Received: by alliance-maui.zrh.corp.google.com (Postfix, from userid 71297)
	id 84FA7603B6; Thu,  8 Mar 2012 11:42:58 +0100 (CET)
X-Mailer: git-send-email 1.7.7.3
X-Gm-Message-State: ALoCoQlqNehUR1BIboFwQZ5RzvSxitlawDmfv/77TDnUj2Z+Jkeo8HXxqo3NNk6ZOMAYbgbbFaUkeAIflq/zSct8ewFsQdVZv2AYTFLHUusYjNZYudi+OeaKz9GkJdh6sL+0UoVkbaaR20BPMviJt++Fdip5ix4vkjKOLLhp8GpUetiRpBG7j4E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192556>

Instead of obtaining short SHA1's from "git rev-list" and hitting the repository
once more with "git rev-parse" for the full-size SHA1's, obtain long SHA1's from
"git rev-list" and truncate them with "cut".
---
 git-rebase--interactive.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5812222..8dcb8b0 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -774,17 +774,17 @@ else
 	revisions=$onto...$orig_head
 	shortrevisions=$shorthead
 fi
-git rev-list $merges_option --pretty=oneline --abbrev-commit \
-	--abbrev=7 --reverse --left-right --topo-order \
+git rev-list $merges_option --pretty=oneline --no-abbrev-commit \
+	--reverse --left-right --topo-order \
 	$revisions | \
 	sed -n "s/^>//p" |
-while read -r shortsha1 rest
+while read -r sha1 rest
 do
+	shortsha1=$(echo $sha1 | cut -c1-7)
 	if test t != "$preserve_merges"
 	then
 		printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
 	else
-		sha1=$(git rev-parse $shortsha1)
 		if test -z "$rebase_root"
 		then
 			preserve=t
-- 
1.7.7.3
