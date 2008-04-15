From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule - possibly use branch name to describe a module
Date: Mon, 14 Apr 2008 22:48:06 -0400
Message-ID: <1208227686-696-1-git-send-email-mlevedahl@gmail.com>
References: <1208225951-1560-1-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 15 04:49:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlbEJ-0003W4-Pw
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 04:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761556AbYDOCsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 22:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761363AbYDOCsV
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 22:48:21 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:7264 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761354AbYDOCsU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 22:48:20 -0400
Received: by yw-out-2324.google.com with SMTP id 5so864579ywb.1
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 19:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3fS3VsOHNYZCncYtSS6Gf1akt3Iu/Ekp7ayAK2zkTTw=;
        b=el2gyjGEhKFbcId10gNXaOrjbdp2vrLscMo9wlFj/31P3LUxLOkOlhph5ynvjmJI466wm61EGknJEAmJTX9MBrIQhJa3UAGloDHMHd87JXN1yVXf77jvRdeVOiwagoW53wOgN6xpNUsVs41262Ro+qY8Mo4q+mAAXWhG1f3ae6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PHXcHzTXSvnfS66cK0jrsL030Oq73tvoeQOIqvLy6RSsSjMOQANq1lA2WvSvBWC2T4UQAyfTPx0KculJkHMOeQJFaDaOwUeHuNBjYRv5QwyDcXF10xmyoB6q7xHCW7VETmRJTas3QqUXM5vFpY1VjSSWS0VA9aTfGDTyufL3vbU=
Received: by 10.151.112.10 with SMTP id p10mr7097827ybm.143.1208227691827;
        Mon, 14 Apr 2008 19:48:11 -0700 (PDT)
Received: from localhost.localdomain ( [71.163.252.223])
        by mx.google.com with ESMTPS id h34sm27106764wxd.10.2008.04.14.19.48.08
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Apr 2008 19:48:10 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.65.gf482
In-Reply-To: <1208225951-1560-1-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79560>

This changes the search logic for describing a submodule from:
- annotated tag
- any tag
- tag on a subsequent commit
- commit id

to

- annotated tag
- any tag
- tag on a subsequent commit
- local or remote branch
- commit id

The change is describing with respect to a branch before falling
back to the commit id. By itself, git-submodule will maintain submodules
as headless checkouts without ever making a local branch. In
general, such heads can always be described relative to the remote branch
regardless of existence of tags, and so provides a better fallback
summary than just the commit id.

This requires inserting an extra describe step as --contains is
incompatible with --all, but the latter can be used with --always
to fall back to a commit ID. Also, --contains implies --tags, so the
latter is not needed.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
One more try - I mistakenly thought bare describe allowed
local branches, not just tags, so the logic IS different.W Oops.

 git-submodule.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 28509ea..af195a7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -389,7 +389,8 @@ set_name_rev () {
 		cd "$1" && {
 			git describe "$2" 2>/dev/null ||
 			git describe --tags "$2" 2>/dev/null ||
-			git describe --contains --tags --always "$2"
+			git describe --contains "$2" 2>/dev/null ||
+			git describe --all --always "$2"
 		}
 	) )
 	test -z "$revname" || revname=" ($revname)"
--
1.5.5.65.gf482
