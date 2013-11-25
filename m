From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 25/28] send-pack: support pushing from a shallow clone via http
Date: Mon, 25 Nov 2013 10:55:51 +0700
Message-ID: <1385351754-9954-26-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:54:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknFU-0002Ps-Th
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749Ab3KYDx6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:53:58 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:40926 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab3KYDx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:53:56 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so4783323pbc.21
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kSOahlamyziv2bxm3JeCtyLYpSpo11OMWpdpNx2zIIM=;
        b=JRNdrbMPZafrWsHpILbRkbVyGjfBSmNiuMtkfs2+fDCc263GrSxMHvlSE3gS+Boo8N
         SXlxhfmeQi090UxMHxg0ytqXCneCbJvW8oSfO1K7kAi6F9eiFpipyeiOAVFemtikEB2U
         wAtO4+fxyUnMf0QPmjarDwpxAmPcLeMziJ5VmlxpUmED2PmLSS/muZWCINmL7RjigOhz
         eAgB+vAxdJ5HyEbIk7gh0Ja6w7rBJ2BVp+fdG3bNPmpFnRdHzNCetJ1wLzZMfqrax+q8
         VE7V2wm52xszwAfxZWbyf7BI7APeM2oiVXyID9LUKlsV+RYcqzdIv/lMHEoS6LBr0+cx
         P+xg==
X-Received: by 10.68.236.133 with SMTP id uu5mr568078pbc.153.1385351635893;
        Sun, 24 Nov 2013 19:53:55 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id ha10sm69725820pbd.17.2013.11.24.19.53.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:53:55 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:58:29 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238297>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/send-pack.c     |  3 ---
 send-pack.c             | 19 +++++++++++++++++--
 t/t5537-push-shallow.sh | 25 +++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 0031165..966b45e 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -208,9 +208,6 @@ int cmd_send_pack(int argc, const char **argv, cons=
t char *prefix)
 	    (send_all && args.send_mirror))
 		usage(send_pack_usage);
=20
-	if (is_repository_shallow() && args.stateless_rpc)
-		die("attempt to push from a shallow repository");
-
 	if (remote_name) {
 		remote =3D remote_get(remote_name);
 		if (!remote_has_url(remote, dest)) {
diff --git a/send-pack.c b/send-pack.c
index 8b5571c..13167ea 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -174,6 +174,21 @@ static int sideband_demux(int in, int out, void *d=
ata)
 	return ret;
 }
=20
+static int advertise_shallow_grafts_cb(const struct commit_graft *graf=
t, void *cb)
+{
+	struct strbuf *sb =3D cb;
+	if (graft->nr_parent =3D=3D -1)
+		packet_buf_write(sb, "shallow %s\n", sha1_to_hex(graft->sha1));
+	return 0;
+}
+
+void advertise_shallow_grafts_buf(struct strbuf *sb)
+{
+	if (!is_repository_shallow())
+		return;
+	for_each_commit_graft(advertise_shallow_grafts_cb, sb);
+}
+
 int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs,
@@ -214,7 +229,7 @@ int send_pack(struct send_pack_args *args,
 	}
=20
 	if (!args->dry_run)
-		advertise_shallow_grafts(out);
+		advertise_shallow_grafts_buf(&req_buf);
=20
 	/*
 	 * Finally, tell the other end!
@@ -275,7 +290,7 @@ int send_pack(struct send_pack_args *args,
 	}
=20
 	if (args->stateless_rpc) {
-		if (!args->dry_run && cmds_sent) {
+		if (!args->dry_run && (cmds_sent || is_repository_shallow())) {
 			packet_buf_flush(&req_buf);
 			send_sideband(out, -1, req_buf.buf, req_buf.len, LARGE_PACKET_MAX);
 		}
diff --git a/t/t5537-push-shallow.sh b/t/t5537-push-shallow.sh
index d252a78..f8200f7 100755
--- a/t/t5537-push-shallow.sh
+++ b/t/t5537-push-shallow.sh
@@ -155,5 +155,30 @@ EOF
 	)
 '
=20
+test_expect_success 'push from shallow repo via http' '
+	mv "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" shallow-upstream.git &&
+	git clone --bare --no-local full "$HTTPD_DOCUMENT_ROOT_PATH/repo.git"=
 &&
+	(
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git config http.receivepack true
+	) &&
+	commit 10 &&
+	git push $HTTPD_URL/smart/repo.git +master:refs/remotes/top/master &&
+	(
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git fsck &&
+	git log --format=3D%s top/master >actual &&
+	cat <<EOF >expect &&
+10
+1
+4
+3
+2
+1
+EOF
+	test_cmp expect actual
+	)
+'
+
 stop_httpd
 test_done
--=20
1.8.2.83.gc99314b
