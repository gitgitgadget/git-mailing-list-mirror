From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] commit: ignore assume-unchanged files in "commmit <file>" mode
Date: Fri,  5 Dec 2014 17:56:14 +0700
Message-ID: <1417776974-6537-1-git-send-email-pclouds@gmail.com>
References: <1417732931.20814.16.camel@segulix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sergio@serjux.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 11:46:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwqOl-0006GC-Hs
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 11:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbaLEKqD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Dec 2014 05:46:03 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34243 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbaLEKqC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 05:46:02 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so474149pdb.22
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 02:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=murHyTrdx/VZx17YaVBQIEPS8nlCJfOJH6zZdr/1gyg=;
        b=qMdpY7D60OMoBD+BLe4oM69vPclGgIzJvFX1JshThyMRwX8bo+g3UEPXkTSSCAecLI
         ZxfXTU7zsYwW//UKjcn+YyWXnIJmJaKPArUte1/q4EDF7/NJ5epZJR0GE/B9nvZyw3Jp
         9Ghl+NS8KTWoRjYzfeXhcYnfaclzioKWTXXfZ+FgobIFRJdUDBdaymwSoR3LLAV8XLBV
         UQVtr4tEM2CmHf5DeIuKL0IvWgOLNZxxeBJqvY37miItl/A/QVJSI7/INFvvgfaDoZ+Y
         mTPKGizb74wYQdCK97Chc61gaJZlksu32jwML5mMlgZUerADal+c/SjA9vWlRnj4tvMY
         BEWw==
X-Received: by 10.70.65.105 with SMTP id w9mr27590081pds.58.1417776361170;
        Fri, 05 Dec 2014 02:46:01 -0800 (PST)
Received: from lanh ([115.73.198.88])
        by mx.google.com with ESMTPSA id k3sm6531841pdj.2.2014.12.05.02.45.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Dec 2014 02:46:00 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 05 Dec 2014 17:56:34 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1417732931.20814.16.camel@segulix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260865>

In the same spirit of 7fce6e3 (commit: correctly respect skip-worktree
bit - 2009-12-14), if a file is marked unchanged, skip it.

Noticed-by: S=C3=A9rgio Basto <sergio@serjux.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c                         |  2 +-
 t/t2106-update-index-assume-unchanged.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e108c53..ee3de12 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -252,7 +252,7 @@ static int list_paths(struct string_list *list, con=
st char *with_tree,
 		if (!ce_path_match(ce, pattern, m))
 			continue;
 		item =3D string_list_insert(list, ce->name);
-		if (ce_skip_worktree(ce))
+		if (ce->ce_flags & (CE_VALID | CE_SKIP_WORKTREE))
 			item->util =3D item; /* better a valid pointer than a fake one */
 	}
=20
diff --git a/t/t2106-update-index-assume-unchanged.sh b/t/t2106-update-=
index-assume-unchanged.sh
index 99d858c..dc332f5 100755
--- a/t/t2106-update-index-assume-unchanged.sh
+++ b/t/t2106-update-index-assume-unchanged.sh
@@ -21,4 +21,14 @@ test_expect_success 'do not switch branches with dir=
ty file' \
 	 git update-index --assume-unchanged file &&
 	 test_must_fail git checkout master'
=20
+test_expect_success 'commit <paths> ignore assume-unchanged files' '
+	: >anotherfile &&
+	git add anotherfile &&
+	echo dirty >anotherfile &&
+	git commit -m one -- file anotherfile &&
+	git diff --name-only HEAD^ HEAD >actual &&
+	echo anotherfile >expected &&
+	test_cmp expected actual
+'
+
 test_done
--=20
2.2.0.60.gb7b3c64
