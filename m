From: Jeff King <peff@peff.net>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 10 Jun 2011 16:35:45 -0400
Message-ID: <20110610203545.GA2564@sigill.intra.peff.net>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
 <BANLkTinfVNxYX3kj4DBm1ra=8Ar5ca9UvQ@mail.gmail.com>
 <BANLkTi=PnYmJVXe8tuqdb9UiYnethf1GSw@mail.gmail.com>
 <4DF0EC32.40001@gmail.com>
 <BANLkTimk06eibz99AO_0BwzoL6FWb5pR8A@mail.gmail.com>
 <4DF1CAC1.7060705@op5.se>
 <BANLkTi=4zfO5jKKzbncJk7ihcoHX7Rst4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	NAKAMURA Takumi <geek4civic@gmail.com>,
	git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:36:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV8RG-0005Ps-0p
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 22:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757835Ab1FJUfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 16:35:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46887
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754736Ab1FJUfu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 16:35:50 -0400
Received: (qmail 28765 invoked by uid 107); 10 Jun 2011 20:35:57 -0000
Received: from m180436d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.4.24)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Jun 2011 16:35:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Jun 2011 16:35:45 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=4zfO5jKKzbncJk7ihcoHX7Rst4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175625>

On Fri, Jun 10, 2011 at 12:41:39PM -0700, Shawn O. Pearce wrote:

> Not really.
> 
> The queue isn't sorting by SHA-1. Its sorting by commit timestamp,
> descending. Those aren't pre-hashed. The O(N^2) insertion is because
> the code is trying to find where this commit belongs in the list of
> commits as sorted by commit timestamp.
> 
> There are some priority queue datastructures designed for this sort of
> work, e.g. a calendar queue might help. But its not as simple as a 1
> byte trie.

All you really need is a heap-based priority queue, which gives O(lg n)
insertion and popping (and O(1) peeking at the top). I even wrote one
and posted it recently (I won't dig up the reference, but I posted it
elsewhere in this thread, I think).

The problem is that many parts of the code assume that commit_list is a
linked list and do fast iterations, or even splicing. It's nothing you
couldn't get around with some work, but it turns out to involve a lot
of code changes.

-Peff
