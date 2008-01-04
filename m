From: Jan Hudec <bulb@ucw.cz>
Subject: Re: git over webdav: what can I do for improving http-push ?
Date: Fri, 4 Jan 2008 20:59:11 +0100
Message-ID: <20080104195911.GA4055@efreet.light.src>
References: <477822C3.9060002@gbarbier.org> <alpine.LNX.1.00.0712302145500.13593@iabervon.org> <47791F90.8030302@pobox.com> <20080101113301.GC9214@efreet.light.src> <477A26FD.7020408@gbarbier.org> <m3myrpo1p0.fsf@roke.D-201> <20080101202352.GA4295@efreet.light.src> <477D3401.2010005@gbarbier.org> <20080103211521.GA4225@efreet.light.src> <46a038f90801031554j6218f08cl6c9608b24e1675f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?R3LDqWdvaXJl?= Barbier <gb@gbarbier.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 20:59:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAshu-00056W-Hx
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 20:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbYADT71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 14:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753341AbYADT70
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 14:59:26 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:38021 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095AbYADT70 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 14:59:26 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 841CD5731E;
	Fri,  4 Jan 2008 20:59:24 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id su9OiiNZtk50; Fri,  4 Jan 2008 20:59:20 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 5AB1E5732C;
	Fri,  4 Jan 2008 20:59:17 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1JAshD-0001NH-89; Fri, 04 Jan 2008 20:59:11 +0100
Content-Disposition: inline
In-Reply-To: <46a038f90801031554j6218f08cl6c9608b24e1675f8@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69599>

On Fri, Jan 04, 2008 at 12:54:58 +1300, Martin Langhoff wrote:
> On Jan 4, 2008 10:15 AM, Jan Hudec <bulb@ucw.cz> wrote:
> > Now to keep it stateless, I thought that:
> ...
> > This would guarantee, that when you want n revisions, you make at most
> > log2(n) requests and get at most 2*n revisions (well, the requests are for
> 
> That is still a lot! How about, for each ref

The whole point of that is that the packs can be statically precomputed and
served with quite low CPU load, which is useful for serving from shared
computers (like servers in school computer labs or cheapo web hosting) or
slow servers like NSLU2. Also it makes HTTP caching actually useful, because
the set of possible requests is quite limited.

Also, while I said it's for each ref, the packs should really be optimized
for the common case of fetching all refs, which would really make it just
log2(n) packs and 2*n revisions for each whole download.

>  - Client sends a POST listing the ref and the latest related commit
> it has that the server is likely to have (from origin/heads/<ref>).
> Optionally, it can provide a blacklist of <treeish> (where every
> object refered is known) and blob sha1s.
>  - Server sends the new sha1 of the ref, and a thin pack that covers the changes
>  - The client can disconnect to stop the transaction. For example --
> if it sees the sha1 of a huge object that it already has. It can
> re-request, with a blacklist.
> 
> A good number of objects will be sent unnecesarily - with no option to
> the client to say "I have this" - but by using the hint of letting the
> server know we have origin/heads/<ref> I suspect that it will be
> minimal.

It would be better to only unnecesarily send revlists. Since each HTTP packed
will likely have something like 1kb overhead, sending few kb worth of revlist
is still pretty efficient. So just send part of revlist, than more revlist
and so on until you find exactly which revisions you need and than ask for
them. That will save *both* bandwidth *and* server CPU. The only reason to
waste bandwidth is to save CPU and you are not doing that.

> Also:
>  - It will probably be useful to list all the refs the client knows
> from that server in the request.
>  - If the ref has changed with a non-fast-forward, the server needs to
> say so, and provide a listing of the commits. As soon as the client
> spots a common commit, it can close the connection -- it now knows
> what ref to tell the server about in a subsequent command.
> 
> This way, you ideally have 1 request per ref, 2 if it has been
> rebased/rewound. This can probably get reorganised to do several refs
> in one request.
> 
> cheers,
> 
> 
> m
-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
