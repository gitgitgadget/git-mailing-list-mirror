From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] Do not create commits whose message contains NUL
Date: Wed, 14 Dec 2011 21:08:19 +0700
Message-ID: <1323871699-8839-4-git-send-email-pclouds@gmail.com>
References: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Miles Bader <miles@gnu.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 15:09:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RapW1-0002L3-Lb
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 15:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757329Ab1LNOI5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 09:08:57 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62916 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861Ab1LNOI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 09:08:56 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so1289113iae.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 06:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Yz/DfxZJsQDAui39JgkxG1INx7MAiQtDMzm9NW1jkj0=;
        b=l3s9aviavG6eHSJR/Ud5eD3o701f4VXdpeqVJTar/8fexcwST6boaXvZ3WL1azTqu8
         7Gq9BmS+ga0FmGCwB3aIAkKDZnS/U+jl0vmUMoOO7+RcWdW8hK45Hy/zvTIjvU7MhdxA
         S0Cf6KPHCDVkgfPCKaHcU7zk/Y5CZxQ0G/d+4=
Received: by 10.42.150.135 with SMTP id a7mr19210878icw.53.1323871736099;
        Wed, 14 Dec 2011 06:08:56 -0800 (PST)
Received: from tre ([115.74.57.162])
        by mx.google.com with ESMTPS id wn1sm4755676igc.3.2011.12.14.06.08.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 06:08:53 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Wed, 14 Dec 2011 21:08:50 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1323871699-8839-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187119>

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
 Documentation/config.txt |    4 ++++
 advice.c                 |    2 ++
 advice.h                 |    1 +
 commit.c                 |    9 +++++++++
 t/t3900-i18n-commit.sh   |    6 ++++++
 t/t3900/UTF-16.txt       |  Bin 0 -> 32 bytes
 6 files changed, 22 insertions(+), 0 deletions(-)
 create mode 100644 t/t3900/UTF-16.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5a841da..daf57c2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -144,6 +144,10 @@ advice.*::
 		Advice shown when you used linkgit::git-checkout[1] to
 		move to the detach HEAD state, to instruct how to create
 		a local branch after the fact.  Default: true.
+	commitWideEncoding::
+		Advice shown when linkgit::git-commit[1] refuses to
+		proceed because there are NULs in commit message.
+		Default: true.
 --
=20
 core.fileMode::
diff --git a/advice.c b/advice.c
index e02e632..130949e 100644
--- a/advice.c
+++ b/advice.c
@@ -6,6 +6,7 @@ int advice_commit_before_merge =3D 1;
 int advice_resolve_conflict =3D 1;
 int advice_implicit_identity =3D 1;
 int advice_detached_head =3D 1;
+int advice_commmit_wide_encoding =3D 1;
=20
 static struct {
 	const char *name;
@@ -17,6 +18,7 @@ static struct {
 	{ "resolveconflict", &advice_resolve_conflict },
 	{ "implicitidentity", &advice_implicit_identity },
 	{ "detachedhead", &advice_detached_head },
+	{ "commitwideencoding", &advice_commmit_wide_encoding },
 };
=20
 void advise(const char *advice, ...)
diff --git a/advice.h b/advice.h
index e5d0af7..d913bdb 100644
--- a/advice.h
+++ b/advice.h
@@ -9,6 +9,7 @@ extern int advice_commit_before_merge;
 extern int advice_resolve_conflict;
 extern int advice_implicit_identity;
 extern int advice_detached_head;
+extern int advice_commmit_wide_encoding;
=20
 int git_default_advice_config(const char *var, const char *value);
 void advise(const char *advice, ...);
diff --git a/commit.c b/commit.c
index d67b8c7..59e5bce 100644
--- a/commit.c
+++ b/commit.c
@@ -855,6 +855,15 @@ int commit_tree(const char *msg, size_t msg_len, u=
nsigned char *tree,
=20
 	assert_sha1_type(tree, OBJ_TREE);
=20
+	if (memchr(msg, '\0', msg_len)) {
+		error(_("your commit message contains NUL characters."));
+		if (advice_commmit_wide_encoding) {
+			advise(_("This is often caused by using wide encodings such as"));
+			advise(_("UTF-16. Please check your editor settings."));
+		}
+		return -1;
+	}
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
