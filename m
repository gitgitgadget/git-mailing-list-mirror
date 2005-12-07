From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-object-id: use git-rev-parse(1) for date parsing
Date: Wed, 7 Dec 2005 22:40:13 +0100
Message-ID: <20051207214013.GD25890@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Dec 07 22:42:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek71e-0004zc-Gh
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 22:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbVLGVkR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 16:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbVLGVkQ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 16:40:16 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:11719 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1030363AbVLGVkO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 16:40:14 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 1E3DE6DFED1; Wed,  7 Dec 2005 22:39:19 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id D7FB96DFE8B; Wed,  7 Dec 2005 22:39:18 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 2EC2161556; Wed,  7 Dec 2005 22:40:13 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13345>

Using the --until switch, git-rev-parse(1) will first be given the ID. If it
cannot make sense of the ID fallback to using date(1).

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 The mixing of date parsing behaviours might be a little questionable,
 but it's good to stay compatible with git.

commit 41447107236a7d23daa6ab0f40a0829935485bc8
tree 27863684c19e7f129304d2a1573c08f974126e2a
parent f0535e9952f1cace89d03649e8238aca69a6df44
author Jonas Fonseca <fonseca@diku.dk> Wed, 07 Dec 2005 22:16:50 +0100
committer Jonas Fonseca <fonseca@antimatter.localdomain> Wed, 07 Dec 2005 22:16:50 +0100

 cg-object-id |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/cg-object-id b/cg-object-id
index ea04dca..baf096e 100755
--- a/cg-object-id
+++ b/cg-object-id
@@ -73,7 +73,14 @@ normalize_id()
 	fi
 
 	if [ "$id" != " " ] && [ ! "$valid" ]; then
-		reqsecs=$(date --date="$id" +'%s' 2>/dev/null)
+		curtime=$(date +'%s' 2>/dev/null)
+		reqsecs=$(git-rev-parse --until="$id"); reqsecs=${reqsecs:10}
+
+		# git-rev-parse(1) will output the current time if the ID
+		# doesn't make sense. Workaround it so date(1) can have a try.
+		if [ "$curtime" -le "$reqsecs" ]; then
+			reqsecs=$(date --date="$id" +'%s' 2>/dev/null)
+		fi
 
 		if [ "$reqsecs" ]; then
 			id=$(git-rev-list --min-age=$reqsecs --max-count=1 HEAD)

-- 
Jonas Fonseca
