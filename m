From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 25/28] send-pack: support pushing from a shallow clone via http
Date: Thu,  5 Dec 2013 20:02:52 +0700
Message-ID: <1386248575-10206-26-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 14:01:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYYE-00034L-Ey
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 14:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243Ab3LENBB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 08:01:01 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:64921 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215Ab3LENBA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 08:01:00 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so24702934pdj.9
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 05:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=b8oRJaY213Qvp2ujccl2V1kNPd8/h30mFcN1qIObhao=;
        b=OkAu7jvtnAGRUs+wGnqojeIaz4R0lxLlQjvEuC+oLYzdBlj2xkLf1APDBHssRmR9du
         9gqWSABgWTMga8qjodBEFPEOtyCIE2W0Hl6DRHhTYVFV6KL0CV2k90kQIBD4EDHWNNgy
         y8wp96OO63aiZsZShzOa/TuusVN82Etg7hYMsqg4dte6+6kpWmAhOj/hkM2zo3l3G7+C
         OMrrNou1+zJskzlhR4zY2vWebUEaQ261SlqZoQ+GoZf7JWxS73uXbq9OpH57pAFsuEIe
         wgrKIfkOjyACwW6cBaC61WwymbnUC6EgnfM9REbCdAO2YaR+gOUuiX49o503+65Yct1i
         ZvqA==
X-Received: by 10.68.233.135 with SMTP id tw7mr52276060pbc.112.1386248458787;
        Thu, 05 Dec 2013 05:00:58 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id rx4sm167050121pab.13.2013.12.05.05.00.55
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 05:00:58 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:05:42 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238881>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/send-pack.c     |  3 ---
 send-pack.c             | 19 +++++++++++++++++--
 t/t5537-push-shallow.sh | 25 +++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 664dd20..cc25744 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -209,9 +209,6 @@ int cmd_send_pack(int argc, const char **argv, cons=
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
index cd536b4..848d15e 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -175,6 +175,21 @@ static int sideband_demux(int in, int out, void *d=
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
@@ -215,7 +230,7 @@ int send_pack(struct send_pack_args *args,
 	}
=20
 	if (!args->dry_run)
-		advertise_shallow_grafts(out);
+		advertise_shallow_grafts_buf(&req_buf);
=20
 	/*
 	 * Finally, tell the other end!
@@ -276,7 +291,7 @@ int send_pack(struct send_pack_args *args,
 	}
=20
 	if (args->stateless_rpc) {
-		if (!args->dry_run && cmds_sent) {
+		if (!args->dry_run && (cmds_sent || is_repository_shallow())) {
 			packet_buf_flush(&req_buf);
 			send_sideband(out, -1, req_buf.buf, req_buf.len, LARGE_PACKET_MAX);
 		}
diff --git a/t/t5537-push-shallow.sh b/t/t5537-push-shallow.sh
index 866621a..0a6e40f 100755
--- a/t/t5537-push-shallow.sh
+++ b/t/t5537-push-shallow.sh
@@ -154,5 +154,30 @@ EOF
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
1.8.5.1.25.g8667982
