Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4701F404
	for <e@80x24.org>; Thu, 19 Apr 2018 21:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753486AbeDSVdZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 17:33:25 -0400
Received: from mxin.vub.ac.be ([134.184.129.114]:55799 "EHLO mxin.vub.ac.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752725AbeDSVdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 17:33:25 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HQBAANCtla/wsxuIZbhU4ogyGJJ44MF?=
 =?us-ascii?q?HuTB4FkC4RpAoJjOBQBAgEBAQEBAQICAmgohSMBAQEBAgE6PxALGAkMGQ8FKCE?=
 =?us-ascii?q?ThHUDDQipPoRYg2qCG4laP4Qagk+BX4EEgnGCJAKFOIIShVqKSQiLDYMlh0WFE?=
 =?us-ascii?q?5AngSUzIoFSTSAYgn6CIBeOGT0wkEEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HQBAANCtla/wsxuIZbhU4ogyGJJ44MFHuTB4FkC4RpAoJ?=
 =?us-ascii?q?jOBQBAgEBAQEBAQICAmgohSMBAQEBAgE6PxALGAkMGQ8FKCEThHUDDQipPoRYg?=
 =?us-ascii?q?2qCG4laP4Qagk+BX4EEgnGCJAKFOIIShVqKSQiLDYMlh0WFE5AngSUzIoFSTSA?=
 =?us-ascii?q?Ygn6CIBeOGT0wkEEBAQ?=
Received: from igwe11.vub.ac.be (HELO igwe.rave.org) ([134.184.49.11])
  by smtp.vub.ac.be with ESMTP/TLS/AES128-GCM-SHA256; 19 Apr 2018 23:33:22 +0200
Received: from kgybels by igwe.rave.org with local (Exim 4.84_2)
        (envelope-from <kgybels@infogroep.be>)
        id 1f9HBC-0005xi-Lc; Thu, 19 Apr 2018 23:33:22 +0200
Date:   Thu, 19 Apr 2018 23:33:22 +0200
From:   Kim Gybels <kgybels@infogroep.be>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] daemon: use timeout for uninterruptible poll
Message-ID: <20180419213322.GA19500@infogroep.be>
References: <20180412210757.7792-1-kgybels@infogroep.be>
 <20180412210757.7792-2-kgybels@infogroep.be>
 <xmqq36zw16gv.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1804182251070.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <xmqqy3hkfais.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3hkfais.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On (19/04/18 06:51), Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> > In other words, you scolded Kim for something that this patch did not
> > introduce, but which was already there.

I didn't feel scolded, just Junio raising a concern about maintainability of
the code.

> > Unless I am misunderstanding violently what you say, that is, in which
> > case I would like to ask for a clarification why this patch (which does
> > not change a thing unless NO_POLL is defined!) must be rejected, and while
> > at it, I would like to ask you how introducing a layer of indirection with
> > a full new function that is at least moderately misleading (as it would be
> > named xpoll() despite your desire that it should do things that poll()
> > does *not* do) would be preferable to this here patch that changes but a
> > few lines to introduce a regular heartbeat check for platforms that
> 
> Our xwrite() and other xfoo() are to "fix" undesirable aspect of the
> underlying pure POSIX API to make it more suitable for our codebase.
> When pure POSIX poll() that requires the implementing or emulating
> platform pays attention to the children being waited on is not
> appropriate for the codepath we are using (i.e. the place where the
> patch is touching), it would be in line to introduce a "fixed" API
> that allows us to pass that information, so that we can build on top
> of that abstraction that is *not* pure POSIX abstraction, no?  After
> all, you are the one who constantly whine that Git is implemented on
> POSIX API and it is inconvenient for other platforms.

There is another issue with the existing code that this new "xpoll" will need
to take into account. If a SIGCHLD arrives between the call to
check_dead_children and poll, the poll will not be interupted by it, resulting
in the child not being reaped until another child terminates or a client
connects. Currently, the effect is just a zombie process for a longer time,
however, the proposed patch (daemon: graceful shutdown of client connection)
relies on the cleanup to close the client connection.

When I have time, I will reroll including a change to ppoll.

-Kim
