Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC9CC4743C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 19:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB4461028
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 19:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhFDTxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 15:53:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60788 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhFDTxX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 15:53:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3D77137873;
        Fri,  4 Jun 2021 15:51:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=grW7mEmTYi/iEJb+z0/Bd+lh5nxJIRpkZ2rF1a
        9zBZc=; b=EVtEjqI0y1jvdwvXjvzH5yHcA2w1P3DzTqAbPR+uHu9GXPt+VBnLDe
        EP5VAoll7x0UUl4wfzJaEnq3IreAmSxcdsr5b3EQsDDc5GT4iUdE29n/mrFbCQiO
        eG6EqTwnCLy+9zpa+nqUlxiuA15xjvRzndQy2214EoetQiCjdlE1Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B404137872;
        Fri,  4 Jun 2021 15:51:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D94AE13786E;
        Fri,  4 Jun 2021 15:51:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Git Mailing List'" <git@vger.kernel.org>
Subject: Re: [Patch 1/3] connect.c: add nonstopssh variant to the sshVariant
 set.
References: <011f01d73dd0$ecf91e00$c6eb5a00$@nexbridge.com>
        <CABPp-BH6RgiMwGLz31nHmis3VTpuEUG--G_6Y+Wfwg24u4Zbag@mail.gmail.com>
        <012601d73ddf$3d0cf660$b726e320$@nexbridge.com>
        <CABPp-BE_5c1vXuxPWTO82cGmyajXxpxW+-ycZ+-5vy+tsV3bUA@mail.gmail.com>
        <012901d73de6$c25a4ff0$470eefd0$@nexbridge.com>
        <01dd01d745b0$875c6920$96153b60$@nexbridge.com>
        <00f101d75978$0074c840$015e58c0$@nexbridge.com>
Date:   Sat, 05 Jun 2021 04:51:31 +0900
In-Reply-To: <00f101d75978$0074c840$015e58c0$@nexbridge.com> (Randall
        S. Becker's message of "Fri, 4 Jun 2021 15:29:51 -0400")
Message-ID: <xmqqo8cl1k8s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43C5355A-C56E-11EB-9686-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> The primary
> problem is supplying -S $ZSSH0 on the command line causes $ZSSH0
> to be resolved as a shell variable. It is not.

I think we've heard that one before, and the whole thing sounds like
you are saying that a command line

    $ cmd $ZSSH0

expects ZSSH0 to be a variable and tries to interpolate its value
before passing it to "cmd" while you want "cmd" to see a literal
string that begins with a dollar sign.

And the standard solution to that problem obviously is to tell the
shell that the dollar-sign is not a reference to a variable by
quoting, by using any variant of e.g.

    $ cmd \$ZSSH0
    $ cmd '$ZSSH0'
    $ cmd "\$ZSSH0"

As far as I can tell, the code in connect.c that spawns ssh via
GIT_SSH_COMMAND uses the pretty vanilla run_command() interface,
and that ought to be capable of producing such a command line, so I
am lost as to where the need to have special case comes from.

"cmd" here may be "ssh" but run_command() should not care what exact
command is being invoked.  I am puzzled why a simple quoting like
the following cannot be adjusted for this particular case, for
example:

    $ cat >>.git/config <<\EOF
    [alias]
	cmdtest0 = "!echo ..\\$ZSSH0.."
	cmdtest1 = "!echo ..$ZSSH0.."
    EOF
    $ ZSSH0=foo git cmdtest0
    ..$ZSSH0..
    $ ZSSH0=foo git cmdtest1
    ..foo..

