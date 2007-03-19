From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Why are ref_lists sorted?
Date: Mon, 19 Mar 2007 01:33:31 -0400
Message-ID: <20070319053331.GA22534@spearce.org>
References: <Pine.LNX.4.64.0703190321370.28570@beast.quantumfyre.co.uk> <Pine.LNX.4.64.0703190520150.24247@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Mar 19 06:33:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTAV4-0000D3-Jm
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 06:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965482AbXCSFdg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 01:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965502AbXCSFdg
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 01:33:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51949 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965482AbXCSFdf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 01:33:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HTAUv-0004PA-Ca; Mon, 19 Mar 2007 01:33:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8BB2020FBAE; Mon, 19 Mar 2007 01:33:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703190520150.24247@beast.quantumfyre.co.uk>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42591>

Julian Phillips <julian@quantumfyre.co.uk> wrote:
> On Mon, 19 Mar 2007, Julian Phillips wrote:
> 
> >A bit of investigation showed this to be due to the first attempt to read 
> >a ref causing the packed refs to be loaded.  In my test repo the 
> >packed-refs file has over 9000 entries, but I still thought that it would 
> >load faster than that.  It turns out that the overhead is from sorting the 
> >refs when building the ref_list.  If I remove the code for sorting the 
> >entries I lose that initial 1s delay, without appearing to break anything 
> >in the fetch. However I assume that it's there for a reason ...

I have to say, I'm looking at the refs.c code and I'm not seeing
any reason why these need to be sorted.  Granted, the current code
expects that as it walks both get_packed_refs() and get_loose_refs()
(as Junio pointed out), but change that code to toss both into a
single refs hash table, with the elements being the current contents
of struct ref_list.

We already have the ISPACKED flag in the flags field to tell us if
the ref is loose or not.  When inserting a ref into the hash table
you keep the loose version (either if its in the table, or the one
being inserted).

-- 
Shawn.
