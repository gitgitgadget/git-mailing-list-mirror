From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 06/11] git-fetch: Release objects used by a prior transport
Date: Fri, 9 Nov 2007 06:06:26 -0500
Message-ID: <20071109110626.GF19368@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 12:07:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqRhJ-0007XS-3H
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 12:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760794AbXKILGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 06:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760359AbXKILGe
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 06:06:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34100 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444AbXKILGa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 06:06:30 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IqRgv-0003Cb-DM; Fri, 09 Nov 2007 06:06:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C5A8C20FBAE; Fri,  9 Nov 2007 06:06:26 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64158>

Some transports allocate objects in the internal object hashtable
during the fetch process (e.g. the HTTP commit walker and also the
native protocol).  These shouldn't be visible to another transport
call running in the same fetch process when we fetch the tags during
automated tag following.  By deallocating the object table (if it
has anything in it) we ensure the second transport execution will
be from a clean slate.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 847db73..18f123e 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -337,7 +337,10 @@ static void store_updated_refs(const char *url, struct ref *ref_map)
 
 static int fetch_refs(struct transport *transport, struct ref *ref_map)
 {
-	int ret = transport_fetch_refs(transport, ref_map);
+	int ret;
+
+	free_all_objects();
+	ret = transport_fetch_refs(transport, ref_map);
 	if (!ret)
 		store_updated_refs(transport->url, ref_map);
 	transport_unlock_pack(transport);
-- 
1.5.3.5.1622.g41d10
