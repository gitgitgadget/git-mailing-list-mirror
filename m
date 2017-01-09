Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BA33205C9
	for <e@80x24.org>; Mon,  9 Jan 2017 01:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967057AbdAIBI2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 20:08:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54893 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965380AbdAIBI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 20:08:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D5505E572;
        Sun,  8 Jan 2017 20:08:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qgw0wIZBKb6kJ2dU3rtTvIEOHsU=; b=liiWMx
        ULdQ2TlZsbMNQJethZgXwz4jQ0CAo4gGB3TG+zpxCzaFyK8NijRQ1nYPs0EuOUrZ
        k7Cr9lU48bjA7hw87z9Qjt/HSx21xeHSiqPdjcMdcNgjamF4Aurf8Fb5hogyr8m+
        uETkGD3hQ+eVejWNHMqJ1cUThzCWU9ebscN8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pNXnmebkQ/VuvnkILXcfz5cUsAideB5n
        tXjwtSFrv9xdMtrRfx5tl8xTtwjSzyVlzIHk91scxglcFraMtvgz5hQKxdYqiQ+t
        lK84F2fDMXqWhIxKplx2b/rraJsPCg91rWhDP7467oM+7yWB/vB+w8JnDrzNWtaj
        oD7WlMZ/8Es=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23BB65E571;
        Sun,  8 Jan 2017 20:08:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8D22D5E570;
        Sun,  8 Jan 2017 20:08:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH] connect: handle putty/plink also in GIT_SSH_COMMAND
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de>
        <xmqqy3ym1dsc.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 08 Jan 2017 17:08:24 -0800
In-Reply-To: <xmqqy3ym1dsc.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sat, 07 Jan 2017 18:33:23 -0800")
Message-ID: <xmqq4m1911mf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F60F35C-D608-11E6-A96D-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I suspect that this will break when GIT_SSH_COMMAND, which is meant
> to be processed by the shell, hence the user can write anything,
> begins with a one-shot environment variable assignment, e.g.
>
> 	[core] sshcommand = VAR1=VAL1 VAR2=VAL2 //path/to/tortoiseplink
>
> One possible unintended side effect of this patch is when VAL1 ends
> with /plink (or /tortoiseplink) and the command is not either of
> these, in which case the "tortoiseplink" and "putty" variables will
> tweak the command line for an SSH implementation that does not want
> such a tweak to be made.  There may be other unintended fallouts.

Thinking about this further, as the sshcommand (or GIT_SSH_COMMAND)
interface takes any shell-interpretable commands, the first "token"
you see is not limited to a one-shot environment assignment.  It
could even be "cmd1 && cmd2 && ..." or even:

	if test -f ${TPLINK:=//path/to/tortoiseplink}
	then
		exec "$TPLINK" "$@"
	elif test -f ${PLINK:=//path/to/plink}
		exec "$PLINK" "$@"
	else
		echo >&2 no usable ssh on this host
	fi

Worse, the above may be in "myssh" script found on user's PATH and
then core.sshcommand may be set to

	TPLINK=//my/path/to/tortoiseplink PLINK=//my/path/to/plink myssh

in the configuration the user uses on multiple hosts, some have
tortoiseplink installed and some do not.  The idea the user who set
it up may be to use whatever available depending on the host.

The posted patch would be confused that we are using tortoiseplink
but the "myssh" script would correctly notice that on a particular
host it is unavailable and choose to use plink instead.

> Sorry, no concrete suggestion to get this to work comes to my mind
> offhand. 
>
> Perhaps give an explicit way to force "tortoiseplink" and "putty"
> variables without looking at and guessing from the pathname, so that
> the solution does not have to split and peek the command line?

A user with such an elaborate set-up with multiple hosts with
different configurations would likely to want to say "Just give me a
regular SSH command line, and in my 'myssh' script I'll futz with
-p/-P differences and such, as I'm writing a small script to cope
with Tortoiseplink and Puttyplink anyway".  With a separate,
explicit configuration variable to tell Git what variant of SSH you
have, even such a user can be served (she would just set ssh.variant
to "vanilla" or whatever that is not "tortoiseplink" or "plink").



.

