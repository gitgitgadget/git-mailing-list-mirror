From: Tuomas Suutari <tuomas.suutari@gmail.com>
Subject: [PATCH 3/3] git-svn: Fix discarding of extra parents from svn:mergeinfo
Date: Mon, 22 Feb 2010 09:57:22 +0200
Message-ID: <1266825442-32107-4-git-send-email-tuomas.suutari@gmail.com>
References: <1266825442-32107-1-git-send-email-tuomas.suutari@gmail.com>
Cc: Tuomas Suutari <tuomas.suutari@gmail.com>,
	Sam Vilain <sam@vilain.net>, Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 10:29:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjTBK-00051w-2V
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 08:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528Ab0BVH6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 02:58:05 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:44130 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336Ab0BVH56 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 02:57:58 -0500
Received: by mail-fx0-f219.google.com with SMTP id 19so2147720fxm.1
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 23:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4aGynM9B1BkP7NXkApbmoHRB+jQzPPktPfCxNRjXTK4=;
        b=WoTV1KPptwqKtoy0Soel6cwZM3U2b7cE/MlrPNRtBopt1D3gfmTDi/kpo6bzo1qSO2
         HAz5DWgRQkfQGMloAZJCOTSWn2wPnN9OBgDtBOez7nR7fVPffu2hLYjLznUVrlKyVxyN
         CQY0hsVyIzGyMVMuq7RdJ1VQwrad4da+UqftY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gY+qQl8ovYuxjiWq62D0UIyo5a8hJqbN7s0ACvezllDxkdqlvXqYOpDxO95J+IZCSM
         AD1mnJ4ZzGiqUQ+FKufeVvLlnzO0ReB5tvyiGH08OAIj4QXl+e9uRLQ0qSbnijaX6HLs
         W2cnD5ZnzvE0Ke/MKjQoNpkuwLto0vhuTsLrk=
Received: by 10.86.236.26 with SMTP id j26mr6030396fgh.77.1266825478098;
        Sun, 21 Feb 2010 23:57:58 -0800 (PST)
Received: from localhost.localdomain (ws-26-184.laitilanpuhelin.fi [188.123.26.184])
        by mx.google.com with ESMTPS id e3sm4952313fga.16.2010.02.21.23.57.57
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 23:57:57 -0800 (PST)
X-Mailer: git-send-email 1.7.0.86.g7501
In-Reply-To: <1266825442-32107-1-git-send-email-tuomas.suutari@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140649>

Use merge-base rather than rev-list for detecting if a parent is an
ancestor of another, because rev-list gives incorrect results
sometimes.

Signed-off-by: Tuomas Suutari <tuomas.suutari@gmail.com>
---
 git-svn.perl             |    8 ++++----
 t/t9151-svn-mergeinfo.sh |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 265852f..1e2bbe5 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3268,11 +3268,11 @@ sub find_extra_svn_parents {
 				next if $i == $j;
 				next unless $new_parents[$i];
 				next unless $new_parents[$j];
-				my $revs = command_oneline(
-					"rev-list", "-1",
-					"$new_parents[$i]..$new_parents[$j]",
+				my $mergebase = command_oneline(
+					"merge-base",
+					"$new_parents[$i]", "$new_parents[$j]",
 				       );
-				if ( !$revs ) {
+				if ( $mergebase eq $new_parents[$i] ) {
 					undef($new_parents[$i]);
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
1.7.0.86.g7501
