From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-daemon on NSLU2
Date: Mon, 27 Aug 2007 02:14:28 +0200
Message-ID: <200708270214.28652.jnareb@gmail.com>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com> <9e4733910708250844n7074cb8coa5844fa6c46b40f0@mail.gmail.com> <20070826093331.GC30474@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 02:15:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPSG3-0000ko-Ck
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 02:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbXH0AOg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 20:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbXH0AOg
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 20:14:36 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:15065 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbXH0AOf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 20:14:35 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2064941mue
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 17:14:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JeSDHA+ZZwQjHxWq3aVKP326C0qIExbTfYR2EA1MVo0odSMBRdEVuKGMVDTsK5OVJ3t9cVhBqOe+uRCCwENlnolXNwp2Yibn8E2VZOLh1OSBIMkzYDO9MInCXLh2lE+xl6MEWk1mVpbB/2MJ7jKRm9rQs0VTwbDCzQQMojKZER4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aRoE/4wZ6TpIBxaZ8dKjqYFOVARKJjSyPxZ9agXozajZiPaAHiFBMpTZch5tjq0RwhQqP9TMWyPGM0TIOrFOqmtGueMy2V6X66NBua5VKl2kRcwhJOJOKJvmWcfHmY8FwZmcoWBUOC/X+wkGM9VB9w14Dy5xNaNkWZD2qrXhEuQ=
Received: by 10.86.99.9 with SMTP id w9mr4424156fgb.1188173673777;
        Sun, 26 Aug 2007 17:14:33 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id e32sm4314140fke.2007.08.26.17.14.30
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Aug 2007 17:14:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070826093331.GC30474@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56746>

On Sun, Aug 26, 2007, Jeff King wrote:
> On Sat, Aug 25, 2007 at 11:44:07AM -0400, Jon Smirl wrote:
> 
>> A very simple solution is to sendfile() existing packs if they contain
>> any objects that the client wants and let the client deal with the
>> unwanted objects. Yes this does send extra traffic over the net, but
>> the only group significantly impacted is #2 which is the most
>> infrequent group.
>>
>> Loose objects are handled as they are currently. To optimize this
>> scheme you need to let the loose objects build up at the server and
>> then periodically sweep only the older ones into a pack. Packing the
>> entire repo into a single pack would cause recent fetches to retrieve
>> the entire pack.
> 
> I was about to write "but then 'fetch recent' clients will have to get
> the entire repo after the upstream does a 'git-repack -a -d'" but you
> seem to have figured that out already.
> 
> I'm unclear: are you proposing new behavior for git-daemon in general,
> or a special mode for resource-constrained servers? If general behavior,
> are you suggesting that we never use 'git-repack -a' on repos which
> might be cloned?

I think that "reuse existing packs if sensible" idea (instead of generating
always new pack) is a good one, even if at first limited to the clone case.

There are nevertheless a few complications.

1. When discussing this idea on git mailing list some time ago somebody
said that we don't need to implement "multi pack" extension (which was
at the beginning in the design, to add later, if I understand correctly),
it is enough to concatenate packs. The receiving side can then detect
boundaries between packs and split them appropriately. But is a
concatenated a proper pack? If not, then we can send concatenation of
packs only if the client (receiving side) understands it, and can split it;
it means checking for protocol extension...

2. How to detect that request is for a clone? git-clone is get all remote
heads and fetch from just received heads. But because fecthing refs and
fetching objects is separate, we cannot I think use this sequence for
detecting that we want a clone. We can use "no haves" as heuristic to
detect a clone request, but "no haves" occurs also for initial fetching of
single branch (i.e. using: git-remote; git-fetch sequence instead of
git-clone).

3. The problem with alternates mentioned by Linus is not much a problem,
as we can simply consider packs from the alternate repository/repositories.
For example if we use single alternate, we would send concatenation of
packs from this repository, and from alternate (and pack of loose objects
from this repository).


We would probably want to have some heuristic (besides configuring
git-daemon) to choose between reusing existing packs (and sending them
concatenated), and generating a pack for sending. Note that for dumb
transports we have the opposite problem and opposite idea: we always
send full packs for dumb transports; the idea was to use range downloading
(available at least for http and ftp protocols) to download only needed
fragments of packs. Perhaps if some % of pack (number of objects in the
pack or size of pack) is to be send then we reuse the pack, and remove
objects in the pack from consideration. No idea of how to implement that,
though. Or if number of objects in pack to be send crosses some threshold,
or generating pack/doing reachability analysis takes to loong, then reuse
existing packs.

Or you can wait fro the GitTorrent protocol to be implemented, or implement
it yourself... ;-)

-- 
Jakub Narebski
Poland
