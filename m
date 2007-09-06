From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 7/9] Add strbuf_read_path().
Date: Wed,  5 Sep 2007 20:23:36 -0400
Message-ID: <11890382262161-git-send-email-krh@redhat.com>
References: <11890382183913-git-send-email-krh@redhat.com>
 <11890382242333-git-send-email-krh@redhat.com>
 <11890382243290-git-send-email-krh@redhat.com>
 <11890382253220-git-send-email-krh@redhat.com>
 <11890382252522-git-send-email-krh@redhat.com>
 <1189038225525-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 02:36:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT5Ma-0001tF-VJ
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 02:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbXIFAf6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Sep 2007 20:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbXIFAf5
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 20:35:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43779 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756896AbXIFAfr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 20:35:47 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l860Zk3Y005453
	for <git@vger.kernel.org>; Wed, 5 Sep 2007 20:35:46 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l860ZkkV032621;
	Wed, 5 Sep 2007 20:35:46 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l860Zhbb016503;
	Wed, 5 Sep 2007 20:35:45 -0400
X-Mailer: git-send-email 1.5.3.rc5.852.gc119
In-Reply-To: <1189038225525-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57787>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-tag.c |    7 +------
 strbuf.c      |   15 +++++++++++++++
 strbuf.h      |    1 +
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 1aff952..8724d49 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -53,14 +53,9 @@ static void launch_editor(const char *path, struct s=
trbuf *sb)
 	if (run_command(&child))
 		die("There was a problem with the editor %s.", editor);
=20
-	fd =3D open(path, O_RDONLY);
-	if (fd < 0)
-		die("could not open '%s': %s", path, strerror(errno));
-	if (strbuf_read_fd(sb, fd) < 0) {
+	if (strbuf_read_path(sb, path) < 0)
 		die("could not read message file '%s': %s",
 		    path, strerror(errno));
-	}
-	close(fd);
 }
=20
 struct tag_filter {
diff --git a/strbuf.c b/strbuf.c
index ed2afea..1951a5b 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -70,6 +70,21 @@ int strbuf_read_fd(struct strbuf *sb, int fd)
 	return total;
 }
=20
+int strbuf_read_path(struct strbuf *sb, const char *path)
+{
+	int fd, len;
+
+	fd =3D open(path, O_RDONLY);
+	if (fd < 0)
+		return -1;
+	len =3D strbuf_read_fd(sb, fd);
+	if (len < 0)
+		return -1;
+	close(fd);
+
+	return len;
+}
+
 void strbuf_printf(struct strbuf *sb, const char *fmt, ...)
 {
 	char buffer[2048];
diff --git a/strbuf.h b/strbuf.h
index a93b9e1..e852070 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -14,6 +14,7 @@ extern void strbuf_add(struct strbuf *sb, const char =
*data, size_t len);
 extern void strbuf_add_char(struct strbuf *sb, int ch);
 extern void strbuf_printf(struct strbuf *sb, const char *fmt, ...);
 extern int strbuf_read_fd(struct strbuf *sb, int fd);
+extern int strbuf_read_path(struct strbuf *sb, const char *path);
 extern size_t stripspace(struct strbuf *sb, int skip_comments);
=20
 #endif /* STRBUF_H */
--=20
1.5.2.GIT
