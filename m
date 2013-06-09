From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/2] read-cache: free cache in discard_index
Date: Sun,  9 Jun 2013 19:39:18 +0200
Message-ID: <1370799558-18188-2-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1370799558-18188-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 19:39:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljaU-0002hH-Dt
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab3FIRj0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:39:26 -0400
Received: from india601.server4you.de ([85.25.151.105]:59096 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab3FIRjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:39:25 -0400
Received: from debian.Speedport_W_504V_Typ_A (p4FFD9DEC.dip0.t-ipconnect.de [79.253.157.236])
	by india601.server4you.de (Postfix) with ESMTPSA id 2E8D435F;
	Sun,  9 Jun 2013 19:39:24 +0200 (CEST)
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370799558-18188-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227047>

discard_cache doesn't have to free the array of cache entries, because
the next call of read_cache can simply reuse it, as they all operate on
the global variable the_index.

discard_index on the other hand does have to free it, because it can be
used e.g. with index_state variables on the stack, in which case a
missing free would cause an unrecoverable leak.  This patch releases th=
e
memory and removes a comment that was relevant for discard_cache but ha=
s
become outdated.

Since discard_cache is just a wrapper around discard_index nowadays, we
lose the optimization that avoids reallocation of that array within
loops of read_cache and discard_cache.  That doesn't cause a performanc=
e
regression for me, however (HEAD =3D this patch, HEAD^ =3D master + p00=
02):

  Test           //              HEAD^             HEAD
  ---------------\\----------------------------------------------------=
-
  0002.1: read_ca// 1000 times   0.62(0.58+0.04)   0.61(0.58+0.02) -1.6=
%

Suggested-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 read-cache.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 04ed561..4245f8e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1518,8 +1518,9 @@ int discard_index(struct index_state *istate)
 	free_name_hash(istate);
 	cache_tree_free(&(istate->cache_tree));
 	istate->initialized =3D 0;
-
-	/* no need to throw away allocated active_cache */
+	free(istate->cache);
+	istate->cache =3D NULL;
+	istate->cache_alloc =3D 0;
 	return 0;
 }
=20
--=20
1.8.3
