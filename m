From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/23] Teach grep to respect skip-worktree bit
Date: Mon, 14 Dec 2009 17:30:50 +0700
Message-ID: <1260786666-8405-8-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:33:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8FJ-0007wL-M9
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171AbZLNKdP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756033AbZLNKcf
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:32:35 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:60353 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbZLNKca (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:32:30 -0500
Received: by mail-pw0-f42.google.com with SMTP id 9so1838737pwj.21
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=QDIljZF3Ltv3PnrpOKagE3Q0f+2K1zkImJN8Kc+bLOI=;
        b=T2CsxqdiAmtBBFZVNc78WebcBjN1p+voet5ZZ6DwfZh081sCr4LmUNrwqeKe7eqOIA
         ieA+DHEN2KXBa1fd3UQaQ1FxCd1+I1x1bI46DuJ3uvUmMs38t+YAA0CpNnxpTFnrpKuI
         k2iDHjuDi8JsMCr4gCFM4NB/05nKfAsulEKGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fqSh4tvG3QNFpOE1C988KMtS93hWFE4Y8h8aymknOvyj5I0LP6bwlTh9F60xvaoU7C
         iY93FcvMLUMol+HWVXFy15f2fv+vwxpsIHne/+DsiPH3b5uvpWy2se7NK6snpb7rInhe
         SBehiphhOMMjrrWIEJpdDLTYbC/wWXJn2vu5k=
Received: by 10.115.101.27 with SMTP id d27mr185133wam.126.1260786750194;
        Mon, 14 Dec 2009 02:32:30 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 20sm4895676pzk.5.2009.12.14.02.32.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:32:29 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:31:48 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135181>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-grep.c                   |    2 +-
 t/t7011-skip-worktree-reading.sh |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index ad0e0a5..813fe97 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -517,7 +517,7 @@ static int grep_cache(struct grep_opt *opt, const c=
har **paths, int cached,
 		 * are identical, even if worktree file has been modified, so use
 		 * cache version instead
 		 */
-		if (cached || (ce->ce_flags & CE_VALID)) {
+		if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
 			if (ce_stage(ce))
 				continue;
 			hit |=3D grep_sha1(opt, ce->sha1, ce->name, 0);
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-r=
eading.sh
index 5db93d0..2ec677a 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -111,6 +111,15 @@ test_expect_success 'ls-files --modified' '
 	test -z "$(git ls-files -m)"
 '
=20
+test_expect_success 'grep with skip-worktree file' '
+	git update-index --no-skip-worktree 1 &&
+	echo test > 1 &&
+	git update-index 1 &&
+	git update-index --skip-worktree 1 &&
+	rm 1 &&
+	test "$(git grep --no-ext-grep test)" =3D "1:test"
+'
+
 echo ":000000 100644 $ZERO_SHA1 $NULL_SHA1 A	1" > expected
 test_expect_success 'diff-index does not examine skip-worktree absent =
entries' '
 	setup_absent &&
--=20
1.6.5.2.216.g9c1ec
