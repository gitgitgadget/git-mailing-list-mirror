From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Compression and dictionaries
Date: Sun, 13 Aug 2006 23:56:03 -0400
Message-ID: <20060814035603.GB18667@spearce.org>
References: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 14 05:56:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCTYp-0000Cf-7j
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 05:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbWHND4I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 23:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWHND4I
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 23:56:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:63114 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751839AbWHND4H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 23:56:07 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GCTYP-0005mz-4Y; Sun, 13 Aug 2006 23:55:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 140B720FB77; Sun, 13 Aug 2006 23:56:04 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25314>

Jon Smirl <jonsmirl@gmail.com> wrote:
> From what I remember from long ago most compression schemes build
> dictionaries as a way of achieving significant compression. If so,
> since we zlib compress each entry in a pack individually, are there
> many copies of very similar dictionaries in the pack?

Yes, possibly.  Every object in the pack has its own dictionary.

But I'm not sure if there would be any savings from sharing
dictionaries.  One problem is you probably don't want a single
massive dictionary for the entire pack as it could be very large,
plus updating it with additions would likely require recompressing
every entry.  Typically once an entry in the pack has been compressed
GIT won't recompress it.

However whenever possible deltas get used between objects.
This allows an object to copy content from another object, with
copy commands typically taking just a couple of bytes to copy a
whole range of bytes from the other object.  This works pretty
well when the current revision of a file is stored with just zlib
compression and older revisions copy their content from the current
revision using the delta format.

I should note that delta compression works on trees, commits and
tags too, however it gets the most benefit out of trees when only
a fraction of the files in the tree are modified.  Commits and tags
are harder to delta as they tend to be mostly different.

My fast-import computes deltas in the order you are feeding
it objects, so each blob is deltafied against the prior object.
Since you are feeding them in reverse RCS order (newest to oldest)
you are probably getting a reasonably good delta compression.

-- 
Shawn.
