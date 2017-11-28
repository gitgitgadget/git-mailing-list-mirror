Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B9EA20C11
	for <e@80x24.org>; Tue, 28 Nov 2017 04:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbdK1E3Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 23:29:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65089 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752088AbdK1E3P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 23:29:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2077BA6523;
        Mon, 27 Nov 2017 23:29:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6aAhplqeT5OaYDvj1nqC+YJsLrU=; b=OUscU5
        XvgsPYk4786NH9xIO5XBvJEbS0imsZpELdRdtdQXz46XrvELEd+vUx8atLbg4yHr
        FBBmHtYX/lro6CictlIhQlv/lDorX83xkS69sAh9VBnoBaDlwGB8Un3CRlBNOzRo
        9ewihdmSL1zf47yOeC1IwoJG6yS6jCkpPhYqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WX2xSdEgwfgUOniZL1xosSB/KmA3OsoZ
        6KibP7T6tJEoujv4Gnl20zG5g/VljUtcWpGH0HDSKWheFD3DsxUQZcsnBVfth193
        XhRBq4OI8yvNa5MDnhiFBTbG7vyTZp+WY2kxK7SQIre7IsjSH46B40h6YjpRC5zq
        MZHOHJEi3fA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17F6FA6522;
        Mon, 27 Nov 2017 23:29:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 747A7A651F;
        Mon, 27 Nov 2017 23:29:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        lars.schneider@autodesk.com, git@vger.kernel.org,
        sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3] launch_editor(): indicate that Git waits for user input
References: <20171127134716.69471-1-lars.schneider@autodesk.com>
        <20171127200932.GA558049@genre.crustytoothpaste.net>
        <20171127230520.GA29636@sigill.intra.peff.net>
Date:   Tue, 28 Nov 2017 13:29:13 +0900
In-Reply-To: <20171127230520.GA29636@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 27 Nov 2017 18:05:20 -0500")
Message-ID: <xmqqpo836n6u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B08C9FE4-D3F4-11E7-B1B9-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... "if we need advice.*, that is a good sign that the
> feature is mis-designed".
>
> Let me elaborate a bit on the latter.
>
> My gut feeling is that this is absolutely the wrong place to put a
> message like this....
> The right place for this message, IMHO, is for the editor itself (or a
> wrapper script) to say "hey, I'm opening a new window" (like emacsclient
> does).

Yes, I think we already had that discussion and if you recall those
involved in the thread except Lars were in favor of writing this off
as "here is a nickel--get a better editor".

One thing that may sway you slightly in favor of doing this in Git
is that a new user _might_ not be expecting Git to open an editor in
response to the command s/he just gave it [*1*].

It is one thing that the user _knowingly_ runs an editor and fails
to locate which window the editor opened.  It is a bit different if
the user didn't even know that s/he is supposed to be interacting
with an editor.

> But I also recognize that the world isn't perfect. Not all editors will
> get this right, and not all users are savvy enough to set up a wrapper
> script for editors which don't. So defaulting this to "on" tries to help
> those cases.
>
> If the anti-cruft techniques I mentioned above work well in practice,
> then we get to have our cake and eat it, too. If they don't, then I'm
> not sure if the tradeoff is worth it.

I agree with all of the above; I do not know if the "go back and
erase to the end of the line" is good enough in practice, and that
is why I sent "here is a possible anti-cruft" but did not push it
strongly forward myself.


[Footnote]

*1* "git merge topic" used to just complete the merge with canned
    log message and people were not all that unhappy--they just
    thought it is an OK design that a clean merge is a
    non-interactive operation.  Perhaps a person new to Git may be
    expecting that behaviour (without knowing anything like (1) that
    was what we used to do or (2) we open an editor by default these
    days), wondering why nothing seems to be happening, staring at
    an inactive window, after typing "git merge topic".
