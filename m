From: =?UTF-8?B?U2ViYXN0aWFuIEfDtnR0ZQ==?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v6 2/5] commit.c/GPG signature verification: Also look at
 the first GPG status line
Date: Sat, 30 Mar 2013 15:15:31 +0100
Message-ID: <5156F383.3040602@physik.tu-berlin.de>
References: <7vvc89k15t.fsf@alter.siamese.dyndns.org> <cover.1364652339.git.jaseg@physik-pool.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 30 15:16:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULwZt-00033I-BS
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 15:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756187Ab3C3OPt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Mar 2013 10:15:49 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:44771 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755702Ab3C3OPs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 10:15:48 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-3) with esmtp 
	id 1ULwZL-0004Vv-Fo; Sat, 30 Mar 2013 15:15:48 +0100
Received: from [94.45.252.144] (unknown [94.45.252.144])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id C4F2C11403;
	Sat, 30 Mar 2013 15:15:42 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <cover.1364652339.git.jaseg@physik-pool.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219589>

Signed-off-by: Sebastian G=C3=B6tte <jaseg@physik-pool.tu-berlin.de>
---
 commit.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index eb645af..ca11919 100644
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
+			found +=3D  strlen(sigcheck_gpg_status[i].check);
+		}
 		sigc->result =3D sigcheck_gpg_status[i].result;
-		found +=3D strlen(sigcheck_gpg_status[i].check);
 		sigc->key =3D xmemdupz(found, 16);
 		found +=3D 17;
 		next =3D strchrnul(found, '\n');
--=20
1.8.1.5
