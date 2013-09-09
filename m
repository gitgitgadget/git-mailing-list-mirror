From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 14/16] pack v4: support "end-of-pack" indicator in index-pack and pack-objects
Date: Mon,  9 Sep 2013 20:58:05 +0700
Message-ID: <1378735087-4813-15-git-send-email-pclouds@gmail.com>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 15:56:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ1xV-0004NT-Tk
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 15:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525Ab3IIN4t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 09:56:49 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:39715 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab3IIN4s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 09:56:48 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so6247679pab.20
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 06:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=34casH38HGcAbgWIyjMx+cZbeXSq03cr4VO4kCyX9X0=;
        b=JQ0ZqhuDD0CCZfPF832xyiVoqQ5lYVI52NF5kJPkjq4OGALkGHouT5yRzDLTF5a/HN
         ZVohIq23BQvKRWaorlPbw4dD1ied87uDzWGSanwFy+23K+5bgdkN4MSjQ1c3XaisLMzH
         t/aQbWuRTxPqrXyjw+12TGlWSYezlvIjLM/9AJ/oGobp0rF2XVPXwKJkVm1LiUO4ie4c
         m0aM7iuGCLO4BkvzRBj40CIl8FGZYQfB/HpMeBLiluyqlfrrMPd3VUPAvVMb+XgixQPb
         5siQIjc09ZZ4qR92w4JYTELl8+cJoXpE879EKVZipyhUB56T7otsHOMlHbhBfNclIlZ5
         dIyg==
X-Received: by 10.67.5.132 with SMTP id cm4mr2021755pad.186.1378735007925;
        Mon, 09 Sep 2013 06:56:47 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id nv6sm16459360pbc.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Sep 2013 06:56:47 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Sep 2013 20:59:57 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234342>

In v2, the number of objects in the pack header indicates how many
objects are sent. In v4 this is no longer true, that number includes
the base objects ommitted by pack-objects. An "end-of-pack" is
inserted just before the final SHA-1 to let index-pack knows when to
stop. The EOP is zero (in variable length encoding it means type zero,
OBJ_NONE, and size zero)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c   | 29 +++++++++++++++++++++++++----
 builtin/pack-objects.c | 15 +++++++++++----
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 88340b5..9036f3e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1493,7 +1493,7 @@ static void parse_dictionaries(void)
  */
 static void parse_pack_objects(unsigned char *sha1)
 {
-	int i, nr_delays =3D 0;
+	int i, nr_delays =3D 0, eop =3D 0;
 	struct stat st;
=20
 	if (verbose)
@@ -1502,7 +1502,28 @@ static void parse_pack_objects(unsigned char *sh=
a1)
 				nr_objects);
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
-		void *data =3D unpack_raw_entry(obj, obj->idx.sha1);
+		void *data;
+
+		if (packv4) {
+			unsigned char *eop_byte;
+			flush();
+			/* Got End-of-Pack signal? */
+			eop_byte =3D fill(1);
+			if (*eop_byte =3D=3D 0) {
+				git_SHA1_Update(&input_ctx, eop_byte, 1);
+				use(1);
+				/*
+				 * consumed by is used to mark the end
+				 * of the object right after this
+				 * loop. Undo use() effect.
+				 */
+				consumed_bytes--;
+				eop =3D 1; /* so we don't flush() again */
+				break;
+			}
+		}
+
+		data =3D unpack_raw_entry(obj, obj->idx.sha1);
 		if (is_delta_type(obj->type) || is_delta_tree(obj)) {
 			/* delay sha1_object() until second pass */
 		} else if (!data) {
@@ -1521,8 +1542,8 @@ static void parse_pack_objects(unsigned char *sha=
1)
 	objects[i].idx.offset =3D consumed_bytes;
 	stop_progress(&progress);
=20
-	/* Check pack integrity */
-	flush();
+	if (!eop)
+		flush();	/* Check pack integrity */
 	git_SHA1_Final(sha1, &input_ctx);
 	if (hashcmp(fill(20), sha1))
 		die(_("pack is corrupted (SHA1 mismatch)"));
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 12d9af4..1efb728 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -865,15 +865,22 @@ static void write_pack_file(void)
 			display_progress(progress_state, written);
 		}
=20
-		/*
-		 * Did we write the wrong # entries in the header?
-		 * If so, rewrite it like in fast-import
-		 */
 		if (pack_to_stdout) {
+			unsigned char type_zero =3D 0;
+			/*
+			 * Pack v4 thin pack is terminated by a "type
+			 * 0, size 0" in variable length encoding
+			 */
+			if (pack_version =3D=3D 4 && nr_written < nr_objects)
+				sha1write(f, &type_zero, 1);
 			sha1close(f, sha1, CSUM_CLOSE);
 		} else if (nr_written =3D=3D nr_remaining) {
 			sha1close(f, sha1, CSUM_FSYNC);
 		} else {
+			/*
+			 * Did we write the wrong # entries in the header?
+			 * If so, rewrite it like in fast-import
+			 */
 			int fd =3D sha1close(f, sha1, 0);
 			fixup_pack_header_footer(fd, sha1, pack_tmp_name,
 						 nr_written, sha1, offset);
--=20
1.8.2.83.gc99314b
