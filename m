Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7ABC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 19:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613C920836
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 19:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="brz6c8c+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfLKTVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:21:43 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65372 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfLKTVn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 14:21:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 489E393D6E;
        Wed, 11 Dec 2019 14:21:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+O79fwHQPz/oCG3arFsJuZO2lOw=; b=brz6c8
        c+gZpAfh/w4EZi1ZiWlFvLW9LwRhMGZFWjveGztfvls4fHax2awPr/iGvLAyrYf3
        1mv9pmhcHoc9s51b4lEFnW3CEn4Z7JOsCKFjcU1pLM67GTsPfueEkkqsk0P+GeaS
        Vt/OLjpCWjmsP6mduPY8kpTcdLhMbtiz9O1FQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gRhCiULXjJ6gD87PCPXlSkfLKQu0BCuk
        uDVPoVy+BmolQZaEnO9MAw/6VkZ2v0tYjoRqliD1vRXRxxcUTuJW0wvdb5Q/U9AJ
        Yfe0T1/9vOCUXktOQMZcxxEr+QQZhs5T0frXlsKkWCrdWO5lPb4VoBkOjbQHbMGi
        A8Nd5CYCZtc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 40B3D93D6C;
        Wed, 11 Dec 2019 14:21:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 614F793D6A;
        Wed, 11 Dec 2019 14:21:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] hook: support reordering of hook list
References: <20191210023335.49987-1-emilyshaffer@google.com>
        <20191210023335.49987-5-emilyshaffer@google.com>
Date:   Wed, 11 Dec 2019 11:21:36 -0800
In-Reply-To: <20191210023335.49987-5-emilyshaffer@google.com> (Emily Shaffer's
        message of "Mon, 9 Dec 2019 18:33:33 -0800")
Message-ID: <xmqqlfrioegv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7418F58E-1C4B-11EA-B62A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>   $ grep -A2 "\[hook\]" ~/.gitconfig
>   [hook]
>           pre-commit = 001:~/test.sh
>           pre-commit = 999:~/baz.sh
>   $ grep -A2 "\[hook\]" ~/git/.git/config
>   [hook]
>           pre-commit = 900:~/bar.sh
>           pre-commit = 050:~/baz.sh
>   $ ./bin-wrappers/git hook --list pre-commit
>   001     global  ~/test.sh
>   050     repo    ~/baz.sh
>   900     repo    ~/bar.sh
>
> In the above example, '~/baz.sh' is provided in the global config with
> order position 999. Then, in the local config, that order is overridden
> to 050. Instead of running ~/baz.sh twice (at order 050 and at order
> 999), only run it once, in the position specified last in config order.

Doesn't that depend on the nature of the hook?  A hook that is
general enough to be used to inspect if another hook's effect is
sane and reject the result may want to be run after invocation of
each hook that is not itself, so I would prefer to avoid a design
that forbids the same command to be specified twice.

I would love it if it were possible without the precedence order and
instead the order of appearance in git_config() stream were usable
to decide the order these hooks are executed.  Unfortunately, there
is a fixed order that the configuration files are read, and I do not
see a way short of adding <number>: prefix like this design does to
ensure that a hook defined in the local config can run before or
after a hook defined in the global config, so <number>: in the above
design is probably a necessary evil X-<.

Having said that, I have a suspicion that the config file itself
should be kept simple---if a hook appears twice with different
numbers, they would be run twice, for example---and the tooling
around it (e.g. "git hook add/edit/replace/reorder") should
implement such a policy (e.g. "the same hook can run only once, so
remove the other entries when adding the same") if desired.

Which would mean that overriding/disabling an entry in the same
configuration file should be done by replacing or removing the
entry.  Adding another entry for the same command with different
precedence should mean the command would run twice.

And you would need a notation to override or disable an entry in a
different configuration file (e.g. global tells us to run foo.sh at
level 50 with "hook.pre-commit=50:foo.sh"; repository wants to say
not to run it at all, or run it at 80 instead).  I would think you'd
just need a notation to kill an existing entry (e.g. the local one
adds "hook.pre-commit=-50:foo.sh" to countermand the entry in the
earlier example, and then can add another one at level 80 if it
desires).

I am also tempted to say that the precedence level may not stay to
be the only attribute for a <hookname, executable> pair wants to
keep.  Instead of

	[hook]
                pre-commit = 900:bar.sh

it may have to become more like

	[hook "pre-commit"]
		level = 900
		path = bar.sh

if we do not want to paint us into a corner from which we cannot get
out of.  I dunno.

Doesn't this require coordination between the three configuration
sources how numbers are assigned and used, by the way?  Between the
per-user and the per-repository config, they are set by the same
person anyway, so there is not much to coordinate, but I am not sure
what the expectations are to allow reading from the system-wide
configuration (or, should we just disable reading from the
system-wide configuration for, say, security reasons?)
