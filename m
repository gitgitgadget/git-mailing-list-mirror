From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] tag: refuse tag messages that contain NULs
Date: Mon, 20 Feb 2012 19:38:03 +0700
Message-ID: <1329741483-22567-1-git-send-email-pclouds@gmail.com>
References: <7v39a6pkmb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 13:37:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzSUb-0004Op-Ev
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 13:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797Ab2BTMhI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 07:37:08 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37091 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab2BTMhH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 07:37:07 -0500
Received: by pbcun15 with SMTP id un15so6234676pbc.19
        for <git@vger.kernel.org>; Mon, 20 Feb 2012 04:37:06 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.129.73 as permitted sender) client-ip=10.68.129.73;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.129.73 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.129.73])
        by 10.68.129.73 with SMTP id nu9mr25735406pbb.100.1329741426871 (num_hops = 1);
        Mon, 20 Feb 2012 04:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=aWZy07smBux5zr1p/9tAQbhDE4FUSqUukKWFfHNFV38=;
        b=dbe1/8vFgG/zdQ1ewlZsxVPgo1K7oMHTy+Lh7PC2Q6nFQ0aRQH8nhPem5je76urMm2
         p7SrVLOR1URzNnNqINJULgxopo9x831fe+OygZi6aaqikX0JyvWJlS7/8MsT9SvGlRIq
         iDyP9dWIYkrE7fot5x1tyNquiuNy1dqRhDIfs=
Received: by 10.68.129.73 with SMTP id nu9mr22022281pbb.100.1329741426778;
        Mon, 20 Feb 2012 04:37:06 -0800 (PST)
Received: from tre ([115.74.53.120])
        by mx.google.com with ESMTPS id lv10sm13123111pbb.33.2012.02.20.04.37.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Feb 2012 04:37:05 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Mon, 20 Feb 2012 19:38:04 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <7v39a6pkmb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191064>

This follows the paranoid spirit in 37576c1 (commit_tree(): refuse
commit messages that contain NULs - 2011-12-15) and stops users from
creating tags that contain NULs. If these tags are merged into a commit
as a mergetag line, it may break the commit header processing badly.

While at it, check for NULs in mergetag and gpgsig commit headers, and
check again at write_sha1_file() as the last resort, mostly to catch
programming errors.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 2012/2/20 Junio C Hamano <gitster@pobox.com>:
 >>       if (verify_tag(buf.buf, buf.len) < 0)
 >>               die("invalid tag signature file");
 >>
 >> +     if (memchr(buf.buf, '\0', buf.len))
 >> +             die("a NUL byte in tag message not allowed.");
 >> +
 >
 > Is there a good reason why you check _after_ calling verify_tag(), i=
nstead
 > of before?
 [...]
 >>       if (sign && do_sign(buf) < 0)
 >>               return error(_("unable to sign the tag"));
 >> +     if (memchr(buf->buf, '\0', buf->len))
 >> +             return error("a NUL byte in tag message not allowed."=
);
 >
 > Is there a good reason why you check _after_ calling do_sign(), inst=
ead of
 > before?
=20
 It's not about after those. It's about right before write_sha1_file().
 I wanted to catch all NULs no matter how they come. But yes the check
 should happen early to avoid wasting user's time (e.g. doing signing)

 So how about this?

 builtin/mktag.c          |    2 ++
 builtin/tag.c            |    2 ++
 commit.c                 |    2 ++
 sha1_file.c              |    6 ++++++
 t/t7004-tag.sh           |    4 ++++
 t/t7510-signed-commit.sh |    2 +-
 6 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 640ab64..e579471 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -160,6 +160,8 @@ int cmd_mktag(int argc, const char **argv, const ch=
ar *prefix)
 		die_errno("could not read from stdin");
 	}
=20
+	if (memchr(buf.buf, '\0', buf.len))
+		return error("a NUL byte in tag message not allowed.");
 	/* Verify it for some basic sanity: it needs to start with
 	   "object <sha1>\ntype\ntagger " */
 	if (verify_tag(buf.buf, buf.len) < 0)
diff --git a/builtin/tag.c b/builtin/tag.c
index 31f02e8..3e284f7 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -257,6 +257,8 @@ static void write_tag_body(int fd, const unsigned c=
har *sha1)
=20
 static int build_tag_object(struct strbuf *buf, int sign, unsigned cha=
r *result)
 {
+	if (memchr(buf->buf, '\0', buf->len))
+		return error("a NUL byte in tag message not allowed.");
 	if (sign && do_sign(buf) < 0)
 		return error(_("unable to sign the tag"));
 	if (write_sha1_file(buf->buf, buf->len, tag_type, result) < 0)
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
diff --git a/sha1_file.c b/sha1_file.c
index 88f2151..2fc8623 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2519,6 +2519,12 @@ int write_sha1_file(const void *buf, unsigned lo=
ng len, const char *type, unsign
 	char hdr[32];
 	int hdrlen;
=20
+	/* GIT_HASH_NUL is for the test suite to hash abitrary content */
+	if (!getenv("GIT_HASH_NUL") &&
+	    (!strcmp(type, commit_type) || !strcmp(type, tag_type)) &&
+	    memchr(buf, '\0', len))
+		return error("BUG: %s message contains NUL.", type);
+
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
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
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 1d3c56f..d75a349 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -63,7 +63,7 @@ test_expect_success GPG 'detect fudged signature with=
 NUL' '
 	git cat-file commit master >raw &&
 	cat raw >forged2 &&
 	echo Qwik | tr "Q" "\000" >>forged2 &&
-	git hash-object -w -t commit forged2 >forged2.commit &&
+	GIT_HASH_NUL=3D1 git hash-object -w -t commit forged2 >forged2.commit=
 &&
 	git show --pretty=3Dshort --show-signature $(cat forged2.commit) >act=
ual2 &&
 	grep "BAD signature from" actual2 &&
 	! grep "Good signature from" actual2
--=20
1.7.8.36.g69ee2
