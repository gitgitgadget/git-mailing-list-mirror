From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v3 7/8] Make git-fetch follow tags we already have objects for sooner
Date: Sun, 2 Mar 2008 21:35:25 -0500
Message-ID: <20080303023525.GG9966@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 03:36:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW0XJ-0001hX-LJ
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 03:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736AbYCCCfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 21:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755574AbYCCCfa
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 21:35:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59533 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755590AbYCCCf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 21:35:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JW0WJ-0002T0-L5; Sun, 02 Mar 2008 21:35:15 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ECC1C20FBAE; Sun,  2 Mar 2008 21:35:25 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75876>

If autofollowing of tags is enabled, we see a new tag on the remote
that we don't have, and we already have the SHA-1 object that the
tag is peeled to, then we can fetch the tag while we are fetching
the other objects on the first connection.

This is a slight optimization for projects that have a habit of
tagging a release commit after most users have already seen and
downloaded that commit object through a prior fetch session. In
such cases the users may still find new objects in branch heads,
but the new tag will now also be part of the first pack transfer
and the subsequent connection to autofollow tags is not required.

Currently git.git does not benefit from this optimization as any
release usually gets a new commit at the same time that it gets a
new release tag, however git-gui.git and many other projects are
in the habit of tagging fairly old commits.

Users who did not already have the tagged commit still require
opening a second connection to autofollow the tag, as we are unable
to determine on the client side if $tag^{} will be sent to the
client during the first transfer or not.  Such computation must be
performed on the remote side of the connection and is deferred to
another series of changes.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 3758d48..a58efa6 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -101,6 +101,10 @@ static void add_merge_config(struct ref **head,
 	}
 }
 
+static void find_non_local_tags(struct transport *transport,
+			struct ref **head,
+			struct ref ***tail);
+
 static struct ref *get_ref_map(struct transport *transport,
 			       struct refspec *refs, int ref_count, int tags,
 			       int *autotags)
@@ -160,6 +164,8 @@ static struct ref *get_ref_map(struct transport *transport,
 			tail = &ref_map->next;
 		}
 	}
+	if (tags == TAGS_DEFAULT && *autotags)
+		find_non_local_tags(transport, &ref_map, &tail);
 	ref_remove_duplicates(ref_map);
 
 	return ref_map;
-- 
1.5.4.3.468.g36990

