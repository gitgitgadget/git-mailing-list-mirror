From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Segfault on git describe
Date: Thu, 20 Mar 2014 19:33:08 -0400
Message-ID: <20140320233307.GB7774@sigill.intra.peff.net>
References: <532975FB.9030803@mozilla.com>
 <loom.20140319T224201-156@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dragos Foianu <dragos.foianu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:33:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQmSa-0000qY-SW
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760127AbaCTXdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:33:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:43617 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759912AbaCTXdK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:33:10 -0400
Received: (qmail 28831 invoked by uid 102); 20 Mar 2014 23:33:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 18:33:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 19:33:08 -0400
Content-Disposition: inline
In-Reply-To: <loom.20140319T224201-156@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244617>

On Wed, Mar 19, 2014 at 10:34:29PM +0000, Dragos Foianu wrote:

> The name_rev function recursively calls itself which is why the backtrace is
> so big. Unfortunately, for repos with long histories it can lead to Stack
> Overflows. This is pretty much what happened in your case.
> 
> I tested it on my computer and I get the same results. I managed to get it
> working by doubling my default stacksize:
> 
> ulimit -S -s 16192
> 
> Considering your project is a very large one and merely allocating a few
> more resources fixes the problem, I'm not sure it warrants rewriting the
> function to use less stack. You will have to wait for one of the maintainers
> to give you a definitive answer.

Thanks for looking into the problem.

As a general rule, I think we are interested in reducing recursion in
functions which can go O(depth of history) or deeper. I'd say that
O(lg(depth of history)) is probably OK.

There is some precedent in 941ba8d (Eliminate recursion in
setting/clearing marks in commit list, 2012-01-14), for example.

Also, in:

  abe601b (sha1_file: remove recursion in unpack_entry, 2013-03-27)

  790d96c (sha1_file: remove recursion in packed_object_info,
  2013-03-25)

  2baad22 (index-pack: eliminate recursion in find_unresolved_deltas,
  2012-01-14)

though I think those recurse in the size of delta chain, which is not
nearly so big.

So I think we'd be happy to see it converted to an iterative process
(probably with a stack on the heap). In addition to name-rev, I believe
that "tag --contains" will recurse down the longest history path, too (I
think there may have been experimental patches for the latter, but you'd
have to search the list archive).

-Peff
