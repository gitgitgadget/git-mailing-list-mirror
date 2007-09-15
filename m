From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/5] Cleanup duplicate initialization code in transport_get
Date: Sat, 15 Sep 2007 03:23:07 -0400
Message-ID: <20070915072307.GC20346@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 09:23:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWS05-0003fr-1g
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 09:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbXIOHXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 03:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbXIOHXM
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 03:23:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35942 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbXIOHXK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 03:23:10 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWRzf-0006hw-Od; Sat, 15 Sep 2007 03:23:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AF8FF20FBAE; Sat, 15 Sep 2007 03:23:07 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58226>

We always allocate and return a struct transport* right now as every
URL is considered to be a native Git transport if it is not rsync,
http/https/ftp or a bundle.  So we can simplify the initialization
of a new transport object by performing one xcalloc call and filling
in only the attributes required.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 transport.c |   27 ++++++++++-----------------
 1 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/transport.c b/transport.c
index 0021190..5eabe8d 100644
--- a/transport.c
+++ b/transport.c
@@ -411,27 +411,26 @@ static int is_file(const char *url)
 struct transport *transport_get(struct remote *remote, const char *url,
 				int fetch)
 {
-	struct transport *ret = NULL;
+	struct transport *ret = xcalloc(1, sizeof(*ret));
+
+	ret->remote = remote;
+	ret->url = url;
+	ret->fetch = !!fetch;
+
 	if (!prefixcmp(url, "rsync://")) {
-		ret = xmalloc(sizeof(*ret));
-		ret->data = NULL;
 		ret->ops = &rsync_transport;
-	} else if (!prefixcmp(url, "http://") || !prefixcmp(url, "https://") ||
-		   !prefixcmp(url, "ftp://")) {
-		ret = xmalloc(sizeof(*ret));
+	} else if (!prefixcmp(url, "http://")
+	        || !prefixcmp(url, "https://")
+	        || !prefixcmp(url, "ftp://")) {
 		ret->ops = &curl_transport;
 		if (fetch)
 			ret->data = get_http_walker(url);
-		else
-			ret->data = NULL;
 	} else if (is_local(url) && is_file(url)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
-		ret = xmalloc(sizeof(*ret));
 		ret->data = data;
 		ret->ops = &bundle_transport;
 	} else {
 		struct git_transport_data *data = xcalloc(1, sizeof(*data));
-		ret = xcalloc(1, sizeof(*ret));
 		ret->data = data;
 		data->thin = 1;
 		data->uploadpack = "git-upload-pack";
@@ -443,13 +442,7 @@ struct transport *transport_get(struct remote *remote, const char *url,
 		data->unpacklimit = -1;
 		ret->ops = &git_transport;
 	}
-	if (ret) {
-		ret->remote = remote;
-		ret->url = url;
-		ret->remote_refs = NULL;
-		ret->fetch = !!fetch;
-		ret->pack_lockfile = NULL;
-	}
+
 	return ret;
 }
 
-- 
1.5.3.1.84.gaf82-dirty
