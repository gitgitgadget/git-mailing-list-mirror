From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Backup the array passed to fetch_pack so we can free items
Date: Fri, 14 Sep 2007 18:57:11 -0400
Message-ID: <20070914225711.GB16512@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 00:57:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWK69-0006rR-TS
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756808AbXINW5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 18:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756843AbXINW5O
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:57:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50908 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbXINW5O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:57:14 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWK6I-0000Pp-C1; Fri, 14 Sep 2007 18:57:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2920D20FBAE; Fri, 14 Sep 2007 18:57:11 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58208>

fetch_pack() can call remove_duplicates() on its input array and
this will possibly overwrite an earlier entry with a later one if
there are any duplicates in the input array.  In such a case the
caller here might then attempt to free an item multiple times as
it goes through its cleanup.

I also forgot to free the heads array we pass down into fetch_pack()
when I introduced the allocation of it in this function during my
builtin-fetch cleanup series.  Better free it while we are here
working on related memory management fixes.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 transport.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/transport.c b/transport.c
index 0882edd..0338ed4 100644
--- a/transport.c
+++ b/transport.c
@@ -311,6 +311,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 {
 	struct git_transport_data *data = transport->data;
 	char **heads = xmalloc(nr_heads * sizeof(*heads));
+	char **origh = xmalloc(nr_heads * sizeof(*origh));
 	struct ref *refs;
 	char *dest = xstrdup(transport->url);
 	struct fetch_pack_args args;
@@ -329,11 +330,13 @@ static int fetch_refs_via_pack(struct transport *transport,
 	setup_fetch_pack(&args);
 
 	for (i = 0; i < nr_heads; i++)
-		heads[i] = xstrdup(to_fetch[i]->name);
+		origh[i] = heads[i] = xstrdup(to_fetch[i]->name);
 	refs = fetch_pack(dest, nr_heads, heads, &transport->pack_lockfile);
 
 	for (i = 0; i < nr_heads; i++)
-		free(heads[i]);
+		free(origh[i]);
+	free(origh);
+	free(heads);
 	free_refs(refs);
 	free(dest);
 	return 0;
-- 
1.5.3.1.921.g8c3b
