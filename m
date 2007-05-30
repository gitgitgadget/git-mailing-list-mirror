From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Test for recent rev-parse $abbrev_sha1 regression
Date: Wed, 30 May 2007 00:50:26 -0400
Message-ID: <20070530045026.GA12380@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 30 06:50:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtG8p-0006VW-50
	for gcvg-git@gmane.org; Wed, 30 May 2007 06:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbXE3Eua (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 00:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbXE3Eua
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 00:50:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44316 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbXE3Eu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 00:50:29 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtG8i-0001TT-4M; Wed, 30 May 2007 00:50:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9B6A520FBAE; Wed, 30 May 2007 00:50:26 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48738>

My recent patch "Lazily open pack index files on demand" caused a
regression in the case of parsing abbreviated SHA-1 object names.
Git was unable to translate the abbreviated name into the full name
if the object was packed, as the pack .idx files were not opened
before being accessed.

This is a simple test to repack a repository then test for an
abbreviated SHA-1 within the packfile.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t6101-rev-parse-parents.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 7d354a1..b0252b9 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -29,5 +29,15 @@ test_expect_success 'final^1^3 not valid' "if git-rev-parse --verify final^1^3;
 test_expect_failure '--verify start2^1' 'git-rev-parse --verify start2^1'
 test_expect_success '--verify start2^0' 'git-rev-parse --verify start2^0'
 
+test_expect_success 'repack for next test' 'git repack -a -d'
+test_expect_success 'short SHA-1 works' '
+	start=`git rev-parse --verify start` &&
+	echo $start &&
+	abbrv=`echo $start | sed s/.\$//` &&
+	echo $abbrv &&
+	abbrv=`git rev-parse --verify $abbrv` &&
+	echo $abbrv &&
+	test $start = $abbrv'
+
 test_done
 
-- 
1.5.2.869.g6b3ba
