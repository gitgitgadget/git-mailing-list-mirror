From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/17] commit: use commit_narrow_tree() to support narrow repo
Date: Sun,  5 Sep 2010 16:47:41 +1000
Message-ID: <1283669264-15759-15-git-send-email-pclouds@gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:50:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os93i-0008WN-Bf
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab0IEGuZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:50:25 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37339 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab0IEGuX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:50:23 -0400
Received: by pxi10 with SMTP id 10so650106pxi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=9cJ+ij7haqXNIag6oafHQVSMofbIBEApoyReJxbpOhQ=;
        b=BPEIJjgSHUd7Nad9PVGLKSmXl5V4c0VljQkLE97XZj8u0uxYHvPcF0+fkvQVo7pqNb
         w+ixdAXVnF4QEbjTln4EPs71HIGYiCYFXhTnth3SaMH4yt7CIk51z+bu8hK3wbYYGrZC
         A2MF6jiMd80faIL9vfDA3BqsMcq2o191zHbWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qUssuWmyl2Q/WnOy4SCTMkM31+oPa48BLNtJyfOFqFYN5mbe0AXIO0xV7+7Mn5TeuE
         HrWydFm0tFwqcn5wcGd5Tf6axL9Wv5zvFow37X3xXbV/kvoLzHKkXxIuEaWOkP6dtZeF
         F0zlPP73Qq2pLwkTNj8J920cEtfOGdgHMw/CE=
Received: by 10.114.112.15 with SMTP id k15mr1865801wac.183.1283669423186;
        Sat, 04 Sep 2010 23:50:23 -0700 (PDT)
Received: from dektop ([119.12.225.18])
        by mx.google.com with ESMTPS id o17sm8037942wal.9.2010.09.04.23.50.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:50:22 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun,  5 Sep 2010 16:50:15 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155440>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c         |   10 +++++++++-
 t/t7510-commit-narrow.sh |   30 ++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletions(-)
 create mode 100755 t/t7510-commit-narrow.sh

diff --git a/builtin/commit.c b/builtin/commit.c
index d8c5273..2321642 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1349,7 +1349,15 @@ int cmd_commit(int argc, const char **argv, cons=
t char *prefix)
 		exit(1);
 	}
=20
-	if (commit_tree(sb.buf, active_cache_tree->sha1, parents, commit_sha1=
,
+	if (get_narrow_prefix()) {
+		if (!parents)
+			die("Narrow mode does not support initial commit (yet)");
+		if (parse_commit(parents->item))
+			die("Bad commit %s", parents->item->object.sha1);
+	}
+	if (commit_narrow_tree(sb.buf, active_cache_tree->sha1,
+			parents ? parents->item->tree->object.sha1 : NULL,
+			parents, commit_sha1,
 			fmt_ident(author_name, author_email, author_date,
 				IDENT_ERROR_ON_NO_NAME))) {
 		rollback_index_files();
diff --git a/t/t7510-commit-narrow.sh b/t/t7510-commit-narrow.sh
new file mode 100755
index 0000000..1232cee
--- /dev/null
+++ b/t/t7510-commit-narrow.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description=3D'commit in narrow repositories'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	touch a b c &&
+	mkdir x y z &&
+	touch x/a y/b z/c &&
+	git add . &&
+	git commit -q -m initial &&
+	echo x >.git/narrow &&
+	rm .git/index &&
+	git reset --hard HEAD
+'
+
+X1_TREE=3D496d6428b9cf92981dc9495211e6e1120fb6f2ba
+X2_TREE=3D4d593e935186bcc35450336864a1aad148210a14
+
+test_expect_success 'commit' '
+	git ls-tree HEAD | sed "s/$X1_TREE/$X2_TREE/" >expected &&
+	echo x >>x/a &&
+	git add x/a &&
+	git commit -m x/a &&
+	git ls-tree HEAD >result &&
+	test_cmp expected result
+'
+
+test_done
--=20
1.7.1.rc1.69.g24c2f7
