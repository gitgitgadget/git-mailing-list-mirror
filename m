From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Tue, 7 Jun 2016 18:29:09 -0400
Message-ID: <20160607222908.GA25631@sigill.intra.peff.net>
References: <20160607195608.16643-1-santiago@nyu.edu>
 <xmqq7fe0pv5b.fsf@gitster.mtv.corp.google.com>
 <20160607211707.GA7981@sigill.intra.peff.net>
 <xmqq37oopt28.fsf@gitster.mtv.corp.google.com>
 <20160607215536.GA20768@sigill.intra.peff.net>
 <xmqqy46gods1.fsf@gitster.mtv.corp.google.com>
 <20160607220743.GA21043@sigill.intra.peff.net>
 <CAPc5daV=gqDLeFLB2csJDvNo4fpSKW_FjoB10TyroapQiHFq=A@mail.gmail.com>
 <20160607221325.GA21166@sigill.intra.peff.net>
 <xmqqk2i0od1f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: santiago@nyu.edu, Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 00:31:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAPUr-0006g8-AT
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 00:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933678AbcFGW3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 18:29:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:50899 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933136AbcFGW3M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 18:29:12 -0400
Received: (qmail 11776 invoked by uid 102); 7 Jun 2016 22:29:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 18:29:11 -0400
Received: (qmail 2679 invoked by uid 107); 7 Jun 2016 22:29:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 18:29:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2016 18:29:09 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk2i0od1f.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296740>

On Tue, Jun 07, 2016 at 03:21:48PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If you are suggesting that you can do the whole thing today by parsing
> > the tag object yourself, then sure, I agree. I thought the point of the
> > exercise was to make that less painful for the callers.
> 
> Yes, and I somehow thought everybody agreed that --show-tag-name was
> striking the balance at about the right level for ease-of-use and
> simplicity?

No, I think "--format" would be much better, unless you want to add a
separate "--show-tagger-ident" when somebody wants to do a check between
the tagger's ident and the key uid.

But either way, I think the whole "do a rev-parse first" thing raises
the question of what object identifiers "git tag" would accept. We would
presumably expect:

  git tag --show-tag-name v1.0

to work. And I think in your world-view, so would:

  git tag --show-tag-name $(git rev-parse v1.0)

How about:

  git tag --show-tag-name refs/tags/v1.0

And what about:

  git tag --show-tag-name refs/remotes/foo/v1.0

or even:

  git tag --show-tag-name foo/v1.0

when refs/remotes/foo/v1.0 exists?

The rule right now is generally that "git tag" takes actual tag names.
Plumbing like "verify-tag" takes arbitrary get_sha1() expressions, but
you're expected to qualify or resolve your refnames before you get
there, to avoid weird situations. This "tag --show-tag-name" seems to
sit in the middle of plumbing and porcelain (for that matter, I am not
sure that it should belong to git-tag at all, as it is really about
scripting).

-Peff
