Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736E9C433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5254E613BD
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243426AbhI2A2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 20:28:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:57362 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240715AbhI2A2i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 20:28:38 -0400
Received: (qmail 12198 invoked by uid 109); 29 Sep 2021 00:26:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Sep 2021 00:26:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6628 invoked by uid 111); 29 Sep 2021 00:26:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Sep 2021 20:26:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Sep 2021 20:26:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Joey Hess <joeyh@joeyh.name>, git@vger.kernel.org
Subject: Re: [PATCH] avoid insecure use of mail in man page example
Message-ID: <YVOy0HLvManYQdGo@coredump.intra.peff.net>
References: <20210928121648.1390915-1-joeyh@joeyh.name>
 <YVNi91WYyj3Le6UF@coredump.intra.peff.net>
 <xmqqtui4gt5f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtui4gt5f.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 04:46:52PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Sep 28, 2021 at 08:16:48AM -0400, Joey Hess wrote:
> >
> >> As recently seen in fail2ban's security hole (CVE-2021-32749),
> >> piping user controlled input to mail is exploitable,
> >> since a line starting with "~! foo" in the input will run command foo.
> >> 
> >> This example on the man page pipes to mail. It may not be exploitable.
> >> git rev-list --pretty indents commit messages, which prevents the escape
> >> sequence working there. It's less clear if it might be possible to embed
> >> the escape sequence in a signed push certificate. The user reading the
> >> man page might alter the example to do something more exploitable.
> >> To encourage safe use of mail, add -E 'set escape'
> >
> > Seems like a good goal, but is "-E" portable?
> >
> > On my system, where "mail" comes from the bsd-mailx package, "-E" means
> > "do not send a message with an empty body" and your example command
> > barfs as it tries to deliver to the recipient "set escape".
> >
> > At least we'd want to make a note in the documentation saying what the
> > mysterious "set escape" is doing, and that not all versions of mail
> > would need / want it.
> 
> It is not the primary focus for this documentation page to teach how
> to send e-mails in the first place.  Instead of risking confused
> users rightly complain with "my 'mail' does not understand the -E
> option---what does this do?", I wonder if it is better to just change it to
> 
> 	git rev-list --pretty ...
> -   fi |
> -   mail -s ...    
> +   fi >>/var/log/update.log
> 
> so that it illustrates what's available *out* *of* *us* to the
> authors of the script, without having to teach them "mail" and other
> things we are responsible for.

Yeah, I'd agree that side-stepping the issue entirely is a good
direction. Doing it right is probably best left to tools like
git-multimail.

-Peff
