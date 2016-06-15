From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/11] index-pack: split second pass obj handling into own function
Date: Mon, 27 Feb 2012 14:55:11 +0700
Message-ID: <1330329315-11407-8-git-send-email-pclouds@gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 08:57:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1vSQ-0007OY-N0
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 08:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576Ab2B0H4x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 02:56:53 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56349 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab2B0H4w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 02:56:52 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so834292dae.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 23:56:51 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.222.39 as permitted sender) client-ip=10.68.222.39;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.222.39 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.222.39])
        by 10.68.222.39 with SMTP id qj7mr35555244pbc.114.1330329411822 (num_hops = 1);
        Sun, 26 Feb 2012 23:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sWRxQ6nJ56g4dp9jmbrwRfVtgr1JdMWzF8cB2jCmUCI=;
        b=QwJtoRnAlMQmv841bLT2xtw8CTv6cuhQKbzsdHB0fHMzQs2j/CrABGHf8F7bi/Fk+E
         fMRXpDYhXIw486w4QmhAM5JYmjFMQmOQ4gzNIBCKFscuoMBpeKriony8eDQ49x6ZHOva
         U3Eqqfuyzba04DY/Ecgl78/35izWQ9yWQYLQM=
Received: by 10.68.222.39 with SMTP id qj7mr30270453pbc.114.1330329411788;
        Sun, 26 Feb 2012 23:56:51 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id q8sm12055649pbi.1.2012.02.26.23.56.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 26 Feb 2012 23:56:50 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 27 Feb 2012 14:56:27 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191614>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index cee83b9..e3cb684 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -683,6 +683,23 @@ static int compare_delta_entry(const void *a, cons=
t void *b)
 				   objects[delta_b->obj_no].type);
 }
=20
+/*
+ * Second pass:
+ * - for all non-delta objects, look if it is used as a base for
+ *   deltas;
+ * - if used as a base, uncompress the object and apply all deltas,
+ *   recursively checking if the resulting object is used as a base
+ *   for some more deltas.
+ */
+static void second_pass(struct object_entry *obj)
+{
+	struct base_data *base_obj =3D alloc_base_data();
+	base_obj->obj =3D obj;
+	base_obj->data =3D NULL;
+	find_unresolved_deltas(base_obj);
+	display_progress(progress, nr_resolved_deltas);
+}
+
 /* Parse all objects and return the pack content SHA1 hash */
 static void parse_pack_objects(unsigned char *sha1)
 {
@@ -737,26 +754,14 @@ static void parse_pack_objects(unsigned char *sha=
1)
 	qsort(deltas, nr_deltas, sizeof(struct delta_entry),
 	      compare_delta_entry);
=20
-	/*
-	 * Second pass:
-	 * - for all non-delta objects, look if it is used as a base for
-	 *   deltas;
-	 * - if used as a base, uncompress the object and apply all deltas,
-	 *   recursively checking if the resulting object is used as a base
-	 *   for some more deltas.
-	 */
 	if (verbose)
 		progress =3D start_progress("Resolving deltas", nr_deltas);
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
-		struct base_data *base_obj =3D alloc_base_data();
=20
 		if (is_delta_type(obj->type))
 			continue;
-		base_obj->obj =3D obj;
-		base_obj->data =3D NULL;
-		find_unresolved_deltas(base_obj);
-		display_progress(progress, nr_resolved_deltas);
+		second_pass(obj);
 	}
 }
=20
--=20
1.7.3.1.256.g2539c.dirty
