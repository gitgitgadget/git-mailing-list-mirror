From: Phil Hord <hordp@cisco.com>
Subject: [PATCH 1/2] git-pull: Avoid merge-base on detached head
Date: Mon, 22 Oct 2012 18:50:04 -0400
Message-ID: <1350946204-26399-1-git-send-email-hordp@cisco.com>
Cc: gitster@pobox.com, phil.hord@gmail.com, santi@agolina.net,
	Elijah Newren <newren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 01:00:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQQyw-0005w3-Au
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 01:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228Ab2JVXAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 19:00:11 -0400
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:24754 "EHLO
	rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab2JVXAK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 19:00:10 -0400
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Oct 2012 19:00:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=985; q=dns/txt; s=iport;
  t=1350946811; x=1352156411;
  h=from:to:cc:subject:date:message-id;
  bh=2oNRHauQcqkn6XqXxRleQFUpdEOagg03NPafpM4eoe8=;
  b=li46AxaWKUZTGhc7fMNYmQvbIStF+gB2UgIZLp84LCFcFN++CkWLrVVb
   B0ZTTxc8rZsGU3kppcODrRpl0hx6BKjicYt5XgasNORFBPeWnWax/WUVT
   LrBIALK5Etj3o92nT6lskEzBIWPM1+J9cYNDKrfkQ2yzl6VvDfHmgIpvL
   w=;
X-IronPort-AV: E=Sophos;i="4.80,632,1344211200"; 
   d="scan'208";a="134307494"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by rcdn-iport-3.cisco.com with ESMTP; 22 Oct 2012 22:50:44 +0000
Received: from ipsn-lnx-hordp.cisco.com (rtp-hordp-8913.cisco.com [10.117.80.100])
	by rcdn-core-2.cisco.com (8.14.5/8.14.5) with ESMTP id q9MMogWm007513;
	Mon, 22 Oct 2012 22:50:43 GMT
X-Mailer: git-send-email 1.8.0.2.ge1a3bdd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208207>

git pull --rebase does some clever tricks to find the base
for $upstream , but it forgets that we may not have any
branch at all.  When this happens, git merge-base reports its
"usage" help in the middle of an otherwise successful
rebase operation, because git-merge is called with one too
few parameters.

Since we do not need the merge-base trick in the case of a
detached HEAD, detect this condition and bypass the clever
trick and the usage noise.
---
 git-pull.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-pull.sh b/git-pull.sh
index 2a10047..266e682 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -200,6 +200,7 @@ test true = "$rebase" && {
 		require_clean_work_tree "pull with rebase" "Please commit or stash them."
 	fi
 	oldremoteref= &&
+	test -n "$curr_branch" &&
 	. git-parse-remote &&
 	remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
 	oldremoteref="$(git rev-parse -q --verify "$remoteref")" &&
-- 
1.8.0.2.ge1a3bdd
