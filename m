Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8561BC433F5
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 04:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349585AbiFAEqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 00:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349551AbiFAEqF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 00:46:05 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366FF9EB7B
        for <git@vger.kernel.org>; Tue, 31 May 2022 21:46:03 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 135A3117825;
        Wed,  1 Jun 2022 00:46:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=4oFOrgK0iNtsjCx/I2gzI4HouQLUpOSKI6UlQNaotSk=; b=V/c/
        jwNXpoTkfKWltyi2QJpJQhuZtMeT1jRi6Ta1Y5+dAMIorDeBSM29upeY6M8k2HF5
        7QOX0Ze4wD8GoDjMjO8jw7LIJm+lhWqhzZSz3gq3qaO4dv7YIwIlCMfndu2BuMec
        czNwb2yqDGdCKSvO94dq6GDn++kdFyIT/eojINc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8FCB117822;
        Wed,  1 Jun 2022 00:46:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D278117821;
        Wed,  1 Jun 2022 00:46:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v3] revert: optionally refer to commit in the
 "reference" format
References: <xmqqsfp2b30k.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205231507350.352@tvgsbejvaqbjf.bet>
        <xmqq35gzn9vk.fsf@gitster.g> <xmqq8rqn7buk.fsf_-_@gitster.g>
        <479d97af-eef1-ce86-19f7-afcc0e6ecf30@gmail.com>
Date:   Tue, 31 May 2022 21:45:59 -0700
Message-ID: <xmqqfskpuh2w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBFFB9A0-E165-11EC-940B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think the changes to the template message are good. We're still
> adding "--reference" as a valid option to cherry-pick though which I
> don't think is a good idea (though in the future we may want to allow 
> "cherry-pick -x --reference")

I love when people notice mistakes that the original author and
other people missed, many eyes making all bugs shallow.

I am inclined to apply the following on top.  How does it look?

Thanks.

----- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] revert: --reference should apply only to 'revert', not 'cherry-pick'

As 'revert' and 'cherry-pick' share a lot of code, it is easy to
modify the behaviour of one command and inadvertently affect the
other.  An earlier change to teach the '--reference' option and the
'revert.reference' configuration variable to the former was not
careful enough and 'cherry-pick --reference' wasn't rejected as an
error.

It is possible to think 'cherry-pick -x' might benefit from the
'--reference' option, but it is fundamentally different from
'revert' in at least two ways to make it questionable:

 - 'revert' names a commit that is ancestor of the resulting commit,
   so an abbreviated object name with human readable title is
   sufficient to identify the named commit uniquely without using
   the full object name.  On the other hand, 'cherry-pick'
   usually [*] picks a commit that is not an ancestor.  It might be
   even picking a private commit that never becomes part of the
   public history.

 - The whole commit message of 'cherry-pick' is a copy of the
   original commit, and there is nothing gained to repeat only the
   title part on 'cherry-picked from' message.

[*] well, you could revert and then you can pick the original that
    was reverted to get back to where you were, but then you can
    revert the revert to do the same thing.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/revert.c              | 9 +++++++--
 sequencer.c                   | 2 +-
 t/t3501-revert-cherry-pick.sh | 6 ++++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index ada51e46b9..f84c253f4c 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -116,8 +116,6 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 			N_("option for merge strategy"), option_parse_x),
 		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
 		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
-		OPT_BOOL(0, "reference", &opts->commit_use_reference,
-			 N_("use the 'reference' format to refer to commits")),
 		OPT_END()
 	};
 	struct option *options = base_options;
@@ -132,6 +130,13 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 			OPT_END(),
 		};
 		options = parse_options_concat(options, cp_extra);
+	} else if (opts->action == REPLAY_REVERT) {
+		struct option cp_extra[] = {
+			OPT_BOOL(0, "reference", &opts->commit_use_reference,
+				 N_("use the 'reference' format to refer to commits")),
+			OPT_END(),
+		};
+		options = parse_options_concat(options, cp_extra);
 	}
 
 	argc = parse_options(argc, argv, NULL, options, usage_str,
diff --git a/sequencer.c b/sequencer.c
index 96fec6ef6d..4b66a1f79c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -221,7 +221,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
 		return ret;
 	}
 
-	if (!strcmp(k, "revert.reference"))
+	if (opts->action == REPLAY_REVERT && !strcmp(k, "revert.reference"))
 		opts->commit_use_reference = git_config_bool(k, v);
 
 	status = git_gpg_config(k, v, NULL);
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index a386ae9e88..fb4466599b 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -205,4 +205,10 @@ test_expect_success 'identification of reverted commit (revert.reference)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick is unaware of --reference (for now)' '
+	test_when_finished "git reset --hard" &&
+	test_must_fail git cherry-pick --reference HEAD 2>actual &&
+	grep "^usage: git cherry-pick" actual
+'
+
 test_done
-- 
2.36.1-393-g8f55ede6c2

