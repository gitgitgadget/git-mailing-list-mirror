From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20cleanup=20precompose=5Futf8?=
Date: Fri, 17 Aug 2012 16:53:10 +0200
Message-ID: <1345215190-95976-1-git-send-email-robin.rosenberg@dewire.com>
References: <7v393mxkpk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, git@vger.kernel.org,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 17 16:53:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Nvk-0003wk-Rz
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 16:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758136Ab2HQOxh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Aug 2012 10:53:37 -0400
Received: from mail.dewire.com ([83.140.172.130]:15143 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755359Ab2HQOxg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 10:53:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9E0E78FC79;
	Fri, 17 Aug 2012 16:53:37 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0h7K9RGYOFaD; Fri, 17 Aug 2012 16:53:37 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 39FA28FC74;
	Fri, 17 Aug 2012 16:53:37 +0200 (CEST)
X-Mailer: git-send-email 1.7.12.rc3.4.ga867a5c
In-Reply-To: <7v393mxkpk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203616>

Remove extraneous parentheses and braces
Remove redundant NUL-termination
Check result of unlink when probing for decomposed file names

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 compat/precompose_utf8.c | 11 ++++-------
 1 fil =C3=A4ndrad, 4 till=C3=A4gg(+), 7 borttagningar(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index d40d1b3..9563760 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -21,11 +21,10 @@ static size_t has_utf8(const char *s, size_t maxlen=
, size_t *strlen_c)
 	size_t strlen_chars =3D 0;
 	size_t ret =3D 0;
=20
-	if ((!utf8p) || (!*utf8p)) {
+	if (!utf8p || !*utf8p)
 		return 0;
-	}
=20
-	while((*utf8p) && maxlen) {
+	while(*utf8p && maxlen) {
 		if (*utf8p & 0x80)
 			ret++;
 		strlen_chars++;
@@ -46,21 +45,19 @@ void probe_utf8_pathname_composition(char *path, in=
t len)
 	int output_fd;
 	if (precomposed_unicode !=3D -1)
 		return; /* We found it defined in the global config, respect it */
-	path[len] =3D 0;
 	strcpy(path + len, auml_nfc);
 	output_fd =3D open(path, O_CREAT|O_EXCL|O_RDWR, 0600);
 	if (output_fd >=3D0) {
 		close(output_fd);
-		path[len] =3D 0;
 		strcpy(path + len, auml_nfd);
 		/* Indicate to the user, that we can configure it to true */
 		if (0 =3D=3D access(path, R_OK))
 			git_config_set("core.precomposeunicode", "false");
 			/* To be backward compatible, set precomposed_unicode to 0 */
 		precomposed_unicode =3D 0;
-		path[len] =3D 0;
 		strcpy(path + len, auml_nfc);
-		unlink(path);
+		if (unlink(path))
+			die_errno(_("failed to unlink '%s'"), path);
 	}
 }
=20
--=20
1.7.12.rc3.4.ga867a5c
