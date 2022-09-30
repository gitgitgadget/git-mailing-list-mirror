Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2163FC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 01:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiI3B2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 21:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiI3B2E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 21:28:04 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E718017F56D
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 18:28:03 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 221931B5AE8;
        Thu, 29 Sep 2022 21:28:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FRUb3QTHx8tE9Eyxw2ZT6yneIX1mTNelB3RUyS
        1jY8c=; b=yS2Ghimdpicwj/nlGXkxdAgfDOGG7VEYdeFh0RdwCTkO7YhXnNHres
        QXeMYuA8rJ91KlRKrCO3t+DYMCKsbL5PICEFPO4xf2ZYQzII9uK6LxwCHiXJ7+HS
        3D7XaicRKSIaRdE747P9bqLkuUmLBQJ7gpyCDoOUGbRvTHlH0YG80=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B3201B5AE6;
        Thu, 29 Sep 2022 21:28:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BEC2C1B5AE3;
        Thu, 29 Sep 2022 21:27:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2] branch: do not fail a no-op --edit-desc
References: <xmqqczbftina.fsf@gitster.g>
Date:   Thu, 29 Sep 2022 18:27:58 -0700
In-Reply-To: <xmqqczbftina.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        28 Sep 2022 12:15:37 -0700")
Message-ID: <xmqq8rm1mz1d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E9BD28A-405F-11ED-9679-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Imagine running "git branch --edit-description" on a branch without
a branch description, and then exit the editor after emptying the
edit buffer, which is the way to tell the command that you changed
your mind and you do not want the description after all.

The command should just happily oblige, adding no branch description
for the current branch, and exit successfully.  But it fails to do
so:

    $ git init -b main
    $ git commit --allow-empty -m commit
    $ GIT_EDITOR=: git branch --edit-description
    fatal: could not unset 'branch.main.description'

The end result is OK in that the configuration variable does not
exist in the resulting repository, but we should do better, by using
git_config_set_gently() and ignoring only the specific error that is
returned when removing a missing configuration variable.

A nice side effect is that it allows us to give a pair of messages
that are tailored to the situation.  Instead of reporting a failure
to set or unset a configuration variable "branch.X.description", we
can report that we failed to set or unset the description for branch
X, allowing the user to be oblivious to the irrelevant detail that
the branch description is implemented as a configuration variable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * So, this is the "other" implementation.  It is a bit more code
   than the simpler one, but may be OK.  I labeled this as v2 but I
   do not mean I consider this one is an improved version of the
   other one.  They are merely alternatives.

 builtin/branch.c  | 13 ++++++++++++-
 t/t3200-branch.sh |  3 +++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git c/builtin/branch.c w/builtin/branch.c
index 5d00d0b8d3..033d8bd29b 100644
--- c/builtin/branch.c
+++ w/builtin/branch.c
@@ -606,6 +606,7 @@ static int edit_branch_description(const char *branch_name)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf name = STRBUF_INIT;
+	int status;
 
 	read_branch_desc(&buf, branch_name);
 	if (!buf.len || buf.buf[buf.len-1] != '\n')
@@ -624,7 +625,17 @@ static int edit_branch_description(const char *branch_name)
 	strbuf_stripspace(&buf, 1);
 
 	strbuf_addf(&name, "branch.%s.description", branch_name);
-	git_config_set(name.buf, buf.len ? buf.buf : NULL);
+
+	status = git_config_set_gently(name.buf, buf.len ? buf.buf : NULL);
+	if (status && !(status == CONFIG_NOTHING_SET && !buf.len)) {
+		if (buf.len)
+			die(_("failed to set description for branch '%s'"), 
+			    branch_name);
+		else
+			die(_("failed to unset description for branch '%s'"), 
+			    branch_name);
+	}
+
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
