From: bdowning@lavos.net (Brian Downing)
Subject: Re: [BUG] fast-import producing very deep tree deltas
Date: Tue, 13 Nov 2007 08:36:00 -0600
Message-ID: <20071113143559.GS6212@lavos.net>
References: <20071112110354.GP6212@lavos.net> <20071113085307.GC14735@spearce.org> <20071113092721.GD14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 15:36:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrwsK-0002ae-BW
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 15:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbXKMOgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 09:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754089AbXKMOgE
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 09:36:04 -0500
Received: from mxsf00.insightbb.com ([74.128.0.70]:39387 "EHLO
	mxsf00.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144AbXKMOgD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 09:36:03 -0500
X-IronPort-AV: E=Sophos;i="4.21,410,1188792000"; 
   d="scan'208";a="109478485"
Received: from unknown (HELO asav02.insightbb.com) ([172.31.249.124])
  by mxsf00.insightbb.com with ESMTP; 13 Nov 2007 09:36:01 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAGNFOUdKhvkY/2dsb2JhbACBWw
X-IronPort-AV: E=Sophos;i="4.21,410,1188792000"; 
   d="scan'208";a="159016974"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav02.insightbb.com with ESMTP; 13 Nov 2007 09:36:01 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 3041F309F21; Tue, 13 Nov 2007 08:36:00 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20071113092721.GD14735@spearce.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64803>

On Tue, Nov 13, 2007 at 04:27:21AM -0500, Shawn O. Pearce wrote:
> Brian, does this fix it?
> 
> So if the tree we reloaded was already at the maximum depth we
> wouldn't know it and make the new tree a delta.  Multiply the
> number of times the branch cache has to swap out the tree times
> max_depth (10) and you get the maximum delta depth of a tree created
> by fast-import.  In Brian's case above the active branch cache had
> to swap the branch out 603/604 times during this import to produce
> a tree with a delta depth of 6035.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

/Much/ better:

git-fast-import statistics:
---------------------------------------------------------------------
Alloc'd objects:     140000
Total objects:       135970 (     62664 duplicates                  )
      blobs  :        42196 (     13695 duplicates      19898 deltas)
      trees  :        72143 (     48969 duplicates      62402 deltas)
      commits:        21631 (         0 duplicates          0 deltas)
      tags   :            0 (         0 duplicates          0 deltas)
Total branches:          10 (         1 loads     )
      marks:        1048576 (     63827 unique    )
      atoms:          18971
Memory total:          8329 KiB
       pools:          2860 KiB
     objects:          5468 KiB
---------------------------------------------------------------------
pack_report: getpagesize()            =       4096
pack_report: core.packedGitWindowSize = 1073741824
pack_report: core.packedGitLimit      = 8589934592
pack_report: pack_used_ctr            =     273071
pack_report: pack_mmap_calls          =      16855
pack_report: pack_open_windows        =         50 /        363
pack_report: pack_mapped              = 8529277175 / 8589933814
---------------------------------------------------------------------

depths: count 135970 total 380519 min 0 max 10 mean 2.80 median 1 std_dev 3.22

In addition, fast-import ran much (probably 10x) faster and with much less
memory usage (last time it peaked around 1GB):

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
13098 bdowning  18   0 8223m  34m 6576 R   72  1.7   0:51.44 git-fast-import

Presumably not having to rebuild the root tree object from a hundreds-deep
delta chain many hundreds of times sped things up a bit.

Acked-by: Brian Downing <bdowning@lavos.net>

-bcd
