From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] core: use env variable instead of config var to turn on logging pack access
Date: Thu, 30 May 2013 20:51:47 +0700
Message-ID: <1369921908-2988-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 15:50:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui3Ff-0001Cy-O2
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259Ab3E3Nug convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 09:50:36 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:44483 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243Ab3E3Nu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 09:50:29 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so391166pbc.3
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=NgJjk39NFv1iZbYXKcuPFUNUYFDcmpDZAiqQ4519/TY=;
        b=o4Ty5ioLgc1GpUBMc+Jh2+M054KbQka80yJETREI2mv5UY4uthrhcT0l33/D2zh3TB
         vxeHuN6Ny6TCAk569eu+UOveoW15kluYsXBuQapnCn5DFdWBWZi+s32uD5YBrUFCEkKd
         6YFF+y3/zPA3BPK+iJ/BfqAZOYBAI+oSnBo0kjXBLoc2FM3P/1UuAip+Qnq2KVwzhXjd
         7jIfbilvFi7Yfidagx+/uVWSL58cGMkzC7XRIjIKQR0jrAXFel9ACykvwkUysj7f7fhG
         4lsxB5hhJt60TubQX74geWiF0+J3Z1NANHUEY374DTncBhgfkTXG/XpSG+wD7XqLFzCw
         rrOA==
X-Received: by 10.68.197.66 with SMTP id is2mr7974894pbc.175.1369921828453;
        Thu, 30 May 2013 06:50:28 -0700 (PDT)
Received: from lanh ([115.73.234.90])
        by mx.google.com with ESMTPSA id qi1sm44912304pac.21.2013.05.30.06.50.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 30 May 2013 06:50:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 30 May 2013 20:51:49 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225993>

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
 sha1_file.c           | 10 ++++++++++
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9e302b0..3e74440 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -832,6 +832,13 @@ for further details.
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
index 94ca1ac..9bfd76b 100644
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
index aefd80b..ce074d7 100644
--- a/config.c
+++ b/config.c
@@ -675,9 +675,6 @@ static int git_default_core_config(const char *var,=
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
diff --git a/sha1_file.c b/sha1_file.c
index 67e815b..7b47bdc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -36,6 +36,8 @@ static inline uintmax_t sz_fmt(size_t s) { return s; =
}
=20
 const unsigned char null_sha1[20];
=20
+static const char *log_pack_access =3D "";
+
 /*
  * This is meant to hold a *small* number of objects that you would
  * want read_sha1_file() to be able to return, but yet you do not want
@@ -1956,6 +1958,14 @@ static void write_pack_access_log(struct packed_=
git *p, off_t obj_offset)
 {
 	static FILE *log_file;
=20
+	if (!*log_pack_access) {
+		log_pack_access =3D getenv("GIT_TRACE_PACK_ACCESS");
+		if (!*log_pack_access)
+			log_pack_access =3D NULL;
+		if (!log_pack_access)
+			return;
+	}
+
 	if (!log_file) {
 		log_file =3D fopen(log_pack_access, "w");
 		if (!log_file) {
--=20
1.8.2.83.gc99314b
