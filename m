Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0119D203BD
	for <e@80x24.org>; Fri, 28 Oct 2016 05:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750961AbcJ1FwB (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 01:52:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39376 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbcJ1FwA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 01:52:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 513A820193;
        Fri, 28 Oct 2016 05:51:59 +0000 (UTC)
Date:   Fri, 28 Oct 2016 05:51:59 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with
 O_CLOEXEC
Message-ID: <20161028055159.GA25950@starla>
References: <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
 <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net>
 <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
 <xmqqoa254czs.fsf@gitster.mtv.corp.google.com>
 <CA+55aFxTHF4BRfcrCiV1D26-be+_rPhwAV+Vq8Roz-NMpPBadg@mail.gmail.com>
 <CA+55aFxdy4maom8byH0FoBBMWx+sQB8J7uWvHOxswjiaAhSjVg@mail.gmail.com>
 <xmqqfunh4b63.fsf@gitster.mtv.corp.google.com>
 <CA+55aFw83E+zOd+z5h-CA-3NhrLjVr-anL6pubrSWttYx3zu8g@mail.gmail.com>
 <xmqqa8dp46wx.fsf@gitster.mtv.corp.google.com>
 <xmqq60od42s0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60od42s0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Linus Torvalds <torvalds@linux-foundation.org> writes:
> >
> >> On Thu, Oct 27, 2016 at 4:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >>>
> >>> Would the best endgame shape for this function be to open with
> >>> O_NOATIME (and retry without), and then add CLOEXEC with fcntl(2)
> >>> but ignoring an error from it, I guess?  That would be the closest
> >>> to what we historically had, I would think.
> >>
> >> I think that's the best model.

Actually, I would flip the order of flags.  O_CLOEXEC is more
important from a correctness standpoint.

> > OK, so perhaps like this.
> 
> Hmph.  This may not fly well in practice, though.  
> 
> To Unix folks, CLOEXEC is not a huge correctness issue.  A child
> process may hold onto an open file descriptor a bit longer than the
> lifetime of the parent but as long as the child eventually exits,

I'm not too familiar with C internals of git; but I know we use
threads in some places, and fork+execve in others.

If our usage of threads and execve intersects, and we run
untrusted code in an execve-ed child, then only having cloexec
on open() will save us time when auditing for leaking FDs.

fcntl(fd, F_SETFD, O_CLOEXEC) is racy in if there are other
threads doing execve; so I wouldn't rely on it as a first
choice.

So I suppose something like this:

	static int noatime = 1;
	int fd = open(... | O_CLOEXEC);
	...error checking and retrying...

	if (fd >= 0 && noatime && fcntl(fd, F_SETFL, O_NOATIME) != 0)
		noatime = 0;

	return fd;
