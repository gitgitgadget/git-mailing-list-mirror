Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26DF5203C4
	for <e@80x24.org>; Fri, 15 Jul 2016 21:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbcGOV2q (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 17:28:46 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45780 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbcGOV2o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 17:28:44 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0F22203C2;
	Fri, 15 Jul 2016 21:28:43 +0000 (UTC)
Date:	Fri, 15 Jul 2016 21:28:43 +0000
From:	Eric Wong <e@80x24.org>
To:	Konstantin Khomoutov <kostix+git@007spb.ru>,
	Ben Peart <peartben@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Turner <novalis@novalis.org>,
	Joey Hess <joey@kitenet.net>,
	Ronnie Sahlberg <rsahlberg@google.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Plugin mechanism(s) for Git?
Message-ID: <20160715212843.GA5131@dcvr.yhbt.net>
References: <CAP8UFD1BnnRqsv8zrcDDby=KqQ3UCDVdHWTycfDNTeyfLArn5g@mail.gmail.com>
 <2C31984D-310C-4E8C-927B-6D98B7D7570B@gmail.com>
 <loom.20160715T181543-821@post.gmane.org>
 <20160715194752.f10351ae84346bd533495496@domain007.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160715194752.f10351ae84346bd533495496@domain007.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Konstantin Khomoutov <kostix+git@007spb.ru> wrote:
> Ben Peart <peartben@gmail.com> wrote:
> > > Lars Schneider wrote:
> > > 
> > > We could dynamically load libraries but this would force us to
> > > freeze the ABI as mentioned by Duy:
> > > http://article.gmane.org/gmane.comp.version-control.git/298463
> > > 
> > 
> > I wouldn’t be too quick to dismiss dynamically loaded libraries as
> > there are some distinct advantages over the other patterns especially
> > performance and simplicity.  I realize it requires us to version the
> > ABI but there are established patterns to manage this.  It also isn’t
> > that much different than us having to freeze or version the protocol
> > for communicating with a remote-helper.

(re-adding dropped CCs)

The critical difference is protocols can be tested and debugged
in a language/tool-independent way.

> Using dynamically loaded libraries precludes or greatly complicates
> creation of plugins written in languages different from C (or C++ FWIW).

Agreed, and folks working on language bindings are often not
experts in or comfortable working in C (I speak for myself,
at least).

It's probably not a good use of git core developers time to
learn to deal with bindings and quirks for language XYZ, either
(as language XYZ likely breaks compatibility more than C,
POSIX or the git data model).

The SVN Perl XS bindings we use for git-svn have introduced
numerous incompatibilities and bugs over the years we've had to
deal with.  I doubt Perl bindings are a high priority for SVN
developers; and even checking their API headers reveals a huge
number of deprecated functions in their native C API.  I'm not
sure if it's a lack of foresight on their part or what, but I'm
happy git's data model and command-line interface has barely had
to deprecate or break compatibility in over a decade.

Protocols like "cat-file --batch" and fast-import using
pipes is great and I hope they're portable enough.  I would
welcome additions to avoid process spawning costs for things
like update-ref/rev-parse/etc...
