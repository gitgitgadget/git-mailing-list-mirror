From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Using gitrevisions :/search style with other operators
Date: Tue, 9 Nov 2010 00:16:31 -0500
Message-ID: <20101109051631.GA19867@sigill.intra.peff.net>
References: <9D675671-693D-4B59-AF2A-0EFE4C537362@sb.org>
 <7vpqufpr7f.fsf@alter.siamese.dyndns.org>
 <4F75AA0C-B68A-4ABB-B67A-D7F62D989655@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Nov 09 06:19:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFgbr-0001uH-Lz
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 06:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120Ab0KIFPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 00:15:37 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:50186 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857Ab0KIFPh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 00:15:37 -0500
Received: (qmail 4579 invoked by uid 111); 9 Nov 2010 05:15:35 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 09 Nov 2010 05:15:35 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Nov 2010 00:16:31 -0500
Content-Disposition: inline
In-Reply-To: <4F75AA0C-B68A-4ABB-B67A-D7F62D989655@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161016>

On Mon, Nov 08, 2010 at 02:11:54PM -0800, Kevin Ballard wrote:

> >    $ git log 'HEAD..:( :/Merge branch 'kb/blame-author-email' )^2'
> > 
> > I haven't visited the particular codepath for some time, so I don't know
> > offhand how involved the change would be, though.
> 
> Interesting idea. It certainly solves the problem of being able to embed it
> within other operations (though you do then have to worry about escaping any
> embedded close-parens in the search), though it does mean my suggestion for
> being able to select the 2nd (or nth) match won't work. When I have the time
> I'll start taking a look at the code.
> 
> Any comments on my suggestion to specify the ref to search from, e.g.
> origin/pu:/"Merge 'kb/blame-author-email'"? As I stated before, I believe

It seems to me the natural way to do that would be to use our existing
generic "start at this ref and follow some chain" syntax, which is
ref^{foo}. For example: origin/pu^{:Merge 'kb/blame-author-email'}.

We already use it for "follow tree link" and "peel tag objects", and it
is syntactically similar to the usual "follow the ancestry chain" syntax
("ref^"). And I believe it should be unambiguous, as nothing that could
go in ^{} could start with ":". And presumably one would have to
backslash-escape embedded closing curly braces.

We also have ref@{upstream}. The analogue here would be
origin/pu@{:Merge 'kb/blame-author-email'}.

I don't recall whether we put any conscious thought into ref@{upstream}
versus ref^{upstream}. Certainly the former implies to me finding a
particular starting point (as we do for reflogs), and the latter implies
walking object graph (either by parent ancestry links, or through
dereferencing tag and commit pointers). But I may just be rationalizing
after the fact. :)

Certainly this particular case seems to me to be more like "^" or "~";
you are walking the ancestry tree not a specific number of steps, but
until you see a particular subject.

-Peff
