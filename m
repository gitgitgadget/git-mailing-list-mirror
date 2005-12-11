From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-object-id: use git-rev-parse(1) for date parsing
Date: Sun, 11 Dec 2005 19:31:07 +0100
Message-ID: <20051211183107.GC2960@diku.dk>
References: <20051207213905.GA25890@diku.dk> <20051211181901.GA2960@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Dec 11 19:31:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElVyq-0002R2-8F
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 19:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVLKSbM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 13:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVLKSbM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 13:31:12 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:59640 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1750795AbVLKSbJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2005 13:31:09 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 2E2CF6DFE7E; Sun, 11 Dec 2005 19:30:09 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id E14A26DFE13; Sun, 11 Dec 2005 19:30:08 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 35F1F615B3; Sun, 11 Dec 2005 19:31:08 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051211181901.GA2960@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13501>

Using the --until switch, git-rev-parse(1) will first be given the ID.
If it cannot make sense of the ID fallback to using date(1).

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
 
---
 
diff --git a/cg-object-id b/cg-object-id
index 49d6d99..4e3a3e2 100755
--- a/cg-object-id
+++ b/cg-object-id
@@ -55,7 +55,14 @@ normalize_id()
 
 	# date does the wrong thing for empty and single-letter ids
 	if [ ${#id} -gt 1 ] && [ ! "$valid" ]; then
-		reqsecs=$(date --date="$id" +'%s' 2>/dev/null)
+		cursecs=$(git-rev-parse --until=yksap); cursecs=${cursecs:10}
+		reqsecs=$(git-rev-parse --until="$id"); reqsecs=${reqsecs:10}
+ 
+		# git-rev-parse(1) will output the current time if the ID
+		# doesn't make sense. Workaround it so date(1) can have a try.
+		if [ "$cursecs" -le "$reqsecs" ]; then
+			reqsecs=$(date --date="$id" +'%s' 2>/dev/null)
+		fi
 
 		if [ "$reqsecs" ]; then
 			revid=$(git-rev-list --min-age=$reqsecs --max-count=1 HEAD)

-- 
Jonas Fonseca
