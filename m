Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18484C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 03:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB08364F90
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 03:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhCLDBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 22:01:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54996 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhCLDBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 22:01:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 69B18124F59;
        Thu, 11 Mar 2021 22:01:16 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=8yD478ONw1UaQ6yg4t4xnjUba
        1Y=; b=axIB0ydC5I0Bq5vEZECKQNt6fjRCzp0DE98kfy9jXqVv6BenFbu+lsMU0
        V8rGTGpb6E6m1LgV6/9Hy2jcx/d/S9tCLzhmF0A5LtYHiQstEu1J8SPghAq1eMqy
        oIOYDYTw7WcJ6gcb2QiLTiap8Il2vgDVgJ889+n2yaXGyeL0qI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=DKH4BY3d0UGc+ATwO0t
        uRD5M1J6d5v3DNWkI00v9uU+c15QEt3N55CKNtQ4dj5/XiI2j4ebP9JN792FTPEs
        4OyRkj8gHb7vdwRYgsBEg7CfCClxWCfGJT6MLu8aMw+bzZEmWSzlovXMS8o6akQ8
        vRoeWN/wryTP4la+yidkvAso=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 61CFD124F58;
        Thu, 11 Mar 2021 22:01:16 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ABBE4124F57;
        Thu, 11 Mar 2021 22:01:13 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] [WIP] sequencer.c: carry forward notes on HEAD across "rebase -x"
Date:   Thu, 11 Mar 2021 19:01:07 -0800
Message-Id: <20210312030107.1849942-3-gitster@pobox.com>
X-Mailer: git-send-email 2.31.0-rc2-175-g3820f1c72e
In-Reply-To: <20210312030107.1849942-1-gitster@pobox.com>
References: <xmqq8s6tcuxc.fsf@gitster.g>
 <20210312030107.1849942-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 34A06760-82DF-11EB-B74A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the external command invoked by "rebase -x" replaces the HEAD,
we seem to lose the notes attached to the original HEAD, which is
why we have been losing the amlog mappings in the git core project.

Here is a half-successful attempt to fix it.  For whatever reason,
when the external command is "git commit --amend --no-edit", the
updated code carries notes forward correctly, but when the command
is changed to "git commit --amend -m tweak", it fails to do so, and
I do not have more time to work on this, so I'd stop here with an
expected failure in the test.

Help is appreciated.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sequencer.c                   | 10 +++++++++-
 t/t3404-rebase-interactive.sh | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 92a4871997..e0bdc39e4d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3276,7 +3276,10 @@ static int do_exec(struct repository *r, const cha=
r *command_line)
 {
 	struct strvec child_env =3D STRVEC_INIT;
 	const char *child_argv[] =3D { NULL, NULL };
-	int dirty, status;
+	int dirty, status, bad_head;
+	struct object_id old_head_oid, new_head_oid;
+
+	bad_head =3D get_oid("HEAD", &old_head_oid);
=20
 	fprintf(stderr, _("Executing: %s\n"), command_line);
 	child_argv[0] =3D command_line;
@@ -3286,6 +3289,11 @@ static int do_exec(struct repository *r, const cha=
r *command_line)
 	status =3D run_command_v_opt_cd_env(child_argv, RUN_USING_SHELL, NULL,
 					  child_env.v);
=20
+	bad_head |=3D get_oid("HEAD", &new_head_oid);
+
+	if (!bad_head && !oideq(&old_head_oid, &new_head_oid))
+		commit_post_rewrite(r, &old_head_oid, &new_head_oid);
+
 	/* force re-reading of the cache */
 	if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
 		return error(_("could not read index"));
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.s=
h
index 66bcbbf952..3222c594ab 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -155,6 +155,8 @@ test_expect_success 'rebase -i with the exec command =
checks tree cleanness' '
 	git rebase --continue
 '
=20
+# NEEDSWORK: Fix c762aada1ab3a2c428c with s/@/HEAD/;
+
 test_expect_success 'rebase -x with empty command fails' '
 	test_when_finished "git rebase --abort ||:" &&
 	test_must_fail env git rebase -x "" @ 2>actual &&
@@ -867,6 +869,22 @@ test_expect_success 'rebase -i can copy notes over a=
 fixup' '
 	test_cmp expect output
 '
=20
+test_expect_success 'notes are copied even rebase -x changes HEAD' '
+	git reset --hard n3 &&
+	git rebase -x "git commit --amend --no-edit" n1^1 &&
+	git log --format=3D"%s <%N>" n1^1..n3 >expect &&
+	git log --format=3D"%s <%N>" n1^1..HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'notes are copied even rebase -x changes HEAD' '
+	git reset --hard n3 &&
+	git rebase -x "git commit --amend -m tweak" n1^1 &&
+	git log --format=3D"tweak <%N>" n1^1..n3 >expect &&
+	git log --format=3D"%s <%N>" n1^1..HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rebase while detaching HEAD' '
 	git symbolic-ref HEAD &&
 	grandparent=3D$(git rev-parse HEAD~2) &&
--=20
2.31.0-rc2-175-g3820f1c72e

