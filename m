From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Reteach builtin-ls-remote to understand remotes
Date: Tue, 6 Nov 2007 20:29:20 -0500
Message-ID: <20071107012920.GA9961@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 02:29:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpZjg-0000pj-PU
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 02:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165AbXKGB3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 20:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755245AbXKGB3Z
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 20:29:25 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53589 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991AbXKGB3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 20:29:24 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IpZjD-0006s0-Hg; Tue, 06 Nov 2007 20:29:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2BB3120FBAE; Tue,  6 Nov 2007 20:29:21 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63763>

Prior to being made a builtin git-ls-remote understood that when
it was given a remote name we wanted it to resolve that to the
pre-configured URL and connect to that location.  That changed when
it was converted to a builtin and many of my automation tools broke.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-ls-remote.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index 003580c..56f3f88 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -14,6 +14,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	unsigned flags = 0;
 	const char *uploadpack = NULL;
 
+	struct remote *remote;
 	struct transport *transport;
 	const struct ref *ref;
 
@@ -52,7 +53,10 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (!dest || i != argc - 1)
 		usage(ls_remote_usage);
 
-	transport = transport_get(NULL, dest);
+	remote = nongit ? NULL : remote_get(dest);
+	if (remote && !remote->url_nr)
+		die("remote %s has no configured URL", dest);
+	transport = transport_get(remote, remote ? remote->url[0] : dest);
 	if (uploadpack != NULL)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
 
-- 
1.5.3.5.1590.gfadfad
