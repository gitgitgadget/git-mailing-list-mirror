From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/20] upload-pack: use skip_prefix() instead of starts_with() when possible
Date: Tue, 29 Dec 2015 19:10:30 +0700
Message-ID: <1451391043-28093-8-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:11:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt7u-0006Sl-DV
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbbL2MLj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:11:39 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34202 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbbL2MLh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:11:37 -0500
Received: by mail-pa0-f47.google.com with SMTP id uo6so101692317pac.1
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0m8C2qqQ65eZIau1LaehEoUfOj+Q7+IjujLST9nTWIw=;
        b=ahdV0yF05kWrQ1zhWjLTDCrW53pRLth5siiMs1mOp36SzmuGuBrPFcIQgL6DIWPolY
         +ZUG//ua4Vxb7q0r+bnz1LL2miEVqJzUg0ZKbMrtAGtMfMuYqVzhVynIMKLBYA2dGLxs
         MaP0PM1uUuXYPDHXNHl6S3LOreCfvcF4otSLvFG5/IIbdYp3a68F2PmCp1MxRu+a+Chi
         Yy6IUA6cUimOW7eTH1LAiioL8R98nLoxZk675GPajffcnOEM5ab/lqgq5J/KXP54YvjY
         vP3tLsZTlXbkrBNX4xCQzkvz4UcDp/qkqj/U9KVrQWuFI/1Jep4yk/FhavzMAXt66nMv
         5yDw==
X-Received: by 10.66.140.39 with SMTP id rd7mr85536553pab.86.1451391097610;
        Tue, 29 Dec 2015 04:11:37 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id y26sm16240834pfi.89.2015.12.29.04.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:11:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:11:32 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283117>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 9ae09a0..e9594d1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -276,7 +276,7 @@ static void create_pack_file(void)
 	die("git upload-pack: %s", abort_msg);
 }
=20
-static int got_sha1(char *hex, unsigned char *sha1)
+static int got_sha1(const char *hex, unsigned char *sha1)
 {
 	struct object *o;
 	int we_knew_they_have =3D 0;
@@ -382,6 +382,8 @@ static int get_common_commits(void)
=20
 	for (;;) {
 		char *line =3D packet_read_line(0, NULL);
+		const char *arg;
+
 		reset_timeout();
=20
 		if (!line) {
@@ -403,8 +405,8 @@ static int get_common_commits(void)
 			got_other =3D 0;
 			continue;
 		}
-		if (starts_with(line, "have ")) {
-			switch (got_sha1(line+5, sha1)) {
+		if (skip_prefix(line, "have ", &arg)) {
+			switch (got_sha1(arg, sha1)) {
 			case -1: /* they have what we do not */
 				got_other =3D 1;
 				if (multi_ack && ok_to_give_up()) {
@@ -623,14 +625,16 @@ static void receive_needs(void)
 		const char *features;
 		unsigned char sha1_buf[20];
 		char *line =3D packet_read_line(0, NULL);
+		const char *arg;
+
 		reset_timeout();
 		if (!line)
 			break;
=20
-		if (starts_with(line, "shallow ")) {
+		if (skip_prefix(line, "shallow ", &arg)) {
 			unsigned char sha1[20];
 			struct object *object;
-			if (get_sha1_hex(line + 8, sha1))
+			if (get_sha1_hex(arg, sha1))
 				die("invalid shallow line: %s", line);
 			object =3D parse_object(sha1);
 			if (!object)
@@ -643,19 +647,19 @@ static void receive_needs(void)
 			}
 			continue;
 		}
-		if (starts_with(line, "deepen ")) {
+		if (skip_prefix(line, "deepen ", &arg)) {
 			char *end;
-			depth =3D strtol(line + 7, &end, 0);
-			if (end =3D=3D line + 7 || depth <=3D 0)
+			depth =3D strtol(arg, &end, 0);
+			if (end =3D=3D arg || depth <=3D 0)
 				die("Invalid deepen: %s", line);
 			continue;
 		}
-		if (!starts_with(line, "want ") ||
-		    get_sha1_hex(line+5, sha1_buf))
+		if (!skip_prefix(line, "want ", &arg) ||
+		    get_sha1_hex(arg, sha1_buf))
 			die("git upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
=20
-		features =3D line + 45;
+		features =3D arg + 40;
=20
 		if (parse_feature_request(features, "multi_ack_detailed"))
 			multi_ack =3D 2;
--=20
2.3.0.rc1.137.g477eb31
