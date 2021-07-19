Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A671C636C9
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 00:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B0D361107
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 00:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhGSXwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 19:52:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53335 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241812AbhGSXNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 19:13:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F217135C14;
        Mon, 19 Jul 2021 19:53:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/NjCgBlW5pa6xGeEwA6CyDh8qi25vmee6pUd1Q
        fepC8=; b=mK3ILkKhdT20L3AfcBjFqxkKbGf6mV3iIMO1VJCtDDcL7vpCfdQrCz
        aJAmGHx+LsRFi3wufDOWc3y80ebYx5k1E6LY6asAMlxRLjoLbK8a7j3BMA1K5uYz
        q0vsrp+cbp2cYfZ01m3LZ5ZM2Ms+2iOf2hvsyYhn95Dkh/ocQEJss=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 34956135C13;
        Mon, 19 Jul 2021 19:53:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6A92C135C11;
        Mon, 19 Jul 2021 19:53:24 -0400 (EDT)
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
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>
Subject: Re: [PATCH v4 2/9] ssh signing: add ssh signature format and
 signing using ssh keys
References: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
        <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
        <2c75adee8e1d6147c5be1b3b0832cc90d44ba6df.1626701596.git.gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 16:53:22 -0700
In-Reply-To: <2c75adee8e1d6147c5be1b3b0832cc90d44ba6df.1626701596.git.gitgitgadget@gmail.com>
        (Fabian Stelzer via GitGitGadget's message of "Mon, 19 Jul 2021
        13:33:09 +0000")
Message-ID: <xmqqpmvdj1xp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8152A10E-E8EC-11EB-A03C-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -65,6 +73,14 @@ static struct gpg_format gpg_format[] = {
>  		.verify_signed_buffer = verify_gpg_signed_buffer,
>  		.sign_buffer = sign_buffer_gpg,
>  	},
> +	{
> +		.name = "ssh",
> +		.program = "ssh-keygen",
> +		.verify_args = ssh_verify_args,
> +		.sigs = ssh_sigs,
> +		.verify_signed_buffer = NULL, /* TODO */
> +		.sign_buffer = sign_buffer_ssh
> +	},
>  };

A payload a malicious person may feed this version of Git can have a
pattern that happens to match the ssh_sigs[] string, and the code
will blindly try to call .verify_signed_buffer==NULL and die, no?

That is not the end of the world; as long as we know that with the
above "TODO" comment it is probably OK.

> @@ -463,12 +482,26 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
>  	return use_format->sign_buffer(buffer, signature, signing_key);
>  }
>  
> +static void strbuf_trim_trailing_cr(struct strbuf *buffer, int offset)
> +{

This removes any and all CR, not just trimming the trailing ones, so
the function is misnamed. Call it remove_cr_after() perhaps?

Alternatively we could tighten the implementation and strip only the
CR that come immediately before a LF.  That would be a better longer
term thing to do, but because you are lifting an existing code from
the end of the gpg side of the thing, it may make sense to keep the
implementation as-is, but give it a name that is more faithful to
what it actually does.  When the dust settles, we may want to
revisit and fix this helper function to actually trim CRLF into LF
(and leave CR in the middle of lines intact), but I do not think it
is urgent.  Just leaving "NEEDSWORK: make it trim only CRs before LFs
and rename" comment would be OK.

Shouldn't the offset (aka bottom) be of type size_t?

I do not recommend giving the function a name that begins with
"strbuf_", as it would tempt unthinking person to suggest moving it
to strbuf.c, but the presense of the "offset" thing means it will be
klunky to reuse in other more generic contexts as a part of the
strbuf API.

> +	size_t i, j;
> +
> +	for (i = j = offset; i < buffer->len; i++) {
> +		if (buffer->buf[i] != '\r') {
> ...

Now it gets interesting ;-)

> +static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
> +			   const char *signing_key)
> +{
> +	struct child_process signer = CHILD_PROCESS_INIT;
> +	int ret = -1;
> +	size_t bottom;
> +	struct strbuf signer_stderr = STRBUF_INIT;
> +	struct tempfile *temp = NULL, *buffer_file = NULL;
> +	char *ssh_signing_key_file = NULL;
> +	struct strbuf ssh_signature_filename = STRBUF_INIT;
> +
> +	if (!signing_key || signing_key[0] == '\0')
> +		return error(
> +			_("user.signingkey needs to be set for ssh signing"));
> +
> +	if (istarts_with(signing_key, "ssh-")) {

Is it common in the ssh world to treat ssh- prefix as case
insensitive?  Not a strong objection but I tend to prefer to start
strict unless there is a good reason to be loose when we do not have
to, as loosening after the fact is much easier than tightening after
starting with a loose definition.

> +		/* A literal ssh key */
> +		temp = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
> +		if (!temp)
> +			return error_errno(
> +				_("could not create temporary file"));
> +		if (write_in_full(temp->fd, signing_key, strlen(signing_key)) <
> +			    0 ||

"keylen = strlen(signing_key)" before that line, for example, could
have easily avoided the line-wrapping at such a place.  Wrapping at
places like after ||, i.e. after an operator with a low precedence,
would make the code easier to follow.

> +		    close_tempfile_gently(temp) < 0) {
> +			error_errno(_("failed writing ssh signing key to '%s'"),
> +				    temp->filename.buf);
> +			goto out;
> +		}
> +		ssh_signing_key_file = temp->filename.buf;

It is kind'a sad that we need a fresh temporary file every time, but
we can easily tell the user in the documentation that they can use a
file with a key in it to avoid it, so it's OK (actually, better than
OK, as without this, we may not consume temporary files but we won't
offer an ability to take a literal key string).

Is ".git_whatever file in the current directory" a good place to
have this temporary file?  I would have expected that we would use
either $GIT_DIR, $HOME, or $TMPDIR for a thing like this (with
different pros-and-cons discussion).  At least it is consistent with
how a temporary file for the payload to be sign-verified is created,
so let's leave it as-is.

> +	} else {
> +		/* We assume a file */
> +		ssh_signing_key_file = expand_user_path(signing_key, 1);
> +	}
> +
> +	buffer_file = mks_tempfile_t(".git_signing_buffer_tmpXXXXXX");
> +	if (!buffer_file) {
> +		error_errno(_("could not create temporary file"));
> +		goto out;
> +	}
> +
> +	if (write_in_full(buffer_file->fd, buffer->buf, buffer->len) < 0 ||
> +	    close_tempfile_gently(buffer_file) < 0) {
> +		error_errno(_("failed writing ssh signing key buffer to '%s'"),
> +			    buffer_file->filename.buf);
> +		goto out;
> +	}
> +
> +	strvec_pushl(&signer.args, use_format->program, "-Y", "sign", "-n",
> +		     "git", "-f", ssh_signing_key_file,

Wrap the line before "-n" to keep "-n" and "git" together, if "git"
is meant as an argument to the "-n" option.

> +		     buffer_file->filename.buf, NULL);
> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +	ret = pipe_command(&signer, NULL, 0, NULL, 0, &signer_stderr, 0);
> +	sigchain_pop(SIGPIPE);
> +
> +	if (ret && strstr(signer_stderr.buf, "usage:")) {
> +		error(_("ssh-keygen -Y sign is needed for ssh signing (available in openssh version 8.2p1+)"));
> +		goto out;

This error message is important to give to the end users, but is it
enough?  That is, unless "usage:" does not appear, we show the whole
raw error message and that would help end users and those helping
them to diagnose the issue, but once the underlying program says
"usage:", no matter what else it says, it is hidden by this code,
since we assume it is a wrong version of openssh.

> +	}
> +
> +	if (ret) {
> +		error("%s", signer_stderr.buf);
> +		goto out;
> +	}

Also, prehaps

	if (ret) {
		if (strstr(..., "usage"))
			error(_("ssh-keygen -Y sign is needed..."));
		else
                        error("%s", signer_stderr.buf);
		goto out;
	}

would be easier to follow.

> +	bottom = signature->len;
> +
> +	strbuf_addbuf(&ssh_signature_filename, &buffer_file->filename);
> +	strbuf_addstr(&ssh_signature_filename, ".sig");
> +	if (strbuf_read_file(signature, ssh_signature_filename.buf, 2048) < 0) {

Is it likely that signature file is smaller than 2kB?  I am just
wondering how much we care to pick the default that is specific to
this codepath vs passing 0 to ask the strbuf API to use whatever
default it wants to.

> +		error_errno(
> +			_("failed reading ssh signing data buffer from '%s'"),
> +			ssh_signature_filename.buf);
> +	}
> +	unlink_or_warn(ssh_signature_filename.buf);

Wait a bit.  Even when pipe_command() tells us that we failed, we
read from ssh_signature_filename anyway?  What is going on?  And ...

> +	if (ret) {

... does this ever trigger?  I thought we would have hit one of the
two "goto out" when ret signals an error by being non-zero earlier,
and since then nobody touched the variable so far.

> +		error(_("ssh failed to sign the data"));
> +		goto out;
> +	}
> +
> +	/* Strip CR from the line endings, in case we are on Windows. */
> +	strbuf_trim_trailing_cr(signature, bottom);
> +
> +out:
> +	if (temp)
> +		delete_tempfile(&temp);
> +	if (buffer_file)
> +		delete_tempfile(&buffer_file);

It is clear that the latter one was holding the contents of the
buffer to be signed, but reminding the readers what "temp" was about
would be a good move.  Perhaps renaming the variable to "key_file"
or something may help?

> +	strbuf_release(&signer_stderr);
> +	strbuf_release(&ssh_signature_filename);
> +	return ret;
> +}

Looking good, except for the "when does 'ret' get updated?
shouldn't we refrain from reading the resulting buffer when it is
set?" question.

Thanks for a pleasant read.

