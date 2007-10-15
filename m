From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix compilation with NO_CURL
Date: Mon, 15 Oct 2007 14:52:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710151452001.25221@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, hjemli@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 15 16:04:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhQNA-0004RY-S3
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 15:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756650AbXJONwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 09:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756281AbXJONwd
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 09:52:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:43564 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755552AbXJONwc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 09:52:32 -0400
Received: (qmail invoked by alias); 15 Oct 2007 13:52:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp009) with SMTP; 15 Oct 2007 15:52:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+cQ7J8lc+cK3kttP0hamkLfVluWkblhqgjgAvG0b
	mAzSUegllhYcTr
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60998>


There were a few places which did not cope well without curl.  This
fixes all of them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 transport.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/transport.c b/transport.c
index 6fe6ec8..438b557 100644
--- a/transport.c
+++ b/transport.c
@@ -1,7 +1,9 @@
 #include "cache.h"
 #include "transport.h"
 #include "run-command.h"
+#ifndef NO_CURL
 #include "http.h"
+#endif
 #include "pkt-line.h"
 #include "fetch-pack.h"
 #include "walker.h"
@@ -368,6 +370,7 @@ static int disconnect_walker(struct transport *transport)
 	return 0;
 }
 
+#ifndef NO_CURL
 static int curl_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags) {
 	const char **argv;
 	int argc;
@@ -400,7 +403,6 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 	return !!err;
 }
 
-#ifndef NO_CURL
 static int missing__target(int code, int result)
 {
 	return	/* file:// URL -- do we ever use one??? */
@@ -730,6 +732,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->fetch = fetch_objs_via_rsync;
 		ret->push = rsync_transport_push;
 
+#ifndef NO_CURL
 	} else if (!prefixcmp(url, "http://")
 	        || !prefixcmp(url, "https://")
 	        || !prefixcmp(url, "ftp://")) {
@@ -737,6 +740,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->fetch = fetch_objs_via_curl;
 		ret->push = curl_transport_push;
 		ret->disconnect = disconnect_walker;
+#endif
 
 	} else if (is_local(url) && is_file(url)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
-- 
1.5.3.GIT
