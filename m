From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] Use a strbuf for building up section header and key/value pair strings.
Date: Fri, 14 Dec 2007 15:59:58 -0500
Message-ID: <1197665998-32386-3-git-send-email-krh@redhat.com>
References: <1197665998-32386-1-git-send-email-krh@redhat.com>
 <1197665998-32386-2-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 14 21:37:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3HHM-0003um-2f
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 21:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbXLNUgA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 15:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754043AbXLNUgA
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 15:36:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55904 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576AbXLNUf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 15:35:59 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBEKIVXI024372;
	Fri, 14 Dec 2007 15:18:31 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBEKIVve002804;
	Fri, 14 Dec 2007 15:18:31 -0500
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lBEKIUZt000415;
	Fri, 14 Dec 2007 15:18:30 -0500
X-Mailer: git-send-email 1.5.4.rc0.9.g7b331-dirty
In-Reply-To: <1197665998-32386-2-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68343>

Avoids horrible 1-byte write(2) calls and cleans up the logic a bit.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 config.c |   91 ++++++++++++++++++++++++++----------------------------=
--------
 1 files changed, 38 insertions(+), 53 deletions(-)

diff --git a/config.c b/config.c
index 2e52b17..4c8e15d 100644
--- a/config.c
+++ b/config.c
@@ -610,46 +610,36 @@ static int write_error(void)
=20
 static int store_write_section(int fd, const char* key)
 {
-	const char *dot =3D strchr(key, '.');
-	int len1 =3D store.baselen, len2 =3D -1;
+	const char *dot;
+	int i, success;
+	struct strbuf sb;
=20
-	dot =3D strchr(key, '.');
+	strbuf_init(&sb, 0);
+	dot =3D memchr(key, '.', store.baselen);
 	if (dot) {
-		int dotlen =3D dot - key;
-		if (dotlen < len1) {
-			len2 =3D len1 - dotlen - 1;
-			len1 =3D dotlen;
+		strbuf_addf(&sb, "[%.*s \"", dot - key, key);
+		for (i =3D dot - key + 1; i < store.baselen; i++) {
+			if (key[i] =3D=3D '"')
+				strbuf_addch(&sb, '\\');
+			strbuf_addch(&sb, key[i]);
 		}
+		strbuf_addstr(&sb, "\"]\n");
+	} else {
+		strbuf_addf(&sb, "[%.*s]\n", store.baselen, key);
 	}
=20
-	if (write_in_full(fd, "[", 1) !=3D 1 ||
-	    write_in_full(fd, key, len1) !=3D len1)
-		return 0;
-	if (len2 >=3D 0) {
-		if (write_in_full(fd, " \"", 2) !=3D 2)
-			return 0;
-		while (--len2 >=3D 0) {
-			unsigned char c =3D *++dot;
-			if (c =3D=3D '"')
-				if (write_in_full(fd, "\\", 1) !=3D 1)
-					return 0;
-			if (write_in_full(fd, &c, 1) !=3D 1)
-				return 0;
-		}
-		if (write_in_full(fd, "\"", 1) !=3D 1)
-			return 0;
-	}
-	if (write_in_full(fd, "]\n", 2) !=3D 2)
-		return 0;
+	success =3D write_in_full(fd, sb.buf, sb.len) =3D=3D sb.len;
+	strbuf_release(&sb);
=20
-	return 1;
+	return success;
 }
=20
 static int store_write_pair(int fd, const char* key, const char* value=
)
 {
-	int i;
-	int length =3D strlen(key+store.baselen+1);
-	int quote =3D 0;
+	int i, success;
+	int length =3D strlen(key + store.baselen + 1);
+	const char *quote =3D "";
+	struct strbuf sb;
=20
 	/*
 	 * Check to see if the value needs to be surrounded with a dq pair.
@@ -659,43 +649,38 @@ static int store_write_pair(int fd, const char* k=
ey, const char* value)
 	 * configuration parser.
 	 */
 	if (value[0] =3D=3D ' ')
-		quote =3D 1;
+		quote =3D "\"";
 	for (i =3D 0; value[i]; i++)
 		if (value[i] =3D=3D ';' || value[i] =3D=3D '#')
-			quote =3D 1;
-	if (i && value[i-1] =3D=3D ' ')
-		quote =3D 1;
+			quote =3D "\"";
+	if (i && value[i - 1] =3D=3D ' ')
+		quote =3D "\"";
+
+	strbuf_init(&sb, 0);
+	strbuf_addf(&sb, "\t%.*s =3D %s",=20
+		    length, key + store.baselen + 1, quote);
=20
-	if (write_in_full(fd, "\t", 1) !=3D 1 ||
-	    write_in_full(fd, key+store.baselen+1, length) !=3D length ||
-	    write_in_full(fd, " =3D ", 3) !=3D 3)
-		return 0;
-	if (quote && write_in_full(fd, "\"", 1) !=3D 1)
-		return 0;
 	for (i =3D 0; value[i]; i++)
 		switch (value[i]) {
 		case '\n':
-			if (write_in_full(fd, "\\n", 2) !=3D 2)
-				return 0;
+			strbuf_addstr(&sb, "\\n");
 			break;
 		case '\t':
-			if (write_in_full(fd, "\\t", 2) !=3D 2)
-				return 0;
+			strbuf_addstr(&sb, "\\t");
 			break;
 		case '"':
 		case '\\':
-			if (write_in_full(fd, "\\", 1) !=3D 1)
-				return 0;
+			strbuf_addch(&sb, '\\');
 		default:
-			if (write_in_full(fd, value+i, 1) !=3D 1)
-				return 0;
+			strbuf_addch(&sb, value[i]);
 			break;
 		}
-	if (quote && write_in_full(fd, "\"", 1) !=3D 1)
-		return 0;
-	if (write_in_full(fd, "\n", 1) !=3D 1)
-		return 0;
-	return 1;
+	strbuf_addf(&sb, "%s\n", quote);
+
+	success =3D write_in_full(fd, sb.buf, sb.len) =3D=3D sb.len;
+	strbuf_release(&sb);
+
+	return success;
 }
=20
 static ssize_t find_beginning_of_line(const char* contents, size_t siz=
e,
--=20
1.5.3.4
