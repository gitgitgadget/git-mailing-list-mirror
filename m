From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Why are ref_lists sorted?
Date: Mon, 19 Mar 2007 00:54:52 -0400
Message-ID: <20070319045452.GK20658@spearce.org>
References: <Pine.LNX.4.64.0703190321370.28570@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Mar 19 05:55:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT9ta-0006CW-0n
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 05:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933811AbXCSEy5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 00:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933816AbXCSEy5
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 00:54:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51195 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933811AbXCSEy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 00:54:56 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HT9tW-00031K-Vz; Mon, 19 Mar 2007 00:54:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3572320FBAE; Mon, 19 Mar 2007 00:54:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703190321370.28570@beast.quantumfyre.co.uk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42588>

Julian Phillips <julian@quantumfyre.co.uk> wrote:
> A bit of investigation showed this to be due to the first attempt to read 
> a ref causing the packed refs to be loaded.  In my test repo the 
> packed-refs file has over 9000 entries, but I still thought that it would 
> load faster than that.  It turns out that the overhead is from sorting the 
> refs when building the ref_list.  If I remove the code for sorting the 
> entries I lose that initial 1s delay, without appearing to break anything 
> in the fetch.  However I assume that it's there for a reason ...
> 
> So my questions are:
> 
> 1) what have I broken by removing the sort?
> 2) is it worth trying to optimise the sort?

Oh gawd, that thing is an O(n**2) insertion.  Ouch.

The entire reason its sorted is just to allow us to find the
existing ref entry, if one exists, and replace it.  This way
a loose (unpacked) ref will shadow/override its packed version.

I think the other reason is to provide predictable behavior.
By making the list sorted, refs always appear at the same relative
position to other refs within that repository.  This makes it easier
to write the packed-refs file and yet keep the ordering within the
file predictable.

I think this could probably be better done as a hash, not as a
linked list, and that only the packed-refs writer needs to pay
any sort of sorting costs.

-- 
Shawn.
