From: Tuomas Suutari <tuomas.suutari@gmail.com>
Subject: [PATCH 3/3 v2] git-svn: Fix discarding of extra parents from svn:mergeinfo
Date: Mon, 22 Feb 2010 20:12:53 +0200
Message-ID: <1266862373-28365-1-git-send-email-tuomas.suutari@gmail.com>
References: <1266825442-32107-4-git-send-email-tuomas.suutari@gmail.com>
Cc: Tuomas Suutari <tuomas.suutari@gmail.com>,
	Sam Vilain <sam@vilain.net>, Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 19:14:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njcnl-0001JL-6m
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 19:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918Ab0BVSOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 13:14:22 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:6350 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab0BVSOV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 13:14:21 -0500
Received: by fg-out-1718.google.com with SMTP id e21so444238fga.1
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 10:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5HtzGrQ9NGHaM8RFktG92mJiCOJOvwH4Cv1NAF41fpM=;
        b=Ycl7n530dUr5SS+6+zRBU7GZwUmCxvpP02IS5MU/dRlAa4ZlPMowfguCPwD+zgzJiE
         9PGoNiCL/kPwW6UlSpH10P4psRTRoaXHZJyV0SRWC2WZbb7AiYH0+aGm27Xk3jDtXdFs
         jv93s7EIpWkO80/64Jhf1XcOePrxp8PwLULiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sRVerrY5x1qWtPDLMK2j7VBQLh+jYU2ZDKsRB/KxFWDQN7oq2ZLBtAYi5RTBaqWZD5
         43sfFxo4O1+q0tk9auR1BkhpKEpPs11T67/Hlb25HOnBRJLZa+xEUfIF/kcmIqQ5ejC5
         bckJb0hrKNXV0bgz8Ia58VDcWQ8ujsYe/R3UY=
Received: by 10.87.67.24 with SMTP id u24mr2342852fgk.21.1266862460355;
        Mon, 22 Feb 2010 10:14:20 -0800 (PST)
Received: from localhost.localdomain (ws-26-184.laitilanpuhelin.fi [188.123.26.184])
        by mx.google.com with ESMTPS id d6sm10045617fga.19.2010.02.22.10.14.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 10:14:19 -0800 (PST)
X-Mailer: git-send-email 1.7.0.87.g6166f6d.dirty
In-Reply-To: <1266825442-32107-4-git-send-email-tuomas.suutari@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140703>

If parent J is an ancestor of parent I, then parent J should be
discarded, not I.

Note that J is an ancestor of I if and only if rev-list I..J is emtpy,
which is what we are testing here.

Signed-off-by: Tuomas Suutari <tuomas.suutari@gmail.com>
---
Thanks to Thomas Rast for pointing out that this can be made with a
smaller change and there is no need swap rev-list to merge-base after
all.

 git-svn.perl             |    2 +-
 t/t9151-svn-mergeinfo.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 265852f..ed96a03 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3273,7 +3273,7 @@ sub find_extra_svn_parents {
 					"$new_parents[$i]..$new_parents[$j]",
 				       );
 				if ( !$revs ) {
-					undef($new_parents[$i]);
+					undef($new_parents[$j]);
 				}
 			}
 		}
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 353f543..1640824 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -33,7 +33,7 @@ test_expect_success 'svn non-merge merge commits did not become git merge commit
 	[ -z "$bad_non_merges" ]
 	'
 
-test_expect_failure 'commit made to merged branch is reachable from the merge' '
+test_expect_success 'commit made to merged branch is reachable from the merge' '
 	before_commit=$(git rev-list --all --grep="trunk commit before merging trunk to b2")
 	merge_commit=$(git rev-list --all --grep="Merge trunk to b2")
 	not_reachable=$(git rev-list -1 $before_commit --not $merge_commit)
-- 
1.7.0.87.g6166f6d.dirty
