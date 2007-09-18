From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/5] Don't attempt to merge non-existant remotes in t5515
Date: Tue, 18 Sep 2007 04:54:51 -0400
Message-ID: <20070918085451.GB5390@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:55:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXYrv-0001jx-84
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 10:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654AbXIRIy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 04:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753597AbXIRIy5
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 04:54:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52373 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbXIRIyz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 04:54:55 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IXYr1-00067h-NB; Tue, 18 Sep 2007 04:54:47 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1C76420FBAE; Tue, 18 Sep 2007 04:54:51 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This was actually reverted in 756373da by Junio.  We no longer
support merging the right hand side of a fetchspec in a branch's
branch.$name.merge configuration setting as we interpret these
names as being only those published by the remote we are going to
fetch from.

The older shell based implementation of git-fetch did not report an
error when branch.$name.merge was referencing a branch that does
not exist on the remote and we are running `git fetch` for the
current branch.  The new builtin-fetch does notice this failure
and aborts the fetch, thus breaking the tests.

Junio and I kicked it around on #git earlier today and decided that
the best approach here is to error out and tell the user that their
configuration is wrong, as this is likely more user friendly than
silently ignoring the user's request.  Since the new builtin-fetch
is already issuing the error there is no code change required, we
just need to remove the bad configuration from our test.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t5515-fetch-merge-logic.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 6c9cc67..31c1081 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -84,8 +84,7 @@ test_expect_success setup '
 		git config branch.br-$remote-merge.merge refs/heads/three &&
 		git config branch.br-$remote-octopus.remote $remote &&
 		git config branch.br-$remote-octopus.merge refs/heads/one &&
-		git config --add branch.br-$remote-octopus.merge two &&
-		git config --add branch.br-$remote-octopus.merge remotes/rem/three
+		git config --add branch.br-$remote-octopus.merge two
 	done
 '
 
-- 
1.5.3.1.1000.g7319b
