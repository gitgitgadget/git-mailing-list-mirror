From: =?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
Subject: [PATCH v2 2/4] textconv: support for cat_file
Date: Tue,  8 Jun 2010 15:49:16 +0200
Message-ID: <1276004958-13540-3-git-send-email-clement.poulain@ensimag.imag.fr>
References: <1276004958-13540-1-git-send-email-clement.poulain@ensimag.imag.fr>
 <1276004958-13540-2-git-send-email-clement.poulain@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 08 15:49:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLzBa-0003Ii-CN
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 15:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296Ab0FHNtn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 09:49:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35900 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755259Ab0FHNtm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 09:49:42 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o58Dg02K021066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 8 Jun 2010 15:42:00 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o58DndY3027957;
	Tue, 8 Jun 2010 15:49:39 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o58Dndbn013670;
	Tue, 8 Jun 2010 15:49:39 +0200
Received: (from poulainc@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o58DndxM013669;
	Tue, 8 Jun 2010 15:49:39 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1276004958-13540-2-git-send-email-clement.poulain@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 08 Jun 2010 15:42:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o58Dg02K021066
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: clement.poulain@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148670>

Make the textconv_object function public, and add --textconv option to =
cat-file
to perform conversion on blob objects. Using --textconv implies that we=
 are
working on a blob.
As files drivers need to be initialized, a new config is required in ad=
dition
to git_default_config. Therefore git_cat_file_config() is introduced

Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>=20
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>=20
---
 builtin/blame.c    |    8 ++++----
 builtin/cat-file.c |   32 +++++++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index f831e3a..64605f5 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -91,10 +91,10 @@ struct origin {
  * if the textconv driver exists.
  * Return 1 if the conversion succeeds, 0 otherwise.
  */
-static int textconv_object(const char *path,
-			   const unsigned char *sha1,
-			   char **buf,
-			   size_t *buf_size)
+int textconv_object(const char *path,
+		    const unsigned char *sha1,
+		    char **buf,
+		    size_t *buf_size)
 {
 	struct diff_filespec *df;
 	struct userdiff_driver *textconv;
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index a933eaa..1457340 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -9,6 +9,7 @@
 #include "tree.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "diff.h"
=20
 #define BATCH 1
 #define BATCH_CHECK 2
@@ -86,8 +87,9 @@ static int cat_one_file(int opt, const char *exp_type=
, const char *obj_name)
 	enum object_type type;
 	void *buf;
 	unsigned long size;
+	struct object_context obj_context =3D OBJECT_CONTEXT_INIT;
=20
-	if (get_sha1(obj_name, sha1))
+	if (get_sha1_with_context(obj_name, sha1, &obj_context))
 		die("Not a valid object name %s", obj_name);
=20
 	buf =3D NULL;
@@ -132,6 +134,17 @@ static int cat_one_file(int opt, const char *exp_t=
ype, const char *obj_name)
=20
 		/* otherwise just spit out the data */
 		break;
+
+	case 'c':
+		if (!obj_context.path)
+			die("git cat-file --textconv %s: <object> must be <sha1:path>",
+			    obj_name);
+
+		if(!textconv_object(obj_context.path, sha1, &buf, (size_t *) &size))
+			die("git cat-file --textconv: unable to run textconv on %s",
+			    obj_name);
+		break;
+
 	case 0:
 		buf =3D read_object_with_reference(sha1, exp_type, &size, NULL);
 		break;
@@ -201,11 +214,22 @@ static int batch_objects(int print_contents)
 }
=20
 static const char * const cat_file_usage[] =3D {
-	"git cat-file (-t|-s|-e|-p|<type>) <object>",
+	"git cat-file (-t|-s|-e|-p|<type>|--textconv) <object>",
 	"git cat-file (--batch|--batch-check) < <list_of_objects>",
 	NULL
 };
=20
+static int git_cat_file_config(const char *var, const char *value, voi=
d *cb)
+{
+	switch (userdiff_config(var, value)) {
+		case 0: break;
+		case -1: return -1;
+		default: return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
 int cmd_cat_file(int argc, const char **argv, const char *prefix)
 {
 	int opt =3D 0, batch =3D 0;
@@ -218,6 +242,8 @@ int cmd_cat_file(int argc, const char **argv, const=
 char *prefix)
 		OPT_SET_INT('e', NULL, &opt,
 			    "exit with zero when there's no error", 'e'),
 		OPT_SET_INT('p', NULL, &opt, "pretty-print object's content", 'p'),
+		OPT_SET_INT(0, "textconv", &opt,
+				"for blob objects, run textconv on object's content", 'c'),
 		OPT_SET_INT(0, "batch", &batch,
 			    "show info and content of objects fed from the standard input",
 			    BATCH),
@@ -227,7 +253,7 @@ int cmd_cat_file(int argc, const char **argv, const=
 char *prefix)
 		OPT_END()
 	};
=20
-	git_config(git_default_config, NULL);
+	git_config(git_cat_file_config, NULL);
=20
 	if (argc !=3D 3 && argc !=3D 2)
 		usage_with_options(cat_file_usage, options);
--=20
1.7.1.202.g79415.dirty
