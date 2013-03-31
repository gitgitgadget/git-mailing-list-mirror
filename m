From: =?ISO-8859-1?Q?Sebastian_G=F6tte?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v7 2/5] commit.c/GPG signature verification: Also look at
 the first GPG status line
Date: Sun, 31 Mar 2013 16:32:52 +0200
Message-ID: <51584914.500@physik.tu-berlin.de>
References: <20130331133332.GD2286@serenity.lan> <cover.1364738348.git.jaseg@physik-pool.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, trast@inf.ethz.ch, john@keeping.me.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 31 16:33:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMJKM-0007d8-Kh
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 16:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867Ab3CaOdR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 10:33:17 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:39895 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755290Ab3CaOdP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 10:33:15 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-3) with esmtp 
	id 1UMJJm-0002cR-Ew; Sun, 31 Mar 2013 16:33:14 +0200
Received: from [94.45.250.108] (unknown [94.45.250.108])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id B4A1811405;
	Sun, 31 Mar 2013 16:33:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <cover.1364738348.git.jaseg@physik-pool.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219623>


Signed-off-by: Sebastian G=F6tte <jaseg@physik-pool.tu-berlin.de>
---
 commit.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index eb645af..eda7f90 100644
--- a/commit.c
+++ b/commit.c
@@ -1027,8 +1027,8 @@ static struct {
 	char result;
 	const char *check;
 } sigcheck_gpg_status[] =3D {
-	{ 'G', "\n[GNUPG:] GOODSIG " },
-	{ 'B', "\n[GNUPG:] BADSIG " },
+	{ 'G', "[GNUPG:] GOODSIG " },
+	{ 'B', "[GNUPG:] BADSIG " },
 };
=20
 static void parse_gpg_output(struct signature_check *sigc)
@@ -1036,13 +1036,20 @@ static void parse_gpg_output(struct signature_c=
heck *sigc)
 	const char *buf =3D sigc->gpg_status;
 	int i;
=20
+	/* Iterate over all search strings */
 	for (i =3D 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
-		const char *found =3D strstr(buf, sigcheck_gpg_status[i].check);
-		const char *next;
-		if (!found)
-			continue;
+		const char *found, *next;
+
+		if (!prefixcmp(buf, sigcheck_gpg_status[i].check + 1)) {
+			/* At the very beginning of the buffer */
+			found =3D buf + strlen(sigcheck_gpg_status[i].check + 1);
+		} else {
+			found =3D strstr(buf, sigcheck_gpg_status[i].check);
+			if (!found)
+ 				continue;
+			found +=3D strlen(sigcheck_gpg_status[i].check);
+		}
 		sigc->result =3D sigcheck_gpg_status[i].result;
-		found +=3D strlen(sigcheck_gpg_status[i].check);
 		sigc->key =3D xmemdupz(found, 16);
 		found +=3D 17;
 		next =3D strchrnul(found, '\n');
--=20
1.8.1.5
