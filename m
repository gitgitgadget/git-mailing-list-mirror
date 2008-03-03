From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v3 2/8] Remove unnecessary delaying of free_refs(ref_map) in builtin-fetch
Date: Sun, 2 Mar 2008 21:34:43 -0500
Message-ID: <20080303023443.GB9966@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 03:35:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW0WS-0001TB-Fr
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 03:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696AbYCCCeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 21:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753548AbYCCCeq
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 21:34:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59198 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715AbYCCCep (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 21:34:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JW0Vd-0002MU-3Y; Sun, 02 Mar 2008 21:34:33 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5F04520FBAE; Sun,  2 Mar 2008 21:34:43 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75871>

We can free this ref_map as soon as the fetch is complete.  It is not
used for the automatic tag following, nor is it used to disconnect the
transport.  This avoids some confusion about why we are holding onto
these refs while following tags.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index f8b9542..1348a0e 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -509,7 +509,7 @@ static struct ref *find_non_local_tags(struct transport *transport)
 static int do_fetch(struct transport *transport,
 		    struct refspec *refs, int ref_count)
 {
-	struct ref *ref_map, *fetch_map;
+	struct ref *ref_map;
 	struct ref *rm;
 	int autotags = (transport->remote->fetch_tags == 1);
 	if (transport->remote->fetch_tags == 2 && tags != TAGS_UNSET)
@@ -540,8 +540,7 @@ static int do_fetch(struct transport *transport,
 		free_refs(ref_map);
 		return 1;
 	}
-
-	fetch_map = ref_map;
+	free_refs(ref_map);
 
 	/* if neither --no-tags nor --tags was specified, do automated tag
 	 * following ... */
@@ -554,8 +553,6 @@ static int do_fetch(struct transport *transport,
 		free_refs(ref_map);
 	}
 
-	free_refs(fetch_map);
