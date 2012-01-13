From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 09/10] clone: allow --branch to take a tag
Date: Fri, 13 Jan 2012 14:22:01 +0700
Message-ID: <1326439322-15648-10-git-send-email-pclouds@gmail.com>
References: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 08:23:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlbUC-0008Ez-G8
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 08:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087Ab2AMHXg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jan 2012 02:23:36 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35052 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab2AMHXf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 02:23:35 -0500
Received: by mail-iy0-f174.google.com with SMTP id z25so3939442iab.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 23:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=O2ZQcngxr+nrbDGnSLE5lYP6of6vmbZo162PULUOtX4=;
        b=ha/CoheLJEsYdiEuO5/1lpMCbig3317agShgCkIAqp9Sw/9+KUqDg9bkqwBJ3dvdes
         SZZPfCOdZorIDW9TDrpVEB3Rc1hWpA+01sECo4kGjr4iePwXWGPetA4RyF8X7NbaZnbr
         paT3jWLf7hfVF+GaEbt1A5Tne/7yLNcudJxmQ=
Received: by 10.42.171.136 with SMTP id j8mr1695864icz.1.1326439415272;
        Thu, 12 Jan 2012 23:23:35 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id r5sm13094094igl.3.2012.01.12.23.23.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 23:23:34 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 13 Jan 2012 14:23:25 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188506>

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
index 6a2886a..a3c8f78 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -471,6 +471,11 @@ static void update_head(const struct ref *our, con=
st struct ref *remote,
 			update_ref(msg, "HEAD", our->old_sha1, NULL, 0, DIE_ON_ERR);
 			install_branch_config(0, head, option_origin, our->name);
 		}
+	} else if (our) {
+		struct commit *c =3D lookup_commit_reference(our->old_sha1);
+		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
+		update_ref(msg, "HEAD", c->object.sha1,
+			   NULL, REF_NODEREF, DIE_ON_ERR);
 	} else if (remote) {
 		/*
 		 * We know remote HEAD points to a non-branch, or
@@ -770,6 +775,14 @@ int cmd_clone(int argc, const char **argv, const c=
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
