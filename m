From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 07/11] sequencer.c: teach append_signoff to avoid adding a duplicate newline
Date: Sun, 25 Nov 2012 17:45:55 -0800
Message-ID: <1353894359-6733-8-git-send-email-drafnel@gmail.com>
References: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Cc: pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 02:48:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcnnj-0007dX-1j
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 02:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840Ab2KZBro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 20:47:44 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37170 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab2KZBrn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 20:47:43 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so7623858pbc.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 17:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nzt2KOZ1fU62HDzzL8rvYQgZYRufGfiMXXTQseAiukU=;
        b=PvBgclfgl2JC++crNjJuVSwlh4S/koHXfbzKoYA8MmphmCt/g2mJ86DXnDf1j9wDcy
         lTc5Ek7gaHIUSUT7mSqEUW40yjSrgN94t762B4afJxB0W09vDMiF7/ii+rSrOpyXGIi2
         UGt3Eqv7GKuW3/wVp2xSF9AteFhT3WbEhqFgWjK/72j5sB3YA8mcthORiAyBk0msWl2V
         7xQpTU9CSrGntEjnhclbIc3WrmIWwJyBZVLhrE+e07+6LShJdIZwFxqGLlMJLBUvTRhQ
         YhPtsJBmG6hhmLRHYiapZAcN901Jl9o/N2ls++9K3GL5E4RcRhrLptkJRfSlMEtU2MKH
         nYfQ==
Received: by 10.66.88.41 with SMTP id bd9mr28575381pab.46.1353894463483;
        Sun, 25 Nov 2012 17:47:43 -0800 (PST)
Received: from charliebrown.sbx05686.santaca.wayport.net (dhcp64-134-221-228.hoic.dca.wayport.net. [64.134.221.228])
        by mx.google.com with ESMTPS id ot5sm7828428pbb.29.2012.11.25.17.47.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Nov 2012 17:47:42 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210397>

Teach append_signoff to detect whether a blank line exists at the position
that the signed-off-by line will be added, and avoid adding an additional
one if one already exists.  This is necessary to allow format-patch to add a
s-o-b to a patch with no commit message without adding an extra newline.  A
following patch will make format-patch use this function rather than the
append_signoff implementation inside log-tree.c.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3062ad4..eb93dd6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1103,8 +1103,8 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, int no_dup_sob)
 	strbuf_addch(&sob, '\n');
 	for (i = msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - 1] != '\n'; i--)
 		; /* do nothing */
-	if (!i || !(has_footer =
-		has_conforming_footer(msgbuf, &sob, ignore_footer)))
+	if (msgbuf->buf[i] != '\n' && (!i || !(has_footer =
+		has_conforming_footer(msgbuf, &sob, ignore_footer))))
 		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
 	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
 		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
-- 
1.8.0.284.g959048a
