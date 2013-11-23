From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] send-pack: don't send a thin pack to a server which doesn't support it
Date: Sat, 23 Nov 2013 17:07:55 +0100
Message-ID: <1385222875-13369-1-git-send-email-cmn@elego.de>
Cc: gitster@pobox.com, jrnieder@gmail.com, pclouds@gmail.com,
	spearce@spearce.org, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 23 17:08:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkFku-0004Ps-At
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 17:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660Ab3KWQIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Nov 2013 11:08:00 -0500
Received: from hessy.cmartin.tk ([78.47.67.53]:48935 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753485Ab3KWQH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Nov 2013 11:07:59 -0500
Received: from cmartin.tk (unknown [IPv6:2001:6f8:900:8cd0:922b:34ff:fe1c:e3e4])
	by hessy.dwim.me (Postfix) with ESMTPA id 3C25B814BD;
	Sat, 23 Nov 2013 17:07:56 +0100 (CET)
Received: (nullmailer pid 13406 invoked by uid 1000);
	Sat, 23 Nov 2013 16:07:55 -0000
X-Mailer: git-send-email 1.8.5.rc3.362.gdf10213
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238236>

Up to now git has assumed that all servers are able to fix thin
packs. This is however not always the case.

Document the 'no-thin' capability and prevent send-pack from generating
a thin pack if the server advertises it.
---

This is a re-roll of the series I sent earlier this month, switching
it around by adding the "no-thin" 

 Documentation/technical/protocol-capabilities.txt | 20 +++++++++++++++-----
 send-pack.c                                       |  2 ++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index fd8ffa5..3a75e79 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -72,15 +72,25 @@ interleaved with S-R-Q.
 thin-pack
 ---------
 
-This capability means that the server can send a 'thin' pack, a pack
-which does not contain base objects; if those base objects are available
-on client side. Client requests 'thin-pack' capability when it
-understands how to "thicken" it by adding required delta bases making
-it self-contained.
+A thin pack is one with deltas which reference base objects not
+contained within the pack (but are known to exist at the receiving
+end). This can reduce the network traffic significantly, but it
+requires the receiving end to know how to "thicken" these packs by
+adding the missing bases to the pack.
+
+The upload-pack server advertises 'thin-pack' when it can generate and
+send a thin pack. The receive-pack server advertises 'no-thin' if
+it does not know how to "thicken" the pack it receives.
+
+A client requests the 'thin-pack' capability when it understands how
+to "thicken" it.
 
 Client MUST NOT request 'thin-pack' capability if it cannot turn a thin
 pack into a self-contained pack.
 
+Client MUST NOT send a thin pack if the server advertises the
+'no-thin' capability.
+
 
 side-band, side-band-64k
 ------------------------
diff --git a/send-pack.c b/send-pack.c
index 7d172ef..9877eb9 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -205,6 +205,8 @@ int send_pack(struct send_pack_args *args,
 		quiet_supported = 1;
 	if (server_supports("agent"))
 		agent_supported = 1;
+	if (server_supports("no-thin"))
+		args->use_thin_pack = 0;
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
-- 
1.8.5.rc3.362.gdf10213
