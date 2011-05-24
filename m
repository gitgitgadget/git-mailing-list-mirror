From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] combine-diff: respect textconv attributes
Date: Tue, 24 May 2011 14:52:46 -0400
Message-ID: <20110524185246.GA584@sigill.intra.peff.net>
References: <20110523201529.GA6281@sigill.intra.peff.net>
 <20110523203105.GE6298@sigill.intra.peff.net>
 <7vk4dg83yy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 20:52:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOwiu-0007qa-6D
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 20:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755849Ab1EXSwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 14:52:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54747
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753080Ab1EXSwt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 14:52:49 -0400
Received: (qmail 20816 invoked by uid 107); 24 May 2011 18:52:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 May 2011 14:52:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 May 2011 14:52:46 -0400
Content-Disposition: inline
In-Reply-To: <7vk4dg83yy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174334>

On Tue, May 24, 2011 at 09:20:53AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This patch converts file contents according to textconv attributes. The
> > implementation is slightly ugly; because the textconv code is tightly
> > linked with the diff_filespec code, we temporarily create a
> > diff_filespec during conversion.
> 
> After reading this patch again, I think this aversion to diff_filespec is
> probably unjustified.

It's not an aversion to diff_filespec; it's an aversion to only half
buying-into diff_filespec. I think the best thing would be rewriting all
of combine-diff in terms of diff_filespec; I just started to do it and
it looked big and ugly for not much gain.

It's a little ugly to have to manually do the conversion into another
data structure just to call a function like fill_textconv, but I can
live with it. What I worry about more is that the ad-hoc use of a
structure like diff_filespec means we are violating some assumption that
other code has about the data structure (e.g., the bug Jay already
uncovered that we must have a valid name in the "path" field).

I think what is there now is correct; it's just that as a general rule,
switching data formats or abstractions in the middle of code makes me
feel I'm doing something wrong (or that the code interfaces need to be
refactored).

> If anything else, we should be using the type in _more_ codepaths that are
> not diff related but want to represent a path with its contents in the git
> namespace (be it from working tree, index or a tree), not less, and in the
> longer term weaken functions like fill_textconv() that take diff_filespec
> to take filespec so that they can be made more reusable.

Yeah, I would agree with that.

-Peff
