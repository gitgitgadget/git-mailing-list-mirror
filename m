From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 13/16] send-pack: support pushing from a shallow clone via http
Date: Sat, 20 Jul 2013 16:58:07 +0700
Message-ID: <1374314290-5976-14-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 11:59:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Twi-0001g8-58
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 11:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671Ab3GTJ7U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 05:59:20 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37943 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631Ab3GTJ7T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 05:59:19 -0400
Received: by mail-ie0-f174.google.com with SMTP id 9so11278492iec.5
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 02:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5YF5d/VEQETvXcwrpfWQw9xLACRGYaeISdVgs83j4ro=;
        b=ZaE4TrgWRd9QHf0ZptN6K2nLPHACYQCuJHpIncnwngKrfzw14mf4Ed3OmTzgfD9W+p
         uzZUq3KIicCEW/dXuQSVn8E/J74W6MhZ8wKBkWUwGBbRlr+Hzrp96bjMG93QcTrm86XJ
         4/9CiSB2fzkUAqUESNbx+/7hrpdIlPRZvCRUHegHLyC62zu2UPnmjyiuAhbudhK8fva5
         iamBYFbxntE2+RyrPIhEQKbee58e0Z9kNvLF+uNs7ntYrnZOqndIL/uzIfsmnbipzpD3
         xDxZepLgDBQZWrWP9S3G4j3/HAnMkZmeoaXLYA9e+NMMyiyhnM3vYX04axyqfGbxhxgf
         8hRA==
X-Received: by 10.42.33.129 with SMTP id i1mr13256392icd.95.1374314358990;
        Sat, 20 Jul 2013 02:59:18 -0700 (PDT)
Received: from lanh ([115.73.248.127])
        by mx.google.com with ESMTPSA id t10sm21069714igz.9.2013.07.20.02.59.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 02:59:18 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Jul 2013 16:59:37 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230891>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/send-pack.c     |  3 ---
 send-pack.c             | 19 +++++++++++++++++--
 t/t5537-push-shallow.sh | 25 +++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 14a73ba..b177120 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -185,9 +185,6 @@ int cmd_send_pack(int argc, const char **argv, cons=
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
index 1b828b0..520c838 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -198,6 +198,21 @@ static int sideband_demux(int in, int out, void *d=
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
@@ -239,7 +254,7 @@ int send_pack(struct send_pack_args *args,
 	}
=20
 	if (!args->dry_run)
-		advertise_shallow_grafts(out);
+		advertise_shallow_grafts_buf(&req_buf);
=20
 	/*
 	 * Finally, tell the other end!
@@ -299,7 +314,7 @@ int send_pack(struct send_pack_args *args,
 	}
=20
 	if (args->stateless_rpc) {
-		if (!args->dry_run && cmds_sent) {
+		if (!args->dry_run && (cmds_sent || is_repository_shallow())) {
 			packet_buf_flush(&req_buf);
 			send_sideband(out, -1, req_buf.buf, req_buf.len, LARGE_PACKET_MAX);
 		}
diff --git a/t/t5537-push-shallow.sh b/t/t5537-push-shallow.sh
index 02d9198..8bea496 100755
--- a/t/t5537-push-shallow.sh
+++ b/t/t5537-push-shallow.sh
@@ -141,5 +141,30 @@ EOF
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
