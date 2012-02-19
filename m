From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] tag: refuse tag messages that contain NULs
Date: Sun, 19 Feb 2012 18:43:57 +0700
Message-ID: <1329651837-1102-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 12:43:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rz5BG-0000bA-LX
	for gcvg-git-2@plane.gmane.org; Sun, 19 Feb 2012 12:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313Ab2BSLnS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Feb 2012 06:43:18 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48420 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab2BSLnR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2012 06:43:17 -0500
Received: by daed14 with SMTP id d14so4837346dae.19
        for <git@vger.kernel.org>; Sun, 19 Feb 2012 03:43:16 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.211.202 as permitted sender) client-ip=10.68.211.202;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.211.202 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.211.202])
        by 10.68.211.202 with SMTP id ne10mr42820452pbc.164.1329651796755 (num_hops = 1);
        Sun, 19 Feb 2012 03:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=gERkSXSR4FjikccpyEPX33aL8QdsQBA7/v5sEN3q5Tc=;
        b=cXCfQ6S//2M3k1ZbBu5c+Xmzx5Paa6wH5j2Y9Wlgdp4oFgLbQ+EBdp7k2OcurA6Kvk
         Yo7MdVzk7WEA6CkeXgL3HuL6Xa4WAc/6WVXfFJpjamgcpLmUqXvMVMybG2Hzcwr3fwSf
         zW3TwAIkGMWrhf6iRXYsWZa222K9aBngH0IMg=
Received: by 10.68.211.202 with SMTP id ne10mr35684585pbc.164.1329651796677;
        Sun, 19 Feb 2012 03:43:16 -0800 (PST)
Received: from tre ([115.74.53.120])
        by mx.google.com with ESMTPS id c9sm10307429pbr.65.2012.02.19.03.43.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Feb 2012 03:43:15 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sun, 19 Feb 2012 18:43:59 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191024>

This follows the paranoid spirit in 37576c1 (commit_tree(): refuse
commit messages that contain NULs - 2011-12-15) and stops users from
creating tags that contain NULs. If these tags are merged into a commit
as mergetag lines, they may break the commit header processing badly.

While at it, check for NULs in mergetag and gpgsig lines before
committing too.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mktag.c |    3 +++
 builtin/tag.c   |    2 ++
 commit.c        |    2 ++
 t/t7004-tag.sh  |    4 ++++
 4 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 640ab64..f51ce20 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -165,6 +165,9 @@ int cmd_mktag(int argc, const char **argv, const ch=
ar *prefix)
 	if (verify_tag(buf.buf, buf.len) < 0)
 		die("invalid tag signature file");
=20
+	if (memchr(buf.buf, '\0', buf.len))
+		die("a NUL byte in tag message not allowed.");
+
 	if (write_sha1_file(buf.buf, buf.len, tag_type, result_sha1) < 0)
 		die("unable to write tag file");
=20
diff --git a/builtin/tag.c b/builtin/tag.c
index 31f02e8..e66811e 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -259,6 +259,8 @@ static int build_tag_object(struct strbuf *buf, int=
 sign, unsigned char *result)
 {
 	if (sign && do_sign(buf) < 0)
 		return error(_("unable to sign the tag"));
+	if (memchr(buf->buf, '\0', buf->len))
+		return error("a NUL byte in tag message not allowed.");
 	if (write_sha1_file(buf->buf, buf->len, tag_type, result) < 0)
 		return error(_("unable to write tag file"));
 	return 0;
diff --git a/commit.c b/commit.c
index 4b39c19..545325f 100644
--- a/commit.c
+++ b/commit.c
@@ -1144,6 +1144,8 @@ int commit_tree_extended(const struct strbuf *msg=
, unsigned char *tree,
 		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
=20
 	while (extra) {
+		if (memchr(extra->value, '\0', extra->len))
+			return error("a NUL byte in commit header %s not allowed.", extra->=
key);
 		add_extra_header(&buffer, extra);
 		extra =3D extra->next;
 	}
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index e93ac73..8cb13e5 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1269,4 +1269,8 @@ test_expect_success 'mixing incompatibles modes a=
nd options is forbidden' '
 	test_must_fail git tag -v -s
 '
=20
+test_expect_success 'tag content contains NUL' '
+	test_must_fail git tag -F "$TEST_DIRECTORY"/t3900/UTF-16.txt utf16
+'
+
 test_done
--=20
1.7.8.36.g69ee2
