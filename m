From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/5] Avoid printing unnecessary warnings during fetch and push
Date: Tue, 18 Sep 2007 04:54:57 -0400
Message-ID: <20070918085457.GD5390@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:55:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXYrx-0001jx-Kr
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 10:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbXIRIzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 04:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbXIRIzH
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 04:55:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52379 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbXIRIzA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 04:55:00 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IXYr7-000684-UG; Tue, 18 Sep 2007 04:54:54 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 542DA20FBAE; Tue, 18 Sep 2007 04:54:57 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58554>

If a transport doesn't support an option we already are telling
the higher level application (fetch or push) that the option is not
valid by sending back a >0 return value from transport_set_option
so there's not a strong motivation to have the function perform the
output itself.  Instead we should let the higher level application
do the output if it is necessary.  This avoids always telling the
user that depth isn't supported on HTTP urls even when they did
not pass a --depth option to git-fetch.

If the user passes an option and the option value is invalid we now
properly die in git-fetch instead of just spitting out a message
and running anyway.  This mimics prior behavior better where
incorrect/malformed options are not accepted by the process.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c |   18 +++++++++++++++---
 transport.c     |   11 ++---------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 670af0b..b9722e5 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -430,6 +430,17 @@ static int do_fetch(struct transport *transport,
 	return 0;
 }
 
+static void set_option(const char *name, const char *value)
+{
+	int r = transport_set_option(transport, name, value);
+	if (r < 0)
+		die("Option \"%s\" value \"%s\" is not valid for %s\n",
+			name, value, transport->url);
+	if (r > 0)
+		warning("Option \"%s\" is ignored for %s\n",
+			name, transport->url);
+}
+
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	struct remote *remote;
@@ -525,10 +536,11 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (quiet)
 		transport->verbose = 0;
 	if (upload_pack)
-		transport_set_option(transport, TRANS_OPT_UPLOADPACK, upload_pack);
+		set_option(TRANS_OPT_UPLOADPACK, upload_pack);
 	if (keep)
-		transport_set_option(transport, TRANS_OPT_KEEP, "yes");
-	transport_set_option(transport, TRANS_OPT_DEPTH, depth);
+		set_option(TRANS_OPT_KEEP, "yes");
+	if (depth)
+		set_option(TRANS_OPT_DEPTH, depth);
 
 	if (!transport->url)
 		die("Where do you want to fetch from today?");
diff --git a/transport.c b/transport.c
index 7f94d30..cc76e3f 100644
--- a/transport.c
+++ b/transport.c
@@ -460,16 +460,9 @@ struct transport *transport_get(struct remote *remote, const char *url)
 int transport_set_option(struct transport *transport,
 			 const char *name, const char *value)
 {
-	int ret = 1;
 	if (transport->ops->set_option)
-		ret = transport->ops->set_option(transport, name, value);
-	if (ret < 0)
-		fprintf(stderr, "For '%s' option %s cannot be set to '%s'\n",
-			transport->url, name, value);
-	if (ret > 0)
-		fprintf(stderr, "For '%s' option %s is ignored\n",
-			transport->url, name);
-	return ret;
+		return transport->ops->set_option(transport, name, value);
+	return 1;
 }
 
 int transport_push(struct transport *transport,
-- 
1.5.3.1.1000.g7319b
