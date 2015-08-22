From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/8] apply: fix adding new files on i-t-a entries
Date: Sat, 22 Aug 2015 08:08:06 +0700
Message-ID: <1440205700-19749-4-git-send-email-pclouds@gmail.com>
References: <xmqqy4j80wdb.fsf@gitster.dls.corp.google.com>
 <1440205700-19749-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, phiggins@google.com,
	snoksrud@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 03:08:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSxIl-0004r7-AV
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 03:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbbHVBIu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 21:08:50 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33977 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbbHVBIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 21:08:49 -0400
Received: by pdbfa8 with SMTP id fa8so31982824pdb.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 18:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tGBoljVrhZJD/OxzcMuFcLe5rEMZAwPn9YV2P/5xSgI=;
        b=eKSc7TuZ9iMEIG5s/Nv/j0I2pc9i+g9+nkJ1qCbxWcqVjFI/o4lJWbxaWjqeHOfqxd
         J19lBfiX29mYgTTFL5xGPMS2Eu5YOZ5DC8gGT52K7pmKJwdldAs2uB+kO1TDuLmzdCg0
         16a2iBxlC8nxYIQLDFjWNtj0cFqjMCE8qeTY9F2LpZYQRAAHDYqcumC3ftv7C7SW3V8O
         LmgSsI+KrYZll+972rT45Wb5icBQn17K3eStv4DpTRYwf8OmxdqRZb6a3DOHWL3AazG7
         ew9tfsKlYE+JMEif/r4QMnqZ88PLvkpPURagUB4GwHXOO7A4DxK5x11NvnyY3zYfd2q8
         0KpA==
X-Received: by 10.70.16.67 with SMTP id e3mr22534934pdd.98.1440205729562;
        Fri, 21 Aug 2015 18:08:49 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id ya3sm9112323pbb.71.2015.08.21.18.08.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 18:08:48 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Aug 2015 08:08:45 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440205700-19749-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276355>

Applying a patch that adds a file when that file is registered with "gi=
t
add -N" will fail with message "already exists in index" because
git-apply checks, sees those i-t-a entries and aborts. git-apply does
not realize those are for bookkeeping only, they do not really exist in
the index. This patch tightens the "exists in index" check, ignoring
i-t-a entries.

Reported-by: Patrick Higgins <phiggins@google.com>
Reported-by: Bj=C3=B8rnar Snoksrud <snoksrud@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/apply.c       |  9 +++++----
 t/t2203-add-intent.sh | 13 +++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 54aba4e..76b58a1 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3553,10 +3553,11 @@ static int check_to_create(const char *new_name=
, int ok_if_exists)
 {
 	struct stat nst;
=20
-	if (check_index &&
-	    cache_name_pos(new_name, strlen(new_name)) >=3D 0 &&
-	    !ok_if_exists)
-		return EXISTS_IN_INDEX;
+	if (check_index && !ok_if_exists) {
+		int pos =3D cache_name_pos(new_name, strlen(new_name));
+		if (pos >=3D 0 && !ce_intent_to_add(active_cache[pos]))
+			return EXISTS_IN_INDEX;
+	}
 	if (cached)
 		return 0;
=20
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 2a4a749..bb5ef2b 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -82,5 +82,18 @@ test_expect_success 'cache-tree invalidates i-t-a pa=
ths' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'apply adds new file on i-t-a entry' '
+	git init apply &&
+	(
+		cd apply &&
+		echo newcontent >newfile &&
+		git add newfile &&
+		git diff --cached >patch &&
+		rm .git/index &&
+		git add -N newfile &&
+		git apply --cached patch
+	)
+'
+
 test_done
=20
--=20
2.3.0.rc1.137.g477eb31
