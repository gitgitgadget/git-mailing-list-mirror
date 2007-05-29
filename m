From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH] rev-parse: Identify short sha1 sums correctly.
Date: Tue, 29 May 2007 19:29:51 -0400
Message-ID: <1180481391179-git-send-email-jbowes@dangerouslyinc.com>
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed May 30 01:30:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtB9S-0008MD-Ec
	for gcvg-git@gmane.org; Wed, 30 May 2007 01:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbXE2Xav (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 19:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbXE2Xav
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 19:30:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54910 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766AbXE2Xau (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 19:30:50 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l4TNUlOf018635;
	Tue, 29 May 2007 19:30:47 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l4TNUlko015673;
	Tue, 29 May 2007 19:30:47 -0400
Received: from localhost.localdomain (vpn-14-58.rdu.redhat.com [10.11.14.58])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l4TNUkMK005790;
	Tue, 29 May 2007 19:30:46 -0400
X-Mailer: git-send-email 1.5.2.869.g6b3ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48713>

find_short_packed_object was not loading the pack index files.
Teach it to do so.

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---
 sha1_name.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 8dfceb2..7df01af 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -76,8 +76,11 @@ static int find_short_packed_object(int len, const unsigned char *match, unsigne
 
 	prepare_packed_git();
 	for (p = packed_git; p && found < 2; p = p->next) {
-		uint32_t num = p->num_objects;
-		uint32_t first = 0, last = num;
+		uint32_t num, last;
+		uint32_t first = 0;
+		open_pack_index(p);
+		num = p->num_objects;
+		last = num;
 		while (first < last) {
 			uint32_t mid = (first + last) / 2;
 			const unsigned char *now;
-- 
1.5.2.869.g6b3ba
