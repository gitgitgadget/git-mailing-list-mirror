From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 09/10] clone: allow --branch to take a tag
Date: Mon, 16 Jan 2012 16:46:15 +0700
Message-ID: <1326707176-8045-10-git-send-email-pclouds@gmail.com>
References: <1326439322-15648-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 10:47:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmjAH-00037w-Vn
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 10:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922Ab2APJrl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jan 2012 04:47:41 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55465 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab2APJrk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 04:47:40 -0500
Received: by mail-iy0-f174.google.com with SMTP id f6so2315494iag.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 01:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sTj2otEU+MbeZ0J8hBXUBQK4Aye8vVeeW5ejIFJT9vY=;
        b=E8CVNFIzTOob3iqzqfZ0F5YwFg1oBBLedyf6KE3A5oyVoYqONV6zEsAcgJt7wIBX5B
         ylXvcpva5lychfpiwyeSw8y5Jia2iGOXu3cISOM8rLiG2To4u6YQzAZAZtx3Y7xRYtQR
         rxOsMpyDs+Us3VPLS5ABm6arqZmHEWHDYnH+E=
Received: by 10.50.156.138 with SMTP id we10mr9589882igb.10.1326707260412;
        Mon, 16 Jan 2012 01:47:40 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id xu6sm32280359igb.7.2012.01.16.01.47.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Jan 2012 01:47:39 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Jan 2012 16:47:31 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326439322-15648-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188624>

Because a tag ref cannot be put to HEAD, HEAD will become detached.
This is consistent with "git checkout <tag>".

This is mostly useful in shallow clone, where it allows you to clone a
tag in addtion to branches.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-clone.txt |    5 +++--
 builtin/clone.c             |   20 +++++++++++++++++++-
 t/t5500-fetch-pack.sh       |   15 +++++++++++++++
 t/t5601-clone.sh            |    9 +++++++++
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 0931a3e..6e22522 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -147,8 +147,9 @@ objects from the source repository into a pack in t=
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
index 3cfedb3..651b4cc 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -420,6 +420,15 @@ static struct ref *find_remote_branch(const struct=
 ref *refs, const char *branch
 	strbuf_addstr(&head, branch);
 	ref =3D find_ref_by_name(refs, head.buf);
 	strbuf_release(&head);
+
+	if (ref)
+		return ref;
+
+	strbuf_addstr(&head, "refs/tags/");
+	strbuf_addstr(&head, branch);
+	ref =3D find_ref_by_name(refs, head.buf);
+	strbuf_release(&head);
+
 	return ref;
 }
=20
@@ -441,8 +450,12 @@ static struct ref *wanted_peer_refs(const struct r=
ef *refs,
 		if (!remote_head && option_branch)
 			warning(_("Could not find remote branch %s to clone."),
 				option_branch);
-		else
+		else {
 			get_fetch_map(remote_head, refspec, &tail, 0);
+
+			/* if --branch=3Dtag, pull the requested tag explicitly */
+			get_fetch_map(remote_head, tag_refspec, &tail, 0);
+		}
 	} else
 		get_fetch_map(refs, refspec, &tail, 0);
=20
@@ -515,6 +528,11 @@ static void update_head(const struct ref *our, con=
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
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 5237066..ce51692 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -311,4 +311,19 @@ EOF
 	test_cmp count6.expected count6.actual
 '
=20
+test_expect_success 'shallow cloning single tag' '
+	git clone --depth 1 --branch=3DTAGB1 "file://$(pwd)/." shallow7 &&
+	cat >taglist.expected <<\EOF &&
+TAGB1
+TAGB2
+EOF
+	GIT_DIR=3Dshallow7/.git git tag -l >taglist.actual &&
+	test_cmp taglist.expected taglist.actual &&
+
+	echo "in-pack: 7" > count7.expected &&
+	GIT_DIR=3Dshallow7/.git git count-objects -v |
+		grep "^in-pack" > count7.actual &&
+	test_cmp count7.expected count7.actual
+'
+
 test_done
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
