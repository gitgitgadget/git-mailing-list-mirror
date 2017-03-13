Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD69E20373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753046AbdCMVdO (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:33:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52091 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752503AbdCMVdN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:33:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60589857CC;
        Mon, 13 Mar 2017 17:33:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t7dqxGtkbjcJ2yurm7JSfFZqq+s=; b=NfbBUM
        wO3mFmKm/mW0AtF5EWI82XC6Hk4LC7O7eFXtXvLTItnKeAV2lDOmaYJm/1VkOL0L
        MEPRc47qlu9xqfbuEjFL5M8VU2Iq10JU+oHxNnUUmNxVNoKJI2gLrYz0UPL/Ste1
        1o4VyGRZ0LligqP2j2V6neKdG/uIGGoxboMQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i9eWnwidWGAr6QbcqNTtkEgGmeFl3olW
        Y0CCD6OdjSOLqDpenGilkR4oYn/czA1roxePWPwpnCnTh+9c42nYWWTgcPWyMgYY
        o4fq5HKtE9MJV2TpBVw5N2paROEoods4P89voBFZcqxqpeJgldyQSR13aVxnyiO4
        zQbyT3e1LGY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A0F4857CB;
        Mon, 13 Mar 2017 17:33:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD623857CA;
        Mon, 13 Mar 2017 17:33:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     David Aguilar <davvid@gmail.com>,
        Christophe Macabiau <christophemacabiau@gmail.com>,
        Git ML <git@vger.kernel.org>
Subject: Re: [PATCH] difftool: handle changing symlinks in dir-diff mode
References: <alpine.DEB.2.20.1703072332370.3767@virtualbox>
        <20170313175640.14106-1-davvid@gmail.com>
        <xmqqlgs9rprt.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703132204410.3767@virtualbox>
Date:   Mon, 13 Mar 2017 14:33:09 -0700
In-Reply-To: <alpine.DEB.2.20.1703132204410.3767@virtualbox> (Johannes
        Schindelin's message of "Mon, 13 Mar 2017 22:27:30 +0100 (CET)")
Message-ID: <xmqqinncrhey.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7FE3108-0834-11E7-AFEE-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +	if (strbuf_readlink(&link, ce->name, ce_namelen(ce)) == 0) {
>> > +		strbuf_add(&path, state->base_dir, state->base_dir_len);
>> > +		strbuf_add(&path, ce->name, ce_namelen(ce));
>> > +
>> > +		write_file_buf(path.buf, link.buf, link.len);
>> 
>> This does "write content into symlink stand-in file", but why?
>
> From the commit message:
>
> 	> Detect the null object ID for symlinks in dir-diff so that
> 	> difftool can prepare temporary files that matches how git
> 	> handles symlinks.

Yes I read what the proposed log message said, and noticed that
symbolic link is _always_ written as a regular file.

I was questioning why.  I know Git falls back to such behaviour when
the filesystem does not support symbolic links.  "Why do so
unconditionally, even when the filesystem does?" was the question.

> The obvious connection: when core.symlinks = false, Git already falls back
> to writing plain files with the link target as contents. This function
> does the same, for the same motivation: it is the best we can do in this
> case.

And that "obvious connection" does not answer the question.
