From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fsck: properly bound "invalid tag name" error message
Date: Mon, 8 Dec 2014 00:57:06 -0500
Message-ID: <20141208055706.GA30207@peff.net>
References: <20141208054812.GA30154@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 08 06:57:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxrJp-0002Lh-64
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 06:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbaLHF5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 00:57:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:49815 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752184AbaLHF5H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 00:57:07 -0500
Received: (qmail 26224 invoked by uid 102); 8 Dec 2014 05:57:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 07 Dec 2014 23:57:07 -0600
Received: (qmail 20458 invoked by uid 107); 8 Dec 2014 05:57:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Dec 2014 00:57:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Dec 2014 00:57:06 -0500
Content-Disposition: inline
In-Reply-To: <20141208054812.GA30154@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260999>

On Mon, Dec 08, 2014 at 12:48:12AM -0500, Jeff King wrote:

> Note that when fscking tags with "index-pack --strict", this
> is even worse. index-pack does not add a trailing
> NUL-terminator after the object, so we may actually read
> past the buffer and print uninitialized memory. Running
> t5302 with valgrind does notice the bug for that reason.

This merits an additional note (but fortunately not a patch :) ).

After writing the above, I thought for a moment that we might actually
read past the end of the buffer in some cases, but I convinced myself
otherwise. And I think Dscho and I might have even had this conversation
off-list a while ago, but I think it is worth pointing out so that
nobody else has to dig into it.

For the most part, we are fine because we parse the object
left-to-right, and barf as soon as we see something unusual (and for
this reason, fsck_commit_buffer is also fine). The two suspicious places
are:

  1. We call strchr(buffer, '\n'), which looks like it could read
     unbounded when "buffer" is not NUL-terminated. However, early in
     the function we confirm that it contains "\n\n", and we will not
     have parsed past that here. Therefore we know that we will always
     hit a newline.

  2. After finding and parsing a line whose trailing newline is marked
     by "eol", we then set "buffer = eol + 1". This would be wrong if
     eol is at the very end of the buffer (the next step would then
     start reading uninitialized memory).

     But again we are saved by the "\n\n" check. The strchr will always
     find the first, so we know that we have at least one character
     after it (and that character is a newline, which cannot be the
     start of a new header, which will cause us to stop parsing).

I do admit that I am tempted to teach index-pack to always NUL-terminate
objects in memory that we feed to fsck, just to be on the safe side. It
doesn't cost much, and could prevent a silly mistake (either in the
future, or one that I missed in my analysis). The fsck code otherwise
generally expects to get the output of read_sha1_file, which has the
safety-NUL appended.

-Peff
