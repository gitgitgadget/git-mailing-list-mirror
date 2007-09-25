From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/3] Prevent send-pack from segfaulting when a branch doesn't match
Date: Tue, 25 Sep 2007 00:13:25 -0400
Message-ID: <20070925041325.GC11363@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 06:13:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia1np-0000qK-01
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 06:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749AbXIYEN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 00:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754582AbXIYEN3
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 00:13:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45088 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105AbXIYEN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 00:13:28 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ia1nb-00074J-5j; Tue, 25 Sep 2007 00:13:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9B2FA20FBAE; Tue, 25 Sep 2007 00:13:25 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59090>

If `git push url foo` can't find a local branch named foo we can't
match it to any remote branch as the local branch is NULL and its
name is probably at position 0x34 in memory.  On most systems that
isn't a valid address for git-send-pack's virtual address space
and we segfault.

If we can't find a source match and we have no destination we
need to abort the match function early before we try to match the
destination against the remote.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 remote.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index 2166a2b..e7d735b 100644
--- a/remote.c
+++ b/remote.c
@@ -610,8 +610,11 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	if (!matched_src)
 		errs = 1;
 
-	if (!dst_value)
+	if (!dst_value) {
+		if (!matched_src)
+			return errs;
 		dst_value = matched_src->name;
+	}
 
 	switch (count_refspec_match(dst_value, dst, &matched_dst)) {
 	case 1:
-- 
1.5.3.2.124.g2456-dirty
