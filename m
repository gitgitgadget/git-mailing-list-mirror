From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] Use --not-so-strict on all pack transfer for connectivity check
Date: Sun, 31 Mar 2013 18:09:08 +0700
Message-ID: <1364728148-7537-5-git-send-email-pclouds@gmail.com>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 31 13:10:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMG98-0007Q7-L3
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 13:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836Ab3CaLJa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 07:09:30 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:40605 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589Ab3CaLJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 07:09:29 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa10so918493pad.13
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 04:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=lPx0DQV+2TL/WAMJLvu5G2YF29OQ8ZDoQO/zJSbYCK8=;
        b=Yd36CFWVYcaslRHY1rx2EhgTTt6sDqt4JThCufHRhah2b6KJlB3dItFnXG56U6bU8d
         gAMWrt/FGvHrBbRiCYcpdsWIjvLEILaE8ef6y6B8x6257CYNYoYbErXVyygM5D8tLTeX
         aJxFTWUTul06IAxPBCdhiEvKOY6GpVd689JTrwd0ceZBzWEcWnAK+tHEJVxzOm+gVp/J
         8WVhUkU6adxmZ+pVtQwWRVKAUE5fxTnRy/tWpJr15wdxvHI7b+MQOQSwVvpyR+wG+bIb
         pQpLOr7uf9F/+YVNbKtx8RbI2B4mqWVhUC5B3itHvpGiYwF5tOFjAdDO+e2/fhbbWhTo
         TFaA==
X-Received: by 10.68.88.37 with SMTP id bd5mr12732968pbb.209.1364728169590;
        Sun, 31 Mar 2013 04:09:29 -0700 (PDT)
Received: from lanh ([115.74.58.181])
        by mx.google.com with ESMTPS id xc4sm9693230pbc.41.2013.03.31.04.09.26
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 31 Mar 2013 04:09:28 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 31 Mar 2013 18:09:36 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219615>

This replaces check_everything_connected() with --not-so-strict, which
accomplishes the same thing and is generally cheaper.

This also forces connectivity check on "git clone".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch.c                 |  6 ------
 builtin/receive-pack.c          | 22 ++++------------------
 fetch-pack.c                    |  2 ++
 t/t5504-fetch-receive-strict.sh |  2 +-
 4 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4b6b1df..d9f970f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -400,12 +400,6 @@ static int store_updated_refs(const char *raw_url,=
 const char *remote_name,
 	else
 		url =3D xstrdup("foreign");
=20
-	rm =3D ref_map;
-	if (check_everything_connected(iterate_ref_map, 0, &rm)) {
-		rc =3D error(_("%s did not send all necessary objects\n"), url);
-		goto abort;
-	}
-
 	/*
 	 * The first pass writes objects to be merged and then the
 	 * second pass writes the rest, in order to allow using
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 62ba6e7..07abb14 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -663,19 +663,6 @@ static int command_singleton_iterator(void *cb_dat=
a, unsigned char sha1[20])
 	return 0;
 }
=20
-static void set_connectivity_errors(struct command *commands)
-{
-	struct command *cmd;
-
-	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
-		struct command *singleton =3D cmd;
-		if (!check_everything_connected(command_singleton_iterator,
-						0, &singleton))
-			continue;
-		cmd->error_string =3D "missing necessary objects";
-	}
-}
-
 static int iterate_receive_command_list(void *cb_data, unsigned char s=
ha1[20])
 {
 	struct command **cmd_list =3D cb_data;
@@ -718,11 +705,6 @@ static void execute_commands(struct command *comma=
nds, const char *unpacker_erro
 		return;
 	}
=20
-	cmd =3D commands;
-	if (check_everything_connected(iterate_receive_command_list,
-				       0, &cmd))
-		set_connectivity_errors(commands);
-
 	reject_updates_to_hidden(commands);
=20
 	if (run_receive_hook(commands, "pre-receive", 0)) {
@@ -843,6 +825,8 @@ static const char *unpack(int err_fd)
 			unpacker[i++] =3D "-q";
 		if (fsck_objects)
 			unpacker[i++] =3D "--strict";
+		else
+			unpacker[i++] =3D "--not-so-strict";
 		unpacker[i++] =3D hdr_arg;
 		unpacker[i++] =3D NULL;
 		memset(&child, 0, sizeof(child));
@@ -868,6 +852,8 @@ static const char *unpack(int err_fd)
 		keeper[i++] =3D "--stdin";
 		if (fsck_objects)
 			keeper[i++] =3D "--strict";
+		else
+			keeper[i++] =3D "--not-so-strict";
 		keeper[i++] =3D "--fix-thin";
 		keeper[i++] =3D hdr_arg;
 		keeper[i++] =3D keep_arg;
diff --git a/fetch-pack.c b/fetch-pack.c
index 1f9c5ba..ae20ae5 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -754,6 +754,8 @@ static int get_pack(struct fetch_pack_args *args,
 	    ? transfer_fsck_objects
 	    : 0)
 		*av++ =3D "--strict";
+	else
+		*av++ =3D "--not-so-strict";
 	*av++ =3D NULL;
=20
 	cmd.in =3D demux.out;
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-st=
rict.sh
index 69ee13c..14d2935 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -60,7 +60,7 @@ test_expect_success 'fetch with transfer.fsckobjects'=
 '
=20
 cat >exp <<EOF
 To dst
-!	refs/heads/master:refs/heads/test	[remote rejected] (missing necessa=
ry objects)
+!	refs/heads/master:refs/heads/test	[remote rejected] (unpacker error)
 EOF
=20
 test_expect_success 'push without strict' '
--=20
1.8.2.83.gc99314b
