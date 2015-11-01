From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 8/9] index-helper: add --detach
Date: Sun,  1 Nov 2015 14:42:48 +0100
Message-ID: <1446385369-8669-9-git-send-email-pclouds@gmail.com>
References: <1446385369-8669-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 14:43:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZssvF-0008Pu-L5
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 14:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbbKANnq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2015 08:43:46 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37357 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbbKANnk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 08:43:40 -0500
Received: by wmff134 with SMTP id f134so41580953wmf.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 05:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SDFQPCXq5MHS77glUBat5SjkBAEh47wyC+dLBco2ne0=;
        b=yhOPucYy+luOqkeaK4WCAaWlQV8Pone6jBT+MP6y6sX4l3ctXRfiV/kmjs7QP6Y9ch
         g5fjUdn+BGWEy9kpNf4bPIXWzD2Z8E2y+smWF+s0+F0vfT6TIEhbwyVMo/aOM3sI23rI
         W3wwmL4BIyRinJYPUHeJr47MJWynxCIkYy9ZyFFhVEagBsLnq5NzaEhZlmrPLlNEu53C
         LMv31BMxWoblynEo/U1B7KKS/d5z+crFjyeU0Vc8vjYABpmi7D278tBCN4W+2nxtYwkh
         oRz87RN6/xIhkoHFf1wZ4KZWAzuDeWUXlnqeL4itP939JiyiMjIX0tOtrqVtO77xtk2K
         mexg==
X-Received: by 10.28.19.198 with SMTP id 189mr8388746wmt.103.1446385419016;
        Sun, 01 Nov 2015 05:43:39 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id gd10sm17058028wjb.47.2015.11.01.05.43.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Nov 2015 05:43:37 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <1446385369-8669-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280624>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-index-helper.txt |  3 +++
 index-helper.c                     | 10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index ad40366..9ced091 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -31,6 +31,9 @@ OPTIONS
 	for reading an index, but because it will happen in the
 	background, it's not noticable. `--strict` is enabled by default.
=20
+--detach::
+	Detach from the shell.
+
 NOTES
 -----
 On UNIX-like systems, $GIT_DIR/index-helper.pid contains the process
diff --git a/index-helper.c b/index-helper.c
index 1140bc0..4dd9656 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -14,7 +14,7 @@ struct shm {
=20
 static struct shm shm_index;
 static struct shm shm_base_index;
-static int to_verify =3D 1;
+static int daemonized, to_verify =3D 1;
=20
 static void release_index_shm(struct shm *is)
 {
@@ -33,6 +33,8 @@ static void cleanup_shm(void)
=20
 static void cleanup(void)
 {
+	if (daemonized)
+		return;
 	unlink(git_path("index-helper.pid"));
 	cleanup_shm();
 }
@@ -172,12 +174,13 @@ int main(int argc, char **argv)
 	static struct lock_file lock;
 	struct strbuf sb =3D STRBUF_INIT;
 	const char *prefix;
-	int fd, idle_in_minutes =3D 10;
+	int fd, idle_in_minutes =3D 10, detach =3D 0;
 	struct option options[] =3D {
 		OPT_INTEGER(0, "exit-after", &idle_in_minutes,
 			    N_("exit if not used after some minutes")),
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
+		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_END()
 	};
=20
@@ -202,6 +205,9 @@ int main(int argc, char **argv)
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
=20
+	if (detach && daemonize(&daemonized))
+		die_errno("unable to detach");
+
 	if (!idle_in_minutes)
 		idle_in_minutes =3D 0xffffffff / 60;
 	loop(sb.buf, idle_in_minutes * 60);
--=20
2.2.0.513.g477eb31
