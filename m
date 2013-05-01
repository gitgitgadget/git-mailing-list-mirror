From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/5] index-pack, unpack-objects: add --not-so-strict for connectivity check
Date: Wed,  1 May 2013 17:59:33 +0700
Message-ID: <1367405974-22190-5-git-send-email-pclouds@gmail.com>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
 <1367405974-22190-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 12:59:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXUkr-0007QI-Cx
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 12:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760693Ab3EAK7S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 May 2013 06:59:18 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:37344 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759472Ab3EAK7O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 06:59:14 -0400
Received: by mail-pa0-f48.google.com with SMTP id lb1so815334pab.35
        for <git@vger.kernel.org>; Wed, 01 May 2013 03:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=KbqLMulQ4pe0azoeyPlDl7ftXigiMVL7CgTNV5B9n8w=;
        b=0s9zKyNRMoNV3GsKMLq27CibrHm2ADfwVWh60gpthT3jmKS0Ev7RA8/4Vub2xYmC91
         Cd1HgMyNVORhd9XJgcHy/aIlrDcB+pYs2a26ZowyA0GaQUSG0ae1XwNkwa+vWjdI53dY
         p9yAk1o2YEI7D7/ehENYPi7YWHHXGzvg/uIvitSmwwkMotezEz/JhokeeVSg4UVH5Ps1
         Xu4X8SmmM2/qjvgazm40nwcgcIbJODroH3Y4sxxAqDZoNcBCbhmhfYh44ShZ+YauQdiI
         qt1uwkmZv5dPzfCFhNGQBRKGbHh5A/fGpOJASWeNXC/sNsejEB0JMx7J90FeXN4q99gV
         +Y/Q==
X-Received: by 10.68.203.101 with SMTP id kp5mr3664855pbc.16.1367405953679;
        Wed, 01 May 2013 03:59:13 -0700 (PDT)
Received: from lanh ([115.74.47.19])
        by mx.google.com with ESMTPSA id aa8sm3233214pad.14.2013.05.01.03.59.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 03:59:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 01 May 2013 18:00:03 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367405974-22190-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223084>

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
 Documentation/git-index-pack.txt     | 3 +++
 Documentation/git-unpack-objects.txt | 4 ++++
 builtin/index-pack.c                 | 7 ++++++-
 builtin/unpack-objects.c             | 9 +++++++--
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index=
-pack.txt
index bde8eec..51af7be 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -74,6 +74,9 @@ OPTIONS
 --strict::
 	Die, if the pack contains broken objects or links.
=20
+--not-so-strict::
+	Die if the pack contains broken links. For internal use only.
+
 --threads=3D<n>::
 	Specifies the number of threads to spawn when resolving
 	deltas. This requires that index-pack be compiled with
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-u=
npack-objects.txt
index ff23494..14b6018 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -44,6 +44,10 @@ OPTIONS
 --strict::
 	Don't write objects with broken content or links.
=20
+--not-so-strict::
+	Don't write objects with broken links. For internal
+	use only.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1fd56d9..5d28a1b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -77,6 +77,7 @@ static int nr_threads;
=20
 static int from_stdin;
 static int strict;
+static int do_fsck_object;
 static int verbose;
 static int show_stat;
=20
@@ -756,7 +757,8 @@ static void sha1_object(const void *data, struct ob=
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
@@ -1511,6 +1513,9 @@ int cmd_index_pack(int argc, const char **argv, c=
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
