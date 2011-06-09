From: Jeff King <peff@peff.net>
Subject: Re: Git is not scalable with too many refs/*
Date: Thu, 9 Jun 2011 12:26:04 -0400
Message-ID: <20110609162604.GC25885@sigill.intra.peff.net>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
 <BANLkTinfVNxYX3kj4DBm1ra=8Ar5ca9UvQ@mail.gmail.com>
 <BANLkTi=PnYmJVXe8tuqdb9UiYnethf1GSw@mail.gmail.com>
 <4DF0EC32.40001@gmail.com>
 <BANLkTimk06eibz99AO_0BwzoL6FWb5pR8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	NAKAMURA Takumi <geek4civic@gmail.com>,
	git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 18:26:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUi3v-0003oC-LL
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 18:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056Ab1FIQ0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 12:26:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43479
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446Ab1FIQ0N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 12:26:13 -0400
Received: (qmail 15318 invoked by uid 107); 9 Jun 2011 16:26:20 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 12:26:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 12:26:04 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimk06eibz99AO_0BwzoL6FWb5pR8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175548>

On Thu, Jun 09, 2011 at 08:56:50AM -0700, Shawn O. Pearce wrote:

> A lot of operations toss every commit that a reference points at into
> the revision walker's LRU queue. If you have a tag pointing to every
> commit, then the entire project history enters the LRU queue at once,
> up front. That queue is managed with O(N^2) insertion time. And the
> entire queue has to be filled before anything can be output.

We ran into this recently at github. Since our many-refs repos were
mostly forks, we had a lot of duplicate commits, and were able to solve
it with ea5f220 (fetch: avoid repeated commits in mark_complete,
2011-05-19).

However, I also worked up a faster priority queue implementation that
would work in the general case:

  http://thread.gmane.org/gmane.comp.version-control.git/174003/focus=174005

I suspect it would speed up the original poster's slow fetch. The
problem is that a fast priority queue doesn't have quite the same access
patterns as a linked list, so replacing all of the commit_lists in git
with the priority queue would be quite a painful undertaking. So we are
left with using the fast queue only in specific hot-spots.

-Peff
