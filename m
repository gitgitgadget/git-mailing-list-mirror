From: =?UTF-8?B?U2ViYXN0aWFuIEfDtnR0ZQ==?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v8 2/5] commit.c/GPG signature verification: Also look at
 the first GPG status line
Date: Sun, 31 Mar 2013 18:01:34 +0200
Message-ID: <51585DDE.9000607@physik.tu-berlin.de>
References: <20130331144452.GF2286@serenity.lan> <cover.1364742659.git.jaseg@physik-pool.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, john@keeping.me.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 31 18:02:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMKi2-000160-NZ
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 18:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766Ab3CaQBu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 12:01:50 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:5023 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755687Ab3CaQBu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 12:01:50 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-4) with esmtp 
	id 1UMKhV-0004Sv-Aq; Sun, 31 Mar 2013 18:01:49 +0200
Received: from [94.45.250.108] (unknown [94.45.250.108])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 6BDA711403;
	Sun, 31 Mar 2013 18:01:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <cover.1364742659.git.jaseg@physik-pool.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219635>


Signed-off-by: Sebastian G=C3=B6tte <jaseg@physik-pool.tu-berlin.de>
---
 commit.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index eb645af..3a8453d 100644
--- a/commit.c
+++ b/commit.c
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
