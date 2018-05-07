Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 889EE1F42E
	for <e@80x24.org>; Mon,  7 May 2018 09:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbeEGJpD (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 05:45:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:58604 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751042AbeEGJpC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 05:45:02 -0400
Received: (qmail 2375 invoked by uid 109); 7 May 2018 09:45:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 May 2018 09:45:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25118 invoked by uid 111); 7 May 2018 09:45:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 May 2018 05:45:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2018 05:45:00 -0400
Date:   Mon, 7 May 2018 05:45:00 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Ben Toews <btoews@github.com>
Subject: Re: [PATCH 8/8] gpg-interface: handle alternative signature types
Message-ID: <20180507094459.GA3412@sigill.intra.peff.net>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
 <20180409204129.43537-9-mastahyeti@gmail.com>
 <CAPig+cT3AobThgZ15iquyRQG0Qes1ZzQxycXcgHYuwQCuDEDBQ@mail.gmail.com>
 <20180414195954.GB14631@genre.crustytoothpaste.net>
 <xmqqbmejyc4j.fsf@gitster-ct.c.googlers.com>
 <20180417001212.GC14631@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180417001212.GC14631@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 17, 2018 at 12:12:12AM +0000, brian m. carlson wrote:

> > That argues more strongly that we would regret unless we make the
> > end-user configuration to at least the whole string (which later can
> > be promoted to "a pattern that matches the whole string"), not just
> > the part after mandatory "-----BEGIN ", methinks.
> 
> Yeah, I think this patch set is "add gpgsm support", which I can see as
> a valuable goal in and of itself, but I'm not sure the attempt to make
> it generic is in the right place.  If we want to be truly generic, the
> way to do that is to invoke a helper based on signature type (e.g.
> git-sign-gpg, git-sign-gpgsm, git-sign-signify) to do the signing and
> verification.  We need not ship these helpers ourselves; interested
> third-parties can provide them, and we can add configuration to match
> against regexes for non-built-in types (which is required for many other
> formats).

Isn't that basically what this patch is, though? Or at least a step in
that direction? For generic signing support, you need:

  1. A way to tell Git to recognize that a signature exists, and what
     type it is.

  2. A way to tell Git how to invoke the signing tool.

Let me discuss (2) first.  In your git-sign-* world, then (2) requires
us to define a set interface to those helpers, including which action to
perform, which key to use, etc. And then the logic is inside the helper
to translate that to the tool's interface.

The direction I anticipated for this patch was more like:

 - for now, we just piggy-back on gpg's interface for interacting with
   sub-programs. That makes gpgsm Just Work, and it means that you can
   plug in any other tool by writing a wrapper which converts from gpg
   options to the tool's interface. I.e., gpg's "-bsau" becomes the
   lingua franca, rather than us inventing a new one.

 - the config schema leaves room for adding new properties to each tool.
   So eventually we could support other option microformats by adding
   signingtool.foo.interface = "signify" or whatever.

   That still leaves room if we want to design our own helper interface.
   One thing we could do that this patch doesn't is require the user to
   explicitly ask for "interface = gpg" (and set it by default for the
   gpg tool stanza). And then leave it as an error if you have a tool
   config that doesn't specify its interface type, which leaves room for
   us later to make that default our generic interface.

Getting back to (1), how do we tell Git to recognize a signature? I
think we have to use config here, since it would not know to invoke a
helper without recognizing the type (and we certainly do not want to
speculatively invoke each helper saying "do you understand this?" for
efficiency reasons).

So let's assume we have some config to do matching. What should that
look like? Is it a substring match? A line match? A regex? There's a
continuum of matching techniques that trade off simplicity for
flexibility. My thought was that we'd eventually need to add multiple
matching methods, and users can pick the one that's simplest for the
format they're using.

So here we add pem-type matching, which errs very much on the side of
"very specific and easy, but not very flexible". We can go further down
the continuum to "match a line" and require the user say the full:

  [signingtool "gpg"]
  matchLine = "----- BEGIN PGP SIGNATURE -----"

(obviously they don't need to reconfigure gpg, but imagine they have a
new similar tool). That's not too bad. But does it extend things enough
to match other types? It sounds like signify doesn't use a line-oriented
armoring, and even matching a whole line wouldn't be enough. So now
we've erred on the other side; we made something more generic, but it's
not clear if it's actually generic enough to be useful.

So I'm open to the idea of line-matching, since the config above isn't
significantly more complicated than the current pemType matcher. It does
mean we can't later do pem-specific things, like matching the "END"
delimiter of the block (but so far we haven't needed to do that, since
the detached signature is always supposed to come at the end of the
content).

But I'm not sure we're ready to go any further in making it generic,
since we don't know what the requirements will be (and won't until
somebody starts trying to plug in a new tool).

-Peff
