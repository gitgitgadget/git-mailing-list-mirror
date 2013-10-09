From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/9] pv4_tree_desc: complete interface
Date: Wed,  9 Oct 2013 21:46:13 +0700
Message-ID: <1381329976-32082-7-git-send-email-pclouds@gmail.com>
References: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Oct 09 16:43:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTuzI-0007dY-7l
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 16:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755663Ab3JIOna convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Oct 2013 10:43:30 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:64664 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642Ab3JIOn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 10:43:29 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so982141pbc.8
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 07:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mmdhuzP5DHR8BTdXhZR25WdLfyfqNK3QWvRaXInO968=;
        b=Bxvtq1lX60Ke1NqGPqE6m8jscqv4p983w0TJ0JAmKNAn0RsTH2Ec6lV/nZa9gxiO8D
         sBpHSi0iXJuSP6aEsCHbsaBSHq+3oz27cnlA0mz5stYU+93xWrTVTrFG4UNwr+06lVij
         eZiDGrdBlFT4XWfrjOJMKBzYh6hRuBbizTtIM6Fa73OEFvbyutCsESNfnfrJUmHuRG+J
         0Xsq5zvRecBW4Ew0ZSlHfGqFwf7vhCKBgqXk3ly+n4biGCisOBRbyJus22VLM3W5KzW/
         FNhQWUQOEzPFb+96x0kNMk4tUXRaNwG1c3mhP/hnN7yHLBWf15+AzkueXRYTxoQTNVr2
         ChZA==
X-Received: by 10.66.25.102 with SMTP id b6mr9774736pag.129.1381329808389;
        Wed, 09 Oct 2013 07:43:28 -0700 (PDT)
Received: from lanh ([115.73.225.201])
        by mx.google.com with ESMTPSA id a6sm439827pbr.17.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 07:43:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Oct 2013 21:47:10 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235819>

Best "explained" with an example

  void walk(const unsigned char *sha1)
  {
    struct pv4_tree_desc desc;
    /*
     * Start pv4_tree_desc from an SHA-1. If it's a v4 tree, v4 walker
     * will be used. Otherwise v2 is walked.
     */
    pv4_tree_desc_from_sha1(&desc, sha1, 0);
    recurse(&desc);
    pv4_release_tree_desc(&desc);
  }

  void recurse(struct pv4_tree_desc *desc)
  {
    /*
     * Then you can go over entries, one by one, similar to the
     * current tree walker. Current entry is in desc->v2.entry.
     * Pathlen in desc->pathlen. Do not use tree_entry_len() because
     * that one is only correct for v2 entries
     */
    while (pv4_get_entry(desc)) {
      printf("%s %s\n", sha1_to_hex(desc->v2.entry.sha1),
             desc->v2.entry.path);

      /*
       * Once you have an initialized pv4_tree_desc you may skip the
       * SHA-1 lookup step if the next tree is in the same pack.
       */
      if (S_ISDIR(desc->v2.entry.mode)) {
        struct pv4_tree_desc new_desc;
        pv4_tree_desc_from_entry(&new_desc, desc);
        recurse(&new_desc);

        /* Finally release everything */
        pv4_release_tree_desc(&new_desc);
      }
    }
  }

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 packv4-parse.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 packv4-parse.h | 12 +++++++++
 2 files changed, 92 insertions(+)

diff --git a/packv4-parse.c b/packv4-parse.c
index f222456..7d257af 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -732,3 +732,83 @@ unsigned long pv4_unpack_object_header_buffer(cons=
t unsigned char *base,
 	*sizep =3D val >> 4;
 	return cp - base;
 }
+
+int pv4_tree_desc_from_sha1(struct pv4_tree_desc *desc,
+			    const unsigned char *sha1,
+			    unsigned flags)
+{
+	unsigned long size;
+	enum object_type type;
+	void *data;
+	struct object_info oi;
+
+	assert(!(flags & ~0xff) &&
+	       "you are not supposed to set these from outside!");
+
+	memset(desc, 0, sizeof(*desc));
+	strbuf_init(&desc->buf, 0);
+
+	memset(&oi, 0, sizeof(oi));
+	if (!sha1_object_info_extended(sha1, &oi) &&
+	    oi.whence =3D=3D OI_PACKED &&
+	    oi.u.packed.real_type =3D=3D OBJ_PV4_TREE &&
+	    oi.u.packed.pack->version >=3D 4) {
+		desc->p =3D oi.u.packed.pack;
+		desc->obj_offset =3D oi.u.packed.offset;
+		desc->flags =3D flags;
+		return 0;
+	}
+
+	data =3D read_sha1_file(sha1, &type, &size);
+	if (!data || type !=3D OBJ_TREE) {
+		free(data);
+		return -1;
+	}
+	desc->flags =3D flags;
+	desc->flags |=3D PV4_TREE_CANONICAL;
+	init_tree_desc(&desc->v2, data, size);
+	/*
+	 * we can attach to strbuf because read_sha1_file always
+	 * appends NUL at the end
+	 */
+	strbuf_attach(&desc->buf, data, size, size + 1);
+	return 0;
+}
+
+int pv4_tree_desc_from_entry(struct pv4_tree_desc *desc,
+			     const struct pv4_tree_desc *src,
+			     unsigned flags)
+{
+	if (!src->sha1_index)
+		return pv4_tree_desc_from_sha1(desc,
+					       src->v2.entry.sha1,
+					       flags);
+	assert(!(flags & ~0xff) &&
+	       "you are not supposed to set these from outside!");
+	memset(desc, 0, sizeof(*desc));
+	strbuf_init(&desc->buf, 0);
+	desc->p =3D src->p;
+	desc->obj_offset =3D
+		nth_packed_object_offset(desc->p, src->sha1_index - 1);
+	desc->flags =3D flags;
+	return 0;
+}
+
+void pv4_release_tree_desc(struct pv4_tree_desc *desc)
+{
+	strbuf_release(&desc->buf);
+	unuse_pack(&desc->w_curs);
+}
+
+int pv4_tree_entry(struct pv4_tree_desc *desc)
+{
+	if (desc->flags & PV4_TREE_CANONICAL) {
+		if (!desc->v2.size)
+			return 0;
+		if (desc->start)
+			update_tree_entry(&desc->v2);
+		desc->start++;
+		return 1;
+	}
+	return !decode_entries(desc, desc->obj_offset, desc->start++, 1);
+}
diff --git a/packv4-parse.h b/packv4-parse.h
index fe0ea38..874f57c 100644
--- a/packv4-parse.h
+++ b/packv4-parse.h
@@ -36,6 +36,8 @@ struct pv4_tree_desc {
 	/* v4 entry */
 	struct packed_git *p;
 	struct pack_window *w_curs;
+	off_t obj_offset;
+	unsigned start;
 	unsigned int sha1_index;
 	int pathlen;
=20
@@ -46,4 +48,14 @@ struct pv4_tree_desc {
 	struct strbuf buf;
 };
=20
+int pv4_tree_desc_from_sha1(struct pv4_tree_desc *desc,
+			    const unsigned char *sha1,
+			    unsigned flags);
+int pv4_tree_desc_from_entry(struct pv4_tree_desc *desc,
+			     const struct pv4_tree_desc *src,
+			     unsigned flags);
+void pv4_release_tree_desc(struct pv4_tree_desc *desc);
+
+int pv4_tree_entry(struct pv4_tree_desc *desc);
+
 #endif
--=20
1.8.2.83.gc99314b
