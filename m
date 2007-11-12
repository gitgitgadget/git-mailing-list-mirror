From: bdowning@lavos.net (Brian Downing)
Subject: [BUG] fast-import producing very deep tree deltas
Date: Mon, 12 Nov 2007 05:03:56 -0600
Message-ID: <20071112110354.GP6212@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 12:04:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrX5S-0005eR-1Z
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 12:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757255AbXKLLD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 06:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757271AbXKLLD7
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 06:03:59 -0500
Received: from mxsf00.insightbb.com ([74.128.0.70]:29579 "EHLO
	mxsf00.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756404AbXKLLD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 06:03:58 -0500
X-IronPort-AV: E=Sophos;i="4.21,404,1188792000"; 
   d="scan'208";a="108074808"
Received: from unknown (HELO asav01.insightbb.com) ([172.31.249.124])
  by mxsf00.insightbb.com with ESMTP; 12 Nov 2007 06:03:57 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAHfBN0dKhvkY/2dsb2JhbACBWw
X-IronPort-AV: E=Sophos;i="4.21,404,1188792000"; 
   d="scan'208";a="93489244"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav01.insightbb.com with ESMTP; 12 Nov 2007 06:03:57 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 93759309F21; Mon, 12 Nov 2007 05:03:56 -0600 (CST)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64600>

I've happened upon a case where fast-import produces deep tree deltas.
How deep?  Really deep.  6035 entries deep to be precise for this case:

    depths: count 135970 total 120567366 min 0 max 6035 mean 886.72 median 3 std_dev 1653.48

    27b8a20bdf39fecd917e8401d3499013e49449d0 tree   32 99609547 6035 0000000000000000000000000000000000000000

This was with git-fast-import from 'next' as of a couple days ago,
run with the default options (no --depth passed in).

Needless to say the pack that resulted was just about useless.  Trying to
repack it resulted in the "counting objects" phase running at about five
objects per second.

I don't know much about the fast-import code, but I'd guess that the
delta_depth member for the tree_content struct is either getting cleared
inappropriately or is not being propagated correctly.  I added a printout
of the depth just before the store_object call in store_tree and it is
never non-zero, even though the pack file clearly was generated with
plenty of deltas.

I may have time to look at this more later this week, but I just wanted
it to be known that this problem existed.

-bcd
