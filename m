From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Thu, 27 Oct 2011 17:19:05 -0700
Message-ID: <20111028001905.GA10802@sigill.intra.peff.net>
References: <7v39ej5uqb.fsf@alter.siamese.dyndns.org>
 <7vy5wb3sto.fsf@alter.siamese.dyndns.org>
 <20111024224558.GB10481@sigill.intra.peff.net>
 <7vvcrd411x.fsf@alter.siamese.dyndns.org>
 <20111027181303.GF1967@sigill.intra.peff.net>
 <7v7h3qz2yo.fsf@alter.siamese.dyndns.org>
 <20111027185220.GA26621@sigill.intra.peff.net>
 <7v39eez1ph.fsf@alter.siamese.dyndns.org>
 <20111027234429.GA28187@sigill.intra.peff.net>
 <7v1utyx9ri.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 02:19:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJaAI-0008Or-RH
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 02:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447Ab1J1ATL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 20:19:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56864
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996Ab1J1ATK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 20:19:10 -0400
Received: (qmail 5927 invoked by uid 107); 28 Oct 2011 00:24:57 -0000
Received: from c-67-169-41-183.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.41.183)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Oct 2011 20:24:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Oct 2011 17:19:05 -0700
Content-Disposition: inline
In-Reply-To: <7v1utyx9ri.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184333>

On Thu, Oct 27, 2011 at 05:03:29PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > My interest is to make things like bare-repository diff (and everything
> > built on it; i.e., things like github, gitweb, or whatever) do the sane
> > thing for these people, even if I think what they're doing is wrong.
> 
> I do not think we are talking about right or wrong. I was primarily saying
> that textconv may not be the right thing (think github/gitweb showing blob
> contents, nicely formatted inside the chrome the site provides).

But I think it is probably a wrong thing to store utf-16 as the
canonical format inside the git repository. Git simply can't handle it
for diffing. And the right thing, as you suggested, is clean/smudge.

But I'm dealing with repositories on the server side, where it is too
late to do clean/smudge; I just get whatever junk people commited.

> We have in-repository representation that diff and grep and friends work
> on, and output conversion layer that externalizes the result of them in
> the form of "smudge". Another layer above the in-repository representation
> and below operations could convert UTF-16 to UTF-8 when going outward and
> in the opposite when going inward.

I'm not sure that could sanely be done in a backwards compatible way.
Doing it with just textual diffs is a hack, of course, but at least we
know that the damage is limited, and the diff we generate on top doesn't
care that much about the original sha1s[1]. But should read_object_sha1
learn to convert utf-16 into utf-8? I think madness lies that way, as
we are breaking assumptions about sha1 validity.

-Peff

[1] Actually, the text diff does mention the original and resulting
sha1s, which would now either bear no relation to the diff text, or bear
no relation to what's in the repo. Either way, I think we are creating
something that can't necessarily be applied, which is bad. And is why I
thought of textconv, which is basically the same concept (and has the
same problems).
