From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/24] untracked cache: invalidate dirs recursively if .gitignore changes
Date: Sun,  8 Mar 2015 17:12:27 +0700
Message-ID: <1425809567-25518-5-git-send-email-pclouds@gmail.com>
References: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 11:13:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYDH-0002el-3f
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbbCHKNb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 06:13:31 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:37318 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbbCHKNa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 06:13:30 -0400
Received: by paceu11 with SMTP id eu11so50728466pac.4
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 03:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=s5VgR/2REHHyZHSIyvWy2Mqy3pMQv1qZ5DiZsMxhE/8=;
        b=o+BnrX1vl05R7oaB1IhxoE5ZsZ2dF6R1lLHnhSRht6GxpqSfiMTrTslEnlM76qcXXg
         jBnpHJlSFQGuBNfQdsaVjMdgE3a1vFmvg/KgnT7bj4lR06GKQu7TlEX/IEXj0xZCQT3a
         tIekNoXKWQUkIpE3F4/Sm75da9P+OJM6GsDACxilmQcFBcx29mb+Z7kCvAgkW+wZJIHf
         PbHR4T4n7foCtCo1tSB5zBCSvXGso+T77Hj1AFVMNOsF1/Gv/PqaZMcFtKe92xWuVG4O
         eL1+T0v/iCsDUn/lkF6NVV2vyFG18sr6rcUAdJsvMWlRB4gm2SfTvHD+1OgC3GBUtF/e
         HTdA==
X-Received: by 10.66.153.1 with SMTP id vc1mr41279768pab.109.1425809609807;
        Sun, 08 Mar 2015 03:13:29 -0700 (PDT)
Received: from lanh ([115.73.247.162])
        by mx.google.com with ESMTPSA id ib3sm14417788pbb.15.2015.03.08.03.13.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 03:13:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Mar 2015 17:13:25 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265057>

It's easy to see that if an existing .gitignore changes, its SHA-1
would be different and invalidate_gitignore() is called.

If .gitignore is removed, add_excludes() will treat it like an empty
=2Egitignore, which again should invalidate the cached directory data.

if .gitignore is added, lookup_untracked() already fills initial
=2Egitignore SHA-1 as "empty file", so again invalidate_gitignore() is
called.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index b1c5faa..bfbd332 100644
--- a/dir.c
+++ b/dir.c
@@ -1011,7 +1011,23 @@ static void prep_exclude(struct dir_struct *dir,=
 const char *base, int baselen)
 			add_excludes(el->src, el->src, stk->baselen, el, 1,
 				     untracked ? &sha1_stat : NULL);
 		}
-		if (untracked) {
+		/*
+		 * NEEDSWORK: when untracked cache is enabled, prep_exclude()
+		 * will first be called in valid_cached_dir() then maybe many
+		 * times more in last_exclude_matching(). When the cache is
+		 * used, last_exclude_matching() will not be called and
+		 * reading .gitignore content will be a waste.
+		 *
+		 * So when it's called by valid_cached_dir() and we can get
+		 * .gitignore SHA-1 from the index (i.e. .gitignore is not
+		 * modified on work tree), we could delay reading the
+		 * .gitignore content until we absolutely need it in
+		 * last_exclude_matching(). Be careful about ignore rule
+		 * order, though, if you do that.
+		 */
+		if (untracked &&
+		    hashcmp(sha1_stat.sha1, untracked->exclude_sha1)) {
+			invalidate_gitignore(dir->untracked, untracked);
 			hashcpy(untracked->exclude_sha1, sha1_stat.sha1);
 		}
 		dir->exclude_stack =3D stk;
--=20
2.3.0.rc1.137.g477eb31
