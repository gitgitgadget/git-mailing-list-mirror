From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/7] unpack-trees: factor out dup_entry
Date: Thu, 30 May 2013 13:34:20 +0200
Message-ID: <1369913664-49734-4-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1369913664-49734-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 13:34:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui181-0006iS-VL
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 13:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932887Ab3E3Len convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 07:34:43 -0400
Received: from india601.server4you.de ([85.25.151.105]:57598 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932286Ab3E3Leb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 07:34:31 -0400
Received: from debian.Speedport_W_504V_Typ_A (p579BEB6E.dip0.t-ipconnect.de [87.155.235.110])
	by india601.server4you.de (Postfix) with ESMTPSA id DBBDA44E;
	Thu, 30 May 2013 13:34:29 +0200 (CEST)
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1369913664-49734-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225962>

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
