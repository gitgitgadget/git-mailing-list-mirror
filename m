Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192A9C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 04:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E617C610EA
	for <git@archiver.kernel.org>; Fri, 14 May 2021 04:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhENE0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 00:26:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56377 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhENE0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 00:26:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB55F120977;
        Fri, 14 May 2021 00:25:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GB+4Zk8Pmy0IlBwnUMmRutBYp+W29XEmx9uCpp
        HzmQs=; b=eaCG3ANNWIsCmCdECOCrGDIG7TaUKZgbYa44XdtJny+M5B6gPOwekW
        Gx2QXZNhnKhcD3czTz2h09xV8SA0gFdyfIkBxCu95sa4hRK8FgsPXbeTS8dgyX+4
        Bk9pyMQUWPhpDBIZIkBi5K6KyA3ibwrZ/mCduPhA5auIhFgLNtA4o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B7CEC120976;
        Fri, 14 May 2021 00:25:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E6E11120974;
        Fri, 14 May 2021 00:25:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gregory Anders <greg@gpanders.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] git-send-email: add option to specify sendmail command
References: <20210513023212.72221-1-greg@gpanders.com>
        <20210513152329.22578-1-greg@gpanders.com>
Date:   Fri, 14 May 2021 13:25:09 +0900
In-Reply-To: <20210513152329.22578-1-greg@gpanders.com> (Gregory Anders's
        message of "Thu, 13 May 2021 09:23:29 -0600")
Message-ID: <xmqq7dk27xi2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F14D418-B46C-11EB-BEA0-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gregory Anders <greg@gpanders.com> writes:

> Use a block scoped variable to print the sendmail invocation at the end 
> of the 'send_message' subroutine. Assigning directly to $sendmail_cmd 
> (as in the v2 patch) causes some bizarre problems; namely, it seems to 
> affect the value of $sendmail_cmd that is read at earlier points in the 
> same subroutine, which causes test invocations of the form
>
>     git send-email --smtp-server="$(pwd)/fake.sendmail"
>
> to fail. The value passed to --smtp-server was assigned to $sendmail_cmd 
> at the end of the 'send_message' subprocedure, but somehow this caused 
> the 'if (defined $sendmail_cmd)' condition earlier in the subproc to 
> evaluate to true.

Are you talking about the use of $sm that is local to the debug
output?  I think leaving $sendmail_cmd intact by using a separate
variable is the right choice.  Isn't the problem you observed a
consequence of send_message() getting called once for each message,
so assigning to $sendmail_cmd in the function for the first
invocation of the function would change its value for the second
invocation?

Also, if we have been using

	--smtp-server=$(pwd)/fake.sendmail

we cannot expect to use the same value like this:

	--sendmail-cmd=$(pwd)/fake.sendmail

because we deliberately add a space in the $(pwd) by choosing the
name of the test directory to be "trash directory.something".  We'd
need to do something like

	--sendmail-cmd='$(pwd)/fake.sendmail'

so that the shell sees '$(pwd)/fake.sendmail' literally and runs pwd
to find out what the path to the program is, I would think.

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 65b3035371..583fbba410 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -2148,6 +2148,37 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
>  	test_cmp expected-list actual-list
>  '
>  
> +test_expect_success $PREREQ 'test using command name with --sendmail-cmd' '
> +	clean_fake_sendmail &&
> +	PATH="$(pwd):$PATH" \
> +	git send-email \
> +		--from="Example <nobody@example.com>" \
> +		--to=nobody@example.com \
> +		--sendmail-cmd="fake.sendmail" \
> +		HEAD^ &&
> +	test_path_is_file commandline1
> +'

Nice demonstration of the "we no longer need an absolute pathname"
feature.

> +test_expect_success $PREREQ 'test using arguments with --sendmail-cmd' '
> +	clean_fake_sendmail &&
> +	git send-email \
> +		--from="Example <nobody@example.com>" \
> +		--to=nobody@example.com \
> +		--sendmail-cmd="\"$(pwd)/fake.sendmail\" -f nobody@example.com" \
> +		HEAD^ &&
> +	test_path_is_file commandline1
> +'

Hmph, if $(pwd) has a double quote character in it, this may not
work as expected, as the shell that is expanding the command line
arguments for "git send-email" would see $(pwd), expand it and our
program will see

    "/path/with/d"quote/git/t/trash directory.9001/fake.sendmail" -f nobody@e.c

as the value of --sendmail-cmd, which would not interpolate well,
no?

We want the shell that eats the command line of 'git send-email' to see

	--sendmail-cmd='$(pwd)/fake.sendmail'\" -f nobody@example.com"

and because this is inside a sq pair, it would become

	--sendmail-cmd='\''$(pwd)/fake.sendmail'\''\" -f nobody@example.com"

after we replace each sq with '\'', or something like that, perhaps?

> +test_expect_success $PREREQ 'test shell expression with --sendmail-cmd' '
> +	clean_fake_sendmail &&
> +	git send-email \
> +		--from="Example <nobody@example.com>" \
> +		--to=nobody@example.com \
> +		--sendmail-cmd="f() { \"$(pwd)/fake.sendmail\" \"\$@\"; };f" \
> +		HEAD^ &&
> +	test_path_is_file commandline1
> +'

Nice demonstration of how a bit of scripting can be used.

>  test_expect_success $PREREQ 'invoke hook' '
>  	mkdir -p .git/hooks &&

Thanks.
