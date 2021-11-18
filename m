Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3360FC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 03:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F00600CD
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 03:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242616AbhKRDMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 22:12:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60509 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242443AbhKRDML (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 22:12:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8414CE1621;
        Wed, 17 Nov 2021 22:09:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=tRtnWW8Sohb0sP8wh7YlFrZbWgcZ74w2kfeF6b0zxS8=; b=IqN6
        17xJCP8YynlaeNIfZtXso9oyIOx9vwD/40UkSry0xtJly+yhi8Ye/vB4JUZVaXM/
        OjYFsk3g/q8D4kuVQeTmRKPjSutlWjjklWcZGc1ghrm81o8xbLvdp+++zm708jVR
        +8LNjQ9Aen8HYn4Ta1PIEFfoQGsCEgIj8axEDYQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C027E1620;
        Wed, 17 Nov 2021 22:09:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2C91E161F;
        Wed, 17 Nov 2021 22:09:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ssh signing: support non ssh-* keytypes
References: <20211117162727.650857-1-fs@gigacodes.de>
Date:   Wed, 17 Nov 2021 19:09:08 -0800
Message-ID: <xmqq4k8a2m97.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E62A0EFC-481C-11EC-A26C-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> +/* Determines wether key contains a literal ssh key or a path to a file */
> +static int is_literal_ssh_key(const char *key) {
> +	return (
> +		starts_with(key, "ssh-") ||
> +		starts_with(key, "ecdsa-") ||
> +		starts_with(key, "sk-ssh-") ||
> +		starts_with(key, "sk-ecdsa-")
> +	);
> +}

A more forward looking thing you could do is to 

 (1) grandfather the convention "any string that begins with 'ssh-'
     is taken as a ssh literal key".

 (2) refrain from spreading such an unstructured mess by picking a
     reserved prefix, say "ssh-key::" and have all other kinds of
     ssh keys use the convention.

making the above function look more like

    static int is_literal_ssh_key(const char *string, const char **key)
    {
	if (skip_prefix(string, "ssh-key::", key)
	    return 1;
	if (starts_with(string, "ssh-")) {
	    key = string;
	    return 1;
	}
	return 0;
    }

so that the caller can extract the literal key from the string that
specifies either the literal key or path to the file.  This will
futureproof us in two axis.  When SSH adds types of keys using new
algo, we do not have to add it to is_literal_ssh_key() function.
Also when another crypto suite other than GPG and SSH comes, we
won't repeat the "bare 'ssh-' prefix is reserved by ssh, and
different kind in the same suite may have to consume more reserved
prefixes" mistake---it would make it more natural for us to pick
"literal keys from any variant of that new FOO crypto suite are
written with 'foo-key::' prefix" if we did so right now.  It would
have been better if we didn't have to do the grandfathering, but I
am assuming that the ship has already sailed?

> @@ -719,7 +729,7 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
>  	 * With SSH Signing this can contain a filename or a public key
>  	 * For textual representation we usually want a fingerprint
>  	 */
> -	if (starts_with(signing_key, "ssh-")) {
> +	if (is_literal_ssh_key(signing_key)) {
> 		strvec_pushl(&ssh_keygen.args, "ssh-keygen", "-lf", "-", NULL);
> 		ret = pipe_command(&ssh_keygen, signing_key,
> 				   strlen(signing_key), &fingerprint_stdout, 0,

This part needs a bit of adjustment if we go the
"is_literal_ssh_key() is not just a boolean but is used to strip the
prefix to signal the kind of key" route, but the necessary
adjustment should be trivial.
