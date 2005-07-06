From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 6/13] Change gitk so that it uses --topo-order rather than --merge-order
Date: Thu, 07 Jul 2005 02:39:34 +1000
Message-ID: <20050706163934.9908.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 06 18:50:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqD66-0006VR-LH
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 18:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVGFQtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 12:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVGFQtJ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 12:49:09 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:62848 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262353AbVGFQjp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 12:39:45 -0400
Received: (qmail 9918 invoked by uid 500); 6 Jul 2005 16:39:34 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This change is made so that gitk --all produces the same result for
every user irrespective of whether git-rev-parse --all produces
the same result for every user. By using --topo-order rather than
--merge-order this can be guaranteed and the existing (non-timestamp dependent)
behaviour of --merge-order can be maintained.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
Paul, could you review this patch and if you agree, ack it.

The rationale for changing gitk to use --topo-order is that git-rev-list will
produce the same order for --topo-order irrespective of the order of the
start list, whereas git-rev-list --merge-order produces an order that is deliberately
sensitive to the order of the start list.

Linus wants gitk --all to behave the same way, irrespective of what order
git-rev-parse --all produces its output. I want --merge-order to keep its
existing behaviour, so we agreed on this compromise whereby gitk uses
--topo-order rather than --merge-order by default.

My understanding of your code is that you only expect a minimal topological ordering
guarantee and the ordering produced by --topo-order should be sufficient
for your needs - that is, you don't rely on the other aspect of the
--merge-order invariant.

I'll leave it to you and Linus to decide how you want to manage the merge between
your HEAD and Linus'.
---

 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

19c9032b06b370511ef1091434df0d1d644fee06
diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -37,7 +37,7 @@ proc getcommits {rargs} {
 	set parsed_args $rargs
     }
     if [catch {
-	set commfd [open "|git-rev-list --header --merge-order $parsed_args" r]
+	set commfd [open "|git-rev-list --header --topo-order $parsed_args" r]
     } err] {
 	puts stderr "Error executing git-rev-list: $err"
 	exit 1
------------
