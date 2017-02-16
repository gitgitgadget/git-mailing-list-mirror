Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5D071FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 23:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933716AbdBPX1d (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 18:27:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:56756 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933590AbdBPX1d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 18:27:33 -0500
Received: (qmail 1601 invoked by uid 109); 16 Feb 2017 23:27:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 23:27:32 +0000
Received: (qmail 28721 invoked by uid 111); 16 Feb 2017 23:27:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 18:27:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2017 18:27:30 -0500
Date:   Thu, 16 Feb 2017 18:27:30 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH] config: preserve <subsection> case for one-shot config
 on the command line
Message-ID: <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net>
References: <20170215111704.78320-1-larsxschneider@gmail.com>
 <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
 <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
 <xmqqy3x712if.fsf@gitster.mtv.corp.google.com>
 <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
 <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com>
 <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 11:30:28AM +0100, Lars Schneider wrote:

> 
> > On 16 Feb 2017, at 00:48, Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > The "git -c <var>=<val> cmd" mechanism is to pretend that a
> 
> The problem is also present for gitconfig variables e.g.
> git config --local submodule.UPPERSUB.update none

Hrm, is it?

  $ git config --file foo submodule.UPPERSUB.update none
  $ cat foo
  [submodule "UPPERSUB"]
	update = none

I could believe that some of the submodule code may try to pass it
through "-c", though, so certain config ends up being missed.

AFAICT, though, the writing code takes what you gave it verbatim. The
reader is responsible for downcasing everything but the subsection
before it hands it to a callback. Commands calling git-config for lookup
should generally ask for the canonical downcased name. There is some
code to downcase, but IIRC there are corner cases around some of the
regex lookup functions.

-Peff
