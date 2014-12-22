From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] git remote add: allow re-adding remotes with the same
 URL
Date: Mon, 22 Dec 2014 18:06:50 +0100 (CET)
Message-ID: <9c0c693efe68b1c0b080c14104bb6c5f7bf74097.1419267895.git.johannes.schindelin@gmx.de>
References: <20141216021900.50095.24877@random.io> <cover.1419267895.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: anapsix@random.io, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 22 18:07:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y36Rn-0003l0-7O
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 18:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450AbaLVRG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 12:06:58 -0500
Received: from mout.gmx.net ([212.227.15.19]:51221 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755411AbaLVRGy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 12:06:54 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0M4Gup-1XmOVM0kfT-00roi5;
 Mon, 22 Dec 2014 18:06:51 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1419267895.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:xivH+3c58YaBnh4+7bCuMMg+UIUQAKMGYz03uds9vawZ7QTD5LN
 wAFxTkXZ/VKGOjq1U2w86LYg2yS+it4OoIbf9+9XpaTFR9hN4ZPPUGwxb4CNVZoIAfnsdbg
 nU4cmAuZn21CAcB44H6T3QYG98P7M/T2jpOlTQA2SYApLqRGe3zlAQ7Fxju9Mrtz7W9yzXr
 hUoBIEu1CNujUkTsd96bg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261650>

When adding a remote, we make sure that the remote does not exist
already.

For convenience, we allow re-adding remotes with the same URLs.
This also handles the case that there is an "[url ...] insteadOf"
setting in the config.

It might seem like a mistake to compare against remote->url[0] without
verifying that remote->url_nr >=1, but at this point a missing URL has
been filled by the name already, therefore url_nr cannot be zero.

Noticed by Anastas Dancha.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/remote.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 46ecfd9..9168c83 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -180,7 +180,8 @@ static int add(int argc, const char **argv)
 	url = argv[1];
 
 	remote = remote_get(name);
-	if (remote && (remote->url_nr > 1 || strcmp(name, remote->url[0]) ||
+	if (remote && (remote->url_nr > 1 || (strcmp(name, remote->url[0]) &&
+				strcmp(url, remote->url[0])) ||
 			remote->fetch_refspec_nr))
 		die(_("remote %s already exists."), name);
 
-- 
2.0.0.rc3.9669.g840d1f9
