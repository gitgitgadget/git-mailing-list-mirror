Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE3CC433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 18:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86FB6619C5
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 18:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhCWS6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 14:58:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57645 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhCWS6A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 14:58:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D69C0B6586;
        Tue, 23 Mar 2021 14:57:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=k
        yhCzzU2VuSypzAdiyw1GjEo1Rs=; b=xhFNKzwvZwH/imbSVv7c45Az8MIZoWmOE
        rblHZKw94sb5VRiObYBoK7oEG9h6r4RhbORBDy4LdQ1rugptBcLNy/J4VNrCCOf9
        egcwoIytAWI6fUht0KLi6c1VmvC5LdC7GgGz3j7vmCzcwr6U5I5C8dxcyBpFFhCo
        4+JyeQ6/U8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=RanNFxzS2IzFNdkpDmsNtk9lq+O7ASKbMVbeuh4iHZqPh1RX12kCdiLF
        cmsgTFO32JEczkpXslPj6jA2UIFrUGQBONlc+lsw8E6aUwTlb/OdkFo67pCbv6+K
        JN1mh1RhlohqnjKcRfgAI9DREjO2bLmU6PUMLoCFzIrKCgQ2MVY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD45FB6585;
        Tue, 23 Mar 2021 14:57:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B238B657F;
        Tue, 23 Mar 2021 14:57:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Cc:     git@vger.kernel.org
Subject: Pass or not to pass config environment down...
Date:   Tue, 23 Mar 2021 11:57:57 -0700
Message-ID: <xmqqk0px3dfu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AED3619E-8C09-11EB-9D5E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was grepping around and found this piece of code today:

        static void prepare_submodule_repo_env_no_git_dir(struct strvec *out)
        {
                const char * const *var;

                for (var = local_repo_env; *var; var++) {
                        if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
                                strvec_push(out, *var);
                }
        }

which tries to "unsetenv" the environment variables that pertain to
the current repository listed in loocal_repo_env[], but makes
exception for GIT_CONFIG_PARAMETERS.

It originally came from 14111fc4 (git: submodule honor -c
credential.* from command line, 2016-02-29) and later simplified by
89044baa (submodule: stop sanitizing config options, 2016-05-04).

Now after d8d77153 (config: allow specifying config entries via
envvar pairs, 2021-01-12), we have yet another way to pass a set of
custom one-shot configuration via the environment variable, using
GIT_CONFIG_COUNT (which is in local_repo_env[] and will be removed
from the environment by this helper function), GIT_CONFIG_KEY_$n and
GIT_CONFIG_VALUE_$n (which are unbound set and naturally not in
local_repo_env[]).  Leaving the latter two exported will not hurt if
we do intend to hide the custom configuration from the subprocess by
unsetting GIT_CONFIG_COUNT, but should we be doing so?

There are many run_command() users that just pass local_repo_env[]
to the child.env when running a subprocess.  Given that the code
that works in a submodule, which presumably is THE primary target
of the "we do not want to pass environment variables that pertain to
the current repository but not to the repository the child process
works in" consideration that the local_repo_env[] is about, does *not*
want the GIT_CONFIG_PARAMETERS cleansed, I have to wonder if the
environment variables (the original GIT_CONFIG_PARAMETERS as well as
Patrick's GIT_CONFIG_{COUNT,KEY_$n,VALUE_$n}) should be in that
local_repo_env[] array in the first place.  If we remove them, the
above helper function can just go away and be replaced with the
usual child.env = local_repo_env assignment like everybody else.

Comments?

 environment.c | 2 --
 1 file changed, 2 deletions(-)

diff --git c/environment.c w/environment.c
index 2f27008424..6dcee6a9c5 100644
--- c/environment.c
+++ w/environment.c
@@ -116,8 +116,6 @@ static char *super_prefix;
 const char * const local_repo_env[] = {
 	ALTERNATE_DB_ENVIRONMENT,
 	CONFIG_ENVIRONMENT,
-	CONFIG_DATA_ENVIRONMENT,
-	CONFIG_COUNT_ENVIRONMENT,
 	DB_ENVIRONMENT,
 	GIT_DIR_ENVIRONMENT,
 	GIT_WORK_TREE_ENVIRONMENT,
