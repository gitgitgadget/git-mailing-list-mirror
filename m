Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6B4720756
	for <e@80x24.org>; Thu, 12 Jan 2017 08:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750819AbdALIVn (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 03:21:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60060 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750777AbdALIVn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 03:21:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7431951D8E;
        Thu, 12 Jan 2017 03:21:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g+1XwlSkvBt5jeZULvz0O8PC/uE=; b=SlAaVs
        XBZYZBIlmvrGCYJrzvcJJgrNhHv18bqmx/TFKjAEk59JlbzPYEzApDc6fxEha4l/
        NhvRt411IX1owgNfi8qgqNYDLbklVoUcNGN1tuPs+R3ICJhr3XZpcDq2pZTBzXi4
        PB+GMHKc4K3yrqWnnEogsTeP637vNTxNwHRXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HSaObyn/qvUMukeBEKQQT7kGHRZFIgBa
        jkxl0cCF/dxx9X0GrQsv+NaJKse6vtCEDjrRWNEY0u5YNFfXYSut6zQvaDTrJFE0
        wuHJpQHJqjWonddKZ1lzGk64dJFvXLRHacOKTHgt2KQlW1bkj/+vfn2gPwWpzHMz
        6uCG2Y3hsVI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CB6351D8B;
        Thu, 12 Jan 2017 03:21:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB3F051D88;
        Thu, 12 Jan 2017 03:21:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pat Pannuto <pat.pannuto@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] Use env for all perl invocations
References: <20170112055140.29877-1-pat.pannuto@gmail.com>
        <xmqqa8awn6i6.fsf@gitster.mtv.corp.google.com>
        <CAAnLKaHrGkAkF+kZtrawDSkuhVkvvUZONp6PQj6=3AGoAwFxyw@mail.gmail.com>
Date:   Thu, 12 Jan 2017 00:21:38 -0800
In-Reply-To: <CAAnLKaHrGkAkF+kZtrawDSkuhVkvvUZONp6PQj6=3AGoAwFxyw@mail.gmail.com>
        (Pat Pannuto's message of "Thu, 12 Jan 2017 02:13:03 -0500")
Message-ID: <xmqqshoolmct.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 245D0356-D8A0-11E6-B417-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pat Pannuto <pat.pannuto@gmail.com> writes:

> It feels weird to me that the perl path is fixed at
> compile/install-time as opposed to run-time discovery -- this means
> users can't change their perl install without breaking git?

Among the software packages that use interpreters like perl, python,
ruby, etc., there are ones that seem to consider that it is a good
idea to let "#!/usr/bin/env $language" pick whatever variant
[*1*] of the $language that happens to be on end-user's $PATH.

Git does not subscribe to that thought, and it is done for very good
reasons.

When you take a popular $language used by many software packages, it
is more than likely that one particular end user uses more than one
such package written in the same $language.  If one assumes that
there is one variant of $language such software packages can all
use, then $PATH can be tweaked so that the common variant and no
other variants of $language can be found and you are done.

However, that is too simplistic in real life.  If you are using Git
(which wants Perl 5.8 or later with certain libs) and some other
software package that needs a much older Perl, there is no such
single variant that can be placed on end-user's $PATH.  Only when
all the other software packages write their she-bang line without
"env" and instead point at the exact variant they need, Git can use
the "env" to rely on $PATH, but at that point, Git is being overly
arrogant.  It insists to be special among packages that use the same
$language and wants the variant it needs to be on $PATH.

Git knows that the real-world is not simplistic.  Git is not
arrogant, either.  And that is why it does not use "#!/usr/bin/env".


[Footnote]

*1* Here a "variant" of a $language refers to a binary of one
    particular version of the $language, together with libs and
    extensions it uses that are installed on the system.  You
    apparently have two variants, one installed as /usr/bin/perl,
    the other as /usr/local/bin/perl.
