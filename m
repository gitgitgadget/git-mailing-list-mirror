From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/13] builtin-apply.c: optimize match_beginning/end processing a bit.
Date: Sat,  2 Feb 2008 02:54:11 -0800
Message-ID: <1201949659-27725-6-git-send-email-gitster@pobox.com>
References: <1201949659-27725-1-git-send-email-gitster@pobox.com>
 <1201949659-27725-2-git-send-email-gitster@pobox.com>
 <1201949659-27725-3-git-send-email-gitster@pobox.com>
 <1201949659-27725-4-git-send-email-gitster@pobox.com>
 <1201949659-27725-5-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 11:56:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLG2p-0005Ue-Sp
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 11:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762694AbYBBKyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 05:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762655AbYBBKyt
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 05:54:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43754 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762241AbYBBKyg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 05:54:36 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 855CD50F2
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:54:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 18C6050F1
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:54:34 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.g41ac4
In-Reply-To: <1201949659-27725-5-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72249>

Wnen the caller knows the hunk needs to match at the beginning
or at the end, there is no point starting from the line number
that is found in the patch and trying match with increasing
offset.  The logic to find matching lines was made more line
oriented with the previous patch and this optimization is now
trivial.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index e046e87..dc650f1 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1579,6 +1579,16 @@ static int find_pos(struct image *img,
 	if (preimage->nr > img->nr)
 		return -1;
 
+	/*
+	 * If match_begining or match_end is specified, there is no
+	 * point starting from a wrong line that will never match and
+	 * wander around and wait for a match at the specified end.
+	 */
+	if (match_beginning)
+		line = 0;
+	else if (match_end)
+		line = img->nr - preimage->nr;
+
 	try = 0;
 	for (i = 0; i < line; i++)
 		try += img->line[i].len;
-- 
1.5.4.2.g41ac4
