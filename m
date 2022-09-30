Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BF2C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiI3SGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiI3SGa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:06:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8034A33373
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:06:27 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C76B1436CD;
        Fri, 30 Sep 2022 14:06:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=djaRCCR8A/iEvT4og7c2/1i0k
        aXjp3QRMlGjVnntraU=; b=MPh6HKQasOOP8QzEungl3Lntm9Xf5qWASdYH2bR6t
        EMuJTQLLe5OUNDHTaXVK5cJQDWYAPkmD79Z3cVJpR0Wp137j5SbFoi3m9ANBNcIy
        xbvHBscMib57PaHCox9pgGSg1js0igyOvKqNbE/x5Mtn4NHY2I1eGdl+jIYNX4GK
        nw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53F641436CC;
        Fri, 30 Sep 2022 14:06:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98BB81436CB;
        Fri, 30 Sep 2022 14:06:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3] branch: do not fail a no-op --edit-desc
References: <xmqqczbftina.fsf@gitster.g> <xmqq8rm1mz1d.fsf@gitster.g>
Date:   Fri, 30 Sep 2022 11:06:22 -0700
Message-ID: <xmqqmtagka8x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9815F718-40EA-11ED-B723-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Imagine running "git branch --edit-description" while on a branch
without the branch description, and then exit the editor after
emptying the edit buffer, which is the way to tell the command that
you changed your mind and you do not want the description after all.

The command should just happily oblige, adding no branch description
for the current branch, and exit successfully.  But it fails to do
so:

    $ git init -b main
    $ git commit --allow-empty -m commit
    $ GIT_EDITOR=3D: git branch --edit-description
    fatal: could not unset 'branch.main.description'

The end result is OK in that the configuration variable does not
exist in the resulting repository, but we should do better.  If we
know we didn't have a description, and if we are asked not to have a
description by the editor, we can just return doing nothing.

This of course introduces TOCTOU.  If you add a branch description
to the same branch from another window, while you had the editor
open to edit the description, and then exit the editor without
writing anything there, we'd end up not removing the description you
added in the other window.  But you are fooling yourself in your own
repository at that point, and if it hurts, you'd be better off not
doing so ;-).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * =C3=86var reports that CONFIG_NOTHING_SET is not a usable error status
   for this purpose, unfortunately.  So let's go back to the approach
   taken by the initial implementation, but with the proposed log
   message clarified.

 builtin/branch.c  | 6 ++++--
 t/t3200-branch.sh | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 8c0b428104..ae08147572 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -576,10 +576,11 @@ static GIT_PATH_FUNC(edit_description, "EDIT_DESCRI=
PTION")
=20
 static int edit_branch_description(const char *branch_name)
 {
+	int exists;
 	struct strbuf buf =3D STRBUF_INIT;
 	struct strbuf name =3D STRBUF_INIT;
=20
-	read_branch_desc(&buf, branch_name);
+	exists =3D !read_branch_desc(&buf, branch_name);
 	if (!buf.len || buf.buf[buf.len-1] !=3D '\n')
 		strbuf_addch(&buf, '\n');
 	strbuf_commented_addf(&buf,
@@ -596,7 +597,8 @@ static int edit_branch_description(const char *branch=
_name)
 	strbuf_stripspace(&buf, 1);
=20
 	strbuf_addf(&name, "branch.%s.description", branch_name);
-	git_config_set(name.buf, buf.len ? buf.buf : NULL);
+	if (buf.len || exists)
+		git_config_set(name.buf, buf.len ? buf.buf : NULL);
 	strbuf_release(&name);
 	strbuf_release(&buf);
=20
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 3ec3e1d730..30dff9e712 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1268,6 +1268,9 @@ test_expect_success 'attempt to delete a branch mer=
ged to its base' '
 '
=20
 test_expect_success 'use --edit-description' '
+	EDITOR=3D: git branch --edit-description &&
+	test_must_fail git config branch.main.description &&
+
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
 	EOF
--=20
2.38.0-rc2-134-gd449533db0

