From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Set hard limit on delta chain depth
Date: Mon,  5 Dec 2011 14:04:48 +0700
Message-ID: <1323068688-31481-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 08:05:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXSc7-0004yu-8F
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 08:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994Ab1LEHFP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Dec 2011 02:05:15 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41961 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab1LEHFN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 02:05:13 -0500
Received: by ghrr1 with SMTP id r1so4132500ghr.19
        for <git@vger.kernel.org>; Sun, 04 Dec 2011 23:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=gXrsZ0sBB9Na9RcpA3UFYn7IpG75o+x12H8aHq8ZH1k=;
        b=sYLTSvnwhkTvRO8KMw43d4qERUuvFG6XG4zNpdpNwqftv7eR7sQn5NYOwp6Mw4MH3I
         dRFzGf/cZugHVvVbUNtXTH+N0hp+qxfDfzx6T9sxGu6Y6GyGrtA44F/WXqpwNQuUTZZn
         gCny3yTtvV/VZL0cl0aDaKRv6gWqfyuqzAMbs=
Received: by 10.50.42.166 with SMTP id p6mr8882261igl.17.1323068712965;
        Sun, 04 Dec 2011 23:05:12 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.41.182])
        by mx.google.com with ESMTPS id mb4sm40649842igc.1.2011.12.04.23.05.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Dec 2011 23:05:12 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 05 Dec 2011 14:04:59 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186278>

Too deep delta chains can cause stack overflow in get_base_data(). Set
a hard limit so that index-pack does not run out of stack. Also stop
people from producing such a long delta chains using "pack-object
--depth=3D<too large>"

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I used to make very long delta chains and triggered this in index-pack=
=2E
 I did not care reporting because it's my fault anyway. Think again,
 index-pack is called at server side and a malicious client can
 trigger this. This patch does not improve the situation much, but at
 least we won't get sigsegv at server side.

 builtin/index-pack.c   |   12 ++++++++++--
 builtin/pack-objects.c |    3 +++
 pack.h                 |    2 ++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0945adb..cfb8cb2 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -504,13 +504,16 @@ static int is_delta_type(enum object_type type)
 	return (type =3D=3D OBJ_REF_DELTA || type =3D=3D OBJ_OFS_DELTA);
 }
=20
-static void *get_base_data(struct base_data *c)
+static void *get_base_data_1(struct base_data *c, int depth)
 {
+	if (depth > MAX_DELTA_DEPTH)
+		die("index-pack: too long delta chain");
+
 	if (!c->data) {
 		struct object_entry *obj =3D c->obj;
=20
 		if (is_delta_type(obj->type)) {
-			void *base =3D get_base_data(c->base);
+			void *base =3D get_base_data_1(c->base, depth + 1);
 			void *raw =3D get_data_from_pack(obj);
 			c->data =3D patch_delta(
 				base, c->base->size,
@@ -530,6 +533,11 @@ static void *get_base_data(struct base_data *c)
 	return c->data;
 }
=20
+static void *get_base_data(struct base_data *c)
+{
+	return get_base_data_1(c, 0);
+}
+
 static void resolve_delta(struct object_entry *delta_obj,
 			  struct base_data *base, struct base_data *result)
 {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 824ecee..85ee04b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2508,6 +2508,9 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
 	if (keep_unreachable && unpack_unreachable)
 		die("--keep-unreachable and --unpack-unreachable are incompatible.")=
;
=20
+	if (depth > MAX_DELTA_DEPTH)
+		die("--depth exceeds %d", MAX_DELTA_DEPTH);
+
 	if (progress && all_progress_implied)
 		progress =3D 2;
=20
diff --git a/pack.h b/pack.h
index 722a54e..b8f60c3 100644
--- a/pack.h
+++ b/pack.h
@@ -3,6 +3,8 @@
=20
 #include "object.h"
=20
+#define MAX_DELTA_DEPTH 128
+
 /*
  * Packed object header
  */
--=20
1.7.8.36.g69ee2
