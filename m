From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] config: read full file content before parsing
Date: Thu,  9 Dec 2010 22:09:46 +0700
Message-ID: <1291907388-9068-2-git-send-email-pclouds@gmail.com>
References: <1291907388-9068-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 16:11:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQi9F-0006OS-Ia
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 16:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609Ab0LIPLG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 10:11:06 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59886 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab0LIPLD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 10:11:03 -0500
Received: by pwj3 with SMTP id 3so545724pwj.19
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 07:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=jUL1tB/mbWuGHasFJS+PGAsqZHqlUnjyybYk/A3ee8Q=;
        b=tZCiiK6NIPP15EJLopYOvdxqBZjyLWtURzR+1D+/wHNvhQYh8kXSKH8M/reqFqt2Ge
         pXi/mswzInr3IXLLS4CoSh6yxuh/NdxlUijqIGuA6n1EXFmPeI4vmx/grp+9Gs0wN9Z/
         7Yct+pmwsZm7dhudLJkbBxOxslBC2gNZuXeLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=BlWDJ4En7cuNmfVHbXbCf+tYvpE/C6mB065co7oVdtAwmU5ygaOW9n/72cY4x842qR
         fjP20blqi0hB3ZvUfv5GuJNz+z4URXFjtgMxis9Z9+Y+YgD47YV09WvavQyJjE5YH+6+
         s4oDFRbQd7ZELEmy12G0h53ngOwOYM8sNOtNY=
Received: by 10.142.179.5 with SMTP id b5mr4161355wff.225.1291907463449;
        Thu, 09 Dec 2010 07:11:03 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id x18sm2600094wfa.23.2010.12.09.07.10.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 07:11:02 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 09 Dec 2010 22:10:03 +0700
X-Mailer: git-send-email 1.7.3.3.476.g893a9
In-Reply-To: <1291907388-9068-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163286>

config files are usually short enough that we can read in full. This
allows the parser to parse in-memory config, for example from a blob.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 config.c |   62 +++++++++++++++++++++++++++++++++++-------------------=
--------
 1 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/config.c b/config.c
index f138c34..c8bf46f 100644
--- a/config.c
+++ b/config.c
@@ -12,7 +12,8 @@
=20
 #define MAXNAME (256)
=20
-static FILE *config_file;
+static char *config_file;
+static size_t config_file_size, config_file_pos;
 static const char *config_file_name;
 static int config_linenr;
 static int config_file_eof;
@@ -108,28 +109,26 @@ int git_config_parse_environment(void) {
=20
 static int get_next_char(void)
 {
-	int c;
-	FILE *f;
+	size_t unread =3D config_file_size - config_file_pos;
+
+	if (config_file =3D=3D NULL)
+		return '\n';
=20
-	c =3D '\n';
-	if ((f =3D config_file) !=3D NULL) {
-		c =3D fgetc(f);
+	if (unread) {
+		char c =3D config_file[config_file_pos++];
 		if (c =3D=3D '\r') {
 			/* DOS like systems */
-			c =3D fgetc(f);
-			if (c !=3D '\n') {
-				ungetc(c, f);
-				c =3D '\r';
-			}
+			if (unread > 1 &&
+			    config_file[config_file_pos] =3D=3D '\n')
+				c =3D config_file[config_file_pos++];
 		}
 		if (c =3D=3D '\n')
 			config_linenr++;
-		if (c =3D=3D EOF) {
-			config_file_eof =3D 1;
-			c =3D '\n';
-		}
+		return c;
 	}
-	return c;
+
+	config_file_eof =3D 1;
+	return '\n';
 }
=20
 static char *parse_value(void)
@@ -786,19 +785,27 @@ int git_default_config(const char *var, const cha=
r *value, void *dummy)
=20
 int git_config_from_file(config_fn_t fn, const char *filename, void *d=
ata)
 {
-	int ret;
-	FILE *f =3D fopen(filename, "r");
+	struct stat st;
+	int ret =3D -1, fd;
+
+	if (lstat(filename, &st))
+		return -1;
+	fd =3D open(filename, O_RDONLY);
+	if (fd =3D=3D -1)
+		return -1;
=20
-	ret =3D -1;
-	if (f) {
-		config_file =3D f;
+	config_file =3D xmalloc(st.st_size);
+	if (read_in_full(fd, config_file, st.st_size) =3D=3D st.st_size) {
+		config_file_pos =3D 0;
+		config_file_size =3D st.st_size;
 		config_file_name =3D filename;
 		config_linenr =3D 1;
 		config_file_eof =3D 0;
 		ret =3D git_parse_file(fn, data);
-		fclose(f);
-		config_file_name =3D NULL;
 	}
+	close(fd);
+	free(config_file);
+	config_file_name =3D NULL;
 	return ret;
 }
=20
@@ -921,7 +928,7 @@ static int store_aux(const char *key, const char *v=
alue, void *cb)
 				return 1;
 			}
=20
-			store.offset[store.seen] =3D ftell(config_file);
+			store.offset[store.seen] =3D config_file_pos;
 			store.seen++;
 		}
 		break;
@@ -948,19 +955,19 @@ static int store_aux(const char *key, const char =
*value, void *cb)
 		 * Do not increment matches: this is no match, but we
 		 * just made sure we are in the desired section.
 		 */
-		store.offset[store.seen] =3D ftell(config_file);
+		store.offset[store.seen] =3D config_file_pos;
 		/* fallthru */
 	case SECTION_END_SEEN:
 	case START:
 		if (matches(key, value)) {
-			store.offset[store.seen] =3D ftell(config_file);
+			store.offset[store.seen] =3D config_file_pos;
 			store.state =3D KEY_SEEN;
 			store.seen++;
 		} else {
 			if (strrchr(key, '.') - key =3D=3D store.baselen &&
 			      !strncmp(key, store.key, store.baselen)) {
 					store.state =3D SECTION_SEEN;
-					store.offset[store.seen] =3D ftell(config_file);
+					store.offset[store.seen] =3D config_file_pos;
 			}
 		}
 	}
@@ -1380,6 +1387,7 @@ int git_config_rename_section(const char *old_nam=
e, const char *new_name)
 {
 	int ret =3D 0, remove =3D 0;
 	char *config_filename;
+	FILE *config_file;
 	struct lock_file *lock =3D xcalloc(sizeof(struct lock_file), 1);
 	int out_fd;
 	char buf[1024];
--=20
1.7.3.3.476.g893a9
