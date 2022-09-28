Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A268C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 19:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiI1TPm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 15:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiI1TPl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 15:15:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C84AE222
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 12:15:40 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F19E814662E;
        Wed, 28 Sep 2022 15:15:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:cc:date:message-id:mime-version:content-type; s=sasl;
         bh=E5CaZCbBELKVZ+X8HQ6ke9MJB2GLbzLfg1feGuOe76Y=; b=twdprbWRvJjj
        a2xr/TQHkDzPUJcw8BSCzmsqDIxfJf8r/fvYb6f6HWO55Dg2EbMorRPxHtmVfPC1
        4D2xfVyQ11Dj8NhFk7PExblp2KKyRtmV2T40PUTD++iGRkOpvOfPcSGREo65QEpy
        ahmskHIV3TROvRPZdzicg35T/Y6peiI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E86A914662D;
        Wed, 28 Sep 2022 15:15:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5584714662C;
        Wed, 28 Sep 2022 15:15:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] branch: do not fail a no-op --edit-desc
cc:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Date:   Wed, 28 Sep 2022 12:15:37 -0700
Message-ID: <xmqqczbftina.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFAB256E-3F61-11ED-A697-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a repository on a branch without branch description, try running
"git branch --edit-description" and then exit the editor after
emptying the edit buffer, which is the way to tell the command that
you changed your mind and you do not want the description after all.

The command should just happily oblige, adding no branch description
for the current branch, and exit successfully.  But it fails to do
so:

    $ git init -b main
    $ git commit --allow-empty -m commit
    $ GIT_EDITOR=: git branch --edit-description
    fatal: could not unset 'branch.main.description'

The end result is OK in that the configuration variable does not
exist in the resulting repository, but we should do better.

One way to solve this is to replace the git_config_set() call that
is also used to unset the variable when the edited buffer is empty
with git_config_set_gently(), so that we do not consider it an error
that we fail to unset something that does not exist in the first
place.

But there is even a simpler way, which is to take advantage of the
fact that we _know_ if the variable existed in the first place.  If
we know we didn't have description, and if we are asked not to have
a description by the editor, we can just return doing nothing.

The simpler solution of course introduces TOCTOU, but you are
fooling yourself in your own repository.  Not overwriting the branch
description on the same branch you added in another window, while
you had this other editor open, may even be a feature ;-)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/branch.c  | 6 ++++--
 t/t3200-branch.sh | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git c/builtin/branch.c w/builtin/branch.c
index 5d00d0b8d3..dcd847158a 100644
--- c/builtin/branch.c
+++ w/builtin/branch.c
@@ -604,10 +604,11 @@ static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
 {
+	int exists;
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf name = STRBUF_INIT;
 
-	read_branch_desc(&buf, branch_name);
+	exists = !read_branch_desc(&buf, branch_name);
 	if (!buf.len || buf.buf[buf.len-1] != '\n')
 		strbuf_addch(&buf, '\n');
 	strbuf_commented_addf(&buf,
@@ -624,7 +625,8 @@ static int edit_branch_description(const char *branch_name)
 	strbuf_stripspace(&buf, 1);
 
 	strbuf_addf(&name, "branch.%s.description", branch_name);
-	git_config_set(name.buf, buf.len ? buf.buf : NULL);
+	if (buf.len || exists)
+		git_config_set(name.buf, buf.len ? buf.buf : NULL);
 	strbuf_release(&name);
 	strbuf_release(&buf);
 
diff --git c/t/t3200-branch.sh w/t/t3200-branch.sh
index 9723c2827c..5f72fd7453 100755
--- c/t/t3200-branch.sh
+++ w/t/t3200-branch.sh
@@ -1381,6 +1381,9 @@ test_expect_success 'branch --delete --force removes dangling branch' '
 '
 
 test_expect_success 'use --edit-description' '
+	EDITOR=: git branch --edit-description &&
+	test_must_fail git config branch.main.description &&
+
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
 	EOF
