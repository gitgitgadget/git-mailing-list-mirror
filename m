Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF635C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 04:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F00A6162A
	for <git@archiver.kernel.org>; Wed, 12 May 2021 04:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhELEUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 00:20:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55307 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhELEUx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 00:20:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6723513F389;
        Wed, 12 May 2021 00:19:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WwyYRKNpqweTuKbMMKMtmniiijrfi/zLrdxmfL
        wmGzA=; b=Cz5jJXxpPcWAQrqPYUKxQhMPp5aGOwlCTDplYl/18XmJhDfb1R6Yk2
        xAt8dpYJoAxuVfhUL7lINvvgVQRVZIfsYHMCmDYvpNpYFCgts/FOA4P5X8Hr+y9Z
        K5+kExv2QpdRKJBAqZDgt+WKoPNEq5LV0L04pjBJX9sSQJ0VOTDTQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5FA2413F388;
        Wed, 12 May 2021 00:19:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9997A13F387;
        Wed, 12 May 2021 00:19:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gregory Anders <greg@gpanders.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-send-email: add sendmailCommand option
References: <20210512033039.4022-1-greg@gpanders.com>
Date:   Wed, 12 May 2021 13:19:41 +0900
In-Reply-To: <20210512033039.4022-1-greg@gpanders.com> (Gregory Anders's
        message of "Tue, 11 May 2021 21:30:40 -0600")
Message-ID: <xmqqh7j8h9cy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4728C1A0-B2D9-11EB-AAD3-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gregory Anders <greg@gpanders.com> writes:

> The sendemail.smtpServer option currently supports using a sendmail-like
> program to send emails by specifying an absolute file path. However,

That is not wrong per-se, but it is not limited to the configuration
variable, but is a shared trait with --smtp-server command line
option.  It is easier on the readers to mention both.

Our problem description talks about the status quo in the present
tense.  No noiseword "currently " necessary.  I.e. something along
this line:

    The sendemail.smtpServer configuration variable (and the
    "--smtp-server" command line option of "git send-email" command)
    allows to name a command to run to send emails by specifying an
    absolute path name.  However,

> this is not ideal for the following reasons:
>
> 1. It overloads the meaning of smtpServer (now a program is being used
>    for the server?)
> 2. It doesn't allow for non-absolute paths, arguments, or arbitrary
>    scripting.
>
> Requiring an absolute path is bad for portability, as the same
> program may be in different locations on different systems. If I wish
> to pass arguments to my program, I have to use the smtpServerOption
> option, which is cumbersome (as it must be repeated for each option)
> and doesn't adhere to normal git conventions.

Up to here, nice explanation of the background and description of
the problem being solved.

> This patch attempts to solve these problems by introducing a new
> configuration option sendemail.sendmailCommand as well as a command line
> option --sendmail-cmd. The value of this option is invoked with the
> standard sendmail options passed as arguments.

When presenting a potential solution, in the history of this
project, we'd talk as if we are giving an order to the codebase to
"be like so".

    Introduce a command line option '--sendmail-cmd' and a
    configuration variable sendemail.sendmailCommand that can be
    used to specify the command line (possibly including its command
    line options) to send pieces of e-mail.  This is invoked while
    honoring $PATH, so it does not have to be named with an absolute
    path to the command.

    Give it a higher precedence over --smtp-server (and
    sendemail.smtpServer), as the new interface is more flexible.

> sendmailCommand has precedence over smtpServer. If both options are
> unspecified, the default is to search for 'sendmail' in /usr/sbin,
> /usr/lib, and $PATH. If not found, smtpServer is set to localhost. This
> mimics the current behavior when smtpServer is unspecified.

I do not think "If both options are unspecified" and everything
after it is needed.

> The option is passed to Perl's `exec()` function, which automatically
> determines whether or not to invoke a shell. If shell metacharacters are
> detected, then a shell is used; otherwise, the command is invoked
> directly.

I do not think this, and the two examples below (omitted), are
relevant, either.

The "metacharacters make the command diverted to shell" is a mere
optimization and not of interest to the end users.  Even if
sendemail.sendmailcommand is set to just a single word 'msmtp',
which does not have any metacharacter, we _could_ spawn it via the
shell and the observable end result would be the same as if the
single word was directly executed without the shell.

> This change deprecates the use of absolute paths in 
> sendemail.smtpServer, although support is kept for backward
> compatibility.

I am on the fence about saying this.  We may eventually want to
deprecate, but until we start issuing a warning when the
absolute-path form is used, I'd rather not to call it "deprecated"
in either the proposed log message or in the documenation.

> ---

Missing sign-off.

>
> Note that this patch is incompatible with (and supersedes) the patch
> discussed here: 
>
>     https://public-inbox.org/git/YJs2RceLliGHI5TX@gpanders.com/T/#t

Thanks---such a note is very valuable.

> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 93708aefea..d9fe8cb7c0 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -159,13 +159,23 @@ Sending
>  ~~~~~~~
>  
>  --envelope-sender=<address>::
> -	Specify the envelope sender used to send the emails.
> -	This is useful if your default address is not the address that is
> -	subscribed to a list. In order to use the 'From' address, set the
> -	value to "auto". If you use the sendmail binary, you must have
> -	suitable privileges for the -f parameter.  Default is the value of the
> -	`sendemail.envelopeSender` configuration variable; if that is
> -	unspecified, choosing the envelope sender is left to your MTA.
> +	Specify the envelope sender used to send the emails.  This is
> +	useful if your default address is not the address that is
> +	subscribed to a list. In order to use the 'From' address, set
> +	the value to "auto". If you use the sendmail binary, you must
> +	have suitable privileges for the -f parameter.  Default is the
> +	value of the `sendemail.envelopeSender` configuration variable;
> +	if that is unspecified, choosing the envelope sender is left to
> +	your MTA.

Is this a totally unwarranted rewrapping of an unrelated part of the
same document, or was there some words or phrases in this
description of the envelope-sender option that needed to be adjusted
for the introduction of sendmail-cmd option?

> +--sendmail-cmd=<command>::
> +	Specify a command to run to send the email. The command should
> +	be compatible with `sendmail` as the arguments are passed
> +	directly.  The command will be executed in the shell if
> +	necessary.  Default is the value of `sendemail.sendmailCommand`.
> +	If unspecified, and if --smtp-server is also unspecified,
> +	git-send-email will search for `sendmail` in `/usr/sbin`,
> +	`/usr/lib` and $PATH if such a program is available.

OK, but doesn't this also need to support '-i'?

> @@ -211,13 +221,14 @@ a password is obtained using 'git-credential'.
>  
>  --smtp-server=<host>::
>  	If set, specifies the outgoing SMTP server to use (e.g.
> -	`smtp.example.com` or a raw IP address).  Alternatively it can
> -	specify a full pathname of a sendmail-like program instead;
> -	the program must support the `-i` option.  Default value can
> -	be specified by the `sendemail.smtpServer` configuration
> -	option; the built-in default is to search for `sendmail` in
> -	`/usr/sbin`, `/usr/lib` and $PATH if such program is
> -	available, falling back to `localhost` otherwise.
> +	`smtp.example.com` or a raw IP address).  If unspecified, and if
> +	`--sendmail-cmd` is also unspecified, the default is to search
> +	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH if such a
> +	program is available, falling back to `localhost` otherwise.
> +
> +	For backward compatibility, this option can also specify a full
> +	pathname of a sendmail-like program instead; the program must
> +	support the `-i` option.  Prefer using `--sendmail-cmd` instead.

Drop the last sentence, if we are not going to explain why.  Or
perhaps:

	... an absolute path to a program that behaves like
	`sendmail` (among other things, it must support the `-i`
	option).  As you only can specify the path to the program
	and cannot give any leading arguments to it, consider using
	`--sendmail-cmd` instead.

> @@ -1490,14 +1497,15 @@ sub send_message {
>  
>  	unshift (@sendmail_parameters, @smtp_server_options);
>  
> +	if (file_name_is_absolute($smtp_server)) {
> +		# Preserved for backward compatibility
> +		$sendmail_command ||= $smtp_server;
> +	}

Hmph, I wonder if this makes the intent more clear.

	if (!defined $sendmail_command && file_name_is_absolute($smtp_server)) {
		$sendmail_command = $smtp_server;
	}

That is, if the user gave us the command in newer form, we do not
even have to bother checking if the server is given as an absolute
pathname.

> @@ -1069,7 +1069,7 @@ test_expect_success $PREREQ 'utf8 Cc is rfc2047 encoded' '
>  	git send-email \
>  	--from="Example <nobody@example.com>" \
>  	--to=nobody@example.com \
> -	--smtp-server="$(pwd)/fake.sendmail" \
> +	--sendmail-cmd="\"$(pwd)/fake.sendmail\"" \
>  	outdir/*.patch &&
>  	grep "^	" msgtxt1 |
>  	grep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"

You seem to have replaced every smtp-server="$(pwd)/ mechanically
with sendmai-cmd=\"$(pwd)/, but please make sure that we have at
least one test left that passes an absolute path to --smtp-server to
ensure that the old mechanism keeps working.  A bonus point for
marking such a test that needs to be adjusted when the actual
deprecation happens (i.e. we'd likely to detect the use of absolute
path and throw a warning, so the test should notice the warning
message).

Also you would want to tweak some of the --sendmail-cmd variants to
use just the command name, with and without args, to ensure that (1)
discovery on $PATH works, and (2) passing initial args works.

Thanks.
