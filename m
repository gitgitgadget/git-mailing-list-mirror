From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 1/2] Make the number of pathname buffers a compile-time constant
Date: Tue, 27 Sep 2011 06:28:06 +0200
Message-ID: <1317097687-11098-2-git-send-email-mhagger@alum.mit.edu>
References: <1317097687-11098-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 06:29:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8PIA-0006KN-2p
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 06:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380Ab1I0E3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 00:29:05 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58800 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab1I0E3D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 00:29:03 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB231.dip.t-dialin.net [84.190.178.49])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8R4SE3R023431;
	Tue, 27 Sep 2011 06:28:17 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1317097687-11098-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182210>

Changing the number of available temporary buffers for get_pathname()
can help diagnose abuse of such buffers.  If a bug goes away when
PATHNAME_BUFFER_COUNT is increased, then it might be due to a buffer
being used after it has been recycled.  Similarly, if a bug appears
when PATHNAME_BUFFER_COUNT is decreased, then there might be a latent
problem that could emerge after unrelated code changes.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 path.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git path.c path.c
index 6f3f5d5..6c4714d 100644
--- path.c
+++ path.c
@@ -13,13 +13,16 @@
 #include "cache.h"
 #include "strbuf.h"
 
+/* This must be a power of 2: */
+#define PATHNAME_BUFFER_COUNT (1 << 2)
+
 static char bad_path[] = "/bad-path/";
 
 static char *get_pathname(void)
 {
-	static char pathname_array[4][PATH_MAX];
+	static char pathname_array[PATHNAME_BUFFER_COUNT][PATH_MAX];
 	static int index;
-	return pathname_array[3 & ++index];
+	return pathname_array[(PATHNAME_BUFFER_COUNT - 1) & ++index];
 }
 
 static char *cleanup_path(char *path)
-- 
1.7.7.rc2
