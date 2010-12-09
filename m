From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] config: add git_config_from_sha1() to read from a blob
Date: Thu,  9 Dec 2010 22:09:47 +0700
Message-ID: <1291907388-9068-3-git-send-email-pclouds@gmail.com>
References: <1291907388-9068-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 16:11:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQi9X-0006bE-Lb
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 16:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948Ab0LIPLW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 10:11:22 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37177 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919Ab0LIPLV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 10:11:21 -0500
Received: by yxt3 with SMTP id 3so1408080yxt.19
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 07:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=RU3GJuABoFGv8CLTwGOFpj6SavJ54NfBfX3V1B/oDK4=;
        b=o+V4LBLn0niDhSe5VNpaXwGA+kUH4THEjv5hp9mdIkRRVt02vKnXhjGjpgv6HZIOpr
         fi2RfMe7VwMGNqJ03J4rql2CwPyAbTJH9+vZH+xRbeC7L6jKWkR6sYtZT6BEhBaQPfdF
         tevBfhUna9BII7lv0xIntYEq33mjbx+PY7E/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=B80oGCJwSmX9WJYYDuKjr/sxovxn4jBcbP+JyNiCJXneX3IEwk7V2bUQAStj6mV+UB
         GXbzxKxMH7fsrQM7Uqd8G55YAHCod/7pjVsCWpOhrQNv6x30UxKfIz2ysFHuRvxPBwvB
         UnfvMYlr3PEAvyKlKVv2cuUz9Nb1W3s+6wSVI=
Received: by 10.151.83.17 with SMTP id k17mr6613153ybl.437.1291907480265;
        Thu, 09 Dec 2010 07:11:20 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id f4sm760903ybi.11.2010.12.09.07.11.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 07:11:19 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 09 Dec 2010 22:10:18 +0700
X-Mailer: git-send-email 1.7.3.3.476.g893a9
In-Reply-To: <1291907388-9068-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163287>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 config.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/config.c b/config.c
index c8bf46f..e7a9ff4 100644
--- a/config.c
+++ b/config.c
@@ -809,6 +809,40 @@ int git_config_from_file(config_fn_t fn, const cha=
r *filename, void *data)
 	return ret;
 }
=20
+static int git_config_from_sha1(config_fn_t fn, const char *sha1_name,=
 void *data)
+{
+	unsigned char sha1[20];
+	enum object_type type;
+	unsigned long size;
+	int ret;
+
+	if (get_sha1(sha1_name, sha1)) {
+		error("bad shared config reference '%s'", sha1_name);
+		return -1;
+	}
+
+	config_file =3D read_sha1_file(sha1, &type, &size);
+	if (!config_file) {
+		error("bad shared config '%s'", sha1_name);
+		return -1;
+	}
+	if (type =3D=3D OBJ_BLOB) {
+		config_file_pos =3D 0;
+		config_file_size =3D size;
+		config_file_name =3D sha1_name;
+		config_linenr =3D 1;
+		config_file_eof =3D 0;
+		ret =3D git_parse_file(fn, data);
+	}
+	else {
+		error("shared config '%s' is not a blob", sha1_name);
+		return -1;
+	}
+	free(config_file);
+	config_file_name =3D NULL;
+	return ret;
+}
+
 const char *git_etc_gitconfig(void)
 {
 	static const char *system_wide;
--=20
1.7.3.3.476.g893a9
