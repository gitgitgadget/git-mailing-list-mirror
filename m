From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 01/11] Fix memory leak in traverse_commit_list
Date: Fri, 9 Nov 2007 06:06:10 -0500
Message-ID: <20071109110610.GA19368@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 12:07:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqRhD-0007XS-Pz
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 12:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbXKILGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 06:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbXKILGO
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 06:06:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34080 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbXKILGN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 06:06:13 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IqRge-0003Bn-P7; Fri, 09 Nov 2007 06:06:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2CDFA20FBAE; Fri,  9 Nov 2007 06:06:10 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64159>

If we were listing objects too then the objects were buffered in an
array only reachable from a stack allocated structure.  When this
function returns that array would be leaked as nobody would have
a reference to it anymore.

Historically this hasn't been a problem as the primary user of
traverse_commit_list() (the noble git-rev-list) would terminate
as soon as the function was finished, thus allowing the operating
system to cleanup memory.  However we have been leaking this data
in git-pack-objects ever since that program learned how to run the
revision listing internally, rather than relying on reading object
names from git-rev-list.

To better facilitate reuse of traverse_commit_list during other
builtin tools (such as git-fetch) we shouldn't leak temporary memory
like this and instead we need to clean up properly after ourselves.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 list-objects.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index e5c88c2..713bef9 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -170,4 +170,11 @@ void traverse_commit_list(struct rev_info *revs,
 	}
 	for (i = 0; i < objects.nr; i++)
 		show_object(&objects.objects[i]);
+	free(objects.objects);
+	if (revs->pending.nr) {
+		revs->pending.nr = 0;
+		revs->pending.alloc = 0;
+		revs->pending.objects = NULL;
+		free(revs->pending.objects);
+	}
 }
-- 
1.5.3.5.1622.g41d10
