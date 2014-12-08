From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 23/23] untracked cache: guard and disable on system changes
Date: Mon,  8 Dec 2014 21:05:07 +0700
Message-ID: <1418047507-22892-25-git-send-email-pclouds@gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 14:56:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxynw-0005MX-W2
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548AbaLHN4p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 08:56:45 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:57555 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbaLHN4o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:56:44 -0500
Received: by mail-pd0-f175.google.com with SMTP id y10so5185516pdj.6
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 05:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2Pl9rx/m5TZ9Z794uRWmaND2yWGGiBqaLOPs83feRwc=;
        b=mBWNhrQyeRoeJ2dDKjQe7uUHp5MDxmaCo3NQOWaTMl4e85IPNX0PjVutkVGv0KdBsP
         01FBGPwjSEnijKXLH6jQRSLEqTl4g4sBIFNLu1D7VnttYHLn/MCxFYtgzeA4w3Ml6kpx
         eme0cpY9gzdpCzYm2JCremXHEvtIiCyNxnTTB6+AdcKzFUv71sgiOQ+KU4qGju8c4yYc
         QrMrVt1Fy+4iCGhzHlmlxjThJR1nCOowydI5rIIFh9XSu0wQ6jl2DAGU5E0T0riog6x8
         5x6UDhTyIu9x2R4Ky0LxPf3n5+s/xvHyMVYhdN7j3YFdZXNa/qF2P2nNQj3tQA1F7C+R
         jCAw==
X-Received: by 10.70.37.104 with SMTP id x8mr14457874pdj.119.1418047003568;
        Mon, 08 Dec 2014 05:56:43 -0800 (PST)
Received: from lanh ([115.73.205.130])
        by mx.google.com with ESMTPSA id x8sm18409015pdi.7.2014.12.08.05.56.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 05:56:43 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 08 Dec 2014 21:07:18 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261041>

If the user enables untracked cache, then

 - move worktree to an unsupported filesystem
 - or simply upgrade OS
 - or move the whole (portable) disk from one machine to another
 - or access a shared fs from another machine

there's no guarantee that untracked cache can still function properly.
Record the worktree location and OS footprint in the cache. If it
changes, err on the safe side and disable the cache. The user can
'update-index --untracked-cache' again to make sure all conditions are
met.

This adds a new requirement that setup_git_directory* must be called
before read_cache() because we need worktree location by then, or the
cache is dropped.

This change does not cover all bases, you can fool it if you try
hard. The point is to stop accidents.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/index-format.txt |  3 +++
 dir.c                                    | 28 ++++++++++++++++++++++++=
++++
 git-compat-util.h                        |  1 +
 test-dump-untracked-cache.c              |  1 +
 4 files changed, 33 insertions(+)

diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
index b97ac8d..5dc2bee 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -242,6 +242,9 @@ Git index format
=20
   The extension starts with
=20
+  - A NUL-terminated string describing the environment when the cache
+    is created.
+
   - Stat data of $GIT_DIR/info/exclude. See "Index entry" section from
     ctime field until "file size".
=20
diff --git a/dir.c b/dir.c
index 916f1ed..ef58547 100644
--- a/dir.c
+++ b/dir.c
@@ -2246,10 +2246,21 @@ static void write_one_dir(struct untracked_cach=
e_dir *untracked,
 			write_one_dir(untracked->dirs[i], wd);
 }
=20
+static void get_ident_string(struct strbuf *sb)
+{
+	struct utsname uts;
+
+	if (uname(&uts))
+		die_errno(_("failed to get kernel name and information"));
+	strbuf_addf(sb, "Location %s, system %s %s %s", get_git_work_tree(),
+		    uts.sysname, uts.release, uts.version);
+}
+
 void write_untracked_extension(struct strbuf *out, struct untracked_ca=
che *untracked)
 {
 	struct ondisk_untracked_cache *ouc;
 	struct write_data wd;
+	struct strbuf sb =3D STRBUF_INIT;
 	unsigned char varbuf[16];
 	int len =3D 0, varint_len;
 	if (untracked->exclude_per_dir)
@@ -2261,6 +2272,11 @@ void write_untracked_extension(struct strbuf *ou=
t, struct untracked_cache *untra
 	hashcpy(ouc->excludes_file_sha1, untracked->ss_excludes_file.sha1);
 	ouc->dir_flags =3D htonl(untracked->dir_flags);
 	memcpy(ouc->exclude_per_dir, untracked->exclude_per_dir, len + 1);
+
+	get_ident_string(&sb);
+	strbuf_add(out, sb.buf, sb.len + 1);
+	strbuf_release(&sb);
+
 	strbuf_add(out, ouc, sizeof(*ouc) + len);
 	if (!untracked->root) {
 		varint_len =3D encode_varint(0, varbuf);
@@ -2444,12 +2460,24 @@ struct untracked_cache *read_untracked_extensio=
n(const void *data, unsigned long
 	struct untracked_cache *uc;
 	struct read_data rd;
 	const unsigned char *next =3D data, *end =3D data + sz;
+	struct strbuf sb =3D STRBUF_INIT;
 	int len;
=20
 	if (sz <=3D 1 || end[-1] !=3D '\0')
 		return NULL;
 	end--;
=20
+	get_ident_string(&sb);
+	if (strcmp(sb.buf, (const char *)next)) {
+		warning(_("system identification does not match, untracked cache dis=
abled.\n"
+			  "Stored: %s\nCurrent: %s\n"),
+			next, sb.buf);
+		strbuf_release(&sb);
+		return NULL;
+	}
+	next +=3D sb.len + 1;
+	strbuf_release(&sb);
+
 	ouc =3D (const struct ondisk_untracked_cache *)next;
 	if (next + sizeof(*ouc) > end)
 		return NULL;
diff --git a/git-compat-util.h b/git-compat-util.h
index f587749..e9502a1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -132,6 +132,7 @@
 #elif defined(_MSC_VER)
 #include "compat/msvc.h"
 #else
+#include <sys/utsname.h>
 #include <sys/wait.h>
 #include <sys/resource.h>
 #include <sys/socket.h>
diff --git a/test-dump-untracked-cache.c b/test-dump-untracked-cache.c
index 710441e..25d855d 100644
--- a/test-dump-untracked-cache.c
+++ b/test-dump-untracked-cache.c
@@ -44,6 +44,7 @@ int main(int ac, char **av)
 {
 	struct untracked_cache *uc;
 	struct strbuf base =3D STRBUF_INIT;
+	setup_git_directory();
 	if (read_cache() < 0)
 		die("unable to read index file");
 	uc =3D the_index.untracked;
--=20
2.2.0.60.gb7b3c64
