From: Sam Vilain <sam@vilain.net>
Subject: Re: Gittorent .. avahi ?
Date: Mon, 02 Apr 2007 14:30:43 +1200
Message-ID: <46106AD3.6000204@vilain.net>
References: <9d916d5b0704011059g31394159kfdd5e01ba81915c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Srijak Rijal <srijak@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 04:31:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYCK6-000245-N2
	for gcvg-git@gmane.org; Mon, 02 Apr 2007 04:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbXDBCau (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Apr 2007 22:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbXDBCau
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Apr 2007 22:30:50 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:48916 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbXDBCat (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2007 22:30:49 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 77984156AF8; Mon,  2 Apr 2007 14:30:47 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id A2D8A156A8D;
	Mon,  2 Apr 2007 14:30:43 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <9d916d5b0704011059g31394159kfdd5e01ba81915c2@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43597>

Srijak Rijal wrote:
> Hi all,
> I hope this is the right forum for this :).
>  I hope to be able to implement the gittorrent client/ tracker during
> GoogleSoc (if chosen :) ). I have been reading up on various git docs
> and listserv messages to figure out what features I want in it in
> addition to the basics. I have been concentrating especially on how to
> minimise tracker load.
>   

Note that a minimal tracker can always return the same static file,
listing known stable peers; the P2P protocol is capable of discovering
new peers.

Also, unlike BitTorrent, the protocol is capable of negotiating the
tracker update frequency.  A tracker under load would just start
advertising addresses for longer, and returning server busy responses
for peers that contact them too frequently.  See the "valid" key in the
Request, and the "expires" key in the Response.

I think in BitTorrent there is an *over*-emphasis on making the tracker
load light, because people want to be able to run them on the most
dirt-cheap hosting account they can find, because they might get shut
down and don't want a huge outlay.  But with GitTorrent, a large number
of the tracker providers are going to be software houses, and people
already running mirroring services - and so the increased load will be
more than justified by the reduced overall load.

> I was thinking about enabling avahi in the clients so that they can
> find peers without putting that much extra load on the tracker.
> A small caveat is that avahi timeout is around 50ms, so this sort of
> dynamic peer discovery would probably turn out to work effectively
> only among clients in the same LAN. However, best case scenario is
> clients in the same LAN would have only a couple of clients talking to
> the tracker and spreading the data(as well as peer list etc) in their
> LAN.
>
> To me, this feature seems be worth implementing if enough git users
> are in the same LAN trying to get at a certain git repository.
> What do you guys think ?
>   

Looks like avahi is only intended for the local network anyway, going by
the home page and Wikipedia article.

I guess the use cases for this include programming houses and hackathons.

At a hackathon, you might scan the network for a list of projects, and
jump into one of the swarms.  Then you hack on the code.  Then to
"commit", you set up and advertise another tracker that has your list of
heads, but refers to the other repo as an "alternative" (see
Metainfo/repo/alternatives).  The other people's avahi-enhanced
gittorrent client could see that a new related project has been
advertised, and fetch new commits to "remotes/" references automatically.

SVN fans would probably then configure it to automatically merge in new
remote references to their current working tree, but that's not
important right now :-).

One current TO-DO item in the specification to make this use case
scalable is to allow connections to deal with multiple (possibly
related) repositories at the same time.  Otherwise, with 6 "committers",
you've got 6 P2P swarms.  But this can happen with the next incremental
version of the specification.

At a programming house, setting up a tracker to commit wouldn't be as
frequent, as you expect people to have the appropriate access to
commit.  It would still be useful as a live directory of projects - but
is it significantly more useful than a simple gitweb?

Anyway, the old warning about scope creep applies to this idea - working
from the bottom up is a lot better for getting things done than thinking
big.  Just look at me, I think big all the time and never get anything
done ;-)  There will be a lot of interesting technologies enabled by
gittorrent.

Sam.
