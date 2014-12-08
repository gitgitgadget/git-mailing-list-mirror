From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 04/23] untracked cache: invalidate dirs recursively if .gitignore changes
Date: Mon,  8 Dec 2014 21:04:48 +0700
Message-ID: <1418047507-22892-6-git-send-email-pclouds@gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 14:55:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxymR-0004H4-0t
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446AbaLHNzK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 08:55:10 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:51588 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbaLHNzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:55:09 -0500
Received: by mail-pa0-f43.google.com with SMTP id kx10so5265828pab.16
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 05:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=q3yuMx/qTrrYTUTfSuwLDBr/Yde6tvrJKm8IUyljV2c=;
        b=bMp8Ota8KGX4UXir9RSmLznXmpXQhA8kyXWv1p4Zecv208QMw817iVqqgl6uuYNK2N
         MpJ68zoZ/8PL+r84CCzMbzpnNRrTzbY45XzsYGKos7LzBRDqf4JJf2RmSgGIOkxczBo5
         PVOkJrXIm5qxEIsBUudKUK2bKDPBDt5MUwvEV0skNE0fYHeb22aAJ8nnyhRfFnMpdqr2
         i+HmDtCO1YKsLkTIb6TdMrLyRlxUybP+rkhGf/UKTQX8tzDuPr7c66uKvOcDEVDzKRu0
         ZCLDz3hHpaMFyHyEqjgPD2pigxweaNMdJmwGaqG3WhX7RvXAoy6LGsHYUtsu/dbE5lcR
         M8ag==
X-Received: by 10.68.165.132 with SMTP id yy4mr61192952pbb.112.1418046908444;
        Mon, 08 Dec 2014 05:55:08 -0800 (PST)
Received: from lanh ([115.73.205.130])
        by mx.google.com with ESMTPSA id pk5sm17428606pbb.56.2014.12.08.05.55.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 05:55:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 08 Dec 2014 21:05:43 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261022>

It's easy to see that if an existing .gitignore changes, its SHA-1
would be different and invalidate_gitignore() is called.

If .gitignore is removed, add_excludes() will treat it like an empty
=2Egitignore, which again should invalidate the cached directory data.

if .gitignore is added, lookup_untracked() already fills initial
=2Egitignore SHA-1 as "empty file", so again invalidate_gitignore() is
called.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 44ed9f2..6e91315 100644
--- a/dir.c
+++ b/dir.c
@@ -1010,7 +1010,23 @@ static void prep_exclude(struct dir_struct *dir,=
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
2.2.0.60.gb7b3c64
