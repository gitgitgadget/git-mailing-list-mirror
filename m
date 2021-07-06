Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB4DC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 15:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF2B961C1E
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 15:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhGFPHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 11:07:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50594 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhGFPHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 11:07:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A4CBCF5DB;
        Tue,  6 Jul 2021 11:04:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5UzYb4oHzdHBTWK2ge70XXzK9b8Pg5u9SvxoZU
        6uUK0=; b=eLkDGH3KA7IQ4+7reG84fPiKW1ZAKONwNzyaATfVYio+L8Bpon3cma
        479Z43ehagpd+wnGhdyF4Gz/FoeW4FNWYB82d/qWVS5CS98ADRDiNDPhth6OYEj9
        2S9s5VQdKPs9xJZ1sesfwzvh5jZAGRvHeao+h2AFna3UCjv4RenJ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3256DCF5DA;
        Tue,  6 Jul 2021 11:04:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A692ACF5D9;
        Tue,  6 Jul 2021 11:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH] Add commit & tag signing/verification via SSH keys
 using ssh-keygen
References: <pull.1041.git.git.1625559593910.gitgitgadget@gmail.com>
Date:   Tue, 06 Jul 2021 08:04:28 -0700
In-Reply-To: <pull.1041.git.git.1625559593910.gitgitgadget@gmail.com> (Fabian
        Stelzer via GitGitGadget's message of "Tue, 06 Jul 2021 08:19:53
        +0000")
Message-ID: <xmqqzguzlc03.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76914ABC-DE6B-11EB-A2EC-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Fabian Stelzer <fs@gigacodes.de>
>
> set gpg.format = ssh and user.signingkey to a ssh public key string (like from an
> authorized_keys file) and commits/tags can be signed using the private
> key from your ssh-agent.
>
> Verification uses a allowed_signers_file (see ssh-keygen(1)) which
> defaults to .gitsigners but can be set via gpg.ssh.allowedsigners
> A possible gpg.ssh.revocationfile is also passed to ssh-keygen on
> verification.

There are probably style and coding-guideline nit people will pick
in the patch, but first of all I have to say that I am uncomfortably
excited to see this addition.

One thing that is unclear is how the 'allowed-signers' is expected
to be maintained in the larger picture.  Who decides which keys
(belong to whom) are trustworthy?  Does a contributor has to agree
with the decision that certain keys are trustworthy made by somebody
else in the project and use the same 'allowed-signers' collection of
keys to effectively participate in the project?  How do revoking and
rotating keys work?

It was a deliberate design decision to let PGP infrastructure that
is used to sign and verify signatures when we use PGP for signing
without tying any of these decisions to the tracked contents, as
that would reduce the attack surface for a malicious tree contents
to affect the signing and verification (in other words, "we punted"
;-).  Even though I am not sure exactly what you meant by "defaults
to .gitsigners", I am assuming that you meant a file with the name
at the top-level of the working tree, which makes me worried, as it
opens us to the risk of reading from and blindly trusting whatever
somebody else placed in the tree contents immediately after we "git
pull" (or "git clone").

Thanks for working on it.
