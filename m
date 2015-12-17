From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] revision.c: propagate tag names from pending array
Date: Thu, 17 Dec 2015 17:14:59 -0500
Message-ID: <20151217221459.GB8150@sigill.intra.peff.net>
References: <20151217064706.GA3531@sigill.intra.peff.net>
 <xmqqoadobz0f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 23:15:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9gpK-0004v2-0y
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 23:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933624AbbLQWPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 17:15:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:43961 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933574AbbLQWPD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 17:15:03 -0500
Received: (qmail 17911 invoked by uid 102); 17 Dec 2015 22:15:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 16:15:02 -0600
Received: (qmail 18558 invoked by uid 107); 17 Dec 2015 22:15:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 17:15:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Dec 2015 17:14:59 -0500
Content-Disposition: inline
In-Reply-To: <xmqqoadobz0f.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282682>

On Thu, Dec 17, 2015 at 12:28:48PM -0800, Junio C Hamano wrote:

> By the way, a totally unrelated niggle I have with 2073949 is this.
> 
>     $ git describe --contains 2073949
>     v2.3.1~3^2~4
> 
> while as you said, this dates back to at least v2.2.0-rc0
> 
>     $ git tag --contains 2073949
>     v2.2.0
>     v2.2.0-rc0
>     ...
>     v2.7.0-rc1
> 
> That "describe --contains" output comes from "name-rev --tags", and
> I need to force it to use v2.2.0-rc0 as the source of naming, i.e.
> 
>     $ git name-rev --refs=refs/tags/v2.2.0-rc0 2073949
>     2073949 tags/v2.2.0-rc0~13^2~9
> 
> to get what I would expect to be more useful.
> 
> I know "name-rev --contains" wants to describe a commit based on an
> anchor point that is topologically closest, and even though I do not
> offhand think of any, I am sure there are valid use cases that want
> to see the current behaviour.  But from time to time, I wish it did
> its naming taking the topological age of the anchor points into
> account.  If a commit is contained in v2.2.0-rc0 and onward, even
> though v2.0.0-rc0~13^2~9 describes a longer path from v2.0.0-rc0
> than v2.3.1~3^2~4 is from v2.3.1, I often want to see the name based
> on the "oldest" tag (if such a thing exists, and for older commits
> in this project, it always is the case, I think).

Yes, I agree (and judging by the number of "git describe is confusing"
threads over the years, I think it is not just us). I rarely use "git
describe --contains" myself. What I typically use (and how I arrived at
v2.2.0 in this instance) is:

  git tag --contains "$@" |
  grep ^v |
  grep -v -- -rc |
  sort -V |
  head -1

But there are some git-specific assumptions in there.

-Peff
