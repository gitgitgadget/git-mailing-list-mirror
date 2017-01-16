Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67D381F89C
	for <e@80x24.org>; Mon, 16 Jan 2017 00:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbdAPAVq (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 19:21:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54577 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751273AbdAPAVp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 19:21:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 879B960C31;
        Sun, 15 Jan 2017 19:21:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DAHV152Ovyx6/8U2lKn8AFYxRxw=; b=JdvOnb
        JbYuF4IOdIJIV7jv7IrJxUH1Nl1lkW8O6spenwa9Bo1MW+48lMCSDHJUEQAEI9G+
        CCR9zjDWoWUzws2ChmSmut1pTGFk1mBYlHMnkFJQkNqNVUTGcPQmO5erffTZQetQ
        akc9sDH6ZL/lcAQEc50VqRB/2/g+D1JPtzEj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Yy7/LIUg1R7yi95m092M6AIQCFLnM19H
        rriz5ipfo6vvhJIeUsW4tX5gnI0ZyISekxT3FTe1qGuaNKotK6jqJkOjIpD/ewid
        e391fdY4Wiw/J+9lHgSdXLoMmIlsHshIAKEiKbP9O2PAUiy3iEvJN8WctDSfnht6
        AWBIbzzMyLw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FF8860C30;
        Sun, 15 Jan 2017 19:21:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D427360C29;
        Sun, 15 Jan 2017 19:21:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, kes-kes@yandex.ru
Subject: Re: [RFC] stash: support filename argument
References: <20170115142542.11999-1-t.gummerer@gmail.com>
Date:   Sun, 15 Jan 2017 16:21:42 -0800
In-Reply-To: <20170115142542.11999-1-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 15 Jan 2017 14:25:42 +0000")
Message-ID: <xmqqvatfc0rt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2534BA4-DB81-11E6-B988-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> While working on a repository, it's often helpful to stash the changes
> of a single or multiple files, and leave others alone.  Unfortunately
> git currently offers no such option.  git stash -p can be used to work
> around this, but it's often impractical when there are a lot of changes
> over multiple files.
>
> Add a --file option to git stash save, which allows for stashing a
> single file.  Specifying the --file argument multiple times allows
> stashing more than one file at a time.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>
> Marked as RFC and without documentation updates to first get a feeling
> for the user interface, and whether people are interested in this
> change.
>
> Ideally I wanted the the user interface to look like something like:
> git stash save -- [<filename1,...>], but unfortunately that's already
> taken up by the stash message.  So to preserve backward compatibility
> I used the new --file argument.

I haven't spent enough time to think if it even makes sense to
"stash" partially, leaving the working tree still dirty.  My initial
reaction was "then stashing away the dirty WIP state to get a spiffy
clean working environment becomes impossible", and I still need time
to recover from that ;-)  So as to the desirablity of this "feature",
I have no strong opinion for or against yet.

But if we were to do this, then we should bite the bullet and
declare that "stash save <message>" was a mistake.  It should have
been "stash save -m <message>" and we should transition to that (one
easy way out would be to find another verb that is not 'save').

Then we can do "git stash save [-m <msg>] [--] [pathspec...]" which
follows the usual command line convention.
