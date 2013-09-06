From: Andreas Krey <a.krey@gmx.de>
Subject: [PATCH 1/3] upload-pack: send the HEAD information
Date: Fri, 6 Sep 2013 17:56:08 +0200
Message-ID: <20130906155608.GF12966@inner.h.apk.li>
References: <20130906155204.GE12966@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 17:58:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHyQg-0001Rp-HC
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 17:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800Ab3IFP61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 11:58:27 -0400
Received: from continuum.iocl.org ([217.140.74.2]:51632 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758Ab3IFP60 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 11:58:26 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r86Fu9F00991;
	Fri, 6 Sep 2013 17:56:09 +0200
Content-Disposition: inline
In-Reply-To: <20130906155204.GE12966@inner.h.apk.li>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234055>

From: Junio C Hamano <gitster@pobox.com>

This implements the server side of protocol extension to show which branch
the HEAD points at.  The information is sent as a capability symref=<target>.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Andreas Krey <a.krey@gmx.de>
---
 upload-pack.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 127e59a..390d1ec 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -745,13 +745,17 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	if (mark_our_ref(refname, sha1, flag, cb_data))
 		return 0;
 
-	if (capabilities)
-		packet_write(1, "%s %s%c%s%s%s agent=%s\n",
+	if (capabilities) {
+		unsigned char dummy[20];
+		const char *target = resolve_ref_unsafe("HEAD", dummy, 0, NULL);
+		packet_write(1, "%s %s%c%s%s%s%s%s agent=%s\n",
 			     sha1_to_hex(sha1), refname_nons,
 			     0, capabilities,
 			     allow_tip_sha1_in_want ? " allow-tip-sha1-in-want" : "",
 			     stateless_rpc ? " no-done" : "",
+			     target ? " symref=" : "", target ? target : 0,
 			     git_user_agent_sanitized());
+	}
 	else
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname_nons);
 	capabilities = NULL;
-- 
1.8.3.1.485.g9704416.dirty
