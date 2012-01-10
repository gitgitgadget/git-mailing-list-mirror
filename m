From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 09/10] clone: allow --branch to take a tag
Date: Tue, 10 Jan 2012 16:57:06 +0700
Message-ID: <1326189427-20800-10-git-send-email-pclouds@gmail.com>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 10:58:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkYTe-0005jn-93
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 10:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935Ab2AJJ6l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 04:58:41 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:45249 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755672Ab2AJJ6l (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 04:58:41 -0500
Received: by obcwo16 with SMTP id wo16so5294167obc.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 01:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wrJQ6WBIwfttyDfJysKkxugarjTxuW+qNj9UEQDu528=;
        b=Pvl9HL4g29cTDnuTjEKD5hfa+axGSeVEgd2maSUM850o2oZbUi5YcnCjO85xBWhuTr
         7OMd920F39Zef/xyqZWwVzYYDYRH3pFx6NGOqWolgbrJ4HNY7uyWk5aPaT0EYBbBIRt/
         EA0RTEg4rtZEo67e7PXKqHjj7vb/jDAdSTAQ4=
Received: by 10.50.76.162 with SMTP id l2mr1442984igw.1.1326189520474;
        Tue, 10 Jan 2012 01:58:40 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id py9sm128084691igc.2.2012.01.10.01.58.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 01:58:39 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 10 Jan 2012 16:58:31 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188241>

Because a tag ref cannot be put to HEAD, HEAD will become detached.
This is consistent with "git checkout <tag>".

This is mostly useful in shallow clone, where it allows you to clone a
tag in addtion to branches.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-clone.txt |    5 +++--
 builtin/clone.c             |   13 +++++++++++++
 t/t5601-clone.sh            |    9 +++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

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
index f751997..ed18c1a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -471,6 +471,11 @@ static void update_head(const struct ref *our, con=
st struct ref *remote,
 			update_ref(msg, "HEAD", our->old_sha1, NULL, 0, DIE_ON_ERR);
 			install_branch_config(0, head, option_origin, our->name);
 		}
+	} else if (our) {
+		struct commit *c =3D lookup_commit_reference(our->old_sha1);
+		/* Source had detached HEAD pointing somewhere. */
+		update_ref(msg, "HEAD", c->object.sha1,
+			   NULL, REF_NODEREF, DIE_ON_ERR);
 	} else if (remote) {
 		/* Source had detached HEAD pointing somewhere. */
 		update_ref(msg, "HEAD", remote->old_sha1,
@@ -766,6 +771,14 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 				find_ref_by_name(mapped_refs, head.buf);
 			strbuf_release(&head);
=20
+			if (!our_head_points_at) {
+				strbuf_addstr(&head, "refs/tags/");
+				strbuf_addstr(&head, option_branch);
+				our_head_points_at =3D
+					find_ref_by_name(mapped_refs, head.buf);
+				strbuf_release(&head);
+			}
+
 			if (!our_head_points_at)
 				die(_("Remote branch %s not found in "
 				      "upstream %s, using HEAD instead"),
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
1.7.3.1.256.g2539c.dirty
