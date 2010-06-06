From: =?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
Subject: [RFC/PATCH 1/4] sha1_name: creating context cache
Date: Sun,  6 Jun 2010 13:30:45 +0200
Message-ID: <1275823848-7151-2-git-send-email-clement.poulain@ensimag.imag.fr>
References: <1275823848-7151-1-git-send-email-clement.poulain@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org, drizzd@aon.at, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 06 13:32:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLE59-0005re-W2
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 13:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933087Ab0FFLbx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jun 2010 07:31:53 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42073 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757795Ab0FFLbv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 07:31:51 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o56BOEjf024191
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 Jun 2010 13:24:14 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o56BVl6X007113;
	Sun, 6 Jun 2010 13:31:47 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o56BVl1u008014;
	Sun, 6 Jun 2010 13:31:47 +0200
Received: (from poulainc@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o56BVl6A008013;
	Sun, 6 Jun 2010 13:31:47 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1275823848-7151-1-git-send-email-clement.poulain@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 06 Jun 2010 13:24:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o56BOEjf024191
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: clement.poulain@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148514>

This cache keeps the global context for the last sha1 looked up, especi=
ally its pathname. The textconv is indeed defined by the diff driver, w=
hich is associated with a pathname, not a blob

Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
---
 builtin/cat-file.c |    3 +++
 cache.h            |    8 ++++++++
 sha1_name.c        |   19 +++++++++++++++++++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index a933eaa..124e0a9 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -87,6 +87,9 @@ static int cat_one_file(int opt, const char *exp_type=
, const char *obj_name)
 	void *buf;
 	unsigned long size;
=20
+	struct strbuf sbuf =3D STRBUF_INIT;
+
+	object_resolve_context_init(&object_context);
 	if (get_sha1(obj_name, sha1))
 		die("Not a valid object name %s", obj_name);
=20
diff --git a/cache.h b/cache.h
index 0f4263c..26a1faf 100644
--- a/cache.h
+++ b/cache.h
@@ -730,6 +730,14 @@ static inline unsigned int hexval(unsigned char c)
 #define MINIMUM_ABBREV 4
 #define DEFAULT_ABBREV 7
=20
+struct object_resolve_context {
+	unsigned char tree[20];
+	char path[PATH_MAX];
+	unsigned mode;
+};
+extern struct object_resolve_context object_context;
+void object_resolve_context_init(struct object_resolve_context *orc);
+
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, =
unsigned *mode, int gently, const char *prefix);
 static inline int get_sha1_with_mode(const char *str, unsigned char *s=
ha1, unsigned *mode)
diff --git a/sha1_name.c b/sha1_name.c
index bf92417..093d71a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -7,6 +7,13 @@
 #include "refs.h"
 #include "remote.h"
=20
+struct object_resolve_context object_context;
+
+void object_resolve_context_init(struct object_resolve_context *orc)
+{
+	memset(orc, 0, sizeof(*orc));
+}
+
 static int find_short_object_filename(int len, const char *name, unsig=
ned char *sha1)
 {
 	struct alternate_object_database *alt;
@@ -1059,6 +1066,11 @@ int get_sha1_with_mode_1(const char *name, unsig=
ned char *sha1, unsigned *mode,
 			cp =3D name + 3;
 		}
 		namelen =3D namelen - (cp - name);
+
+		strncpy(object_context.path, cp,
+			sizeof(object_context.path));
+		object_context.path[sizeof(object_context.path)] =3D '\0';
+
 		if (!active_cache)
 			read_cache();
 		pos =3D cache_name_pos(cp, namelen);
@@ -1072,6 +1084,7 @@ int get_sha1_with_mode_1(const char *name, unsign=
ed char *sha1, unsigned *mode,
 			if (ce_stage(ce) =3D=3D stage) {
 				hashcpy(sha1, ce->sha1);
 				*mode =3D ce->ce_mode;
+				object_context.mode =3D *mode;
 				return 0;
 			}
 			pos++;
@@ -1104,6 +1117,12 @@ int get_sha1_with_mode_1(const char *name, unsig=
ned char *sha1, unsigned *mode,
 							   tree_sha1, object_name);
 				free(object_name);
 			}
+			hashcpy(object_context.tree, tree_sha1);
+			strncpy(object_context.path, filename,
+				sizeof(object_context.path));
+			object_context.path[sizeof(object_context.path)] =3D '\0';
+			object_context.mode =3D *mode;
+
 			return ret;
 		} else {
 			if (!gently)
--=20
1.6.6.7.ga5fe3
