From: James Denholm <nod.helm@gmail.com>
Subject: [PATCH v2] contrib/subtree bugfix: Can't `add` annotated tag
Date: Tue, 13 May 2014 14:08:58 +1000
Message-ID: <1399954138-2807-1-git-send-email-nod.helm@gmail.com>
Cc: Kevin Cagle <kcagle@micron.com>,
	Junio C Hamano <gitster@pobox.com>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 06:09:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wk41l-0003Ku-HJ
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 06:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbaEMEJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 00:09:13 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33756 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbaEMEJL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 00:09:11 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so9828448pab.10
        for <git@vger.kernel.org>; Mon, 12 May 2014 21:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XiVpLFg7m/rygRoukMzsFT1RjxYAzAAnmlTVaFRBvHw=;
        b=xE7Y0SvwHsmjODEm1vBjOc+lHypTQfJRlpRMVoolxX1rtSXX//gFduId30hw5M4cRT
         quQgYGDi4eE2T5rDhx1Okvee/KWMAVm3QoAxtVQ7JTrBGynVfSUZbpnvNrktCHblGVkE
         choRxMPkAQkk/XAzFWtm31RFBVyu3J2x/iqAf9+wwXa8FioxQAIFl2rpmosbO0dUkR/I
         NMHSPJ7yhSUtmL74uCysT95Vf2Jfp0ntPH2fWeDET98mq+Ul1zYQCBjBuWnQdmoTt1Xg
         1qUYCVN4q+67PeOJCFnQqPp5haD88jZvM7A+yVQz8TOLFiQGByiqLq7KnXVbr+MUxcBo
         nrkA==
X-Received: by 10.66.227.193 with SMTP id sc1mr61472659pac.102.1399954151124;
        Mon, 12 May 2014 21:09:11 -0700 (PDT)
Received: from pvtjoker.unimelb.edu.au (e-nat-unistudent-0-78.uniaccess.unimelb.edu.au. [128.250.0.78])
        by mx.google.com with ESMTPSA id qh2sm56125685pab.13.2014.05.12.21.09.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 May 2014 21:09:10 -0700 (PDT)
X-Mailer: git-send-email 1.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248745>

cmd_add_commit() is passed FETCH_HEAD by cmd_add_repository, which is
then rev-parsed into an object ID. However, if the user is fetching a
tag rather than a branch HEAD, such as by executing:

$ git subtree add -P oldGit https://github.com/git/git.git tags/v1.8.0

The object ID is a tag and is never peeled, and the git commit-tree call
(line 561) slaps us in the face because it doesn't handle tag IDs.

Because peeling a committish ID doesn't do anything if it's already a
commit, fix by peeling[1] the object ID before assigning it to $rev, as
per the patch.

[*1*]: Via peel_committish(), from git:git-sh-setup.sh, pre-existing
dependency of git-subtree.

Reported-by: Kevin Cagle <kcagle@micron.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: James Denholm <nod.helm@gmail.com>
---
I felt that defining revp would be a little more self-documenting than
using $rev^0.

 contrib/subtree/git-subtree.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index dc59a91..eefd720 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -557,8 +557,9 @@ cmd_add_commit()
 		commit=$(add_squashed_msg "$rev" "$dir" |
 			 git commit-tree $tree $headp -p "$rev") || exit $?
 	else
+		revp=$(peel_committish "$rev")
 		commit=$(add_msg "$dir" "$headrev" "$rev" |
-			 git commit-tree $tree $headp -p "$rev") || exit $?
+			 git commit-tree $tree $headp -p "$revp") || exit $?
 	fi
 	git reset "$commit" || exit $?
 	
-- 
1.9.2
