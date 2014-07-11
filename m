From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3 v5] tag: support configuring --sort via .gitconfig
Date: Fri, 11 Jul 2014 14:22:14 -0400
Message-ID: <20140711182214.GF7856@sigill.intra.peff.net>
References: <1405099447-27555-1-git-send-email-jacob.e.keller@intel.com>
 <1405099447-27555-3-git-send-email-jacob.e.keller@intel.com>
 <20140711174628.GC7856@sigill.intra.peff.net>
 <1405102267.22963.35.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:22:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5fSe-0004Ai-4h
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 20:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbaGKSWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 14:22:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:60298 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751424AbaGKSWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 14:22:16 -0400
Received: (qmail 15632 invoked by uid 102); 11 Jul 2014 18:22:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jul 2014 13:22:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jul 2014 14:22:14 -0400
Content-Disposition: inline
In-Reply-To: <1405102267.22963.35.camel@jekeller-desk1.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253309>

On Fri, Jul 11, 2014 at 06:11:08PM +0000, Keller, Jacob E wrote:

> I personally prefer error out on options, even though it can make it a
> bit more difficult, though as far as I know unknown fields simply warn
> or are ignored. (ie: old versions of git just ignore unknown fields in
> configuration).

Right, we _have_ to ignore unknown config options, because we
specifically allow other programs built on git to store their config
with us (and anyway, our callback style of parsing means that no single
callback knows about all of the keys).

In the past we have staked out particular areas of the namespace,
though. E.g., the diff code said "I own all of color.diff.*, and if you
put in something I don't understand, I'll complain". That ended up being
annoying, and now we ignore slots we don't understand there.

So old gits will always silently ignore tag.sort if they don't know
about it, and we can't change that. The only thing we can change is:

> It's possible we should warn instead though, so that older gits work
> with new sorts that they don't understand.

Right. I think other config variables in similar situations will barf.
This is backwards-compatible as long as the new variables are a superset
(i.e., we only add new understood values, never remove or change the
meaning of existing values). It's just not forwards-compatible.

> I am ok with warning but I don't know the best practice for how to warn
> here instead of failing. Returning error causes a fatal "bad config"
> message. Any thoughts?

The simplest thing is ignoring the return from parse_sort_string and
just calling "return 0". That will still say "error:", but continue on.
If you really want it to say "warning:", I think you'll have to pass a
flag into parse_sort_string. I'm not sure if it's worth the effort.

-Peff
