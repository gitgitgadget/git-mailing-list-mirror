From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] introduce git root
Date: Thu, 4 Dec 2014 16:12:32 -0500
Message-ID: <20141204211232.GC19953@peff.net>
References: <1417291211-32268-1-git-send-email-arjun024@gmail.com>
 <2AC7B765F56B4AA8A0DB76E8C670A889@PhilipOakley>
 <CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
 <vpqoaro99xd.fsf@anie.imag.fr>
 <xmqqd284rryz.fsf@gitster.dls.corp.google.com>
 <CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
 <20141202070415.GC1948@peff.net>
 <xmqqd282m09j.fsf@gitster.dls.corp.google.com>
 <20141204092251.GC27455@peff.net>
 <xmqqlhmntf02.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 22:12:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwdhW-0008ME-Qu
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 22:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809AbaLDVMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 16:12:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:48537 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754715AbaLDVMe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 16:12:34 -0500
Received: (qmail 20638 invoked by uid 102); 4 Dec 2014 21:12:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 15:12:34 -0600
Received: (qmail 9444 invoked by uid 107); 4 Dec 2014 21:12:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 16:12:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Dec 2014 16:12:32 -0500
Content-Disposition: inline
In-Reply-To: <xmqqlhmntf02.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260802>

On Thu, Dec 04, 2014 at 11:02:37AM -0800, Junio C Hamano wrote:

> > Christian raised the issue of cluttering the "git --option" namespace,
> > and I do agree that's a potential issue. 
> 
> I am not sure if that is an issue at all.  You will need the same
> number of options to cover all the necessary "computables" somewhere
> anyway.
> 
> "git --show-this-or-that-computable" is not more or not less
> cluttering compared to "git var --show-this-or-that-computable".

My issue is only that "git --foo" has other options besides computables.
So you need to name each option in a way that makes it clear it is
reporting a computable and not doing something else.

Take "git --pager" for instance. That would be a natural choice to
replace "git var GIT_PAGER". But shouldn't "--pager" be the opposite of
the existing "--no-pager"?

So instead we probably need some namespace to indicate that it is a
"showing" option. Like "--show-pager". And then for consistency, we
would probably want to move "--exec-path" to "--show-exec-path",
creating a new "--show-" namespace. Or we could call that namespace
"git var". :)

> I understand we are not talking about removing "git --exec-path",
> but the desire is to have one single command the user can go to ask
> about all the computables.  If "var" is to become that single
> command, then we need to keep the interface to it uniform and
> consistent, and telling the users to use "git var GIT_PAGER" and
> "git var --exec-path" in the same script will not fly well.  Also
> these GIT_$COMPUTABLE_NAME appear as if they can be influenced by
> setting environment variables of the same name, which invites
> further confusion.  This is especially bad because some of then do
> get affected by environment (i.e. GIT_EDITOR="vi" has effect, but
> GIT_AUTHOR_IDENT="Gitster <gitster@pobox.com>" does not).

I do not think "git var --exec-path" is a good idea, nor GIT_EXEC_PATH
for the environment-variable confusion you mentioned. I was thinking of
just creating a new namespace, like:

  git var exec-path
  git var author-ident

and deprecating the 4 existing GIT_* variables.

> If we admit that "git var" was a failed experiment that gained only
> four fake variables for the past 10 years, it will not be too much
> trouble and transition pain to turn the existing ones into option
> form, like --author-ident etc., like your original proposal did, I
> would think.

I am also OK with that, if the details turn out to be not too ugly once
somebody starts digging in. I was just anticipating some ugliness in
advance. :) But I am not planning to work on it in the immediate future,
so whoever does can make that call.

-Peff
