From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] grep: grep cache entries if they are "assume unchanged"
Date: Sat, 27 Dec 2008 15:21:03 +0700
Message-ID: <1230366064-1306-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Dec 27 09:22:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGURd-0006rN-9Q
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 09:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbYL0IV2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 03:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbYL0IV2
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 03:21:28 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:27750 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbYL0IV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 03:21:27 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3764552rvb.1
        for <git@vger.kernel.org>; Sat, 27 Dec 2008 00:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=+nCeinf001e0dOeY0HcBXeyCCf5a3NfVFqr2iSE0Vwg=;
        b=AQCOl8OlPZE4Q2aujp04MZyMIT9LYSV4kaMvwE/RPRTC7tWAh2cgG97F3yiaeQDAcL
         Ubcchvjds1aAmoh6j3aZomspPXGwqiq6GnrAdTyJrNmXI7WIyoFcpCNTib6/hisG2ERN
         Py9MT70kbxbkOOwXZz33phPbA84bIWvKgQqSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=BQ99qd01frHY+05GRXZViTKuN4ZT6wWfZN+LJvrc7FMA95obw9irsKthtVLnuAQmOB
         EQInsIWlZJ052Lv01xV5wOM2h455zirND23r3mIa1Q/50usTVYgFqUea9ySbPaxJdRuV
         1cOBWD3WXHtNV1ePwBpygkKh/b1nrn6C8lNI0=
Received: by 10.140.162.21 with SMTP id k21mr5362985rve.206.1230366086640;
        Sat, 27 Dec 2008 00:21:26 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.192.118])
        by mx.google.com with ESMTPS id c20sm21769852rvf.5.2008.12.27.00.21.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Dec 2008 00:21:25 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 27 Dec 2008 15:21:04 +0700
X-Mailer: git-send-email 1.6.0.4.1116.g25b13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103987>

"Assume unchanged" bit means "please pretend that I have never touched
this file", so  if user removes the file, we should not care.

This patch teaches "git grep" to use cache version in such
situations. External grep case has not been fixed yet. But given that
on the platform that CE_VALID bit may be used like Windows, external
grep is not available anyway, I would wait for people to raise their
hands before touching it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I will do git-grep fixes for sparse checkout later because it will req=
uire
 nd/narrow. This series does not, so it can be applied separatedly.

 builtin-grep.c  |    7 ++++++-
 t/t7002-grep.sh |    7 +++++++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 3c97c2c..bebf15c 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -404,7 +404,12 @@ static int grep_cache(struct grep_opt *opt, const =
char **paths, int cached)
 			continue;
 		if (!pathspec_matches(paths, ce->name))
 			continue;
-		if (cached) {
+		/*
+		 * If CE_VALID is on, we assume worktree file and its cache entry
+		 * are identical, even if worktree file has been modified, so use
+		 * cache version instead
+		 */
+		if (cached || (ce->ce_flags & CE_VALID)) {
 			if (ce_stage(ce))
 				continue;
 			hit |=3D grep_sha1(opt, ce->sha1, ce->name, 0);
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index 18fe6f2..e12b5dc 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -161,7 +161,14 @@ test_expect_success 'log grep (6)' '
 	git log --author=3D-0700  --pretty=3Dtformat:%s >actual &&
 	>expect &&
 	test_cmp expect actual
+'
=20
+test_expect_success 'grep with CE_VALID file' '
+	git update-index --assume-unchanged t/t &&
+	rm t/t &&
+	test "$(git grep --no-ext-grep t)" =3D "t/t:test" &&
+	git update-index --no-assume-unchanged t/t &&
+	git checkout t/t
 '
=20
 test_done
--=20
1.6.0.4.1116.g25b13
