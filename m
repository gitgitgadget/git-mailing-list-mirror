Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0665620248
	for <e@80x24.org>; Tue,  9 Apr 2019 23:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfDIXII (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 19:08:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55418 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfDIXII (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 19:08:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2C2352A17;
        Tue,  9 Apr 2019 19:08:04 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=+0lhzme+vNDLQTaizt7PIc8gZ
        9Y=; b=h+Gi+AXsemKFMLFbBHTdoocT884tHJW5ukdvYUO5r/+oM1iQYdKZLdE2t
        /ONMoB5tkijTJwcBI4kksUAw7195PFz1dahmGUFr958JVmWzhPnelugIlIhwVEoV
        IBJucTKESRmNdsu0G1svlGDd2U9W4edlg9Oiusxtzy3A/R/wBQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B4F652A15;
        Tue,  9 Apr 2019 19:08:04 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=mesmtp; bh=yHYCQgWWcgWi0LFyVdcLYncOjvn7HnV2AgAP1EadCf0=; b=elxvc2qidHFXkZijWFf1bQ36A+lxOKT+yKpRAV82CbiVEtw15v0BTXW7aBOadPEcSRfh9Sd/4Vf3YcMmFu6esvLzqgFD63QmSxmO9VRy+ZdXDt77fUwyAia78APuD+dFSk9DJ0fF16Ja9+I2vOd/xoryS6btuNKMmDQ3pPmyF0Y=
Received: from hylob.dartmouth.edu (unknown [129.170.31.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BE8E952A0A;
        Tue,  9 Apr 2019 19:08:00 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, debian@onerussian.com,
        Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH v3 3/3] add: error appropriately on repository with no commits
Date:   Tue,  9 Apr 2019 19:07:37 -0400
Message-Id: <20190409230737.26809-4-kyle@kyleam.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190409230737.26809-1-kyle@kyleam.com>
References: <20190409230737.26809-1-kyle@kyleam.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 52FBBE4A-5B1C-11E9-B7DE-EE24A11ADF13-24757444!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit made 'git add' abort when given a repository that
doesn't have a commit checked out.  However, the output upon failure
isn't appropriate:

  % git add repo
  warning: adding embedded git repository: repo
  hint: You've added another git repository inside your current repositor=
y.
  hint: [...]
  error: unable to index file 'repo/'
  fatal: adding files failed

The hint doesn't apply in this case, and the error message doesn't
tell the user why 'repo' couldn't be added to the index.

Provide better output by teaching add_to_index() to error when given a
git directory where HEAD can't be resolved.  To avoid the embedded
repository warning and hint, call check_embedded_repo() only after
add_file_to_index() succeeds because, in general, its output doesn't
make sense if adding to the index fails.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 builtin/add.c  |  3 ++-
 read-cache.c   |  3 +++
 t/t3700-add.sh | 11 +++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index db2dfa4350..dd18e5c9b6 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -374,11 +374,12 @@ static int add_files(struct dir_struct *dir, int fl=
ags)
 	}
=20
 	for (i =3D 0; i < dir->nr; i++) {
-		check_embedded_repo(dir->entries[i]->name);
 		if (add_file_to_index(&the_index, dir->entries[i]->name, flags)) {
 			if (!ignore_add_errors)
 				die(_("adding files failed"));
 			exit_status =3D 1;
+		} else {
+			check_embedded_repo(dir->entries[i]->name);
 		}
 	}
 	return exit_status;
diff --git a/read-cache.c b/read-cache.c
index 4dc6de1b55..b4b68d6ec8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -708,6 +708,7 @@ int add_to_index(struct index_state *istate, const ch=
ar *path, struct stat *st,
 	int add_option =3D (ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|
 			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
 	int hash_flags =3D HASH_WRITE_OBJECT;
+	struct object_id oid;
=20
 	if (flags & ADD_CACHE_RENORMALIZE)
 		hash_flags |=3D HASH_RENORMALIZE;
@@ -717,6 +718,8 @@ int add_to_index(struct index_state *istate, const ch=
ar *path, struct stat *st,
=20
 	namelen =3D strlen(path);
 	if (S_ISDIR(st_mode)) {
+		if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
+			return error(_("'%s' does not have a commit checked out"), path);
 		while (namelen && path[namelen-1] =3D=3D '/')
 			namelen--;
 	}
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 5a8425962b..c325167b90 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -296,6 +296,17 @@ test_expect_success '"git add ." in empty repo' '
 	)
 '
=20
+test_expect_success 'error on a repository with no commits' '
+	rm -fr empty &&
+	git init empty &&
+	test_must_fail git add empty >actual 2>&1 &&
+	cat >expect <<-EOF &&
+	error: '"'empty/'"' does not have a commit checked out
+	fatal: adding files failed
+	EOF
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'git add --dry-run of existing changed file' "
 	echo new >>track-this &&
 	git add --dry-run track-this >actual 2>&1 &&
--=20
2.21.0

