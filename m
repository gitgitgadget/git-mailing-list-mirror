From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] fsck: check tag objects' headers
Date: Wed, 3 Sep 2014 18:29:37 -0400
Message-ID: <20140903222937.GA30560@peff.net>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
 <alpine.DEB.1.00.1408281646530.990@s15462909.onlinehome-server.info>
 <xmqqlhq88fyb.fsf@gitster.dls.corp.google.com>
 <xmqqegw08fft.fsf@gitster.dls.corp.google.com>
 <20140829234641.GG24834@peff.net>
 <xmqqwq9o2s6l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 00:29:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPJ3o-0005LM-2R
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 00:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933735AbaICW3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 18:29:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:43820 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933040AbaICW3k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 18:29:40 -0400
Received: (qmail 6472 invoked by uid 102); 3 Sep 2014 22:29:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Sep 2014 17:29:40 -0500
Received: (qmail 23128 invoked by uid 107); 3 Sep 2014 22:29:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Sep 2014 18:29:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Sep 2014 18:29:37 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwq9o2s6l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256427>

On Sun, Aug 31, 2014 at 03:46:42PM -0700, Junio C Hamano wrote:

> If "git fsck" were a tool to validate that the objects and refs are
> in line with how "git-core" plumbing and Porcelain toolset uses the
> underlying Git data model, it makes sense to insist a tag has a name
> that is suitable for a refname, and the tag is pointed by a ref in
> "refs/tags/" followed by its name.  The rules such a "git fsck" should
> implement would be stricter than what the underlying Git data model
> could represent and existing Git tools could handle (i.e. a commit
> with broken ident line may not be usable with "shortlog -e" and would
> be flagged as corrupt).

This is a bit of an aside, but why do we have the "tag" line in the tag
object in the first place?

It is part of the object contents, and therefore is part of the
signature (which the refname is not). That's somewhat redundant with the
tag message itself. E.g., the git v2.0.4 tag says:

  object 32f56600bb6ac6fc57183e79d2c1515dfa56672f
  type commit
  tag v2.0.4
  tagger Junio C Hamano <gitster@pobox.com> 1406755201 -0700

  Git 2.0.4
  -----BEGIN PGP SIGNATURE-----
  ...

Imagine an evil person pushed the signed v2.0.4 tag to refs/tags/v2.1.0
(perhaps because there is a bug in v2.0.4, and they want you to run the
wrong version so they can exploit it). You can check with "git show"
that the "tag" field is actually v2.0.4, but then you could similarly
check that the message says "Git 2.0.4".

The main advantage of the "tag" field is that it is machine-readable,
and that your verification process can check that "git verify-tag
v2.1.0" actually returns a tag that says "tag v2.1.0". But I do not
think we do that verification at all. I wonder if that is something we
should add support for.

You gave examples later in your email of tags that would not necessarily
care about this tag field (and anyway, if "for-linus" is used over and
over, it is subject to these sorts of replays), so I do not think it is
something we would want unconditionally in verify-tag.

I think this may need to be filed under "possible policy flags for
verifying" that we discussed earlier (i.e., in the same boat as "does
the committer ident match the commit signature", as it is a
porcelain-ish policy, not an integral part of the plumbing).

So this is mostly food for thought at this point.

-Peff
