Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CDFA1FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 18:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754734AbcLOSKu (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 13:10:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57572 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753971AbcLOSKt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 13:10:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 688BE57A43;
        Thu, 15 Dec 2016 13:10:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VWae+8d2FA8GO/g+PaqNoPZPplg=; b=kgqlU8
        L5orJqhGjHN/+hvqKBFfm9l9TTi/yTCT6TYzOfpee1ctqiJ9CCk0C2Uju3+xhyXs
        Mk4e6Tw+xvGyQ33BLMxPipFMauu8KR9ke5kJXwnmB4c3VpmkrNNKhH45ZoW46ntw
        l4wrglCQT5D8ANrdwwZbhdC4RoNkkZYMSAXSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jLh3J+kzOBioWOeU/eGF3kRGup6EZT8f
        67yZoUf+bh6W4UF6fSGYuy+v4G4i14SuT86yCKPqTCKEb6N+ddc5NCqALJD+o2tY
        q0DOSwVnUW3Eb0Hz4ZmRtjSC4GCf+ZHJYY86eXcDeh8QJQv73LmHw3H5Fk+d7TpV
        nHdrjY+MAYM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 617D757A42;
        Thu, 15 Dec 2016 13:10:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CE0A357A40;
        Thu, 15 Dec 2016 13:10:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexander Mills <alexander.d.mills@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git bug - merging JS / Node.js code with "git merge --squash"
References: <CA+KyZp4HzsSOghKZnKgXEXy_gqw-9oTHveDHn1eRUY-_C6_jww@mail.gmail.com>
Date:   Thu, 15 Dec 2016 10:10:46 -0800
In-Reply-To: <CA+KyZp4HzsSOghKZnKgXEXy_gqw-9oTHveDHn1eRUY-_C6_jww@mail.gmail.com>
        (Alexander Mills's message of "Wed, 14 Dec 2016 23:12:03 -0800")
Message-ID: <xmqqwpf1ukpl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDE4BCBC-C2F1-11E6-A121-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexander Mills <alexander.d.mills@gmail.com> writes:

> basically it is doing the merge with this line:
>
> git merge --squash -Xtheirs dev -m "squashing" &&

The order of command line parameters are "dashed options and their
arguments first, then refs (and then pathspecs if exists), so you
should make it a habit to move that "dev" at the end of the command
line.  This does not have anything to do with the issue you are
asking for help, though.

I suspect the problem is not in --squash but with -Xtheirs.  It is
"I give up correctly resolving conflicts and blindly take whatever
comes from their side, discarding what I did".

The "git merge" command stops and asks a human to help resolving a
conflict using their brain when it needs to because the command
knows it itself does not have any but the human user has a better
one ;-).  -Xtheirs and -Xours disables this safety/sanity.

If you punt, it is expected that you would get garbage.  

For example, your side may have introduced a new function (or
renamed an existing one) near where their side made a change that
resulted in conflicts.  Naturally, your side also would have added
new callsites to that new function (you wouldn't be adding an unused
function).  Imagine in such a scenario that you asked "discard what
I did in the conflicted section and blindly take whatever they did".
What happens?  They may not have done anything near the places you
added calls to the new function and these sections of the code would
merge cleanly with or without -Xtheirs, but the actual new function
you added may be in the conflicted section that you asked to discard,
taking their changes.


