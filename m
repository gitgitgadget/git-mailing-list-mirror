From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v3 5/8] Free the path_lists used to find non-local tags in git-fetch
Date: Sun, 2 Mar 2008 21:35:10 -0500
Message-ID: <20080303023510.GE9966@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 03:36:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW0Wz-0001c9-EN
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 03:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbYCCCfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 21:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755532AbYCCCfO
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 21:35:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59398 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866AbYCCCfN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 21:35:13 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JW0W4-0002Qc-0M; Sun, 02 Mar 2008 21:35:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4C06720FBAE; Sun,  2 Mar 2008 21:35:10 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75875>

To support calling find_non_local_tags() more than once in a single
git-fetch process we need the existing_refs to be stack-allocated
so it resets on the second call.  We also should free the path
lists to avoid unnecessary memory leaking.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 1d3ce77..3758d48 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -457,7 +457,7 @@ static void find_non_local_tags(struct transport *transport,
 			struct ref **head,
 			struct ref ***tail)
 {
-	static struct path_list existing_refs = { NULL, 0, 0, 0 };
+	struct path_list existing_refs = { NULL, 0, 0, 0 };
 	struct path_list new_refs = { NULL, 0, 0, 1 };
 	char *ref_name;
 	int ref_name_len;
@@ -503,6 +503,8 @@ static void find_non_local_tags(struct transport *transport,
 		}
 		free(ref_name);
 	}
+	path_list_clear(&existing_refs, 0);
+	path_list_clear(&new_refs, 0);
 }
 
 static int do_fetch(struct transport *transport,
-- 
1.5.4.3.468.g36990

