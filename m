From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/21] fixup! pack-objects: support writing pack v4
Date: Wed, 11 Sep 2013 13:06:03 +0700
Message-ID: <1378879582-15372-3-git-send-email-pclouds@gmail.com>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
 <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 08:07:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJda5-0004m3-HB
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754975Ab3IKGHI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:07:08 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:46277 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165Ab3IKGHH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:07:07 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so8553449pbc.36
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sKCnEHNfJVQABXzdLqYfRHMGXyL39zFwOcg+D/cvMFU=;
        b=ShqejryZeZrXUNyr3xaTMqYcR9sehJ85jbC2u0WevFgae3VGJ3jiqu4HZInG9T7NHh
         dn6z1eHyM+nfDOf6iCFNYet55I4KHfhI3ycXm7LMI6yZlQwbbkd9zSamBGiAdXpWe7Zo
         MthLXZ4gVww9UuUv01sIAIN4ytc2pNDtJ7VXHuJguvhOBt7fGXKyr+vdN7M930qdg/1b
         vrQqBwe1lUbP2RU4RuFj86ENjmMuY19+1McBfoxFJxuB36BXtvrUhRwK2O9cvqmMop1v
         ZI78zNi27II43JgJE4QB1OlnKc7dNgK0xHI+cxzJbBTu67nhQ2aSPcfTKWnjD2sNp2Nl
         Luwg==
X-Received: by 10.66.141.199 with SMTP id rq7mr1761368pab.9.1378879624499;
        Tue, 10 Sep 2013 23:07:04 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id y5sm27445754pbs.18.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:07:03 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:06:53 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234526>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 by setting usable_delta to zero, I disable tree delta in
 pack-objects. Some test cases spotted this.

 builtin/pack-objects.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 945b817..b60b1a0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -256,7 +256,12 @@ static unsigned long write_no_reuse_object(struct =
sha1file *f, struct object_ent
 	struct git_istream *st =3D NULL;
 	char *result =3D "OK";
=20
-	if (!usable_delta) {
+	if (!usable_delta ||
+	    /*
+	     * Force loading canonical tree. In future we may want to
+	     * read v4 trees directly instead.
+	     */
+	    (pack_version =3D=3D 4 && entry->type =3D=3D OBJ_TREE)) {
 		if (entry->type =3D=3D OBJ_BLOB &&
 		    entry->size > big_file_threshold &&
 		    (st =3D open_istream(entry->idx.sha1, &type, &size, NULL)) !=3D =
NULL)
@@ -518,9 +523,6 @@ static unsigned long write_object(struct sha1file *=
f,
 	else
 		usable_delta =3D 0;	/* base could end up in another pack */
=20
-	if (pack_version =3D=3D 4 && entry->type =3D=3D OBJ_TREE)
-		usable_delta =3D 0;
-
 	if (!reuse_object)
 		to_reuse =3D 0;	/* explicit */
 	else if (!entry->in_pack)
--=20
1.8.2.82.gc24b958
