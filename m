From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v3 08/11] sequencer.c: teach append_signoff to avoid adding a duplicate newline
Date: Sun, 27 Jan 2013 17:11:52 -0800
Message-ID: <1359335515-13818-9-git-send-email-drafnel@gmail.com>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
Cc: jrnieder@gmail.com, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 02:12:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzdHK-0006QA-Gd
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 02:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902Ab3A1BMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 20:12:35 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:57627 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757120Ab3A1BMa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 20:12:30 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so982591dak.33
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 17:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=6+nMb6sQhoGQ8Okf9URJnXerExLQnRBkDMC5sLYScYo=;
        b=JI9HMMUlBHCjtLW+cGJIGnS5gVqSa12p54CaOoveRCdmnTzC9XXR8RzQU8zbfP/Vg3
         GkMl7pyFc61sg6j0Ex818vSqE+JTarVscFkorzXmx7Ya0NwKumvMWAiLy8MAP1zZeI0Z
         1Id6v7TINUS2lJyefUcfEHZgAbu7lku4wYeXFSdq7L9vtIJlHozm/69j01Y5nlhGVtV8
         9G+gsDtLlDNvqv/FV8Vel/LhIsBwK2T232kHAc01YMkmSM5XmQgWm9IjmK+x0hd2pyLC
         vJLpYf3TLnHGh05ngfyaucc+ErMou9hIO7pxkOpJtXP5Ppj91H09C4LCc0BxHL9Eq1D2
         g+XA==
X-Received: by 10.68.231.41 with SMTP id td9mr33183079pbc.128.1359335549924;
        Sun, 27 Jan 2013 17:12:29 -0800 (PST)
Received: from charliebrown.sbx10663.mountca.wayport.net (ip-64-134-226-147.public.wayport.net. [64.134.226.147])
        by mx.google.com with ESMTPS id x2sm5619521paw.8.2013.01.27.17.12.27
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 17:12:28 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214771>

Teach append_signoff to detect whether a blank line exists at the position
that the signed-off-by line will be added, and avoid adding an additional
one if one already exists.  This is necessary to allow format-patch to add a
s-o-b to a patch with no commit message without adding an extra newline.  A
following patch will make format-patch use this function rather than the
append_signoff implementation inside log-tree.c.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 sequencer.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 015cb58..404b786 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1118,11 +1118,15 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 	for (i = msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - 1] != '\n'; i--)
 		; /* do nothing */
 
-	if (i)
-		has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
-
-	if (!has_footer)
-		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
+	if (msgbuf->buf[i] != '\n') {
+		if (i)
+			has_footer = has_conforming_footer(msgbuf, &sob,
+					ignore_footer);
+
+		if (!has_footer)
+			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
+					"\n", 1);
+	}
 
 	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
 		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
-- 
1.8.1.1.450.g0327af3
