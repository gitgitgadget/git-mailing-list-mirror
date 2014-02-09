From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/2] dir: warn about trailing spaces in exclude patterns
Date: Sun,  9 Feb 2014 07:26:37 +0700
Message-ID: <1391905598-19198-2-git-send-email-pclouds@gmail.com>
References: <1391847004-22810-1-git-send-email-pclouds@gmail.com>
 <1391905598-19198-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 09 01:27:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCIEf-0001zn-Jk
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 01:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbaBIA0y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 19:26:54 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:60229 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbaBIA0m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 19:26:42 -0500
Received: by mail-pa0-f52.google.com with SMTP id bj1so4707986pad.11
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 16:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GwTSObLr/x2ZWIMwBJoIW2I2kBRU/VYPbgGs2R/D9Ac=;
        b=DCTHpXfx0IgQlfxNEjWodzfbv/OLZvxn02DRjwSRkqxOEwgJENOhOtQgXAKjp7ow7M
         ie+GabcYM4YiNEvSeOBF12k3AF7fqKaPz0W44KwQfSVB55e1ZMzL6k5gCfH8e3TmyD7s
         aeSNMDDPSj+k4as6k8XKFHGQVZrDZQ4ggXJfuJkRu9caURGC4pLoZ517Z9LyYYjhAZ4y
         HcFHJXSsSfCNCLrdzSExV0QfXK972VkBU+XAgbEqO6cckAVS1YSszQQNqUTDWwblMGFm
         JYEDjyv5vBBltkrGbsSWyxFHM4FnXXbV0doNJnc5bOKqqExBlqRYbbIle2TcOCg4xwkw
         KnIw==
X-Received: by 10.68.231.35 with SMTP id td3mr28453644pbc.137.1391905602485;
        Sat, 08 Feb 2014 16:26:42 -0800 (PST)
Received: from lanh ([115.73.239.36])
        by mx.google.com with ESMTPSA id jk16sm27438215pbb.34.2014.02.08.16.26.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Feb 2014 16:26:41 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Feb 2014 07:26:45 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391905598-19198-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241869>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c              | 17 +++++++++++++++++
 t/t0008-ignores.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/dir.c b/dir.c
index b35b633..6162209 100644
--- a/dir.c
+++ b/dir.c
@@ -491,6 +491,22 @@ void clear_exclude_list(struct exclude_list *el)
 	el->filebuf =3D NULL;
 }
=20
+static void check_trailing_spaces(const char *fname, char *buf)
+{
+	int i, last_space =3D -1, len =3D strlen(buf);
+	for (i =3D 0; i < len; i++)
+		if (buf[i] =3D=3D '\\')
+			i++;
+		else if (buf[i] =3D=3D ' ')
+			last_space =3D i;
+		else
+			last_space =3D -1;
+
+	if (last_space =3D=3D len - 1)
+		warning(_("%s: trailing spaces in '%s'. Please quote or remove them.=
"),
+			fname, buf);
+}
+
 int add_excludes_from_file_to_list(const char *fname,
 				   const char *base,
 				   int baselen,
@@ -542,6 +558,7 @@ int add_excludes_from_file_to_list(const char *fnam=
e,
 		if (buf[i] =3D=3D '\n') {
 			if (entry !=3D buf + i && entry[0] !=3D '#') {
 				buf[i - (i && buf[i-1] =3D=3D '\r')] =3D 0;
+				check_trailing_spaces(fname, entry);
 				add_exclude(entry, base, baselen, el, lineno);
 			}
 			lineno++;
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index b4d98e6..9e1d64c 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -775,4 +775,35 @@ test_expect_success PIPE 'streaming support for --=
stdin' '
 	echo "$response" | grep "^::	two"
 '
=20
+######################################################################=
######
+#
+# test whitespace handling
+
+test_expect_success 'trailing whitespace is warned' '
+	mkdir whitespace &&
+	>whitespace/trailing &&
+	>whitespace/untracked &&
+	echo "whitespace/trailing   " >ignore &&
+	cat >expect <<EOF &&
+whitespace/trailing
+whitespace/untracked
+EOF
+	git ls-files -o -X ignore whitespace >actual 2>err &&
+	grep "ignore:.*'\''whitespace/trailing   '\''" err &&
+	test_cmp expect actual
+'
+
+test_expect_success 'quoting allows trailing whitespace' '
+	rm -rf whitespace &&
+	mkdir whitespace &&
+	>"whitespace/trailing  " &&
+	>whitespace/untracked &&
+	echo "whitespace/trailing\\ \\ " >ignore &&
+	echo whitespace/untracked >expect &&
+	: >err.expect &&
+	git ls-files -o -X ignore whitespace >actual 2>err &&
+	test_cmp expect actual &&
+	test_cmp err.expect err
+'
+
 test_done
--=20
1.8.5.2.240.g8478abd
