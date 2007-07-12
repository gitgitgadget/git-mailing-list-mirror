From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 1/6] Don't try to delta if target is much smaller than source
Date: Thu, 12 Jul 2007 07:55:47 -0500
Message-ID: <11842449523154-git-send-email-bdowning@lavos.net>
References: <1184244952554-git-send-email-bdowning@lavos.net>
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Brian Downing <bdowning@lavos.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 14:56:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8yDX-0005TH-0K
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 14:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbXGLMz5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 08:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbXGLMz4
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 08:55:56 -0400
Received: from 74-134-246-243.dhcp.insightbb.com ([74.134.246.243]:62320 "EHLO
	silvara" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761801AbXGLMzu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 08:55:50 -0400
Received: by silvara (Postfix, from userid 1000)
	id 8269152132; Thu, 12 Jul 2007 07:55:52 -0500 (CDT)
X-Mailer: git-send-email 1.5.2.GIT
In-Reply-To: <1184244952554-git-send-email-bdowning@lavos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52276>

Add a new try_delta heuristic:  Don't bother trying to make a delta if
the target object size is much smaller (currently 1/32) than the source,
as it's very likely not going to get a match.  Even if it does, you will
have to read at least 32x the size of the new file to reassemble it,
which isn't such a good deal.  This leads to a considerable performance
improvement when deltifying a mix of small and large files with a very
large window, because you don't have to wait for the large files to
percolate out of the window before things start going fast again.

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 builtin-pack-objects.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 54b9d26..132ce96 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1342,6 +1342,8 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	sizediff = src_size < trg_size ? trg_size - src_size : 0;
 	if (sizediff >= max_size)
 		return 0;
+	if (trg_size < src_size / 32)
+		return 0;
 
 	/* Load data if not already done */
 	if (!trg->data) {
-- 
1.5.2.GIT
