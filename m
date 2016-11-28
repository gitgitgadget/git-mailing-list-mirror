Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1B9B1FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 17:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbcK1Rxz (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 12:53:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51473 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751033AbcK1Rxx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 12:53:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 992BA523A1;
        Mon, 28 Nov 2016 12:53:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VZeHV4U9yVnZ43A96I8Bpll/vpk=; b=wTAvOI
        t4C4aiTejK3DIqEwo7womnJmP58kVprDRGY2lG5ykKPuSj5YOqfgg4wbarD0Gr2Y
        2HegieLTnbCau2SbORC9BAHYxTc2vhcIU1PnqghnJMRUrQdP1empc9MzHU62UNih
        LmUl4sJkN5QH77fsTL3qn538Op3t8nf2i/EkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k3YdiE7VR4eqn2UnbnaG3iaoRduyoVsT
        AxBvNpubk3LjBRC8Edy+GHPBL7zFbeEIR/jOFQnFxxFGy36cHBGuwusTdPJNEivV
        /hF5W8kS+vdOmKH+c6t+9gHJPW+eM1u3sauNxPN1opdQjtnJ9Nb38TdvDPAcRbpo
        FKi5lG3eV4U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58DAF5239F;
        Mon, 28 Nov 2016 12:53:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B07455239C;
        Mon, 28 Nov 2016 12:52:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luis Ressel <aranea@aixah.de>
Cc:     git@vger.kernel.org
Subject: Re: [feature request] Make "commit --only" work with new files
References: <20161125175619.19e13e59@gentp.lnet>
Date:   Mon, 28 Nov 2016 09:52:58 -0800
In-Reply-To: <20161125175619.19e13e59@gentp.lnet> (Luis Ressel's message of
        "Fri, 25 Nov 2016 17:56:19 +0100")
Message-ID: <xmqqzikjjxtx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8038CAAA-B593-11E6-BBFF-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luis Ressel <aranea@aixah.de> writes:

> currently "git commit --only <file>" only works if <file> is already
> checked into the repo, but not with newly created and still untracked
> files (builtin/commit.c:list_path() throws the error "error: pathspec
> '<file>' did not match any file(s) known to git.")

The fact that pathspec on the command line of "commit" does not let
you add new files is true with or without "--only".  Yes, "--only"
is the default so with or without it it means the same thing, but
even with "--include" that says "I am happy with what is in the
index, but please take further changes to these paths, too" does not
affect files that are not so far tracked.

> I don't think this limitation is intented. 

This actually was intended.  Back when "commit [--opts] <pathspec>"
was invented, out tools were designed to avoid adding unwanted files
by mistake (e.g. "update-index" without an explicit "--add" work
only on paths already known to Git), and the behaviour is in line
with that design.  It partly was because back then we didn't even
have ".gitignore" mechanism, I would say.  So it was not only
intended, but was a sensible design decision back then.

I suspect that an argument could be made that it is about time we
shift the design philosophy and allow adding new paths with pathspec
given to "git commit".  If I were designing Git without any existing
users, with all the other goodies we already have, and "git commit"
in my version of Git lacked pathspec support now, I might allow it
to add untracked files with the pathspec [*1*].

There however are backward compatibility worries.  People who are
used to the designed behaviour for the past 10 years still expect
and rely on that

    $ git commit <path-to-dir>

to take _only_ changes to the files that are already tracked in the
<path-to-dir> since the last "git add" they did to them, and other
files in the same <path-to-dir> that are not yet ready (and they
deliberately left un-added) will not be in the commit.


[Footnote]

*1* I might decide not to, after thinking long enough, though. The
    point is that times changed and the trade off between safetly of
    not adding at the point of commit and convenience of adding has
    shifted. I haven't thought enough to decide that the shift is
    big enough to warrant the change in behaviour, but at least it
    is now worth considering.

