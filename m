Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3986C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB82761370
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhGNUfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:35:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55106 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhGNUfV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 16:35:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF4B1D1A7B;
        Wed, 14 Jul 2021 16:32:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q5WmGaimYsP3c+e6akPRRN7+rXXeRzQpd4ozOC
        RiuF8=; b=jfNw0eWO3UlTHvEdGTjdfXjuC1Z2S0ECedvzZuadFwEaBPljXB+Jyu
        IBt85vfAP7tOXZLmbA7Rqx+agkD7x+q/SAPwfCutFjQXp7fXViRxQrVcSVPsqOlO
        fE6TJ/SABccdL153n2i2aPW88QVWOvDcrTMP4X3/YYh8g7McXR/t0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5BDDD1A7A;
        Wed, 14 Jul 2021 16:32:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C561D1A79;
        Wed, 14 Jul 2021 16:32:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 4/9] ssh signing: sign using either gpg or ssh keys
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
        <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
        <df55b9e1d5989766b08596f5b9057ba0be38c10e.1626264613.git.gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:32:27 -0700
In-Reply-To: <df55b9e1d5989766b08596f5b9057ba0be38c10e.1626264613.git.gitgitgadget@gmail.com>
        (Fabian Stelzer via GitGitGadget's message of "Wed, 14 Jul 2021
        12:10:08 +0000")
Message-ID: <xmqqmtqovdpg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B3FDF90-E4E2-11EB-80F9-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
>  {
> -	struct child_process gpg = CHILD_PROCESS_INIT;
> +	struct child_process signer = CHILD_PROCESS_INIT;
>  	int ret;
>  	size_t i, j, bottom;
> -	struct strbuf gpg_status = STRBUF_INIT;
> +	struct strbuf signer_stderr = STRBUF_INIT;
> +	struct tempfile *temp = NULL, *buffer_file = NULL;
> +	char *ssh_signing_key_file = NULL;
> +	struct strbuf ssh_signature_filename = STRBUF_INIT;
>  
> -	strvec_pushl(&gpg.args,
> -		     use_format->program,
> +	if (!strcmp(use_format->name, "ssh")) {

I wonder if we can split the body of these if/else clauses into
separate helper functions, point them with fmt structure and
dispatch via use_format->sign_buffer pointer, just like I suggested
how to do the same on the signature validation side.

> +		if (!signing_key || signing_key[0] == '\0')
> +			return error(_("user.signingkey needs to be set for ssh signing"));
> +
> +
> +		if (istarts_with(signing_key, "ssh-")) {
> +			/* A literal ssh key */
> +			temp = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
> +			if (!temp)
> +				return error_errno(_("could not create temporary file"));
> +			if (write_in_full(temp->fd, signing_key, strlen(signing_key)) < 0 ||
> +				close_tempfile_gently(temp) < 0) {
> +				error_errno(_("failed writing ssh signing key to '%s'"),
> +					temp->filename.buf);
> +				delete_tempfile(&temp);
> +				return -1;
> +			}
> +			ssh_signing_key_file= temp->filename.buf;
> +		} else {
> +			/* We assume a file */
> +			ssh_signing_key_file = expand_user_path(signing_key, 1);
> +		}
> +
> +		buffer_file = mks_tempfile_t(".git_signing_buffer_tmpXXXXXX");
> +		if (!buffer_file)
> +			return error_errno(_("could not create temporary file"));
> +		if (write_in_full(buffer_file->fd, buffer->buf, buffer->len) < 0 ||
> +			close_tempfile_gently(buffer_file) < 0) {
> +			error_errno(_("failed writing ssh signing key buffer to '%s'"),
> +				buffer_file->filename.buf);
> +			delete_tempfile(&buffer_file);
> +			return -1;
> +		}
> +
> +		strvec_pushl(&signer.args, use_format->program ,
> +					"-Y", "sign",
> +					"-n", "git",
> +					"-f", ssh_signing_key_file,
> +					buffer_file->filename.buf,
> +					NULL);
> +
> +		sigchain_push(SIGPIPE, SIG_IGN);
> +		ret = pipe_command(&signer, NULL, 0, NULL, 0, &signer_stderr, 0);
> +		sigchain_pop(SIGPIPE);
> +
> +		strbuf_addbuf(&ssh_signature_filename, &buffer_file->filename);
> +		strbuf_addstr(&ssh_signature_filename, ".sig");
> +		if (strbuf_read_file(signature, ssh_signature_filename.buf, 2048) < 0) {
> +			error_errno(_("failed reading ssh signing data buffer from '%s'"),
> +				ssh_signature_filename.buf);
> +		}
> +		unlink_or_warn(ssh_signature_filename.buf);
> +		strbuf_release(&ssh_signature_filename);
> +		delete_tempfile(&buffer_file);
> +	} else {
> +		strvec_pushl(&signer.args, use_format->program ,
>  		     "--status-fd=2",
>  		     "-bsau", signing_key,
>  		     NULL);
>  
> -	bottom = signature->len;
> -
>  	/*
>  	 * When the username signingkey is bad, program could be terminated
>  	 * because gpg exits without reading and then write gets SIGPIPE.
>  	 */
>  	sigchain_push(SIGPIPE, SIG_IGN);
> -	ret = pipe_command(&gpg, buffer->buf, buffer->len,
> -			   signature, 1024, &gpg_status, 0);
> +		ret = pipe_command(&signer, buffer->buf, buffer->len, signature, 1024, &signer_stderr, 0);
>  	sigchain_pop(SIGPIPE);
> +	}
> +
> +	bottom = signature->len;
> +
> +	if (temp)
> +		delete_tempfile(&temp);
>  
> -	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
> -	strbuf_release(&gpg_status);
> +	if (!strcmp(use_format->name, "ssh")) {
> +		if (strstr(signer_stderr.buf, "usage:")) {
> +			error(_("openssh version > 8.2p1 is needed for ssh signing (ssh-keygen needs -Y sign option)"));

This looks iffy.  You do call error() to show the error message, but
you do not set "ret", which affects how the return value from the
function is computed at the end of the function.

> +		}
> +	} else {
> +		ret |= !strstr(signer_stderr.buf, "\n[GNUPG:] SIG_CREATED ");
> +	}
> +	strbuf_release(&signer_stderr);

>  	if (ret)
>  		return error(_("gpg failed to sign the data"));

And this error message belongs to the GPG half of the logic, not
ssh (you are allowed to have a separate "ssh failed to sign"
message, of course, but the point is that the error message emission
should happen in the codepath dispatched for each crypto backend.

And of course, again the "if (ssh) {do this shiny new ssh thing}
else {do gpg thing}" structure is questionable.  We should be
dispatching with use_format->fn (whatever the method name is), no?

THanks.

