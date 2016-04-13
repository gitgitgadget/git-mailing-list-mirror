From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/26] upload-pack: split check_unreachable() in two, prep for get_reachable_list()
Date: Wed, 13 Apr 2016 19:55:08 +0700
Message-ID: <1460552110-5554-25-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:57:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKMV-0004n9-0m
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758070AbcDMM5X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:57:23 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34984 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757586AbcDMM5V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:57:21 -0400
Received: by mail-pa0-f66.google.com with SMTP id zy2so3924307pac.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DqlcObJ9Y6STGTApkXRYBmbaCXr3NdaZIUe219FvYDM=;
        b=s32l7y7VDrBxSJ3zkQxc97yIqhTIDiix/ZetO2d96OTjryWO4rB4J9JYnIE5OqTut/
         yh8ovst7vzuZx0tCeyivtYPek5/p+MNW96XZUgKVTKMyTBNqoAOOFiFRUzqSgghksez3
         hoYv0bZPiQncVgYjkHCFoyV7MHQcq9qvyTJhZpfTWLOjgG07fFGdPjeCgOy3Ym85/6BW
         t29WL37KqQhthUCdQ4hMx4DKNIswUw1cluptvfQBl2JjwjcFUu5FTUeUCZJZcxyuZovw
         KVLNYAvhuT1jsfVxcS1viFTQsBnr/mO3cOai9dLIIRt8mveS2kLN/LeaCKMGtlGCjEJN
         4btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DqlcObJ9Y6STGTApkXRYBmbaCXr3NdaZIUe219FvYDM=;
        b=JGAwdQjTXQiN+72InP50AxK1dgqElFYjX2FRLaA0sLqmgMJmTFWtQGLk1e0YYb7d+M
         nlZC3CR/LqLkIzRZD5O/IZt6yr7+8yHUlRuZPI6R0R4yAztw0oa+jDD4QyFJKHEo07LV
         TNNWfdOuSge4rpTaKKa8CtCfn3aoWizCeILMXzkKq+sve2+QYYXWnIzYMpHD7Va1Ri0D
         1aAdTLCM7eJWlWA8V5U3TWDyM6skeTvo/oplII5gpTNtSQFLt7/9MYgcsj21eggk3E5u
         5kpkSw27f3PPKXaLVPutNaxCKmtUt1gkclWwTor4AFy4LJB2/rEHFRK4Vtzb4I8J/2Sh
         vSog==
X-Gm-Message-State: AOPr4FXi4nzUWzH/4SMF2sZM2k/lWlz371N7/im1DFMZtCA2oF8LmGc1UFn84JCk/EtFZg==
X-Received: by 10.66.139.9 with SMTP id qu9mr12683260pab.101.1460552240967;
        Wed, 13 Apr 2016 05:57:20 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id ba9sm51165197pab.24.2016.04.13.05.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:57:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:57:27 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291418>

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
2.8.0.rc0.210.gd302cd2
