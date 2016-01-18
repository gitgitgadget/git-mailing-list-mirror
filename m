From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] shortlog: match both "Author:" and "author" on stdin
Date: Mon, 18 Jan 2016 14:26:21 -0500
Message-ID: <20160118192621.GA981@sigill.intra.peff.net>
References: <20160115170627.GA20983@sigill.intra.peff.net>
 <20160115170823.GA21102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 20:26:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLFRd-00007N-HA
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 20:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbcART0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 14:26:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:55567 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932357AbcART0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 14:26:24 -0500
Received: (qmail 29535 invoked by uid 102); 18 Jan 2016 19:26:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 14:26:24 -0500
Received: (qmail 12963 invoked by uid 107); 18 Jan 2016 19:26:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 14:26:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2016 14:26:21 -0500
Content-Disposition: inline
In-Reply-To: <20160115170823.GA21102@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284304>

On Fri, Jan 15, 2016 at 12:08:23PM -0500, Jeff King wrote:

> The original git-shortlog could read both the normal "git
> log" output as well as "git log --format=raw". However, when it was
> converted to C by b8ec592 (Build in shortlog, 2006-10-22),
> the trailing colon became mandatory, and we no longer
> matched the raw output.
> 
> Given the amount of intervening time without any bug
> reports, it's probable that nobody cares. But given that
> it's easy to fix, and that the end result is hopefully more
> obvious and flexible (it could now easily accomodate matching
> "Committer"), let's just make it work.

I rebased the rest of my shortlog-trailer series on this, and sadly,
this final sentence isn't quite true.

The regular "git log" output uses "Commit:" for the committer line, and
the raw output uses "committer". So the match_ident_header function
_can't_ be reused.

So it's not wrong, but it's perhaps more complicated than it needs to
be. We could scrap this patch in favor of just:

  if (!skip_prefix(author, "Author: ", &v) &&
      !skip_prefix(author, "author ", &v))
          continue;

That is technically more strict (it does not take "author: ", which is
accepted by the current code), but matches "git log" and "git log --raw"
output, and misses nothing that git has ever generated. And it extends
naturally to:

  if (!skip_prefix(author, "Commit: ", &v) &&
      !skip_prefix(author, "committer ", &v))
          continue;

-Peff
