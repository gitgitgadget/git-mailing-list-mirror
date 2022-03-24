Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A886C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 17:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347268AbiCXRet (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiCXRes (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 13:34:48 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0FE41F83
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 10:33:14 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1874218F8E9;
        Thu, 24 Mar 2022 13:33:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EcckKUQxeKbGYAifGPCq0dYTWlC3B98khmBKmo
        7ddaI=; b=a9H65hCp4FsGbAdZwdhN1yvv6xUj9eFVQThtqdYUlND7Ufu71bqykz
        50e5+kwpWMR8Dyu42mOQezDbIref0BZg7ju27C6gTXOSDJ9/y+OzVVJ4eFSUTJjK
        Ap6u/shvpy2zhXLzMJVsPD/ButwkeQ7ZnTN4cRV3lEJ10wCy/2u+0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 10B2A18F8E8;
        Thu, 24 Mar 2022 13:33:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 74CB818F8E7;
        Thu, 24 Mar 2022 13:33:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/3] reset: make --no-refresh the only way to skip
 index refresh
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
        <pull.1184.v2.git.1648059480.gitgitgadget@gmail.com>
        <6d424915-5c63-bebd-f3b5-f153a541d077@gmail.com>
        <xmqqsfr7jmtb.fsf@gitster.g>
Date:   Thu, 24 Mar 2022 10:33:10 -0700
In-Reply-To: <xmqqsfr7jmtb.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        24 Mar 2022 10:13:36 -0700")
Message-ID: <xmqq7d8jjlwp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A2F7CF2-AB98-11EC-BB15-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ... as you suggested, I think mimicking how existing commands with
> "--no-<option>" are shown, e.g. builtlin/update-ref.c does
> "--no-deref",
>
>     $ git update-ref -h 2>&1 | grep deref
>         --no-deref            update <refname> not the one it points to
>     $ git grep 'OPT_BOOL.*"no-deref"'
>     builtin/update-ref.c:		OPT_BOOL( 0 , "no-deref", &no_deref,
>
> would be a good approach.
>
>> The range-diff for the other changes looks good
>
> Thanks.
>
> #leftoverbit: we may want to discuss if it is a good idea to teach
> OPT_BOOL() to list "--[no-]<option>" in "git cmd -h", instead of
> just "--<option>".


Unfortunately, I merged these already to 'next' before seeing your
comment, so we'd need to go incremental.

How about this?

----- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] reset: show --no-refresh in the short-help

In the short help output from "git reset -h", the recently added
"--[no-]refresh" option is shown like so:

        --refresh             skip refreshing the index after reset

which explains what happens when the option is given in the negative
form, i.e. "--no-refresh".  We could rephrase the explanation to
read "refresh the index after reset (default)" to hint that the user
can say "--no-refresh" to override the default, but listing the
"--no-refresh" form in the list of options would be more helpful.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/reset.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git c/builtin/reset.c w/builtin/reset.c
index 1d89faef5e..344fff8f3a 100644
--- c/builtin/reset.c
+++ w/builtin/reset.c
@@ -392,7 +392,7 @@ static int git_reset_config(const char *var, const char *value, void *cb)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
-	int refresh = 1;
+	int no_refresh = 0;
 	int patch_mode = 0, pathspec_file_nul = 0, unborn;
 	const char *rev, *pathspec_from_file = NULL;
 	struct object_id oid;
@@ -400,7 +400,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	int intent_to_add = 0;
 	const struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
-		OPT_BOOL(0, "refresh", &refresh,
+		OPT_BOOL(0, "no-refresh", &no_refresh,
 				N_("skip refreshing the index after reset")),
 		OPT_SET_INT(0, "mixed", &reset_type,
 						N_("reset HEAD and index"), MIXED),
@@ -519,7 +519,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			if (read_from_tree(&pathspec, &oid, intent_to_add))
 				return 1;
 			the_index.updated_skipworktree = 1;
-			if (refresh && get_git_work_tree()) {
+			if (!no_refresh && get_git_work_tree()) {
 				uint64_t t_begin, t_delta_in_ms;
 
 				t_begin = getnanotime();
