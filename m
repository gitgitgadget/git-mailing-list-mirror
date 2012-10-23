From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv2] git-pull: Avoid merge-base on detached head
Date: Tue, 23 Oct 2012 16:39:56 -0400
Message-ID: <1351024796-28174-2-git-send-email-hordp@cisco.com>
References: <1351024796-28174-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 22:40:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQlHJ-0004yy-NU
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 22:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031Ab2JWUkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 16:40:25 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:5713 "EHLO
	rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933816Ab2JWUkV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 16:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1037; q=dns/txt; s=iport;
  t=1351024821; x=1352234421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=I5379ctUDYRdJ94FGig65oFXdyqLebVVoRzUeQtE9T0=;
  b=FIBZJ9lIDdZpiaQ/VoSSyLkNM/rZ/Anz/4ns1VpKTSet8ZG+2yQEvjUB
   XvhUGO/mXRJG9uTouwLepxhK/iYyVNDhqdJ7n9HK6OKCqFglxIHzk67OU
   rDtvP9b/UYF2ctuvKF8LtXHxkC+vxMPTx8/ykvm/GvdeewABdiZKLsym0
   s=;
X-IronPort-AV: E=Sophos;i="4.80,637,1344211200"; 
   d="scan'208";a="134638445"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by rcdn-iport-5.cisco.com with ESMTP; 23 Oct 2012 20:40:20 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core-3.cisco.com (8.14.5/8.14.5) with ESMTP id q9NKeDVT019733;
	Tue, 23 Oct 2012 20:40:20 GMT
X-Mailer: git-send-email 1.8.0.2.gc921d59.dirty
In-Reply-To: <1351024796-28174-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208244>

git pull --rebase does some clever tricks to find the base
for $upstream , but it forgets that we may not have any
branch at all.  When this happens, git merge-base reports its
"usage" help in the middle of an otherwise successful
rebase operation, because git-merge is called with one too
few parameters.

Since we do not need the merge-base trick in the case of a
detached HEAD, detect this condition and bypass the clever
trick and the usage noise.

Signed-off-by: Phil Hord <hordp@cisco.com>
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
1.8.0.2.gc921d59.dirty
