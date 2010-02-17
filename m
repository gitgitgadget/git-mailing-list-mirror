From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 6/6] fast-import: use the diff_delta() max_delta_size argument
Date: Wed, 17 Feb 2010 14:05:56 -0500
Message-ID: <1266433556-1987-7-git-send-email-nico@fluxnic.net>
References: <1266433556-1987-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 20:06:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhpEP-0005G9-CI
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 20:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037Ab0BQTGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 14:06:12 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11748 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793Ab0BQTGL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 14:06:11 -0500
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KY000GRF2DZ9K50@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 17 Feb 2010 14:06:03 -0500 (EST)
X-Mailer: git-send-email 1.7.0.23.gf5ef4
In-reply-to: <1266433556-1987-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140251>

This let diff_delta() abort early if it is going to bust the given
size limit.  Also, only objects larger than 20 bytes are considered
as objects smaller than that are most certainly going to produce
larger deltas than the original object due to the additional headers.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 fast-import.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7fc9862..74f08bd 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1041,14 +1041,10 @@ static int store_object(
 		return 1;
 	}
 
-	if (last && last->data.buf && last->depth < max_depth) {
+	if (last && last->data.buf && last->depth < max_depth && dat->len > 20) {
 		delta = diff_delta(last->data.buf, last->data.len,
 			dat->buf, dat->len,
-			&deltalen, 0);
-		if (delta && deltalen >= dat->len) {
-			free(delta);
-			delta = NULL;
-		}
+			&deltalen, dat->len - 20);
 	} else
 		delta = NULL;
 
-- 
1.7.0.23.gf5ef4
