From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] index-pack, unpack-objects: add --not-so-strict for connectivity check
Date: Sun, 31 Mar 2013 18:09:07 +0700
Message-ID: <1364728148-7537-4-git-send-email-pclouds@gmail.com>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 31 13:09:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMG92-0007Lf-A6
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 13:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570Ab3CaLJY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 07:09:24 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:64003 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab3CaLJX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 07:09:23 -0400
Received: by mail-pb0-f42.google.com with SMTP id up7so137718pbc.29
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 04:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=A3W0yK/HgYcRPQo22+pXbDG/dwbvkYTSS2wpBGI3X0Q=;
        b=VUPhJ3Sefho0GNqwt4vKllCgQ0Qv7Gk+RcmvFrhpLNsPP9S71xOUJlit0FFxDeQ3i+
         b20Ir4krMoB0Q3n9VCPHoDlf/mC8X17BvKqQgaAWVcV/bvQwryxXOk8yJzAN0j1oejPP
         NhFKMRhZlOgRCMiAUXYSihx5oZxUJ+j3KmGQsus36xo10OQ9QMzbk73FqApJQvFUSWxJ
         rhqb63cxsdVMlMDlHyiiopb/LhVQcHskRJi3wQiSP58/U4sXIFyt1ehCjTTG7QxC0Hdc
         NjjuVn8I1HZPCQBxt5lLOsAc/kY3xeHwcb6nKUDRcs/EuVlUYRbuX6rn2Q1s4VoH0pYx
         r+gg==
X-Received: by 10.68.212.104 with SMTP id nj8mr12724692pbc.197.1364728162861;
        Sun, 31 Mar 2013 04:09:22 -0700 (PDT)
Received: from lanh ([115.74.58.181])
        by mx.google.com with ESMTPS id gf1sm9703509pbb.33.2013.03.31.04.09.19
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 31 Mar 2013 04:09:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 31 Mar 2013 18:09:29 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219613>

--not-so-strict only checks if all links from objects in the pack
point to real objects (either in current repo, or from the pack
itself). It's like check_everything_connected() except that:

 - it does not follow DAG in order
 - it can detect incomplete object islands
 - it seems to be faster than "rev-list --objects --all"

On my box, "rev-list --objects --all" takes 34 seconds. index-pack take=
s

215.25user 8.42system 1:32.31elapsed 242%CPU (0avgtext+0avgdata 1357328=
maxresident)k
0inputs+1421016outputs (0major+1222987minor)pagefaults 0swaps

And index-pack --not-so-strict takes

pack    96a4e3befa40bf38eddc2d7c99246a59af4ad55d
229.75user 11.31system 1:42.50elapsed 235%CPU (0avgtext+0avgdata 187681=
6maxresident)k
0inputs+1421016outputs (0major+1307989minor)pagefaults 0swaps

The overhead is about 10 seconds, just 1/3 of rev-list, which makes it
in a better position to replace check_everything_connected(). If this
holds true for general case, it could reduce fetch time by a little bit=
=2E

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c     | 7 ++++++-
 builtin/unpack-objects.c | 9 +++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index fdac7c7..3cded32 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -77,6 +77,7 @@ static int nr_threads;
=20
 static int from_stdin;
 static int strict;
+static int do_fsck_object;
 static int verbose;
=20
 static struct progress *progress;
@@ -744,7 +745,8 @@ static void sha1_object(const void *data, struct ob=
ject_entry *obj_entry,
 			obj =3D parse_object_buffer(sha1, type, size, buf, &eaten);
 			if (!obj)
 				die(_("invalid %s"), typename(type));
-			if (fsck_object(obj, 1, fsck_error_function))
+			if (do_fsck_object &&
+			    fsck_object(obj, 1, fsck_error_function))
 				die(_("Error in object"));
 			if (fsck_walk(obj, mark_link, NULL))
 				die(_("Not all child objects of %s are reachable"), sha1_to_hex(ob=
j->sha1));
@@ -1491,6 +1493,9 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 				fix_thin_pack =3D 1;
 			} else if (!strcmp(arg, "--strict")) {
 				strict =3D 1;
+				do_fsck_object =3D 1;
+			} else if (!strcmp(arg, "--not-so-strict")) {
+				strict =3D 1;
 			} else if (!strcmp(arg, "--verify")) {
 				verify =3D 1;
 			} else if (!strcmp(arg, "--verify-stat")) {
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 2217d7b..dd0518b 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -12,7 +12,7 @@
 #include "decorate.h"
 #include "fsck.h"
=20
-static int dry_run, quiet, recover, has_errors, strict;
+static int dry_run, quiet, recover, has_errors, strict, do_fsck_object=
;
 static const char unpack_usage[] =3D "git unpack-objects [-n] [-q] [-r=
] [--strict] < pack-file";
=20
 /* We always read in 4kB chunks. */
@@ -198,7 +198,7 @@ static int check_object(struct object *obj, int typ=
e, void *data)
 		return 0;
 	}
=20
-	if (fsck_object(obj, 1, fsck_error_function))
+	if (do_fsck_object && fsck_object(obj, 1, fsck_error_function))
 		die("Error in object");
 	if (fsck_walk(obj, check_object, NULL))
 		die("Error on reachable objects of %s", sha1_to_hex(obj->sha1));
@@ -520,6 +520,11 @@ int cmd_unpack_objects(int argc, const char **argv=
, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--strict")) {
+				do_fsck_object =3D 1;
+				strict =3D 1;
+				continue;
+			}
+			if (!strcmp(arg, "--not-so-strict")) {
 				strict =3D 1;
 				continue;
 			}
--=20
1.8.2.83.gc99314b
