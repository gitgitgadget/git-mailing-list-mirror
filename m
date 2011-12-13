From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH resend] Do not create commits whose message contains NUL
Date: Tue, 13 Dec 2011 18:56:08 +0700
Message-ID: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 12:57:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaQz4-0005L7-Qt
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 12:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423Ab1LML5S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Dec 2011 06:57:18 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56778 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab1LML5R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 06:57:17 -0500
Received: by ghbz12 with SMTP id z12so289477ghb.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 03:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=OM7zsQ7+ham23IEGV5Ji8EdefN1oGzJHjX3LHKEoklY=;
        b=o2/XzJKUhI+bx7FkbJ6mNt0KFCXKEC/5jLipH7/TRzOwX0k2YYPtTE/ZE2txugr6MK
         xnpyy6evDrGYk3qahuc61Br/Bt5LQZKeHmwhPaUJmMJ+hsdCkDckHfzHddL62wqS7jfr
         4saCKcUSKSc+WH6Z/UTBubcszxNp1M1gJkAZk=
Received: by 10.50.163.97 with SMTP id yh1mr19384235igb.37.1323777436575;
        Tue, 13 Dec 2011 03:57:16 -0800 (PST)
Received: from tre ([115.74.32.245])
        by mx.google.com with ESMTPS id g34sm63195687ibk.10.2011.12.13.03.57.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 03:57:15 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 13 Dec 2011 18:56:08 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187012>

We assume that the commit log messages are uninterpreted sequences of
non-NUL bytes (see Documentation/i18n.txt). However the assumption
does not really stand out and it's quite easy to set an editor to save
in a NUL-included encoding. Currently we silently cut at the first NUL
we see.

Make it more obvious that NUL is not welcome by refusing to create
such commits. Those who deliberately want to create them can still do
with hash-object.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This is from UTF-16 in commit message discussion [1] a few months
 ago. I don't want to resurrect the discussion again. However I think
 it's a good idea to stop users from shooting themselves in this case,
 especially at porcelain level.
=20
 There were no comments on this patch previously. So, any comments
 this time ? Should I drop it?

 [1] http://thread.gmane.org/gmane.comp.version-control.git/184123/focu=
s=3D184335
 commit.c               |    3 +++
 t/t3900-i18n-commit.sh |    6 ++++++
 t/t3900/UTF-16.txt     |  Bin 0 -> 32 bytes
 3 files changed, 9 insertions(+), 0 deletions(-)
 create mode 100644 t/t3900/UTF-16.txt

diff --git a/commit.c b/commit.c
index d67b8c7..0775eec 100644
--- a/commit.c
+++ b/commit.c
@@ -855,6 +855,9 @@ int commit_tree(const char *msg, size_t msg_len, un=
signed char *tree,
=20
 	assert_sha1_type(tree, OBJ_TREE);
=20
+	if (strlen(msg) < msg_len)
+		die(_("cannot commit with NUL in commit message"));
+
 	/* Not having i18n.commitencoding is the same as having utf-8 */
 	encoding_is_utf8 =3D is_encoding_utf8(git_commit_encoding);
=20
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 1f62c15..d48a7c0 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -34,6 +34,12 @@ test_expect_success 'no encoding header for base cas=
e' '
 	test z =3D "z$E"
 '
=20
+test_expect_failure 'UTF-16 refused because of NULs' '
+	echo UTF-16 >F &&
+	git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-16.txt
+'
+
+
 for H in ISO8859-1 eucJP ISO-2022-JP
 do
 	test_expect_success "$H setup" '
diff --git a/t/t3900/UTF-16.txt b/t/t3900/UTF-16.txt
new file mode 100644
index 0000000000000000000000000000000000000000..53296be684253f40964c060=
4be7fa7ff12e200cb
GIT binary patch
literal 32
mcmezOpWz6@X@-jo=3DNYasZ~@^#h9rjP3@HpR7}6Nh8Mpw;r3yp<

literal 0
HcmV?d00001

--=20
1.7.8.36.g69ee2
