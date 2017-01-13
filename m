Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58F5820756
	for <e@80x24.org>; Fri, 13 Jan 2017 23:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbdAMXhk (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 18:37:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60670 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751482AbdAMXhj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 18:37:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93FBA5ED3E;
        Fri, 13 Jan 2017 18:37:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wkwBKuBXTHYj0QBzBAtJ2R4jQv0=; b=s+uPAZ
        h6O+7uNV7LWipQkeMT9OYl2b/fWXpjq8T2praZJTlJeUxbvilDhMKNBJgeTUnFL1
        pbwBaLnhVKbKyHBbono/qMsXbVc+x6X8Ayv6JnRSXRc6wajME28TxGF3IBZFM9F/
        XY98jBNCfxRuGgs9wVKkhrF8kmdd9KmPflJJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g78M84Xs6o3RR7T6Nzwr0XDhRWmda/8Q
        1MqlgFffeTnhYtsDnMOyJ5ZwuKYMmfHHHgnJ4aHEzXL0xSbPW13x3ENkg6H9V2nQ
        /8MeUuXQqG266zSaStX4gzy4KZDVwH7xQYbz7SITbahV2R9EHKp42TLsjch3UKPC
        7T3WAqGc3yQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B6015ED3D;
        Fri, 13 Jan 2017 18:37:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8BAB5ED3C;
        Fri, 13 Jan 2017 18:37:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] diff --no-index: follow symlinks
References: <20170113102021.6054-1-dennis@kaarsemaker.net>
        <20170113102021.6054-2-dennis@kaarsemaker.net>
Date:   Fri, 13 Jan 2017 15:37:36 -0800
In-Reply-To: <20170113102021.6054-2-dennis@kaarsemaker.net> (Dennis
        Kaarsemaker's message of "Fri, 13 Jan 2017 11:20:20 +0100")
Message-ID: <xmqqk29yedkv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 445EA854-D9E9-11E6-A9E0-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> Git's diff machinery does not follow symlinks, which makes sense as git
> itself also does not, but stores the symlink destination.
>
> In --no-index mode however, it is useful for diff to to follow symlinks,
> matching the behaviour of ordinary diff. A new --no-dereference (name
> copied from diff) option has been added to disable this behaviour.

If you add a --no-dereference option, --dereference option should
also be there, so that "--no-dereference" earlier on the command
line (perhaps coming from a configured alias) can be countermanded.

While I am not opposed to giving an optional feature to treat a
symlink as if it is a regular file with the contents of its link
target, I am not enthused that this patch tries to make that the
default behaviour.  We are not matching the behaviour of ordinary
diff anyway [*1*].

It probably makes more sense for our first step to introduce this
feature that is only enabled when "--dereference" option is given.
Making it the default for "--no-index" case should be discussed as
a separate step.

[Footnote]

*1* E.g. "git diff --no-index dirA/ dirB/" does not say "Only in
dirA: file".  It also recurses into subdirectories of dirA/ and
dirB/ without the --recursive option.
