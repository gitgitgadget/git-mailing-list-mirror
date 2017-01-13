Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3F7B20756
	for <e@80x24.org>; Fri, 13 Jan 2017 18:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbdAMSwr (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 13:52:47 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:51018 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750789AbdAMSwr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 13:52:47 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5CFB120756;
        Fri, 13 Jan 2017 18:52:46 +0000 (UTC)
Date:   Fri, 13 Jan 2017 18:52:46 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pat Pannuto <pat.pannuto@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
Message-ID: <20170113185246.GA17441@starla>
References: <20170112055140.29877-1-pat.pannuto@gmail.com>
 <20170112055140.29877-3-pat.pannuto@gmail.com>
 <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org>
 <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com>
 <alpine.DEB.2.20.1701121118170.3469@virtualbox>
 <xmqqbmvcj9le.fsf@gitster.mtv.corp.google.com>
 <CAAnLKaGvz4Wzs36gMSdoYCg+tzx6KFCe59FNnk5zNQ-L58ww1g@mail.gmail.com>
 <20170113024842.GA20572@starla>
 <xmqq4m12izmd.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4m12izmd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> > Pat Pannuto <pat.pannuto@gmail.com> wrote:
> >> You may still want the 1/2 patch in this series, just to make things
> >> internally consistent with "-w" vs "use warnings;" inside git's perl
> >> scripts.
> >
> > No, that is a step back.  "-w" affects the entire process, so it
> > spots more potential problems.  The "warnings" pragma is scoped
> > to the enclosing block, so it won't span across files.
> 
> OK, so with "-w", we do not have to write "use warnings" in each of
> our files to get them checked.  It is handy when we ship our own
> libs (e.g. Git.pm) that are used by our programs.

Yes.  "use warnings" should be in our own libs in case other
people run without "-w"

> If something we write outselves trigger a false-positive, we can
> work it around with "no warnings;" in the smallest block that
> encloses the offending code in the worst case, or just rephrase it
> in a way that won't trigger a false-positive.

Correct.

> If something we _use_ from a third-party is not warnings-clean,
> there is no easy way to squelch them if we use "-w", which is a
> potential downside, isn't it?  I do not know how serious a problem
> it is in practice.  I suspect that the core package we use from perl
> distribution are supposed to be warnings-clean, but we use a handful
> of things from outside the core and I do not know what state they
> are in.

Yes, "-w" will trigger warnings in third party packages.
Existing uses we have should be fine, and I think most Perl
modules we use or would use are vigilant about being
warnings-clean.  If we have to leave off a "-w", there should
probably be a comment at the top stating the reason:

#!/usr/bin/perl
# Not using "perl -w" since Foo::Bar <= X.Y.Y is not warnings-clean
use strict;
use warnings;
use Foo::Bar;
...
