Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44D021F855
	for <e@80x24.org>; Sat, 30 Jul 2016 04:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbcG3EvH (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 00:51:07 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:55410 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbcG3EvE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 00:51:04 -0400
Received: from mfilter21-d.gandi.net (mfilter21-d.gandi.net [217.70.178.149])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id 513AF41C088;
	Sat, 30 Jul 2016 06:51:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter21-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter21-d.gandi.net (mfilter21-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id TUoTyBT0gyta; Sat, 30 Jul 2016 06:50:59 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 801C641C084;
	Sat, 30 Jul 2016 06:50:57 +0200 (CEST)
Date:	Fri, 29 Jul 2016 21:50:55 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC] git-format-patch: default to --from to avoid spoofed mails?
Message-ID: <20160730045055.e3t6tpgi6zch4epo@x>
References: <20160728211149.GA371@x>
 <xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
 <20160728215603.GA22865@sigill.intra.peff.net>
 <xmqq4m79qujr.fsf@gitster.mtv.corp.google.com>
 <20160729001618.GA9646@sigill.intra.peff.net>
 <20160729020801.GA14892@x>
 <20160729225800.GA23268@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160729225800.GA23268@sigill.intra.peff.net>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 06:58:00PM -0400, Jeff King wrote:
> On Thu, Jul 28, 2016 at 07:08:02PM -0700, Josh Triplett wrote:
> 
> > > I think on the whole that defaulting to "--from" would help more people
> > > than hurt them, but if we do believe there are scripts that would be
> > > regressed, it probably needs a deprecation period.
> > 
> > I don't think it's likely that there are scripts that would be regressed
> > (and I think it's likely that there are scripts that would be
> > progressed), but I'd also have no objection to a deprecation period.
> 
> I'm on the fence, so I'd leave the final decision on whether to deal
> with deprecation to you (who will write the patch) and Junio (as the
> maintainer).

OK, see the plan proposed below then.

> > I just confirmed that with the default changed, --no-from works to
> > return to the current behavior, so we don't need a new option.  And
> > --no-from has worked for a long time, so scripts won't need to care if
> > they're working with an old version of git.
> > 
> > I can provide a patch implementing a new config option to set the
> > format-patch --from default ("false" for --no-from, "true" for --from,
> > or a string value for --from=value).
> 
> I'd be surprised if the config option is actually useful to anybody in
> practice (the distinction is not "this my preference" as much as "in
> what context am I calling the program?"). It is a convenient way to do
> deprecations (introduce an option, then flip the default, leaving the
> option as an escape hatch for anybody who has been broken), though.

It also allows people to change their local default in advance of git
changing the default.

> > Do you think this needs the kind of very noisy deprecation period that
> > push.default had, where anyone without the git-config option set gets a
> > warning to stderr?  Or do you think it would suffice to provide a
> > warning in the release notes for a while and then change the default?
> 
> IMHO the noisy deprecations haven't really been all that beneficial.
> Even after the length push.default one, I think we still had people who
> had skipped enough versions to miss it, and quite a few people became
> confused or annoyed by the spew of text.
> 
> OTOH, I'm not sure most people read the release notes carefully, either.
> It would be nice if we could make the change and count on people to
> notice it in 'next' or even 'master' before the release, but empirically
> that does not happen.
> 
> So I dunno. If we consider the risk minor, perhaps a mention in the
> release notes for version X, and then the change in X+1 would be fine.
> That gives some opportunity for release-note readers to pipe up. It's
> not foolproof, but it would give us more confidence.

I would propose the following then:

- I'll write a patch adding a config option format.from, along with
  documentation, without changing the default.
- The release notes for the version of git introducing that config
  option should mention, prominently, the plan to change the default in
  a future version of git.
- A subsequent release can change the default.  No major rush to do
  this.

Does that sound reasonable?

- Josh Triplett
