From: Jeff King <peff@peff.net>
Subject: Re: Migrating away from SHA-1?
Date: Thu, 14 Apr 2016 22:13:27 -0400
Message-ID: <20160415021327.GC22112@sigill.intra.peff.net>
References: <570D78CC.9030807@zytor.com>
 <CAGZ79kaUN0G7i0GNZgWU7ZzJvWY=k=Rc6tqWvJsTu8gcRhP5bA@mail.gmail.com>
 <1460502934.5540.71.camel@twopensource.com>
 <20160414015324.GA16656@thunk.org>
 <1460654583.5540.87.camel@twopensource.com>
 <71A5D062-FCCD-42E5-80A8-AA9D8DE20604@zytor.com>
 <20160414224051.GD16656@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	David Turner <dturner@twopensource.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 15 04:13:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqtGJ-0004Kq-CF
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 04:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbcDOCNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 22:13:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:49891 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751775AbcDOCNa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 22:13:30 -0400
Received: (qmail 7605 invoked by uid 102); 15 Apr 2016 02:13:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 22:13:30 -0400
Received: (qmail 5921 invoked by uid 107); 15 Apr 2016 02:13:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 22:13:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2016 22:13:27 -0400
Content-Disposition: inline
In-Reply-To: <20160414224051.GD16656@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291594>

On Thu, Apr 14, 2016 at 06:40:51PM -0400, Theodore Ts'o wrote:

> Also, remember that while we can write programs that look for
> suspicious git objects that have stuff hidden after the null
> terminator (in fact, maybe that would be a good thing to add to git,
> hmmm?)[...]

Detecting the hidden bytes is underway elsewhere on the list. And while
I think it's a good idea to do so, I don't think it really introduces
a meaningful defense against collision attacks.

You can also hide bytes in arbitrary headers in a git object[1], and
they will not be shown by default. Adding the extra bytes at the end is
certainly easier if you're micro-optimizing the collision process[2],
but I don't think it changes the fundamental equation. It reduces the
work you do per-sha1 by a constant factor, but not the number of sha1s
you expect to compute.

-Peff

[1] Obviously neither "extra headers" nor "stuff after NUL" applies to
    patches sent by email, where everything short of binary-diffs is
    human-readable. So for the kernel, you're really talking about
    attacking a lieutenant whose repo gets pulled. But there are plenty
    of other projects that "git merge" from strangers.

[2] Somewhere in the list archive is my patch to find partial
    collisions like "git commit --sha1=31337", and I did in fact use
    that micro-optimization. That, along with multi-threading, made it
    feasible to do 6-8 character prefixes, as I recall.
