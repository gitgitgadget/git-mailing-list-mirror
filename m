From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH v2 3/7] unpack-trees: factor out dup_entry
Date: Sun,  2 Jun 2013 17:46:53 +0200
Message-ID: <1370188017-24672-4-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 02 17:47:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjAVA-0006uU-1N
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 17:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486Ab3FBPrR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Jun 2013 11:47:17 -0400
Received: from india601.server4you.de ([85.25.151.105]:58114 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab3FBPrF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 11:47:05 -0400
Received: from debian.Speedport_W_504V_Typ_A (p579BEE4A.dip0.t-ipconnect.de [87.155.238.74])
	by india601.server4you.de (Postfix) with ESMTPSA id 1EE98490;
	Sun,  2 Jun 2013 17:47:03 +0200 (CEST)
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226164>

While we're add it, mark the struct cache_entry pointer of add_entry
const because we only read from it and this allows callers to pass in
const pointers.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 unpack-trees.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index ede4299..e8b4cc1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -116,14 +116,20 @@ static void do_add_entry(struct unpack_trees_opti=
ons *o, struct cache_entry *ce,
 			ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 }
=20
-static void add_entry(struct unpack_trees_options *o, struct cache_ent=
ry *ce,
-	unsigned int set, unsigned int clear)
+static struct cache_entry *dup_entry(const struct cache_entry *ce)
 {
 	unsigned int size =3D ce_size(ce);
 	struct cache_entry *new =3D xmalloc(size);
=20
 	memcpy(new, ce, size);
-	do_add_entry(o, new, set, clear);
+	return new;
+}
+
+static void add_entry(struct unpack_trees_options *o,
+		      const struct cache_entry *ce,
+		      unsigned int set, unsigned int clear)
+{
+	do_add_entry(o, dup_entry(ce), set, clear);
 }
=20
 /*
--=20
1.8.3
