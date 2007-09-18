From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 5/7] Add strbuf_read_file().
Date: Mon, 17 Sep 2007 20:06:46 -0400
Message-ID: <11900740154136-git-send-email-krh@redhat.com>
References: <1190074008617-git-send-email-krh@redhat.com>
 <1190074014548-git-send-email-krh@redhat.com>
 <11900740142347-git-send-email-krh@redhat.com>
 <11900740153845-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 02:07:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXQcp-0002Qo-3m
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 02:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757125AbXIRAHG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 20:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757105AbXIRAHF
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 20:07:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56224 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756884AbXIRAG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 20:06:57 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8I06uj9012109
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 20:06:56 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8I06uK2022182;
	Mon, 17 Sep 2007 20:06:56 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8I06sd0021539;
	Mon, 17 Sep 2007 20:06:55 -0400
X-Mailer: git-send-email 1.5.3.1.993.gbf388-dirty
In-Reply-To: <11900740153845-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58505>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-tag.c |   10 +++-------
 strbuf.c      |   15 +++++++++++++++
 strbuf.h      |    1 +
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 68c9a20..c97673f 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -53,13 +53,9 @@ static void launch_editor(const char *path, struct s=
trbuf *buffer)
 	if (run_command(&child))
 		die("There was a problem with the editor %s.", editor);
=20
-	fd =3D open(path, O_RDONLY);
-	if (fd < 0)
-		die("could not open '%s': %s", path, strerror(errno));
-	if (strbuf_read(buffer, fd, 0) < 0) {
-		die("could not read message file '%s': %s", path, strerror(errno));
-	}
-	close(fd);
+	if (strbuf_read_file(buffer, path) < 0)
+		die("could not read message file '%s': %s",
+		    path, strerror(errno));
 }
=20
 struct tag_filter {
diff --git a/strbuf.c b/strbuf.c
index d919047..438606d 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -110,6 +110,21 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, siz=
e_t hint)
 	return sb->len - oldlen;
 }
=20
+int strbuf_read_file(struct strbuf *sb, const char *path)
+{
+	int fd, len;
+
+	fd =3D open(path, O_RDONLY);
+	if (fd < 0)
+		return -1;
+	len =3D strbuf_read(sb, fd, 0);
+	close(fd);
+	if (len < 0)
+		return -1;
+
+	return len;
+}
+
 void read_line(struct strbuf *sb, FILE *fp, int term) {
 	int ch;
 	if (feof(fp)) {
diff --git a/strbuf.h b/strbuf.h
index 5960637..3a523ab 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -95,6 +95,7 @@ extern void strbuf_addf(struct strbuf *sb, const char=
 *fmt, ...);
 extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 /* XXX: if read fails, any partial read is undone */
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
+extern int strbuf_read_file(struct strbuf *sb, const char *path);
=20
 extern void read_line(struct strbuf *, FILE *, int);
=20
--=20
1.5.3.1.993.gbf388-dirty
