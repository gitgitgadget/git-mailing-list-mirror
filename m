Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB50C83F37
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 20:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347469AbjHaU5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 16:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbjHaU52 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 16:57:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8B5CFE
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 13:57:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 823C621A24;
        Thu, 31 Aug 2023 16:57:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=X1/qNJMxNSmAu0VZOcXkCDewYdwnguFfACLMQm
        znBaM=; b=mJX9MTN9ZM0cvjWc3sAZEQoMpO+30vEGUDCM+Aq/LH8NHs6R1JuGcA
        UYdb0EKwoTjwwmBFLmXzJD5a7hJOwbNzxcYDwvpP2L7xVkka5tYPatYo+VMb8J12
        pV1aOP7waNZmfyiF8ia8Dq5j37xGqOqg7H3yA7J8i53khTxOZjl6Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6952F21A23;
        Thu, 31 Aug 2023 16:57:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 90A3C21A21;
        Thu, 31 Aug 2023 16:57:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wesley Schwengle <wesleys@opperschaap.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] builtin/rebase.c: Emit warning when rebasing
 without a forkpoint
In-Reply-To: <20230819203528.562156-2-wesleys@opperschaap.net> (Wesley
        Schwengle's message of "Sat, 19 Aug 2023 16:34:49 -0400")
References: <20230819203528.562156-1-wesleys@opperschaap.net>
        <20230819203528.562156-2-wesleys@opperschaap.net>
Date:   Thu, 31 Aug 2023 13:57:13 -0700
Message-ID: <xmqqbkenszfa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F684DE46-4840-11EE-8392-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wesley Schwengle <wesleys@opperschaap.net> writes:

> The behaviour of `git rebase' was that if you supply an upstream on the
> command line that it behaves as if `--no-forkpoint' was supplied and if
> you don't supply an upstream, it behaves as if `--forkpoint' was
> supplied.

I actually think it is a reasonable, if a bit too clever (for my
taste at least), default for those who do not want to type the
"--fork-point" option from the command line and still want to use
that option when they are pulling from or rebasing on the source
they usually interact with, while still allowing them to be precise
when they do want to specify exactly what commit they want to base
it on.

And the way how you tell if they are using the "usual" source is to
see if they used the lazy "git rebase" (without arguments) form.  So
I do not think it is particularly a bad design to allow "git rebase
master" and "git rebase" to behave differently.  The latter may use
the "fork point computed using 'master' branch" (when the current
branch is configured to rebuild on top of 'master') while the former
may use "exactly the commit pointed at by the 'master' branch".

> This can result in a loss of commits if you don't know that
> and if you don't know about `git reflog' or have other copies of your
> changes.

Surely, but you would lose commits if you don't know these things
and explicitly gave the --fork-point option the same way.  So I am
not sure if switching of the default is warranted.

> -			if (options.fork_point < 0)
> +			if (options.fork_point < 0) {
> +				warning(_(
> +					"Rebasing without specifying a forkpoint is discouraged. You can squelch\n"
> +					"this message by running one of the following commands something before your\n"
> +					"next rebase:\n"
> +					"\n"
> +					"  git config rebase.forkpoint = false # This will become the new default\n"
> +					"  git config rebase.forkpoint = true  # This is the old default\n"
> +					"\n"

The message "Rebasing without specifying a forkpoint" reads as if
you are encouraging the use of forkpoint mode (which you are not, I
know), but then what the message advertises as a future default
stops not make sense.  "If we hate the forkpoint mode so much to
disable it by default, why so we discourage running the command
without specifying it?" would be the confused message the users will
read from it.

Your "git config" example command lines are not correct, are they?
There should be no '=' assignment operator.

I am also afraid that this is giving a way too broad an advice.

What you want to discourage is to rebase without specifying what to
rebase on and without saying if you want or you do not want the
forkpoint behaviour, which will opt the user into the more dangerous
forkpoint behaviour.  The above makes it sound as if we will
discourage even the more precise "git rebase <newbase>" form, but I
do not think it is the case.  We would and should not trigger the
folk-point behaviour if there is an explicit <upstream> and the user
does not say "--fork-point" from the command line.

Here is my attempt to rewrite the above:

    When 'git rebase' is run without specifying <upstream> on the
    command line, the current default is to use the fork-point
    heuristics, but this is expected to change in a future version
    of Git, and you will have to explicitly give "--fork-point" from
    the command line if you keep using the fork-point mode.  You can
    run "git config rebase.forkpoint false" to adopt the new default
    in advance and that will also squelch the message.

Note that the parsing of "rebase.forkpoint" is a bit peculiar in
that 

 - By leaving it unspecified, the .fork_point = -1 in
   REBASE_OPTIONS_INIT takes effect (which is unsurprising);

 - By setting it to false, .fork_point becomes 0; but

 - If you set the configuration variable to true, .fork_point
   becomes -1, not 1.

And this is very much deliberate if I understand it correctly [*1*].
By the time we get to this part of the code (i.e. .fork_point is
-1), the user may already have rebase.forkpoint set to true.  IOW,
setting it to 'true' is not a valid way to squelch this message.

I am not commenting on the tests, as the above code probably needs
to be corrected first so that folks who want to squelch the message
and want the "forkpoint behaviour by default when rebuilding on the
usual upstream" behaviour can do so by setting the variable to true.

And that obviously need to be tested, too.

Thanks.


[References]

*1* https://lore.kernel.org/git/xmqqturbdxi2.fsf@gitster.c.googlers.com/
