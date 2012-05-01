From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 4/4] diff --stat: do not run diff on indentical files
Date: Tue,  1 May 2012 19:10:15 +0200
Message-ID: <1335892215-21331-5-git-send-email-zbyszek@in.waw.pl>
References: <1335892215-21331-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mj@ucw.cz,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue May 01 19:11:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPGbz-0003dQ-7Z
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757527Ab2EARLe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 13:11:34 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35799 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755877Ab2EARLe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:11:34 -0400
Received: from ip-37-209-134-178.free.aero2.net.pl ([37.209.134.178] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SPGbs-0003uH-Q5; Tue, 01 May 2012 19:11:33 +0200
X-Mailer: git-send-email 1.7.10.539.g288dd
In-Reply-To: <1335892215-21331-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196702>

If sha1's are equal, then there's no point in performing the diff.

In a very unscientific test:

git init &&
  dd if=3D/dev/urandom bs=3D1M count=3D30 | hexdump >file1 &&
  git add file1 && git commit -m 'add file' &&
  git mv file1 file1-moved && chmod +x file1-moved &&
  command time git diff --stat

(before) git diff --stat  2.00s user 0.31s system 99% cpu 2.323 total
(after)  git diff --stat  0.80s user 0.10s system 98% cpu 0.913 total

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 diff.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 6eb2946..7cb9893 100644
--- a/diff.c
+++ b/diff.c
@@ -2398,7 +2398,7 @@ static void builtin_diffstat(const char *name_a, =
const char *name_b,
 		data->added =3D count_lines(two->data, two->size);
 	}
=20
-	else {
+	else if (!data->is_unchanged) {
 		/* Crazy xdl interfaces.. */
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
--=20
1.7.10.539.g288dd
