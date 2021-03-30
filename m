Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B560C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 21:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C993F619CA
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 21:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhC3VW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 17:22:56 -0400
Received: from elephants.elehost.com ([216.66.27.132]:52175 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbhC3VWg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 17:22:36 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 12ULMWml029553
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 30 Mar 2021 17:22:33 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <011901d72596$e5ed8670$b1c89350$@nexbridge.com> <xmqqim58cpqa.fsf@gitster.g>
In-Reply-To: <xmqqim58cpqa.fsf@gitster.g>
Subject: RE: [Bug] worktree prune --expires
Date:   Tue, 30 Mar 2021 17:22:26 -0400
Message-ID: <011f01d725aa$cb807360$62815a20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFYurzvhq+kApihHpUV0DhhN7A8UgKD6Pouq4W/4wA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 30, 2021 5:10 PM, Junio C Hamano wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: git@vger.kernel.org
> Subject: Re: [Bug] worktree prune --expires
> 
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> > This is pretty much just a quibble, but the command parser for
> > worktree prune --expires should really report when a timestamp is
> > invalid. For
> > example:
> >
> > worktree prune --expires A:30 actually
> 
> Assuming that you had "git" in front, and spelled "--expire" without the
extra
> 's':

Yes, it was. I just transcribed it badly.

> $ git worktree prune --expire no.such.date
> fatal: malformed expiration date 'no.such.date'
> 
> So apparently, "A:30" is taken as a expiration date that is not malformed.
> 
> $ git rev-parse --since=A:30 --until=now
> --max-age=1617138312
> --min-age=1617138312
> 
> Appears to show that A:30 is interpreted as the same as 'now', but thta is
an
> unlucky coincidence of the day.
> 
> What happens in this case is that "A:" is discarded as cruft (just like
dots are
> discarded in "git log --since=8.days.ago"), and only the "30" takes effect
of
> filling an unspecified "date of the month"
> [*1*].  And then the remainder is taken from the wallclock time, and that
is
> how the above "rev-parse" shows the same for A:30 and now, as it is the
> 30th of the month for me right now.
> 
> $ git rev-parse --since=A:31 --until=now
> --max-age=1617224881
> --min-age=1617138481
> 
> gives me the same time tomorrow (for the same reason that today's 30th for
> me).
> 
> 
> [Footnote]
> 
> *1* In A:30, there is no "date of month", "month", "year", etc. specified,
so
> we start from all unspecified, take the first number that is discovered
(i.e. 30)
> and fill "date of the month"
> with it.

Well, sounds a bit like an elbow test situation. The question is, what to do
about it, if anything, I suppose. I didn't even put the "30" in context
while testing. Oops.

