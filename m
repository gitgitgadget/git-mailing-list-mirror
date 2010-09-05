From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/17] write-tree: requires --narrow-base in narrow repository
Date: Sun,  5 Sep 2010 16:47:42 +1000
Message-ID: <1283669264-15759-16-git-send-email-pclouds@gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:50:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os93p-000058-N1
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638Ab0IEGue convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:50:34 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35545 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab0IEGud (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:50:33 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so717333pwi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=542UKh4o5en/z8p4FAKW+JNbp/gW6U+57cs5V4uIMXg=;
        b=uN6Pgs3T5HEPpjVtDXpN7W+lAmkao/8XxNqiYFmsQPo0K0PhkdJ0FsQAa55DPGXPYT
         5814cn851gEQeHhWhm2eNxSE8XDJho0ctDMgD//pUHWbVIPM0N0voV1Oyl0tiu7lUiBF
         WMGv5iALY9oPVeJWbvgb50guVfA7qninif8gA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=tzVQoQ1Q6WlOIVLY6oEK3n7clOrKDJWuLVgW5WICFMMvn3UHgZEvogP5KxY0G7wxXh
         HRda/xn18Z4/inku+3knMmzgv1EuxXBnCXtYAaeYrUNHW92zZwWTyogUEGydtd9l80Ms
         QnvPHcBG1RNKtz3Zkqp6iHsLpcK2O77s+BMnU=
Received: by 10.142.217.21 with SMTP id p21mr1123851wfg.297.1283669432963;
        Sat, 04 Sep 2010 23:50:32 -0700 (PDT)
Received: from dektop ([119.12.225.18])
        by mx.google.com with ESMTPS id t11sm1978781wfc.22.2010.09.04.23.50.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:50:32 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun,  5 Sep 2010 16:50:23 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155441>

Without a base, a full tree cannot be generated, because the index
does not contain all trees.

--narrow-base is ignored if the repository is not a narrow one.

git-am is modified to "test" write-tree, which makes git-rebase works
in simple cases.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/write-tree.c |   25 +++++++++++++++++++++++++
 git-am.sh            |    2 +-
 2 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index b223af4..5da3cb3 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -8,6 +8,7 @@
 #include "tree.h"
 #include "cache-tree.h"
 #include "parse-options.h"
+#include "narrow-tree.h"
=20
 static const char * const write_tree_usage[] =3D {
 	"git write-tree [--missing-ok] [--prefix=3D<prefix>/]",
@@ -18,6 +19,7 @@ int cmd_write_tree(int argc, const char **argv, const=
 char *unused_prefix)
 {
 	int flags =3D 0, ret;
 	const char *prefix =3D NULL;
+	const char *narrow_str =3D NULL;
 	unsigned char sha1[20];
 	const char *me =3D "git-write-tree";
 	struct option write_tree_options[] =3D {
@@ -26,6 +28,9 @@ int cmd_write_tree(int argc, const char **argv, const=
 char *unused_prefix)
 		{ OPTION_STRING, 0, "prefix", &prefix, "<prefix>/",
 		  "write tree object for a subdirectory <prefix>" ,
 		  PARSE_OPT_LITERAL_ARGHELP },
+		{ OPTION_STRING, 0, "narrow-base", &narrow_str, "base tree",
+		  "base tree in narrow index" ,
+		  PARSE_OPT_LITERAL_ARGHELP },
 		{ OPTION_BIT, 0, "ignore-cache-tree", &flags, NULL,
 		  "only useful for debugging",
 		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, NULL,
@@ -40,6 +45,26 @@ int cmd_write_tree(int argc, const char **argv, cons=
t char *unused_prefix)
 	ret =3D write_cache_as_tree(sha1, flags, prefix);
 	switch (ret) {
 	case 0:
+		if (get_narrow_prefix()) {
+			unsigned char sha1_param[20];
+			unsigned char narrow_base[20];
+			unsigned char old_sha1[20];
+			unsigned long size;
+			void *buf;
+
+			if (!narrow_str)
+				die("write-tree in narrow repo requires --narrow-base");
+
+			if (get_sha1(narrow_str, sha1_param))
+				die("Invalid SHA1 %s", narrow_str);
+			buf =3D read_object_with_reference(sha1_param, tree_type, &size, na=
rrow_base);
+			if (!buf)
+				die("Bad treeish %s", sha1_to_hex(sha1));
+			free(buf);
+			hashcpy(old_sha1, sha1);
+			if (join_narrow_tree(sha1, narrow_base, old_sha1, get_narrow_prefix=
()))
+				die("Failed to join tree");
+		}
 		printf("%s\n", sha1_to_hex(sha1));
 		break;
 	case WRITE_TREE_UNREADABLE_INDEX:
diff --git a/git-am.sh b/git-am.sh
index e7f008c..6adda43 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -783,7 +783,7 @@ do
 		"$GIT_DIR"/hooks/pre-applypatch || stop_here $this
 	fi
=20
-	tree=3D$(git write-tree) &&
+	tree=3D$(git write-tree --narrow-base=3DHEAD) &&
 	commit=3D$(
 		if test -n "$ignore_date"
 		then
--=20
1.7.1.rc1.69.g24c2f7
