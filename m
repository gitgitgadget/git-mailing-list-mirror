From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/4] make verify_one_pack() a bit less wrong wrt packed_git
 structure
Date: Thu, 28 Feb 2008 00:25:18 -0500
Message-ID: <1204176320-31358-3-git-send-email-nico@cam.org>
References: <1204176320-31358-1-git-send-email-nico@cam.org>
 <1204176320-31358-2-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 06:26:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUbHO-0004Z9-Az
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 06:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbYB1FZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 00:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbYB1FZ2
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 00:25:28 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61471 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbYB1FZY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 00:25:24 -0500
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JWX00B63OE9QT70@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 Feb 2008 00:25:22 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.200.g99e75
In-reply-to: <1204176320-31358-2-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75354>

Simply freeing it is wrong.  There are many things attached to this
structure that are not cleaned up.  In practice this doesn't matter much
since this happens just before the program exits, but it is still
a bit more "correct" to leak it implicitly rather than explicitly.

And therefore it is also a good idea to register it with
install_packed_git().  Not only might it have better chance of being
properly cleaned up if such functionality is implemented for the general
case, but some functions like init_revindex() expect all packed_git
instances to be globally accessible.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-verify-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index 4e31c27..4958bbb 100644
--- a/builtin-verify-pack.c
+++ b/builtin-verify-pack.c
@@ -40,8 +40,8 @@ static int verify_one_pack(const char *path, int verbose)
 	if (!pack)
 		return error("packfile %s not found.", arg);
 
+	install_packed_git(pack);
 	err = verify_pack(pack, verbose);
-	free(pack);
 
 	return err;
 }
-- 
1.5.4.2.200.g99e75
