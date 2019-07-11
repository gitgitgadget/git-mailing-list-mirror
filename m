Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A3121F461
	for <e@80x24.org>; Thu, 11 Jul 2019 19:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfGKTav (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 15:30:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63960 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfGKTau (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 15:30:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 771521707F4;
        Thu, 11 Jul 2019 15:30:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9slSca+aP707tHqu85MAw7Vm8Ss=; b=Bv7wOI
        qdyJjWtz+71AARE/xrSn3LELe7q2u2r1trYUrcsG8Z6L1FBCzG6HgBigXUGYVjkp
        uh54UunQ73AP0tJXVNAX8qrMx3VZ33XxO2t53+JjTSHwgtOBoRsDOglVXB6Arejq
        7w1JH0Oi/httOWTcGGnvEBqKQfKtFPK5wdZAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pEIWw977Hh/6kVU4o/VklCIIH7PoUYvc
        DlTgx0SiqqpIIEcewdgFAIsUTXLcSKYgddtffXHvCYoNR3kvDFY9ueKG5Z/qVx+N
        FapdLuKsiH9nhFGe5fjMo7OKgIzTViF8x3c71VTGIq6jX6zE1g7y5Nv4efxK7X5q
        ScU434k3iWA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CF2A1707F3;
        Thu, 11 Jul 2019 15:30:48 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5FCC1707F2;
        Thu, 11 Jul 2019 15:30:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 0/3] use mailmap by default in git log
References: <20190711183727.8058-1-ariadne@dereferenced.org>
Date:   Thu, 11 Jul 2019 12:30:46 -0700
In-Reply-To: <20190711183727.8058-1-ariadne@dereferenced.org> (Ariadne
        Conill's message of "Thu, 11 Jul 2019 13:37:24 -0500")
Message-ID: <xmqqy314qsgp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 625F0A06-A412-11E9-8AC9-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ariadne Conill <ariadne@dereferenced.org> writes:

> It is not uncommon for people to change their name or e-mail address.
> To facilitate this, Git provides support for the `.mailmap` file,
> which contains a list of identities and previously used e-mail
> addresses that are associated with that identity.
>
> Unfortunately, while Git's support for the `.mailmap` file is generally
> excellent, I recently discovered that `git log` does not treat the
> mail map file the same as the other tools, instead requiring an
> explicit flag to use the mailmap file.

Make "the other tools" a bit more explicit.  Making things
consistent is good but which way the consistency should go
needs more data than the above to decide.

Even though I personally think it is an OK longer-term end goal, the
execution looks too hasty.  The normal way we handle a big behaviour
change like this is to do the following in steps, in different
releases:

 - In the first release, introduce an early adoptor option (say
   log.usemailmap) that can be turned on by the user, but is off by
   default.  IOW, the initial step is "no change in behaviour,
   unless you ask for it".  This step also makes sure that the way
   to disable it for those who opt into the option from the command
   line (i.e.  the --no-use-mailmap option) works well.

 - In the second release, when "git log" is run without command line
   "--[no-]use-mailmap" and "log.usemailmap" is not set by the user,
   give warning about an upcoming flipping of the default, with an
   advice message that the user can squelch the warning by setting
   the option.

 - In the final release, flip the default and remove the warning.

Usually there needs sufficient time between the second step and the
third step, so that people will not miss the warning.

Thanks.
