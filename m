Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1B651F4DD
	for <e@80x24.org>; Fri, 25 Aug 2017 09:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754630AbdHYJLM (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 05:11:12 -0400
Received: from zm-mta-out-1.u-ga.fr ([152.77.200.56]:58580 "EHLO
        zm-mta-out-1.u-ga.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754607AbdHYJLK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 05:11:10 -0400
Received: from zm-mta-out.u-ga.fr (zm-mta-out.u-ga.fr [152.77.200.58])
        by zm-mta-out-1.u-ga.fr (Postfix) with ESMTP id 04E77A0295;
        Fri, 25 Aug 2017 11:11:08 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [195.83.24.202])
        by zm-mta-out.u-ga.fr (Postfix) with ESMTP id E3ED1E0099;
        Fri, 25 Aug 2017 11:11:10 +0200 (CEST)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 1F1AC6036A;
        Fri, 25 Aug 2017 11:11:09 +0200 (CEST)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] send-email: fix garbage removal after address
References: <vpqo9r6lhzq.fsf@anie.imag.fr>
        <20170823102102.20120-1-git@matthieu-moy.fr>
        <xmqqk21svh9o.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 25 Aug 2017 11:11:09 +0200
In-Reply-To: <xmqqk21svh9o.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 24 Aug 2017 13:32:19 -0700")
Message-ID: <vpq378g107m.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via smtps.univ-grenoble-alpes.fr ACL (97)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <git@matthieu-moy.fr> writes:
>
>> +sub strip_garbage_one_address {
>> +	my ($addr) = @_;
>> +	chomp $addr;
>> +	if ($addr =~ /^(("[^"]*"|[^"<]*)? *<[^>]*>).*/) {
>> +		# "Foo Bar" <foobar@example.com> [possibly garbage here]
>> +		# Foo Bar <foobar@example.com> [possibly garbage here]
>> +		return $1;
>> +	}
>> +	if ($addr =~ /^(<[^>]*>).*/) {
>> +		# <foo@example.com> [possibly garbage here]
>> +		# if garbage contains other addresses, they are ignored.
>> +		return $1;
>> +	}
>
> Isn't this already covered by the first one,

Oops, indeed. I just removed the second "if" (and added the appropriate
comment to the first):

+       if ($addr =~ /^(("[^"]*"|[^"<]*)? *<[^>]*>).*/) {
+               # "Foo Bar" <foobar@example.com> [possibly garbage here]
+               # Foo Bar <foobar@example.com> [possibly garbage here]
+               # <foo@example.com> [possibly garbage here]
+               return $1;
+       }

> By the way, these three regexps smell like they were written
> specifically to cover three cases you care about (perhaps the ones
> in your proposed log message), but what will be our response when
> somebody else comes next time to us and says that their favourite
> formatting of "Cc:" line is not covered by these rules?

Well, actually the last one covers essentially everything. Just stop at
the first space, #, ',' or '"'. The first case is here to allow putting
a name in front of the address, which is something we've already allowed
and sounds reasonable from the user point of view.

OTOH, I didn't bother with real corner-cases like

  Cc: "Foo \"bar\"" <foobar@example.com>

> So, from that point of view, I, with devil's advocate hat on, wonder
> why we are not saying
>
> 	"Cc: s@k.org # cruft"?  Use "Cc: <s@k.org> # cruft" instead
> 	and you'd be fine.
>
> right now, without this patch.

I would agree if the broken case were an exotic one. But a plain adress
is really the simplest use-case I can think of, so it's hard to say
"don't do that" when we should say "sorry, we should obviously have
thought about this use-case".

-- 
Matthieu Moy
https://matthieu-moy.fr/
