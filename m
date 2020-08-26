Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0392C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 22:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F4A20678
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 22:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GXul2Qyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHZWZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 18:25:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55932 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZWZL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 18:25:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4AFAFEEBC1;
        Wed, 26 Aug 2020 18:25:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7rA/7OZdG2bWgIXwzf+G4Vi7o4E=; b=GXul2Q
        ybw92YvTZ/tC3xdYlxwYKN/CNfqyn/S3/KEOhHcyKmc1AO/RgMKENmKKX5nPmMmy
        xtqnDi60Eu8c17AxWEGWZFUewMaOCmRvcbf6HA9NkD+Nop4hzOeZZB3+L4YVeeUc
        md8tb0BTkO7RQ0WGnpX/bD8/rvuYt47EsXoS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qJ44gA2buGQpSt8Gb/07VgOXqy5C3p0P
        amWw5zj9pCQF9CoyhmfpKMvBz032SHtvx72yKV1OYOaBZ6MLmG1kHhvL7Q+xWq2c
        2Q9XsVdo7Gx5A+8NCVT6hRfXthYF5msgmaN3cdCVuHF3dezdOYGTksbBD4jk/dPY
        Qw4lV3ndp1Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 45490EEBC0;
        Wed, 26 Aug 2020 18:25:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 59022EEBBF;
        Wed, 26 Aug 2020 18:25:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH] run_command: teach API users to use embedded 'args' more
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
        <20200826194650.4031087-1-gitster@pobox.com>
        <20200826194650.4031087-3-gitster@pobox.com>
        <xmqqzh6ht7fg.fsf_-_@gitster.c.googlers.com>
Date:   Wed, 26 Aug 2020 15:25:03 -0700
In-Reply-To: <xmqqzh6ht7fg.fsf_-_@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 26 Aug 2020 14:37:39 -0700")
Message-ID: <xmqqmu2ht58g.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDBFD3B4-E7EA-11EA-80A1-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The child_process structure has an embedded strvec for formulating
the command line argument list these days, but code that predates
the wide use of it prepared a separate char *argv[] array and
manually set the child_process.argv pointer point at it.

Teach these old-style code to lose the separate argv[] array.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 convert.c    |  5 +----
 credential.c |  4 +---
 submodule.c  | 13 ++++---------
 trailer.c    |  4 +---
 4 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/convert.c b/convert.c
index 572449825c..8e6c292421 100644
--- a/convert.c
+++ b/convert.c
@@ -638,7 +638,6 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	struct child_process child_process = CHILD_PROCESS_INIT;
 	struct filter_params *params = (struct filter_params *)data;
 	int write_err, status;
-	const char *argv[] = { NULL, NULL };
 
 	/* apply % substitution to cmd */
 	struct strbuf cmd = STRBUF_INIT;
@@ -656,9 +655,7 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	strbuf_expand(&cmd, params->cmd, strbuf_expand_dict_cb, &dict);
 	strbuf_release(&path);
 
-	argv[0] = cmd.buf;
-
-	child_process.argv = argv;
+	strvec_push(&child_process.args, cmd.buf);
 	child_process.use_shell = 1;
 	child_process.in = -1;
 	child_process.out = out;
diff --git a/credential.c b/credential.c
index d8d226b97e..efc29dc5e1 100644
--- a/credential.c
+++ b/credential.c
@@ -274,11 +274,9 @@ static int run_credential_helper(struct credential *c,
 				 int want_output)
 {
 	struct child_process helper = CHILD_PROCESS_INIT;
-	const char *argv[] = { NULL, NULL };
 	FILE *fp;
 
-	argv[0] = cmd;
-	helper.argv = argv;
+	strvec_push(&helper.args, cmd);
 	helper.use_shell = 1;
 	helper.in = -1;
 	if (want_output)
diff --git a/submodule.c b/submodule.c
index 01697848be..e6086faff7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1727,14 +1727,6 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 int submodule_uses_gitfile(const char *path)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *argv[] = {
-		"submodule",
-		"foreach",
-		"--quiet",
-		"--recursive",
-		"test -f .git",
-		NULL,
-	};
 	struct strbuf buf = STRBUF_INIT;
 	const char *git_dir;
 
@@ -1747,7 +1739,10 @@ int submodule_uses_gitfile(const char *path)
 	strbuf_release(&buf);
 
 	/* Now test that all nested submodules use a gitfile too */
-	cp.argv = argv;
+	strvec_pushl(&cp.args,
+		     "submodule", "foreach", "--quiet",	"--recursive",
+		     "test -f .git", NULL);
+
 	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
diff --git a/trailer.c b/trailer.c
index 0c414f2fed..68dabc2556 100644
--- a/trailer.c
+++ b/trailer.c
@@ -221,15 +221,13 @@ static char *apply_command(const char *command, const char *arg)
 	struct strbuf cmd = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *argv[] = {NULL, NULL};
 	char *result;
 
 	strbuf_addstr(&cmd, command);
 	if (arg)
 		strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
 
-	argv[0] = cmd.buf;
-	cp.argv = argv;
+	strvec_push(&cp.args, cmd.buf);
 	cp.env = local_repo_env;
 	cp.no_stdin = 1;
 	cp.use_shell = 1;
