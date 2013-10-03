From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: local URLs are not for ssh
Date: Wed, 2 Oct 2013 21:31:27 -0400
Message-ID: <20131003013127.GA7917@sigill.intra.peff.net>
References: <201309282137.21802.tboegi@web.de>
 <CACsJy8B-wA=bX6+E6O6UvX2vEtOwnR1PCMZNoi-q0x_jacB89Q@mail.gmail.com>
 <524C6885.8020602@web.de>
 <CACsJy8DjPiwpMvLe2p+dGBdpU6iTg2my7tddBsQwLnHiHdG8wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 03 03:31:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRXla-0004VL-Ox
	for gcvg-git-2@plane.gmane.org; Thu, 03 Oct 2013 03:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178Ab3JCBba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Oct 2013 21:31:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:50593 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753001Ab3JCBb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Oct 2013 21:31:29 -0400
Received: (qmail 8456 invoked by uid 102); 3 Oct 2013 01:31:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Oct 2013 20:31:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Oct 2013 21:31:27 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8DjPiwpMvLe2p+dGBdpU6iTg2my7tddBsQwLnHiHdG8wQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235679>

On Thu, Oct 03, 2013 at 08:01:23AM +0700, Nguyen Thai Ngoc Duy wrote:

> > Sorry for the noise, I noticed it when I was trying to construct test cases.
> >
> > What do we think about adding this at the end of t5505:
> 
> As usual more tests are usually better. But is t5505-remote.sh the
> best place? That file seems about "git remote"..

Yeah, agreed. How about at the end of t5601, after the ssh wrapper I set
up here:

  http://article.gmane.org/gmane.comp.version-control.git/235473

I don't know of Jonathan squashed those in to your commit...neither is
in his 'pu' yet.

> > test_expect_success 'fetch fail [noexistinghost0:2223]:blink.git' '
> >         (
> >                 ! git fetch [noexistinghost0:2223]:blink.git 2>err &&
> >                 grep ssh err &&
> >                 rm err
> >         )
> > '

This one looks like basically the same test I added in the message
above (except because of the ssh wrapper, we can check that it did
indeed try to ssh to noexistinghost0:2223).

The other tests can check that we fed ssh various host/port/path
combinations. I'm not clear on what we're expecting, though...

> > test_expect_success 'fetch fail noexistinghost1:2223:blink.git' '
> >         (
> >                 ! git fetch "noexistinghost1:2223:blink.git" 2>err &&
> >                 grep ssh err &&
> >                 rm err
> >         )
> > '

We are expecting this to be host=noexistinghost1, and
path=2223:blink.git?

> > test_expect_success 'fetch fail noexistinghost2:2223' '
> >         (
> >                 ! git fetch "noexistinghost2:2223" 2>err &&
> >                 grep ssh err &&
> >                 rm err
> >         )
> > '

And this is host=noexistinghost2, path=2223?

> > test_expect_success 'fetch fail ./noexistinghost4:2223"' '
> >         (
> >                 ! git fetch "./noexistinghost4:2223" 2>err &&
> >                 grep "does not appear to be a git repository" err &&
> >                 rm err
> >         )
> > '

And this one we would be checking that ssh is _not_ used. It seems
redundant with the "./foo:bar" test already in t5601, but perhaps it is
worth double-checking the numeric path. It would be more robust if we
actually had a repo called "noexistinghost4:2223" and checked that we
did clone it, as the existing test does (maybe that test can just
"s/bar/2223/" ?).

-Peff
