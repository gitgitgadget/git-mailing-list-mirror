From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/6] clone: allow --branch to take a tag
Date: Sun,  8 Jan 2012 18:46:27 +0700
Message-ID: <1326023188-15559-5-git-send-email-pclouds@gmail.com>
References: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
 <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 12:48:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjrEH-0000t7-DC
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 12:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103Ab2AHLrk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 06:47:40 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39267 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab2AHLrj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 06:47:39 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so5239138iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 03:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lJ7H+hBP77+ZvSUiDzQjxlmsb5iI/9rg07zZVnHxYzE=;
        b=DZ+urpisMOw/YxhPs2fFpqvPQMvricHw+NRgkQ+5/B8WLnLrPbtNk2HUc5inNehE+n
         wJQjk7c1z20xoYhnqiPGDA23DmZO/1oskD3CijmIYNgf9+FtWGLSf4+MZiSPA2dCCRva
         MmVrsQZpeMoKf1Udy1k75ixp4KXKaQafAJchE=
Received: by 10.50.17.195 with SMTP id q3mr14592751igd.11.1326023258879;
        Sun, 08 Jan 2012 03:47:38 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.35.243])
        by mx.google.com with ESMTPS id gh9sm9485968igb.3.2012.01.08.03.47.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 03:47:38 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 08 Jan 2012 18:47:11 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188104>

Because a tag ref cannot be put to HEAD, HEAD will become detached.
This is consistent with "git checkout <tag>".

This is mostly useful in shallow clone, where it allows you to clone a
tag in addtion to branches.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Although 'git clone --depth 1 --branch <tag>' still needs fixups on
 top. I'll do that later.

 Documentation/git-clone.txt |    5 +++--
 builtin/clone.c             |   14 ++++++++++++++
 t/t5601-clone.sh            |    9 +++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 4b8b26b..db2b29c 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -146,8 +146,9 @@ objects from the source repository into a pack in t=
he cloned repository.
 -b <name>::
 	Instead of pointing the newly created HEAD to the branch pointed
 	to by the cloned repository's HEAD, point to `<name>` branch
-	instead. In a non-bare repository, this is the branch that will
-	be checked out.
+	instead. `--branch` can also take tags and treat them like
+	detached HEAD. In a non-bare repository, this is the branch
+	that will be checked out.
=20
 --upload-pack <upload-pack>::
 -u <upload-pack>::
diff --git a/builtin/clone.c b/builtin/clone.c
index 914fd6b..0d4b9ab 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -734,6 +734,14 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 			strbuf_release(&head);
=20
 			if (!our_head_points_at) {
+				strbuf_addstr(&head, "refs/tags/");
+				strbuf_addstr(&head, option_branch);
+				our_head_points_at =3D
+					find_ref_by_name(mapped_refs, head.buf);
+				strbuf_release(&head);
+			}
+
+			if (!our_head_points_at) {
 				warning(_("Remote branch %s not found in "
 					"upstream %s, using HEAD instead"),
 					option_branch, option_origin);
@@ -776,6 +784,12 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 			install_branch_config(0, head, option_origin,
 					      our_head_points_at->name);
 		}
+	} else if (our_head_points_at) {
+		const struct ref *ref =3D our_head_points_at;
+		struct commit *c =3D lookup_commit_reference(ref->old_sha1);
+		/* Source had detached HEAD pointing somewhere. */
+		update_ref(reflog_msg.buf, "HEAD", c->object.sha1,
+			   NULL, REF_NODEREF, DIE_ON_ERR);
 	} else if (remote_head) {
 		/* Source had detached HEAD pointing somewhere. */
 		update_ref(reflog_msg.buf, "HEAD", remote_head->old_sha1,
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index e0b8db6..67869b4 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -271,4 +271,13 @@ test_expect_success 'clone from original with rela=
tive alternate' '
 	grep /src/\\.git/objects target-10/objects/info/alternates
 '
=20
+test_expect_success 'clone checking out a tag' '
+	git clone --branch=3Dsome-tag src dst.tag &&
+	GIT_DIR=3Dsrc/.git git rev-parse some-tag >expected &&
+	test_cmp expected dst.tag/.git/HEAD &&
+	GIT_DIR=3Ddst.tag/.git git config remote.origin.fetch >fetch.actual &=
&
+	echo "+refs/heads/*:refs/remotes/origin/*" >fetch.expected &&
+	test_cmp fetch.expected fetch.actual
+'
+
 test_done
--=20
1.7.8.36.g69ee2
