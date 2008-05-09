From: Jeff King <peff@peff.net>
Subject: Re: git gc & deleted branches
Date: Fri, 9 May 2008 00:19:21 -0400
Message-ID: <20080509041921.GA14773@sigill.intra.peff.net>
References: <20080508210125.GC32762@sigill.intra.peff.net> <alpine.LFD.1.10.0805081712270.23581@xanadu.home> <20080508211734.GA819@sigill.intra.peff.net> <48236F69.2060900@nrlssc.navy.mil> <20080508213107.GA1016@sigill.intra.peff.net> <48237344.6070405@nrlssc.navy.mil> <20080508214454.GA1939@sigill.intra.peff.net> <48237650.5060008@nrlssc.navy.mil> <20080508224827.GA2938@sigill.intra.peff.net> <loom.20080509T011318-478@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 06:20:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuK5e-0002o0-Ot
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 06:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbYEIETX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 00:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754809AbYEIETV
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 00:19:21 -0400
Received: from peff.net ([208.65.91.99]:3816 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754645AbYEIETU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 00:19:20 -0400
Received: (qmail 18517 invoked by uid 111); 9 May 2008 04:19:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 09 May 2008 00:19:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 May 2008 00:19:21 -0400
Content-Disposition: inline
In-Reply-To: <loom.20080509T011318-478@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81597>

On Fri, May 09, 2008 at 01:41:30AM +0000, Brandon Casey wrote:

> Here's what I was thinking (posted using gmane):
> 
> diff --git a/git-repack.sh b/git-repack.sh
> index e18eb3f..064c331 100755
> --- a/git-repack.sh
> +++ b/git-repack.sh

I like it. It makes an easy rule to say "packed objects _never_ get
pruned, they only get demoted to loose objects." And then of course
we have sane rules for pruning loose objects.

> -       rm -f "$PACKDIR/old-pack-$name.pack" "$PACKDIR/old-pack-$name.idx"
> +       rm -f "$PACKDIR/old-pack-$name.idx"
> +       test -z "$keep_unreachable" ||
> +         ! test -f "$PACKDIR/old-pack-$name.pack" ||
> +         git unpack-objects < "$PACKDIR/old-pack-$name.pack" || {
> +               echo >&2 "Failed unpacking unreachable objects from old pack"
> +               echo >&2 "saved as old-pack-$name.pack in $PACKDIR."
> +               exit 1
> +       }
> +       rm -f "$PACKDIR/old-pack-$name.pack"
> [...]
> 
> Is the first invocation of unpack-objects necessary? pack-objects has created
> a pack which hashes to the same name of a pack we already have, and we replace
> the original with the new one. Is that what is happening? They will be
> identical right?

Yeah, that's what it looks like to me (that the first unpack is
unnecessary, because we will just be putting the new pack into place
that has all the same objects). AIUI, two packs with identical hashes
must contain the exact same objects.

> Of course this won't set the timestamp on the created objects based on the
> timestamp of the pack file, but this was easy. Setting the timestamp would be
> proper, but what's another two weeks. Besides, for those users not manually
> running git-gc, this code path won't even be executed until there are enough
> pack files for git-gc to add -A to the repack options.

I think the extra two weeks is fine.

-Peff
