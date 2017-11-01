Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F3CC20281
	for <e@80x24.org>; Wed,  1 Nov 2017 11:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbdKALEL (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 07:04:11 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:19703 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751316AbdKALEL (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2017 07:04:11 -0400
X-IronPort-AV: E=Sophos;i="5.44,327,1505772000"; 
   d="scan'208";a="298857537"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 01 Nov 2017 12:04:09 +0100
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Payre Nathan <second.payre@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        ALBERTIN TIMOTHEE p1514771 
        <timothee.albertin@etu.univ-lyon1.fr>,
        BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Tom Russello <tom.russello@grenoble-inp.org>
Subject: Re: [PATCH 1/2] quote-email populates the fields
References: <20171030223444.5052-1-nathan.payre@etu.univ-lyon1.fr>
        <20171030223444.5052-2-nathan.payre@etu.univ-lyon1.fr>
        <607ed87207454d1098484b0ffbc6916f@BPMBX2013-01.univ-lyon1.fr>
Date:   Wed, 01 Nov 2017 12:04:01 +0100
In-Reply-To: <607ed87207454d1098484b0ffbc6916f@BPMBX2013-01.univ-lyon1.fr>
        (Junio C. Hamano's message of "Wed, 1 Nov 2017 02:44:56 +0000")
Message-ID: <q7h97evaxntq.fsf@orange.lip.ens-lyon.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Payre Nathan <second.payre@gmail.com> writes:
>
>> From: Tom Russello <tom.russello@grenoble-inp.org>
>>
>> ---
>
> Missing something here???

To clarify for Nathan, Thimothee and Danial: the cover-letter is an
introduction send before the patch series. It can be needed to explain
the overall approach followed by the series. But in general, it does not
end up in the Git history, i.e. after the review is finished, the
cover-letter is forgotten.

OTOH, the commit messages for each patch is what ends up in the Git
history. This is what people will find later when running e.g. "git
blame", "git bisect" or so. Clearly the future user examining history
expects more than "quote-email populates the fields" (which was a good
reminder during development, but is actually a terrible subject line for
a final version).

A quick advice: if in doubt, prefer writing explanations in commit
message rather than the cover letter. If still in doubt, write the
explanations twice: once quickly in the cover letter and once more
detailed in the commit message.

>  * Do not call this option "quote" anything; you are not quoting,
>    just using some info from the given file.  
>
>    I wonder if we can simply reuse "--in-reply-to" option for this
>    purpose.  If it is a message id and not a file on the filesystem,
>    we behave just as before.  Otherwise we try to open it as a file
>    and grab the "Message-ID:" header from it and use it.

There's a possible ambiguity since user may in theory want to run
"--in-reply-to=msgid" with a file named msgid and still want the old
behavior. But: a real message-id is typically something rather cryptic
and it is safe to assume that users won't have a file named exactly like
an actual message id containing something which isn't the message in
question.

The main drawback I see in re-using "--in-reply-to" is that typos are
hard to miss. For example, running

  git send-email --in-reply-to=msgi

when the user actually wanted msgid would trigger a different behavior
instead of raising an error (no such file or directory). I think it's
acceptable: in the current form of send-email, we're already not
user-friendly to users when they write a typo in the --in-reply-to
argument (and we can't really detect typos anyway).

>> +if ($quote_email) {
>> +	my $error = validate_patch($quote_email);
>> +	die "fatal: $quote_email: $error\nwarning: no patches were sent\n"
>> +		if $error;
>
> validate_patch() calls sendemail-validate hook that is expecting to
> be fed a patch email you are going to send out that might have
> errors so that it can catch it and save you from embarrassment.  The
> file you are feeding it is *NOT* what you are going to send out, but
> is what you are responding to with your patch.  Even if it had an
> embarassing error as a patch, that is not something you care about
> (and it is something you received, so catching this late won't save
> the sender from embarrassment anyway).

I think the intention was to detect cases when $quote_email is not a
patch at all (and give a proper error message instead of trying to
continue with probably absurd behavior).

But I agree that there's no point in being too strict here, and if that
was the intension then it should be documented with a comment.

-- 
Matthieu Moy
https://matthieu-moy.fr/
