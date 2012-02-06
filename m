From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] tag: add --points-at list option
Date: Mon, 6 Feb 2012 02:13:02 -0500
Message-ID: <20120206071302.GA10447@sigill.intra.peff.net>
References: <1328480887-27463-1-git-send-email-tmgrennan@gmail.com>
 <20120206000420.GC28735@sigill.intra.peff.net>
 <20120206063213.GC10489@tgrennan-laptop>
 <20120206070424.GC9931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 08:13:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuIlC-0008HI-PD
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 08:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036Ab2BFHNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 02:13:06 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58621
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab2BFHNF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 02:13:05 -0500
Received: (qmail 24515 invoked by uid 107); 6 Feb 2012 07:20:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 02:20:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 02:13:02 -0500
Content-Disposition: inline
In-Reply-To: <20120206070424.GC9931@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190035>

On Mon, Feb 06, 2012 at 02:04:24AM -0500, Jeff King wrote:

> > >Before your patch, a tag whose sha1 could not be read would get its name
> > >printed, and then we would later return without printing anything more.
> > >Now it won't get even the first bit printed.
> > >
> > >However, I'm not sure the old behavior wasn't buggy; it would print part
> > >of the line, but never actually print the newline.
> > 
> > If you prefer, I can restore the old behavior just moving the
> > condition/return back below the refname print; then add "buf" qualifier
> > to the following fragment and at each intermediate free.
> 
> Thinking on it more, your behavior is at least as good as the old. And
> it only comes up in a broken repo, anyway, so trying to come up with
> some kind of useful outcome is pointless.

Sorry to reverse myself, but I just peeked at the show_reference
function one more time. Unconditionally moving the buffer-reading up
above the "if (!filter->lines)" conditional is not a good idea.

If I do "git tag -l", right now git doesn't have to actually read and
parse each object that has been tagged (lightweight or not). If I use
"git tag -n10", then obviously we do need to read it (and we do). And if
we use your new "--points-at", we also do. But if neither of those
options are in use, it would be nice to avoid the object lookup (it may
not seem like much, but if you have a repo with an insane number of
tags, it can add up).

> BTW, writing that helped me notice two bugs in your patch:
> 
>   1. You read up to 47 bytes into the buffer without ever checking
>      whether size >= 47.
> 
>   2. You never check whether the object you read from read_sha1_file is
>      actually a tag.

Hmm, the "filter->lines" code for "git tag -n" makes a similar error. It
should probably print nothing for objects that are not tags.

-Peff
