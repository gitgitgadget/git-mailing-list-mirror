From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 3/6] Stop producing index version 2
Date: Tue, 7 Feb 2012 18:25:43 +0100
Message-ID: <874nv2o8rs.fsf@thomas.inf.ethz.ch>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
	<1328507319-24687-3-git-send-email-pclouds@gmail.com>
	<7v4nv4a131.fsf@alter.siamese.dyndns.org>
	<CAJo=hJvtRnmvALcn3vKpYTr3j6ada8iboPjWN3cQnwwKzRvrDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= 
	<pclouds@gmail.com>, <git@vger.kernel.org>,
	Joshua Redstone <joshua.redstone@fb.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 07 18:25:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ruong-0008RP-DF
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 18:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922Ab2BGRZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 12:25:47 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:40999 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755661Ab2BGRZr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 12:25:47 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 7 Feb
 2012 18:25:43 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (84.73.49.17) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 7 Feb
 2012 18:25:43 +0100
In-Reply-To: <CAJo=hJvtRnmvALcn3vKpYTr3j6ada8iboPjWN3cQnwwKzRvrDA@mail.gmail.com>
	(Shawn Pearce's message of "Mon, 6 Feb 2012 19:09:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [84.73.49.17]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190186>

Shawn Pearce <spearce@spearce.org> writes:

> I have long wanted to scrap the current index format. I unfortunately
> don't have the time to do it myself. But I suspect there may be a lot
> of gains by making the index format match the canonical tree format
> better by keeping the tree structure within a single file stream,
> nesting entries below their parent directory, and keeping tree SHA-1
> data along with the directory entry.

If I may add to this: the one thing that I would like to see fixed about
the index is that it's flat out impossible to change a single thing in
it without re"writing" it from scratch.

I'm saying "writing" because it is possible to change a few things
around, but recomputing the trailing SHA1 swamps that by a large margin
unless you are writing to a floppy disk, so it doesn't matter.  I'm sure
using a CRC32 helps here, but if we're going to make an incompatible
change, why not go all the way?

A tree layout can fix that if it is properly arranged so that if you
'git add path/to/file', it only updates the SHA1s for path/to/file,
path/to and path.  For this to work, the checks would have to correspond
to the trees, perhaps even directly use the actual tree SHA1.  This
would at least be natural in some sense; getting to actual log(n)
complexity for hilariously large directories would require dynamically
splitting directories where appropriate.

Along the same lines the format should allow for changing the extension
data for a single extension while only rehashing the new data.


When I worked on cache-tree, I considered making a change to the latter
effect, but thought the impact too great for a little gain.  Now from
this thread, I'm getting the impression that such a change would be ok,
even if users would have to scrap the index if they downgrade.  Is that
right?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
