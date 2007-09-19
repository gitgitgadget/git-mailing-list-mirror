From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/5] Fix memory leaks when disconnecting transport instances
Date: Wed, 19 Sep 2007 00:49:42 -0400
Message-ID: <20070919044942.GE17107@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 06:50:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXrVh-00072u-Eh
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 06:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbXISEtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 00:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbXISEtq
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 00:49:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38751 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbXISEtp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 00:49:45 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IXrVN-0006xf-MC; Wed, 19 Sep 2007 00:49:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A287820FBAE; Wed, 19 Sep 2007 00:49:42 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58678>

Most transport implementations tend to allocate a data buffer
in the struct transport instance during transport_get() so we
need to free that data buffer when we disconnect it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 transport.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/transport.c b/transport.c
index a1d0a3c..4f9cddc 100644
--- a/transport.c
+++ b/transport.c
@@ -236,6 +236,7 @@ static int close_bundle(struct transport *transport)
 	struct bundle_transport_data *data = transport->data;
 	if (data->fd > 0)
 		close(data->fd);
+	free(data);
 	return 0;
 }
 
@@ -372,6 +373,12 @@ static int git_transport_push(struct transport *transport, int refspec_nr, const
 	return !!err;
 }
 
+static int disconnect_git(struct transport *transport)
+{
+	free(transport->data);
+	return 0;
+}
+
 static int is_local(const char *url)
 {
 	const char *colon = strchr(url, ':');
@@ -419,6 +426,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->get_refs_list = get_refs_via_connect;
 		ret->fetch = fetch_refs_via_pack;
 		ret->push = git_transport_push;
+		ret->disconnect = disconnect_git;
 
 		data->thin = 1;
 		data->uploadpack = "git-upload-pack";
-- 
1.5.3.1.195.gadd6
