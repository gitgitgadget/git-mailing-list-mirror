From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] fast-import: zero all of 'struct tag' to silence valgrind
Date: Mon, 5 Mar 2012 14:48:49 +0100
Message-ID: <f95bf5b4fb814e9c83df96604526dd48d13f1abc.1330955283.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 14:49:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4YHa-0004fB-9Z
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 14:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282Ab2CENsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 08:48:52 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:15853 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932246Ab2CENsv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 08:48:51 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Mar
 2012 14:48:50 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Mar
 2012 14:48:50 +0100
X-Mailer: git-send-email 1.7.9.2.467.g7fee4
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192238>

When running t9300, valgrind (correctly) complains about an
uninitialized value in write_crash_report:

  ==2971== Use of uninitialised value of size 8
  ==2971==    at 0x4164F4: sha1_to_hex (hex.c:70)
  ==2971==    by 0x4073E4: die_nicely (fast-import.c:468)
  ==2971==    by 0x43284C: die (usage.c:86)
  ==2971==    by 0x40420D: main (fast-import.c:2731)
  ==2971==  Uninitialised value was created by a heap allocation
  ==2971==    at 0x4C29B3D: malloc (vg_replace_malloc.c:263)
  ==2971==    by 0x433645: xmalloc (wrapper.c:35)
  ==2971==    by 0x405DF5: pool_alloc (fast-import.c:619)
  ==2971==    by 0x407755: pool_calloc.constprop.14 (fast-import.c:634)
  ==2971==    by 0x403F33: main (fast-import.c:3324)

Fix this by zeroing all of the 'struct tag'.  We would only need to
zero out the 'sha1' field, but this way seems more future-proof.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 fast-import.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fast-import.c b/fast-import.c
index 6cd19e5..c1486ca 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2712,7 +2712,7 @@ static void parse_new_tag(void)
 	/* Obtain the new tag name from the rest of our command */
 	sp = strchr(command_buf.buf, ' ') + 1;
 	t = pool_alloc(sizeof(struct tag));
-	t->next_tag = NULL;
+	memset(t, 0, sizeof(struct tag));
 	t->name = pool_strdup(sp);
 	if (last_tag)
 		last_tag->next_tag = t;
-- 
1.7.9.2.467.g7fee4
