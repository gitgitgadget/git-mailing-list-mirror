Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6434BC4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 19:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E1CD60FC0
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 19:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhHLTi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 15:38:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55724 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhHLTi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 15:38:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E685014DB49;
        Thu, 12 Aug 2021 15:38:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MAoTudv7PI7SkrFaFAkdR/O9K4VZrYzdvKM8mJ
        o4a/I=; b=Zj4HLffEx8fhHdTn+JD6tjWnq7BW/D/08STNl4ERMsPuSdCTCv41w4
        0INMtRXTFRv5oRUseEOj2XvXi6seR8smsqo/NWaeLLNxjjEl4X61mXrK6C43ojRI
        Rk9oNwQq9PoFP26p/tPkY7MgJQ32AnrxpiWkS4d1uHZ4sCNEIcO24=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DEBE314DB48;
        Thu, 12 Aug 2021 15:38:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2C60314DB45;
        Thu, 12 Aug 2021 15:37:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Azeem Bande-Ali via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, David Barr <b@rr-dav.id.au>,
        Azeem Bande-Ali <A.BandeAli@gmail.com>,
        Azeem Bande-Ali <me@azeemba.com>
Subject: Re: [PATCH] help.c: help.autocorrect=prompt waits for user action
References: <pull.1012.git.1628640954160.gitgitgadget@gmail.com>
Date:   Thu, 12 Aug 2021 12:37:57 -0700
In-Reply-To: <pull.1012.git.1628640954160.gitgitgadget@gmail.com> (Azeem
        Bande-Ali via GitGitGadget's message of "Wed, 11 Aug 2021 00:15:53
        +0000")
Message-ID: <xmqqh7fu314a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCAC30B4-FBA4-11EB-80FD-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -618,7 +622,18 @@ const char *help_unknown_cmd(const char *cmd)
>  				   _("Continuing under the assumption that "
>  				     "you meant '%s'."),
>  				   assumed);
> -		else {
> +		else if (autocorrect == AUTOCORRECT_PROMPT) {
> +			if (!isatty(STDIN_FILENO) | !isatty(STDERR_FILENO))

Don't do bitwise or when you only care about boolean outcome.

> +				exit(1);

This is not a new issue, but I think it is probably a bug in the
original design of the help-unknown that we do not do this check
much early in help_unknown_cmd(), to disable auto-correction in
a non-interactive session.  If we did so, we do not have to have
this check here. 

If we cannot yet come to consensus that disabling autocorrection
when running non-interactively is a good idea, at least we should be
able to do so only for _PROMPT case, like the attached patch at the
end.

> +			char *answer;

This is decl-after-statement, but as I am suggesting to get rid of
the tty check done inside this block, it will become OK.

> +			fprintf_ln(stderr, _("Assuming you meant: '%s'."),
> +				   assumed);
> +			answer = git_prompt(_("Continue? (y/N)"), PROMPT_ECHO);

Hmph, the above does not look WRONG per-se, but I wonder if it is
easier for the users to see a single line, e.g.

	struct strbuf msg = STRBUF_INIT;
	strbuf_addf(&msg, _("Run '%s' instead? (y/N)"), assumed);
        answer = git_prompt(msg.buf, PROMPT_ECHO);
        strbuf_release(&msg);

Thanks.


diff --git i/help.c w/help.c
index e22ba1d246..3629cb8796 100644
--- i/help.c
+++ w/help.c
@@ -540,6 +540,13 @@ const char *help_unknown_cmd(const char *cmd)
 
 	read_early_config(git_unknown_cmd_config, NULL);
 
+	/*
+	 * Disable autocorrection prompt in a non-interactive session
+	 */
+	if ((autocorrect != AUTOCORRECT_PROMPT) &&
+	    (!isatty(0) || !isatty(2)))
+		autocorrect = AUTOCORRECT_NEVER;
+
 	if (autocorrect == AUTOCORRECT_NEVER) {
 		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 		exit(1);



