From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/3] git-fetch: test avoiding unnecessary copying from alternates
Date: Thu, 8 Nov 2007 03:22:13 -0500
Message-ID: <20071108082213.GA17054@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 09:22:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq2em-00013D-OR
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 09:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbXKHIWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 03:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbXKHIWS
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 03:22:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33181 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbXKHIWR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 03:22:17 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iq2eT-0000fM-7R; Thu, 08 Nov 2007 03:22:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3D7AC20FBAE; Thu,  8 Nov 2007 03:22:13 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63960>

This test verifies my prior "avoid local fetching from alternate"
patch is functional and doesn't regress in the future during any
additional improvements made to git.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t5502-quickfetch.sh |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/t/t5502-quickfetch.sh b/t/t5502-quickfetch.sh
index b4760f2..16eadd6 100755
--- a/t/t5502-quickfetch.sh
+++ b/t/t5502-quickfetch.sh
@@ -86,4 +86,37 @@ test_expect_success 'quickfetch should not leave a corrupted repository' '
 
 '
 
+test_expect_success 'quickfetch should not copy from alternate' '
+
+	(
+		mkdir quickclone &&
+		cd quickclone &&
+		git init-db &&
+		(cd ../.git/objects && pwd) >.git/objects/info/alternates &&
+		git remote add origin .. &&
+		git fetch -k -k
+	) &&
+	obj_cnt=$( (
+		cd quickclone &&
+		git count-objects | sed -e "s/ *objects,.*//"
+	) ) &&
+	pck_cnt=$( (
+		cd quickclone &&
+		git count-objects -v | sed -n -e "/packs:/{
+				s/packs://
+				p
+				q
+			}"
+	) ) &&
+	origin_master=$( (
+		cd quickclone &&
+		git rev-parse origin/master
+	) ) &&
+	echo "loose objects: $obj_cnt, packfiles: $pck_cnt" &&
+	test $obj_cnt -eq 0 &&
+	test $pck_cnt -eq 0 &&
+	test z$origin_master = z$(git rev-parse master)
+
+'
+
 test_done
-- 
1.5.3.5.1590.gfadfad
