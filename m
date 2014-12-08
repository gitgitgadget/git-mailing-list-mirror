From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fsck: properly bound "invalid tag name" error message
Date: Mon, 8 Dec 2014 12:17:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412081201180.13845@s15462909.onlinehome-server.info>
References: <20141208054812.GA30154@peff.net> <20141208055706.GA30207@peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 08 12:17:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxwJd-0001BS-Qu
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 12:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726AbaLHLRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 06:17:18 -0500
Received: from mout.gmx.net ([212.227.15.18]:57354 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151AbaLHLRR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 06:17:17 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0MCtql-1Y73FU1fdL-009j0q;
 Mon, 08 Dec 2014 12:17:11 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20141208055706.GA30207@peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:2+/hwq9FeEvE2f16finaVNcS2HYFjZOZst5G3HTecmym0CM4EOT
 eHlHuQnvsLM8O2jE3O6NX96gBf74RLaInreQyQ1pe/TZlKlLMJt9yyyVub7nwZJQF/RfME1
 ytxR0HLxdnCx7FITTPOJXJwfSfOVpYVSxf3ChQoumc1j36God3/WPIZ5Ug36E4Et7Iyve14
 2FBDQEmAg/OAqISVvxBWg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261008>

Hi,

On Mon, 8 Dec 2014, Jeff King wrote:

> On Mon, Dec 08, 2014 at 12:48:12AM -0500, Jeff King wrote:
> 
> > Note that when fscking tags with "index-pack --strict", this is even
> > worse. index-pack does not add a trailing NUL-terminator after the
> > object, so we may actually read past the buffer and print
> > uninitialized memory. Running t5302 with valgrind does notice the bug
> > for that reason.
> 
> This merits an additional note (but fortunately not a patch :) ).

Wehell... your note about index-pack is definitely worth an additional
note, and - as you suggest later - probably also a patch. When I
started working on the fsck code handling tags, I did note that the tag
buffers were not NUL terminated, mainly due to crashes that were really
difficult to debug (I had to resort to the sleep loop trick to attach to a
process spawned by git-push) after I added code that assumed the buffers
to be NUL terminated.

> After writing the above, I thought for a moment that we might actually
> read past the end of the buffer in some cases, but I convinced myself
> otherwise. And I think Dscho and I might have even had this conversation
> off-list a while ago, but I think it is worth pointing out so that
> nobody else has to dig into it.

Yep, we discussed this quite a bit. I argued that the safest thing is
*not* to assume that the buffers are NUL terminated because it was not
obvious to me how to guarantee NUL-terminated object buffers (because the
commit objects are reused by the fsck machinery, not re-read).

> For the most part, we are fine because we parse the object
> left-to-right, and barf as soon as we see something unusual (and for
> this reason, fsck_commit_buffer is also fine). The two suspicious places
> are:
> 
>   1. We call strchr(buffer, '\n'), which looks like it could read
>      unbounded when "buffer" is not NUL-terminated. However, early in
>      the function we confirm that it contains "\n\n", and we will not
>      have parsed past that here. Therefore we know that we will always
>      hit a newline.

For reference, this is the code:

	https://github.com/git/git/blob/c18b86734113ee2aeb0e140c922c8fbd4accc860/fsck.c#L241-L259

being called by:

	https://github.com/git/git/blob/c18b86734113ee2aeb0e140c922c8fbd4accc860/fsck.c#L308

and

	https://github.com/git/git/blob/c18b86734113ee2aeb0e140c922c8fbd4accc860/fsck.c#L387

>   2. After finding and parsing a line whose trailing newline is marked
>      by "eol", we then set "buffer = eol + 1". This would be wrong if
>      eol is at the very end of the buffer (the next step would then
>      start reading uninitialized memory).
> 
>      But again we are saved by the "\n\n" check. The strchr will always
>      find the first, so we know that we have at least one character
>      after it (and that character is a newline, which cannot be the
>      start of a new header, which will cause us to stop parsing).

Exactly. It is unfortunately a little too brittle for my taste, because it
would be relatively easy to break the assumption without noticing. For
example, in my upcoming patch series allowing to turn specific fsck errors
into mere warnings, it would have been potentially very dangerous to allow
demoting that error (no end of header found, NUL inside header) to a
warning - because that would have allowed the code to go beyond the
buffer.

However...

> I do admit that I am tempted to teach index-pack to always NUL-terminate
> objects in memory that we feed to fsck, just to be on the safe side. It
> doesn't cost much, and could prevent a silly mistake (either in the
> future, or one that I missed in my analysis). The fsck code otherwise
> generally expects to get the output of read_sha1_file, which has the
> safety-NUL appended.

If we do that, we have to NUL-terminate all of the objects, correct? I
mean, even the blobs and the trees and stuff, because we cannot know
beforehand what type of object we're gonna read, right?

Ciao,
Dscho
