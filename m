From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 25/27] upload-pack: split check_unreachable() in two, prep for get_reachable_list()
Date: Fri, 10 Jun 2016 19:27:12 +0700
Message-ID: <20160610122714.3341-26-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:30:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLZl-00025G-0p
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933012AbcFJM36 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:29:58 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33186 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933004AbcFJM34 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:29:56 -0400
Received: by mail-pa0-f65.google.com with SMTP id di3so5028721pab.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q4s/5WpdGG3djGUEFt4zrnL01dvzZiEz1Voc/Re9L5Y=;
        b=mOMsm3KX1tisZpEFyqKVbkTAkuJBDKf+ixGpSgAhHwL7XzwEC5/RcK/mUNur6WeoEm
         I8LwVZTRKtejU3Bj+X+SRP1QsgRXhz/+sPag5zIxC4CZ5xaWXR9kJpEkvibhKZsgxBt7
         wt1xe19qi5xsrBK1yKQuMcfI5MEQqtJcs7yKUHle+wg6zQeBAaSJ7v6v9F3APZ5OQMwM
         VpgGSXWj3nB1vI2YAkK7plaN3H9FInGmUXn6k+4wq1jzxsh3/8Tx8Rk0uP56SBxChyKH
         M09FT1uP9tDbe8bsZls0F7p/U3dUfrBssS02Y036g3WiuPpiMuOxDpUxl1cJSbZR31hK
         eBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q4s/5WpdGG3djGUEFt4zrnL01dvzZiEz1Voc/Re9L5Y=;
        b=EKC9K8nJYuVmjYIL2juUywXSGUyhiImzCjU/thDqNt2uh82CUkEr9heSvblmZnqqif
         hbYhC+XbLjEd6dvEnakaNhc4X9tncobVweroR4bYGxi6vFjvOmKWD0HC2icnWzrNnwF+
         NFTZRU2VWewleZELM5laG4X+oNFwuQS/oESr/xDn19HUH0HNGkSSMJEQ9Kmsx4XTP0z1
         o6//E2M52i5IxSAPWQs4dWqD9VlRQ7DJ8ecrsBjqTZpyPrMOqvcTFF5VeFc0CrhSK6VE
         v4g9b5LHkwJ9duZCNPVoS79opcVoMfBh6IQTv9Pr2OlXDZ4n3LbGBhgoRxndDJpHqJle
         n0lQ==
X-Gm-Message-State: ALyK8tIPZL/gHn3X+iSIjmwJs08uOzNgr9kw5aOl6DR+UpIfCi79SuZmjmm5tTyaYFle8w==
X-Received: by 10.66.126.47 with SMTP id mv15mr2161488pab.74.1465561794972;
        Fri, 10 Jun 2016 05:29:54 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id g195sm17614731pfb.7.2016.06.10.05.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:29:54 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:29:50 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296987>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 3f40fcb..5942f99 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -452,23 +452,23 @@ static int is_our_ref(struct object *o)
 	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
 }
=20
-static int check_unreachable(struct object_array *src)
+static int do_reachable_revlist(struct child_process *cmd,
+				struct object_array *src)
 {
 	static const char *argv[] =3D {
 		"rev-list", "--stdin", NULL,
 	};
-	static struct child_process cmd =3D CHILD_PROCESS_INIT;
 	struct object *o;
 	char namebuf[42]; /* ^ + SHA-1 + LF */
 	int i;
=20
-	cmd.argv =3D argv;
-	cmd.git_cmd =3D 1;
-	cmd.no_stderr =3D 1;
-	cmd.in =3D -1;
-	cmd.out =3D -1;
+	cmd->argv =3D argv;
+	cmd->git_cmd =3D 1;
+	cmd->no_stderr =3D 1;
+	cmd->in =3D -1;
+	cmd->out =3D -1;
=20
-	if (start_command(&cmd))
+	if (start_command(cmd))
 		goto error;
=20
 	/*
@@ -487,7 +487,7 @@ static int check_unreachable(struct object_array *s=
rc)
 		if (!is_our_ref(o))
 			continue;
 		memcpy(namebuf + 1, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(cmd.in, namebuf, 42) < 0) {
+		if (write_in_full(cmd->in, namebuf, 42) < 0) {
 			sigchain_pop(SIGPIPE);
 			goto error;
 		}
@@ -498,21 +498,39 @@ static int check_unreachable(struct object_array =
*src)
 		if (is_our_ref(o))
 			continue;
 		memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(cmd.in, namebuf, 41) < 0) {
+		if (write_in_full(cmd->in, namebuf, 41) < 0) {
 			sigchain_pop(SIGPIPE);
 			goto error;
 		}
 	}
-	close(cmd.in);
-	cmd.in =3D -1;
+	close(cmd->in);
+	cmd->in =3D -1;
=20
 	sigchain_pop(SIGPIPE);
+	return 0;
+
+error:
+	if (cmd->in >=3D 0)
+		close(cmd->in);
+	if (cmd->out >=3D 0)
+		close(cmd->out);
+	return -1;
+}
+
+static int check_unreachable(struct object_array *src)
+{
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+	char buf[1];
+	int i;
+
+	if (do_reachable_revlist(&cmd, src) < 0)
+		return 0;
=20
 	/*
 	 * The commits out of the rev-list are not ancestors of
 	 * our ref.
 	 */
-	i =3D read_in_full(cmd.out, namebuf, 1);
+	i =3D read_in_full(cmd.out, buf, 1);
 	if (i)
 		goto error;
 	close(cmd.out);
--=20
2.8.2.524.g6ff3d78
