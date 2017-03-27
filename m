Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C049620969
	for <e@80x24.org>; Mon, 27 Mar 2017 05:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbdC0Fo1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 01:44:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57766 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751852AbdC0FoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 01:44:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE82371BC6;
        Mon, 27 Mar 2017 01:44:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GpgljbUUudjmnbKTaDBV2h+3o14=; b=gzVUpx
        qGb+ROwINa9JFqnAyWk3eNVFGI8StmTK4Kqqk1wEmmIIXqNixwG1Vj24O5NTsh96
        mcK3S6FxU2/ElvvVH2IZN0fCa2eXeW/A8Vi3ajoIyMQtVhi6t0sr1G7qjT0+VOQV
        9G3XR6UY3G0oJPVoen5z88Jg0HvOax8gtCOQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QctIC3eI95B465zjn3BZiGJXm9vWTfi3
        JvK4WYiUHWZpFiDQaqdBqtlC8w0ZHWlzL9JZwRjK+5w3zRtmcQkOeJa3HmSw7GgW
        9KczK1HeLe8e9Kmwc13cPqWjnRmT+nJE8CoRoPNeatAJmVXLs7Hug6JfoXC1wO4W
        SWpXQvJa61k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C665871BC5;
        Mon, 27 Mar 2017 01:44:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3BCEE71BC4;
        Mon, 27 Mar 2017 01:44:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     BongHo Lee <techcap@live.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: --no-commit option does not work.
References: <CY4PR14MB1238A8AC2BFECB56B9B68056CB300@CY4PR14MB1238.namprd14.prod.outlook.com>
        <CY4PR14MB1238D2E5D35E99405AA8BF61CB300@CY4PR14MB1238.namprd14.prod.outlook.com>
Date:   Sun, 26 Mar 2017 22:44:21 -0700
In-Reply-To: <CY4PR14MB1238D2E5D35E99405AA8BF61CB300@CY4PR14MB1238.namprd14.prod.outlook.com>
        (BongHo Lee's message of "Sun, 26 Mar 2017 23:57:07 +0000")
Message-ID: <xmqqfuhz2s0a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E52FFDE-12B0-11E7-B261-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

BongHo Lee <techcap@live.com> writes:

> If I add --no-ff option, it works properly.
> I think --no-commit option should be worked without --no-ff.

It is understandable that this is confusing, but --no-commit is an
instruction not to create a new commit object.  As fast-forwarding
to the commit that is a strict descendant of your old tip does not
involve creation of any new commit, the command is working exactly
as instructed.  If you say "--no-ff", you are explicitly forbidding
the command to fast-forward, so the command attempts to create a
(needless) new commit that is a merge, and then --no-commit stops
the command after it prepared the tree state ready to be committed.

So with or without --no-ff, the option and the command are working
correctly.

Having said all that, my gut feeling is that a backward incompatible
change to make --no-commit "imply" --no-ff may not hurt too many
existing users, but I am saying this without thinking things through.
I may very well be missing a valid use case where --no-commit that
does not fail but does fast-forward when the user does not give --no-ff
is useful, so if that is the case, such a change will be breaking
those users.

