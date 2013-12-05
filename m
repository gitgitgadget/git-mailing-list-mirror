From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 21/28] send-pack: support pushing to a shallow clone
Date: Thu,  5 Dec 2013 20:02:48 +0700
Message-ID: <1386248575-10206-22-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 14:00:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYXr-0002mV-Fk
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 14:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220Ab3LENAj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 08:00:39 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:46730 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215Ab3LENAi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 08:00:38 -0500
Received: by mail-pb0-f45.google.com with SMTP id rp16so25858275pbb.32
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 05:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sxFsHMWGvMhXX6A8SaTE4iYvWFo3yINiKxlOm9Yzg9A=;
        b=WbdFcaxWrWnDmhsOCQo+PfdwzRdxxJNw+HpQR8yvU0WXMn0XmkSKRq7Sa4O2eCLinh
         XbAv8PXs0K2L24k19zp0xLXVUbwzKppybqyFXp4IaKoyChupds2zw4G2qzKBtWUAi5gC
         P8OoE+GmWjihq6+qtics1yZr/bSsNRGIEM35613+90m0DCovrzpI1OkRqfIZgOKjfmdq
         N7p0OxEd4gDmN5zoOxCPw5dKuyfpE+fpgLad0qAuZYQfDA+/0xGWG9zHaneHjkrCo3/b
         x/ifuQv3sjjB1fcm/AKUsRN5sfeyTbtERi/8Lsfvz78jCI3tiVJinlSeRSzKAXiNl4BV
         WIXw==
X-Received: by 10.66.234.131 with SMTP id ue3mr87360272pac.35.1386248432586;
        Thu, 05 Dec 2013 05:00:32 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id sd3sm144595943pbb.42.2013.12.05.05.00.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 05:00:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:05:16 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238877>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/send-pack.c     |  4 +++-
 t/t5537-push-shallow.sh | 38 ++++++++++++++++++++++++++++++++++++++
 transport.c             |  5 ++---
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index ea2ab28..664dd20 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -101,6 +101,7 @@ int cmd_send_pack(int argc, const char **argv, cons=
t char *prefix)
 	int fd[2];
 	struct child_process *conn;
 	struct sha1_array extra_have =3D SHA1_ARRAY_INIT;
+	struct sha1_array shallow =3D SHA1_ARRAY_INIT;
 	struct ref *remote_refs, *local_refs;
 	int ret;
 	int helper_status =3D 0;
@@ -232,7 +233,8 @@ int cmd_send_pack(int argc, const char **argv, cons=
t char *prefix)
 			args.verbose ? CONNECT_VERBOSE : 0);
 	}
=20
-	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL, &extra_hav=
e, NULL);
+	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL,
+			 &extra_have, &shallow);
=20
 	transport_verify_remote_names(nr_refspecs, refspecs);
=20
diff --git a/t/t5537-push-shallow.sh b/t/t5537-push-shallow.sh
index ff5eb5b..f5c74e6 100755
--- a/t/t5537-push-shallow.sh
+++ b/t/t5537-push-shallow.sh
@@ -82,4 +82,42 @@ EOF
 	test_cmp expect actual
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
index a09fdb6..d596abb 100644
--- a/transport.c
+++ b/transport.c
@@ -819,11 +819,10 @@ static int git_transport_push(struct transport *t=
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
1.8.5.1.25.g8667982
