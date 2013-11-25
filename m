From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 21/28] send-pack: support pushing to a shallow clone
Date: Mon, 25 Nov 2013 10:55:47 +0700
Message-ID: <1385351754-9954-22-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:53:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknEy-0002D8-JQ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667Ab3KYDxh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:53:37 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34482 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659Ab3KYDxd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:53:33 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so4644050pdj.9
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=d7wlggBw1s0qXwbkoKqm/DZvjwuye8krtILxA2d7CTg=;
        b=ZkZS6iYgboJbZbQr1G3Xnlr+izH+Dr8lyz/98N4vcd5yZktKIRfUBr1g+T/eOCF0e0
         OWaCcJBG+xyMkBE7yokH8nvk4xQaUMcSkpP15d7G4eHzv8RPsC/WP7Cdmq9n6o9lhg1V
         sKo98JUoOcIaNO6/6TwdX7UGGyptz6/uUIXTDxuJI3YD10205KQN7n3wJ7C8EPML1uF3
         5b4hN9BXrkfI65T+MbFu3fOsKPN2FVSyv4nf23SiXF37SecpElnh0JWKT3jRlELfaNil
         0Bso088EtOspVcsBP6eQYhSwLiKDL0gJFiIqNvSnxcCxC32u3ypICgYTvk9KEpqvyQuT
         bUxQ==
X-Received: by 10.69.11.65 with SMTP id eg1mr9912204pbd.100.1385351612258;
        Sun, 24 Nov 2013 19:53:32 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id ja5sm69197157pbc.14.2013.11.24.19.53.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:53:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:58:05 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238292>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/send-pack.c     |  5 ++++-
 t/t5537-push-shallow.sh | 38 ++++++++++++++++++++++++++++++++++++++
 transport.c             |  5 ++---
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 5db1311..0031165 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -100,6 +100,7 @@ int cmd_send_pack(int argc, const char **argv, cons=
t char *prefix)
 	int fd[2];
 	struct child_process *conn;
 	struct extra_have_objects extra_have;
+	struct extra_have_objects shallow;
 	struct ref *remote_refs, *local_refs;
 	int ret;
 	int helper_status =3D 0;
@@ -232,8 +233,10 @@ int cmd_send_pack(int argc, const char **argv, con=
st char *prefix)
 	}
=20
 	memset(&extra_have, 0, sizeof(extra_have));
+	memset(&shallow, 0, sizeof(shallow));
=20
-	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL, &extra_hav=
e, NULL);
+	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL,
+			 &extra_have, &shallow);
=20
 	transport_verify_remote_names(nr_refspecs, refspecs);
=20
diff --git a/t/t5537-push-shallow.sh b/t/t5537-push-shallow.sh
index 0084a31..ccb41b6 100755
--- a/t/t5537-push-shallow.sh
+++ b/t/t5537-push-shallow.sh
@@ -83,4 +83,42 @@ EOF
 	git config receive.shallowupdate false
 '
=20
+test_expect_success 'push from shallow to shallow' '
+	(
+	cd shallow &&
+	git --git-dir=3D../shallow2/.git config receive.shallowupdate true &&
+	git push ../shallow2/.git +master:refs/remotes/shallow/master &&
+	git --git-dir=3D../shallow2/.git config receive.shallowupdate false
+	) &&
+	(
+	cd shallow2 &&
+	git log --format=3D%s shallow/master >actual &&
+	git fsck &&
+	cat <<EOF >expect &&
+5
+4
+3
+EOF
+	test_cmp expect actual
+	)
+'
+
+test_expect_success 'push from full to shallow' '
+	! git --git-dir=3Dshallow2/.git cat-file blob `echo 1|git hash-object=
 --stdin` &&
+	commit 1 &&
+	git push shallow2/.git +master:refs/remotes/top/master &&
+	(
+	cd shallow2 &&
+	git log --format=3D%s top/master >actual &&
+	git fsck &&
+	cat <<EOF >expect &&
+1
+4
+3
+EOF
+	test_cmp expect actual &&
+	git cat-file blob `echo 1|git hash-object --stdin` >/dev/null
+	)
+'
+
 test_done
diff --git a/transport.c b/transport.c
index c0be6b1..6a3fe9b 100644
--- a/transport.c
+++ b/transport.c
@@ -818,11 +818,10 @@ static int git_transport_push(struct transport *t=
ransport, struct ref *remote_re
 		struct ref *tmp_refs;
 		connect_setup(transport, 1, 0);
=20
-		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL, NULL, =
NULL);
+		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL,
+				 NULL, &data->shallow);
 		data->got_remote_heads =3D 1;
 	}
-	if (data->shallow.nr)
-		die("pushing to a shallow repository is not supported");
=20
 	memset(&args, 0, sizeof(args));
 	args.send_mirror =3D !!(flags & TRANSPORT_PUSH_MIRROR);
--=20
1.8.2.83.gc99314b
