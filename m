From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 5/5] format-patch: pick up branch description when no ref is specified
Date: Thu,  3 Jan 2013 23:16:37 +0700
Message-ID: <1357229797-12260-1-git-send-email-pclouds@gmail.com>
References: <7v7gnuxo4q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 17:17:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqnTV-00035I-7K
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 17:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499Ab3ACQQi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2013 11:16:38 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:40693 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab3ACQQh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 11:16:37 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so8748208pad.16
        for <git@vger.kernel.org>; Thu, 03 Jan 2013 08:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=zwX7XHFdb9+QG6/8JG7bGBtZZWOFgnwTbopGlZYVFyk=;
        b=FFKAmM478j9QDoQOfO6XLwQQmKJSb3tWzq7lZwtVp+yPzCKyXHbeZb4e6yagZQu2wo
         qpHmU6hWYWXcQDrJIT45n719a317iLYYIIQ08T6isMQJmGBWUsbMMOFrr29qy4PXxqQV
         AEYf1lqnpQy8EZqZXH76PgLERLkfadAgKlb0JiMrFqACXfpjvWtciUrvmomCsQ0h3gcN
         9KxLJXdyNnDz/B24U5aHDt35F2bQzHNgIYf2XTWuwZPO3bur7oiqzqKZj+pi28aZhV2o
         VbcY4etgcQ9+KnbwIBuWEhC4PSyTQLKaBdO/MslZs5jsE5ekwlG+V5OQtMiwSn1UqfK5
         FQlw==
X-Received: by 10.66.80.202 with SMTP id t10mr146753808pax.81.1357229796594;
        Thu, 03 Jan 2013 08:16:36 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id bi8sm27718834pab.15.2013.01.03.08.16.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Jan 2013 08:16:35 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 03 Jan 2013 23:16:42 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <7v7gnuxo4q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212594>

We only try to get branch name in "format-patch origin" case or
similar and not "format-patch -22" where HEAD is automatically
added. Without correct branch name, branch description cannot be
added. Make sure we always get branch name.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Thu, Jan 3, 2013 at 10:49 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
 > You could (and I think you should) do something like this:
 >
 >         if (0 <=3D positive) {
 >                 ref =3D rev->cmdline.rev[positive].name;
 >                 tip_sha1 =3D rev->cmdline.rev[positive].item->sha1;
 >         } else if (... defaulted to implied HEAD? ...) {
 >                 ref =3D "HEAD";
 >                 tip_sha1 =3D rev->pending.objects[0].item->sha1;
 >         } else {
 >                 return NULL;
 >         }
 >
 >         if (dwim_ref(...) && !prefixcmp(full_ref, "refs/heads/") &&
 >             !hashcmp(tip_sha1, branch_sha1))
 >
 > to preserve that safety instead.

 Good idea. Done.

 builtin/log.c           | 18 +++++++++++++++---
 t/t4014-format-patch.sh |  7 +++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 039bf67..72a368a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1016,6 +1016,7 @@ static char *find_branch_name(struct rev_info *re=
v)
 {
 	int i, positive =3D -1;
 	unsigned char branch_sha1[20];
+	const unsigned char *tip_sha1;
 	const char *ref;
 	char *full_ref, *branch =3D NULL;
=20
@@ -1027,12 +1028,23 @@ static char *find_branch_name(struct rev_info *=
rev)
 		else
 			return NULL;
 	}
-	if (positive < 0)
+	if (0 <=3D positive) {
+		ref =3D rev->cmdline.rev[positive].name;
+		tip_sha1 =3D rev->cmdline.rev[positive].item->sha1;
+	} else if (!rev->cmdline.nr && rev->pending.nr =3D=3D 1 &&
+		   !strcmp(rev->pending.objects[0].name, "HEAD")) {
+		/*
+		 * No actual ref from command line, but "HEAD" from
+		 * rev->def was added in setup_revisions()
+		 * e.g. format-patch --cover-letter -12
+		 */
+		ref =3D "HEAD";
+		tip_sha1 =3D rev->pending.objects[0].item->sha1;
+	} else
 		return NULL;
-	ref =3D rev->cmdline.rev[positive].name;
 	if (dwim_ref(ref, strlen(ref), branch_sha1, &full_ref) &&
 	    !prefixcmp(full_ref, "refs/heads/") &&
-	    !hashcmp(rev->cmdline.rev[positive].item->sha1, branch_sha1))
+	    !hashcmp(tip_sha1, branch_sha1))
 		branch =3D xstrdup(full_ref + strlen("refs/heads/"));
 	free(full_ref);
 	return branch;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 903a797..7e52941 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -998,4 +998,11 @@ test_expect_success 'cover letter using branch des=
cription (5)' '
 	grep hello actual >/dev/null
 '
=20
+test_expect_success 'cover letter using branch description (6)' '
+	git checkout rebuild-1 &&
+	test_config branch.rebuild-1.description hello &&
+	git format-patch --stdout --cover-letter -2 >actual &&
+	grep hello actual >/dev/null
+'
+
 test_done
--=20
1.8.0.rc2.23.g1fb49df
