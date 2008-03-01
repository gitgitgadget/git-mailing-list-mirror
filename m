From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 2/7] Remove unnecessary delaying of free_refs(ref_map) in builtin-fetch
Date: Sat, 1 Mar 2008 00:24:48 -0500
Message-ID: <20080301052448.GB27300@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 06:25:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVKE8-0004rx-DU
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 06:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbYCAFYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 00:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbYCAFYw
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 00:24:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48492 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbYCAFYw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 00:24:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JVKDJ-0000qk-K2; Sat, 01 Mar 2008 00:24:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AD98120FBAE; Sat,  1 Mar 2008 00:24:48 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75615>

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
