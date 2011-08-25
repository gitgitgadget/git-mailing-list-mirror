From: Jeff King <peff@peff.net>
Subject: Re: git-config: case insensitivity for subsections
Date: Thu, 25 Aug 2011 16:58:49 -0400
Message-ID: <20110825205849.GA10384@sigill.intra.peff.net>
References: <20110818063528.GH13342@hal.rescomp.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: milki <milki@rescomp.berkeley.edu>
X-From: git-owner@vger.kernel.org Thu Aug 25 22:59:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwh0s-0002d3-Gs
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 22:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688Ab1HYU6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 16:58:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51844
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754509Ab1HYU6w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 16:58:52 -0400
Received: (qmail 19071 invoked by uid 107); 25 Aug 2011 20:59:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Aug 2011 16:59:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Aug 2011 16:58:49 -0400
Content-Disposition: inline
In-Reply-To: <20110818063528.GH13342@hal.rescomp.berkeley.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180115>

On Wed, Aug 17, 2011 at 11:35:28PM -0700, milki wrote:

> If I define [section.SUBSECTION] (aka, not all lowercase), I cannot
> use: git config section.SUBSECTION.option, but rather only git config
> section.subsection.option.

The way the config code works (both internally and via git-config), is
to read through the config files, convert each key into a canonical
format (downcasing the section and key, and either preserving the
case for the subsection in '[section "FOO"]' or downcasing it for
'[section.FOO]'), and then compare the result to the canonical version
of what you're looking for.

In other words, if you want to match section.SUBSECTION, you should
always ask for the canonical version "section.subsection.whatever".

We could try to be nicer and handle this automatically, but it's
nontrivial. When you say "git config foo.BAR.baz", we don't know if you
mean for "BAR" to be case-insensitive or not. So it would involve
carrying more information around about how the section header in the
config file was actually parsed. Not impossible, but it would involve
changing the internal git_config interface and tweaking a lot of code to
match.

Is there a reason that you can't use the canonical version in your "git
config" invocation? Or was it simply confusing that it didn't work? I'd
much prefer to document this limitation in git-config(1) than change the
code.

> Furthermore, If I also define a [section "SUBSECTION"], the two
> sections are not merged.

I'm not sure it makes sense to do so. I can see how:

  [section.SUBSECTION]

and

  [section.subsection]

should be merged. But isn't:

  [section "SUBSECTION"]

conceptually a different section entirely?

Again, do you have a real-world use for this?

-Peff
