From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] index-pack: do not segfault when keep_name is NULL
Date: Sun, 16 Mar 2014 20:35:01 +0700
Message-ID: <1394976904-15395-3-git-send-email-pclouds@gmail.com>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 14:34:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPBD8-0005sl-3E
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 14:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbaCPNeh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Mar 2014 09:34:37 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:54015 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbaCPNeg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 09:34:36 -0400
Received: by mail-pd0-f182.google.com with SMTP id y10so4526590pdj.27
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 06:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Q8ytwZAGjAg1h0C3ks+BBgKjCCMMfuWbLTj4RChvJTU=;
        b=e0UtV3ApRLJdpE9nGtZvGtzvJjQMBv1Ss5nmSWFyfrMb62xkEfTIq0eNNJzOloegoB
         OnmS2xRRBjw2RmBrOK8BZKyX66YqBdFiWOGBwm7A8aW4ed1moXVYcyexWNtye3AkZ63P
         eCbRzaVoSFHMrur7U23eNpFioZWDvtRW/ueu0+xo6HnrRNMeHN1hYIH37dLmY+dMaKFw
         p54oXOjGlyApKEEiuiY8viGqW3aQ1dFd4qlxHqIppkCJrXkDxAgvyPEtTQAUmSbd2Np6
         smLrYJ2lNmYt70a6cgopNt8WXB2HsznIQ7XGpxINfXO05fJ/7sYICqqLL4qB0E3+OsRm
         SM/Q==
X-Received: by 10.66.150.69 with SMTP id ug5mr20388408pab.55.1394976875754;
        Sun, 16 Mar 2014 06:34:35 -0700 (PDT)
Received: from lanh ([115.73.203.48])
        by mx.google.com with ESMTPSA id x9sm34456518pbu.1.2014.03.16.06.34.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Mar 2014 06:34:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Mar 2014 20:35:17 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244196>

keep_name is used to print error messages a couple lines down. Reset
it to the real path returned by odb_pack_keep() if it's set to NULL by
caller.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 One of these moments I will make git log and friends optionally recogn=
ize
 "Diff-Options:" line in commit message. Adding -U14 in this case
 should help the reviewer to see how those error messages are printed.

 builtin/index-pack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a6b1c17..d95c3dc 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1283,9 +1283,10 @@ static void final(const char *final_pack_name, c=
onst char *curr_pack_name,
 	if (keep_msg) {
 		int keep_fd, keep_msg_len =3D strlen(keep_msg);
=20
-		if (!keep_name)
+		if (!keep_name) {
 			keep_fd =3D odb_pack_keep(name, sizeof(name), sha1);
-		else
+			keep_name =3D name;
+		} else
 			keep_fd =3D open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0600);
=20
 		if (keep_fd < 0) {
--=20
1.9.0.40.gaa8c3ea
