From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] core: use env variable instead of config var to turn on logging pack access
Date: Sun,  9 Jun 2013 12:22:48 +0700
Message-ID: <1370755369-30868-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 07:21:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlY4c-00084f-O9
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 07:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960Ab3FIFVl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 01:21:41 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56504 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab3FIFVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 01:21:40 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so1108036pbb.19
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 22:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=QYr2eMPHw1VtnMlmQy08nW3W3D2sQgM6+4Pw9UEjrt4=;
        b=Ht6rYwkpcJb9yIIL6LBp1VZsLZasKhVhQh1nLrWUUK6Rl3Kf6iAQyV87HsKAyJsVr0
         Vs2AV7xVQ/LUEc7jOwvmcmLkwGEF6KqIlZodgbQtNd1fhDmVJpBrjm4zjxRJH40MwPZ0
         LCFxoHhRHorVpwL8+KoZDGBZM6X9uHTEIA5wmsWNJFPB4M9y4GX2im/Pc6EqVpdx2FHm
         948t3y9Dhx6wHHnUHgLG5ZVQOpY9jykn5R7ijM+KHEm1mv5zKEsPNFrBTcWUui6tALN/
         AiaoVHP5W3cFoMnublG3O6AU2HIiZq5WxgpwrYdnWw1R6t2HKZNIPGpQauEg6TXScwYA
         OBSQ==
X-Received: by 10.68.218.8 with SMTP id pc8mr4936690pbc.115.1370755300034;
        Sat, 08 Jun 2013 22:21:40 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id nt2sm5346474pbc.17.2013.06.08.22.21.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 22:21:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 12:23:10 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226883>

5f44324 (core: log offset pack data accesses happened - 2011-07-06)
provides a way to observe pack access patterns via a config
switch. Setting an environment variable looks more obvious than a
config var, especially when you just need to _observe_, and more
inline with other tracing knobs we have.

Document it as it may be useful for remote troubleshooting.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git.txt |  7 +++++++
 cache.h               |  3 ---
 config.c              |  3 ---
 environment.c         |  1 -
 sha1_file.c           | 14 ++++++++++++--
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 68f1ee6..c760918 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -838,6 +838,13 @@ for further details.
 	as a file path and will try to write the trace messages
 	into it.
=20
+'GIT_TRACE_PACK_ACCESS'::
+	If this variable is set to a path, a file will be created at
+	the given path logging all accesses to any packs. For each
+	access, the pack file name and an offset in the pack is
+	recorded. This may be helpful for troubleshooting some
+	pack-related performance problems.
+
 GIT_LITERAL_PATHSPECS::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs literally, rather than as glob patterns. For example,
diff --git a/cache.h b/cache.h
index df532f8..4f41606 100644
--- a/cache.h
+++ b/cache.h
@@ -772,9 +772,6 @@ extern int parse_sha1_header(const char *hdr, unsig=
ned long *sizep);
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
=20
-/* for development: log offset of pack access */
-extern const char *log_pack_access;
-
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, =
unsigned long size, const char *type);
=20
 extern int move_temp_to_file(const char *tmpfile, const char *filename=
);
diff --git a/config.c b/config.c
index 7a85ebd..d04e815 100644
--- a/config.c
+++ b/config.c
@@ -688,9 +688,6 @@ static int git_default_core_config(const char *var,=
 const char *value)
 		return 0;
 	}
=20
-	if (!strcmp(var, "core.logpackaccess"))
-		return git_config_string(&log_pack_access, var, value);
-
 	if (!strcmp(var, "core.autocrlf")) {
 		if (value && !strcasecmp(value, "input")) {
 			if (core_eol =3D=3D EOL_CRLF)
diff --git a/environment.c b/environment.c
index e2e75c1..0cb67b2 100644
--- a/environment.c
+++ b/environment.c
@@ -37,7 +37,6 @@ size_t packed_git_window_size =3D DEFAULT_PACKED_GIT_=
WINDOW_SIZE;
 size_t packed_git_limit =3D DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit =3D 16 * 1024 * 1024;
 unsigned long big_file_threshold =3D 512 * 1024 * 1024;
-const char *log_pack_access;
 const char *pager_program;
 int pager_use_color =3D 1;
 const char *editor_program;
diff --git a/sha1_file.c b/sha1_file.c
index b114cc9..4b23bb8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -36,6 +36,9 @@ static inline uintmax_t sz_fmt(size_t s) { return s; =
}
=20
 const unsigned char null_sha1[20];
=20
+static const char *no_log_pack_access =3D "no_log_pack_access";
+static const char *log_pack_access;
+
 /*
  * This is meant to hold a *small* number of objects that you would
  * want read_sha1_file() to be able to return, but yet you do not want
@@ -1956,12 +1959,19 @@ static void write_pack_access_log(struct packed=
_git *p, off_t obj_offset)
 {
 	static FILE *log_file;
=20
+	if (!log_pack_access)
+		log_pack_access =3D getenv("GIT_TRACE_PACK_ACCESS");
+	if (!log_pack_access)
+		log_pack_access =3D no_log_pack_access;
+	if (log_pack_access =3D=3D no_log_pack_access)
+		return;
+
 	if (!log_file) {
 		log_file =3D fopen(log_pack_access, "w");
 		if (!log_file) {
 			error("cannot open pack access log '%s' for writing: %s",
 			      log_pack_access, strerror(errno));
-			log_pack_access =3D NULL;
+			log_pack_access =3D no_log_pack_access;
 			return;
 		}
 	}
@@ -1992,7 +2002,7 @@ void *unpack_entry(struct packed_git *p, off_t ob=
j_offset,
 	int delta_stack_nr =3D 0, delta_stack_alloc =3D UNPACK_ENTRY_STACK_PR=
EALLOC;
 	int base_from_cache =3D 0;
=20
-	if (log_pack_access)
+	if (log_pack_access !=3D no_log_pack_access)
 		write_pack_access_log(p, obj_offset);
=20
 	/* PHASE 1: drill down to the innermost base object */
--=20
1.8.2.83.gc99314b
