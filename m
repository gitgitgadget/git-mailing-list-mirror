From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 23/25] upload-pack: split check_unreachable() in two, prep for get_reachable_list()
Date: Tue, 23 Feb 2016 20:45:01 +0700
Message-ID: <1456235103-26317-24-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:47:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDJE-0001PV-1r
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbcBWNrS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:47:18 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35339 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851AbcBWNrO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:47:14 -0500
Received: by mail-pa0-f53.google.com with SMTP id ho8so113764356pac.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TscU9o9BliHUmXenoE0r8aJZG307Hbc6DIA8nwmvAk8=;
        b=K/V3s7DOLhCVZ1htLtYY+Um/DmYw4AWxyL774+b/YWSsfWVaOPGbHTT/cTFEa0ZgU4
         J4C5HPb+Wvs0ZsTUAYyKNsgbgebvQeBqDmJ21UKBooYoohH/sFVUZG5pzt3wvSK29Grd
         3fsxoqukSwYkN7KGLm8JiQXlc4r0ueVAV9+yN2ZU4yRPRhXYWyrajKMXEyCN5pozkdeV
         6yS8TQY+Sc/bebdl4ASxwhRGga1z0vO2C3iOC66TlJhUk83mIMvvkr9Q64ppBkyHFftz
         OYc9AphEQHILQtvSXbiBS3ltGw/FnNomHm/Fn5RdhnQ1tdQVEOTIUI5ucaGQ0k9wdbBj
         +fFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=TscU9o9BliHUmXenoE0r8aJZG307Hbc6DIA8nwmvAk8=;
        b=mI8JMseaEepCCrE/Y4YB++lek79mgLUOpwJmAKpK6yZlg1S5jZrR5zUPNLR69PtZuf
         PztCnIZvvyI4oGtj8UMypW2K0xVBr06cHViuGHiG0JNggCODPWYdSIyw+a2aLTHofGTC
         VtwPdEmhfKUhNeC71GBBNuulER2mLQBLgZZoxEAhF3Gy1rJPUeWsvaHOTx84n1a8lzv1
         FrNkpU4gPKHEgaQEYz+H0ldGStgqv6XnHMblqRdp2wTtuXDEGgOA3fAxgx0vWFAPpKOY
         +hW0bpPSIuFKR1oA0tFH2cShKVWPR5F0+QuJZ7s9WIZgX9x0rVT4w9LeQnEX3q0VRDTY
         mZow==
X-Gm-Message-State: AG10YOSpOYiMM99u0u9lQqLmlOrkguoYJTV53mDAEBiCfluqnjAt0DOsLwIULmcjkxTjVQ==
X-Received: by 10.67.21.205 with SMTP id hm13mr46492233pad.56.1456235234531;
        Tue, 23 Feb 2016 05:47:14 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id ss5sm44737756pab.15.2016.02.23.05.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:47:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:47:43 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287073>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 95a0bfb..9e4a4fa 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -452,24 +452,24 @@ static int is_our_ref(struct object *o)
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
-		return 0;
+	if (start_command(cmd))
+		return -1;
=20
 	/*
 	 * If rev-list --stdin encounters an unknown commit, it
@@ -487,8 +487,8 @@ static int check_unreachable(struct object_array *s=
rc)
 		if (!is_our_ref(o))
 			continue;
 		memcpy(namebuf + 1, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(cmd.in, namebuf, 42) < 0)
-			return 0;
+		if (write_in_full(cmd->in, namebuf, 42) < 0)
+			return -1;
 	}
 	namebuf[40] =3D '\n';
 	for (i =3D 0; i < src->nr; i++) {
@@ -496,18 +496,29 @@ static int check_unreachable(struct object_array =
*src)
 		if (is_our_ref(o))
 			continue;
 		memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(cmd.in, namebuf, 41) < 0)
-			return 0;
+		if (write_in_full(cmd->in, namebuf, 41) < 0)
+			return -1;
 	}
-	close(cmd.in);
+	close(cmd->in);
=20
 	sigchain_pop(SIGPIPE);
+	return 0;
+}
+
+static int check_unreachable(struct object_array *src)
+{
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+	int i, ret =3D do_reachable_revlist(&cmd, src);
+	char buf[1];
+
+	if (ret < 0)
+		return 0;
=20
 	/*
 	 * The commits out of the rev-list are not ancestors of
 	 * our ref.
 	 */
-	i =3D read_in_full(cmd.out, namebuf, 1);
+	i =3D read_in_full(cmd.out, buf, 1);
 	if (i)
 		return 0;
 	close(cmd.out);
--=20
2.7.1.532.gd9e3aaa
