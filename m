Return-Path: <SRS0=hslh=3A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D698BC33C9E
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 12:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F49920866
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 12:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVuZ/ztQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgAKMfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jan 2020 07:35:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43945 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729109AbgAKMfp (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 11 Jan 2020 07:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578746143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=w3NyEcZREkOaFS5FpgnT/NVQ3MW8w56RCZXLgxnltTg=;
        b=NVuZ/ztQ2rTBtxjl3+SYUIlZzjnD4byFjPHJzTFvfOzXhgZifzpmztJ5XgdNM6U94zCnar
        dp4QFXCOxvGDk8VH4l5Yfpz81yxNPfau3wfNy4k5XyOeMehN+iLY8QOtNuZ3luyLBWuQOZ
        ztw0Wxjc1YoXs8tfwYxuwBzLqEnO9FA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-V3pKH-u6OnurNIrK98Hlnw-1; Sat, 11 Jan 2020 07:35:42 -0500
X-MC-Unique: V3pKH-u6OnurNIrK98Hlnw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDB1D801E76;
        Sat, 11 Jan 2020 12:35:40 +0000 (UTC)
Received: from localhost (unknown [10.36.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AC9960E3E;
        Sat, 11 Jan 2020 12:35:36 +0000 (UTC)
From:   marcandre.lureau@redhat.com
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] branch: let '--edit-description' default to rebased branch during rebase
Date:   Sat, 11 Jan 2020 16:35:33 +0400
Message-Id: <20200111123533.1613844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Defaulting to editing the description of the rebased branch without an
explicit branchname argument would be useful.  Even the git bash prompt
shows the name of the rebased branch, and then

  ~/src/git (mybranch|REBASE-i 1/2)$ git branch --edit-description
  fatal: Cannot give description to detached HEAD

looks quite unhelpful.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
Changed in v2:
 - add a test
 - fix commit message & summary
 - simplify code

builtin/branch.c  | 24 +++++++++++++++++++-----
 t/t3200-branch.sh | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index d8297f80ff..ee82dc828e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -745,15 +745,27 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 		string_list_clear(&output, 0);
 		return 0;
 	} else if (edit_description) {
-		const char *branch_name;
+		char *branch_name =3D NULL;
 		struct strbuf branch_ref =3D STRBUF_INIT;
=20
 		if (!argc) {
-			if (filter.detached)
-				die(_("Cannot give description to detached HEAD"));
-			branch_name =3D head;
+			if (filter.detached) {
+				struct wt_status_state state;
+
+				memset(&state, 0, sizeof(state));
+
+				if (wt_status_check_rebase(NULL, &state)) {
+					branch_name =3D state.branch;
+				}
+
+				if (!branch_name)
+					die(_("Cannot give description to detached HEAD"));
+
+				free(state.onto);
+			} else
+				branch_name =3D xstrdup(head);
 		} else if (argc =3D=3D 1)
-			branch_name =3D argv[0];
+			branch_name =3D xstrdup(argv[0]);
 		else
 			die(_("cannot edit description of more than one branch"));
=20
@@ -772,6 +784,8 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
=20
 		if (edit_branch_description(branch_name))
 			return 1;
+
+		free(branch_name);
 	} else if (copy) {
 		if (!argc)
 			die(_("branch name required"));
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 411a70b0ce..a20ebedea0 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1260,6 +1260,25 @@ test_expect_success 'use --edit-description' '
 	test_cmp expect EDITOR_OUTPUT
 '
=20
+test_expect_success 'use --edit-description during rebase' '
+	write_script editor <<-\EOF &&
+		echo "Rebase contents" >"$1"
+	EOF
+	(
+		set_fake_editor &&
+		FAKE_LINES=3D"break 1" git rebase -i HEAD^ &&
+		EDITOR=3D./editor git branch --edit-description &&
+		git rebase --continue
+	) &&
+	write_script editor <<-\EOF &&
+		git stripspace -s <"$1" >"EDITOR_OUTPUT"
+	EOF
+	EDITOR=3D./editor git branch --edit-description &&
+	echo "Rebase contents" >expect &&
+	test_cmp expect EDITOR_OUTPUT
+'
+test_done
+
 test_expect_success 'detect typo in branch name when using --edit-descri=
ption' '
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"

base-commit: 7a6a90c6ec48fc78c83d7090d6c1b95d8f3739c0
--=20
2.25.0.rc2.2.g5aece98438

