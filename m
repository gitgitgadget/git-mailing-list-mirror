From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH] git-rebase--interactive.sh: preserve-merges fails on merges created with no-ff
Date: Wed, 20 Apr 2011 23:38:00 -0400
Message-ID: <1303357080-25840-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 05:38:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCkiw-0006dn-9K
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 05:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909Ab1DUDi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 23:38:29 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33809 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775Ab1DUDi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 23:38:28 -0400
Received: by yxs7 with SMTP id 7so390658yxs.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 20:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=tOi96grp2ZyseTFD04ZphSsqAiM/yQ6DTpeSmqNKJh0=;
        b=vC92cA0nJrN8bCdGCHtCBCt7xLIaCpfnN6JkyWAtzUw2ZCKEwcm+1s/eoX0nZ8+gd+
         iZMk5dn2xJ2huiF30UYGVEqAkp1d2XF19GzW/74rPaokTkvJpDNYSP42fj5BgmWlAyoc
         dBtEpYvXU6StsusFHAcmHsQrn7fOKwrKoGjQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=iin/7JyQSBWjIqmqIY/av/vzs980HbTyy8Vsc3S2Tj4iSPwjCjZyLey/GlRR5feieL
         oEmXeZthjXLmD6VFDGvORLKPoQbP6dYyUCqrQYVgZRFA9n3wBOcF+ebq8Szwni7iIMXE
         ZJdINmG7l2JMxIv1BhoH9DWC+wFunglSDj0WQ=
Received: by 10.150.214.11 with SMTP id m11mr108196ybg.254.1303357108212;
        Wed, 20 Apr 2011 20:38:28 -0700 (PDT)
Received: from localhost.localdomain (CPE687f74883d54-CM001692fb632e.cpe.net.cable.rogers.com [99.231.190.188])
        by mx.google.com with ESMTPS id v35sm1989870yba.19.2011.04.20.20.38.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Apr 2011 20:38:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171892>

'git rebase' uses 'git merge' to preserve merges (-p).  This preserves
the original merge commit correctly, except when the original merge
commit was created by 'git merge --no-ff'.  In this case, 'git rebase'
will fail to preserve the merge, because during 'git rebase', 'git
merge' will simply fast-forward and skip the commit.  For example:

               B
              / \
             A---M
            /
    ---o---O---P---Q

If we try to rebase M onto P, we lose the merge commit and this happens:

                 A---B
                /
    ---o---O---P---Q

To correct this, we simply do a "no fast-forward" on all merge commits
when rebasing.  Since by the time we decided to do a 'git merge' inside
'git rebase', it means there was a merge originally, so 'git merge'
should always create a merge commit regardless of what the merge
branches look like. This way, when rebase M onto P from the above
example, we get:

                   B
                  / \
                 A---M
                /
    ---o---O---P---Q

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5873ba4..c308529 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -339,7 +339,7 @@ pick_one_preserving_merges () {
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
 			if ! do_with_author output \
-				git merge $STRATEGY -m "$msg" $new_parents
+				git merge --no-ff $STRATEGY -m "$msg" $new_parents
 			then
 				printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
 				die_with_patch $sha1 "Error redoing merge $sha1"
-- 
1.7.2.2
