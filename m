Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E9811F858
	for <e@80x24.org>; Fri, 29 Jul 2016 00:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbcG2AFR (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 20:05:17 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:53282 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbcG2AFP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 20:05:15 -0400
Received: from mfilter46-d.gandi.net (mfilter46-d.gandi.net [217.70.178.177])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 4ADC41720AE;
	Fri, 29 Jul 2016 02:05:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter46-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
	by mfilter46-d.gandi.net (mfilter46-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id iI2HiPmGCcEP; Fri, 29 Jul 2016 02:05:10 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id C6CCF172094;
	Fri, 29 Jul 2016 02:05:09 +0200 (CEST)
Date:	Thu, 28 Jul 2016 17:05:07 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: [RFC] git-format-patch: default to --from to avoid spoofed mails?
Message-ID: <20160729000507.GA3149@x>
References: <20160728211149.GA371@x>
 <xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 02:37:04PM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > I'd like to propose changing the default behavior of git-format-patch to
> > --from (and adding a --from-author option to override, and perhaps a
> > config setting).  This will not change the output *except* when
> > formatting patches authored by someone else.  git-am and git-send-email
> > both handle the --from format without any issues.
> 
> I see this in "format-patch --help":
> 
>            Note that this option is only useful if you are actually
>            sending the emails and want to identify yourself as the
>            sender, but retain the original author (and git am will
>            correctly pick up the in-body header).  Note also that
>            git send-email already handles this transformation for
>            you, and this option should not be used if you are
>            feeding the result to git send-email.
> 
> The first one says "only useful", but it seems what it really means
> is "it becomes no-op if you are sending your own patch anyway".  So
> that one does not worry me.  What is most worrysome is the latter
> half of the last sentence.  Is it really "should not be", or is it
> merely "use of this option is just a waste of time, as you would get
> exactly the same result anyway"?  If it is the latter, that is fine.

As far as I can tell, it's the latter.  git send-email can do this same
transformation, but handles mails that already have the transformation
done to them without any issue.

> One thing I absolutely do not want to see is people to start
> repeating their own ident on in-body "From: " header when they send
> their own patch.  That would waste everybody's time pointing out
> "You do not have to do that, it merely adds noise".  As long as you
> can guarantee that your change won't increase the rate of that, I am
> fine with the proposal.

git format-patch with --from *only* adds an in-body "From:" if the
commit author differs from the local committer identity.  So, as far as
I can tell, the only scenario that would produce additional in-body "From:"
headers here would be if someone had failed to configure their git
identity, and manually set the author for their own commits.  (In which
case, they'd also have a broken "From:" in any cover letter they
generated.)

So, it seems exceedingly unlikely to me that this would result in
unnecessary in-body "From:" headers.

- Josh Triplett
