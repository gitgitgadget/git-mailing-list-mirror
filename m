From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v2 3/3] verify_uptodate(): add ce_uptodate(ce) test
Date: Thu, 19 Feb 2009 21:08:30 +0100
Message-ID: <e00cfda6e7d884680f0d20ad714465672bb9a232.1235071656.git.barvik@broadpark.no>
References: <cover.1235071656.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 21:10:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaFE8-0003d0-Gu
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 21:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbZBSUIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 15:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426AbZBSUIk
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 15:08:40 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:52173 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396AbZBSUIh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 15:08:37 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFB00FW8XA9LA20@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Thu, 19 Feb 2009 21:08:33 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.205])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KFB00L04XA6CY10@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Thu, 19 Feb 2009 21:08:33 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <cover.1235071656.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110741>

If we inside verify_uptodate() can already tell from the ce entry that
it is already uptodate by testing it with ce_uptodate(ce), there is no
need to call lstat(2) and ie_match_stat() afterwards.

And, reading from the commit log message from:

    commit eadb5831342bb2e756fa05c03642c4aa1929d4f5
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Fri Jan 18 23:45:24 2008 -0800

    Avoid running lstat(2) on the same cache entry.

this also seems to be correct usage of the ce_uptodate() macro
introduced by that patch.

This will avoid lots of lstat(2) calls in some cases, for example
by running the 'git checkout' command.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 unpack-trees.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 44714cc..1687aee 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -450,7 +450,7 @@ static int verify_uptodate(struct cache_entry *ce,
 {
 	struct stat st;
 
-	if (o->index_only || o->reset)
+	if (o->index_only || o->reset || ce_uptodate(ce))
 		return 0;
 
 	if (!lstat(ce->name, &st)) {
-- 
1.6.1.349.g99fa5
