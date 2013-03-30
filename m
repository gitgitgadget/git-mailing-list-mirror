From: =?ISO-8859-1?Q?Sebastian_G=F6tte?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v5 2/5] commit.c/GPG signature verification: Also look at
 the first GPG status line
Date: Sat, 30 Mar 2013 01:14:20 +0100
Message-ID: <51562E5C.8020206@physik.tu-berlin.de>
References: <7vy5d7qhmm.fsf@alter.siamese.dyndns.org> <cover.1364601337.git.jaseg@physik-pool.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 30 01:15:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULjRx-0001Qw-Lm
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 01:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757309Ab3C3AOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Mar 2013 20:14:46 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:6307 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757274Ab3C3AOp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 20:14:45 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-3) with esmtp 
	id 1ULjRI-00059d-DL; Sat, 30 Mar 2013 01:14:44 +0100
Received: from [94.45.252.144] (unknown [94.45.252.144])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 2CB6411402;
	Sat, 30 Mar 2013 01:14:31 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <cover.1364601337.git.jaseg@physik-pool.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219541>

Signed-off-by: Sebastian G=F6tte <jaseg@physik-pool.tu-berlin.de>
---
 commit.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/commit.c b/commit.c
index e94d122..48f09e9 100644
--- a/commit.c
+++ b/commit.c
@@ -1027,27 +1027,33 @@ static struct {
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
 {
-	const char *buf =3D sigc->gpg_status;
 	int i;
=20
+	/* Iterate over all search strings */
 	for (i =3D 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
-		const char *found =3D strstr(buf, sigcheck_gpg_status[i].check);
-		const char *next;
-		if (!found)
-			continue;
-		sigc->check_result =3D sigcheck_gpg_status[i].result;
-		found +=3D strlen(sigcheck_gpg_status[i].check);
-		sigc->key =3D xmemdupz(found, 16);
-		found +=3D 17;
-		next =3D strchrnul(found, '\n');
-		sigc->signer =3D xmemdupz(found, next - found);
-		break;
+		const char *found =3D sigc->gpg_status;
+
+		/* Iterate over all lines */
+		do {
+			if (!prefixcmp(found, sigcheck_gpg_status[i].check)) {
+				const char *next;
+			=09
+				found +=3D strlen(sigcheck_gpg_status[i].check);
+				sigc->check_result =3D sigcheck_gpg_status[i].result;
+				sigc->key =3D xmemdupz(found, 16);
+				found +=3D 17;
+				next =3D strchrnul(found, '\n');
+				sigc->signer =3D xmemdupz(found, next - found);
+				return;
+			}
+			found =3D strchr(found, '\n')+1;
+		} while(found-1);
 	}
 }
=20
--=20
1.8.1.5
