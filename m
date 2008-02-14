From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Thu, 14 Feb 2008 17:57:47 -0600
Message-ID: <20080214235747.GV27535@lavos.net>
References: <200802081828.43849.kendy@suse.cz> <m3y79nb8xk.fsf@localhost.localdomain> <alpine.LSU.1.00.0802142054080.30505@racer.site> <200802142300.01615.jnareb@gmail.com> <alpine.LSU.1.00.0802142334480.30505@racer.site> <20080214235129.GU27535@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Nicolas Pitre <nico@cam.org>, Jan Holesovsky <kendy@suse.cz>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 15 00:58:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPnyW-0002Ch-9t
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 00:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764436AbYBNX5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 18:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763828AbYBNX5w
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 18:57:52 -0500
Received: from mxsf01.insightbb.com ([74.128.0.71]:33495 "EHLO
	mxsf01.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761691AbYBNX5u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 18:57:50 -0500
X-IronPort-AV: E=Sophos;i="4.25,355,1199682000"; 
   d="scan'208";a="223921568"
Received: from unknown (HELO asav01.insightbb.com) ([172.31.249.124])
  by mxsf01.insightbb.com with ESMTP; 14 Feb 2008 18:57:51 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAOBjtEdKhvkY/2dsb2JhbACBWa1Z
X-IronPort-AV: E=Sophos;i="4.25,355,1199682000"; 
   d="scan'208";a="116939631"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav01.insightbb.com with ESMTP; 14 Feb 2008 18:57:49 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 1EB00309F24; Thu, 14 Feb 2008 17:57:48 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20080214235129.GU27535@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73930>

On Thu, Feb 14, 2008 at 05:51:29PM -0600, Brian Downing wrote:
> Do you by chance have repack.usedeltabaseoffset turned on?  That has the
> unfortunate side effect of changing the output of verify-pack -v to be
> almost useless for my packinfo script (specifically, it no longer
> reports the parent SHA1 hash for deltas, and the script is basically all
> about deltra tree statistics.)  I suppose that should probably be fixed,
> but I never looked into it.

That being said, the most useful output for figuring out where all the
space in the pack is going in my experience is gotten from:

git-verify-pack -v | packinfo.pl -tree -filenames

That will produce a huge amount of output, which is basically the tree
structure of the delta chains in the file.  If things aren't being
deltified together properly, it's usually pretty obvious.

A delta chain in this output looks approximately like this:

#   0   blob 03156f21...     1767     1767 Documentation/git-lost-found.txt @ tags/v1.2.0~142
#   1    blob f52a9d7f...       10     1777 Documentation/git-lost-found.txt @ tags/v1.5.0-rc1~74
#   2     blob a8cc5739...       51     1828 Documentation/git-lost+found.txt @ tags/v0.99.9h^0
#   3      blob 660e90b1...       15     1843 Documentation/git-lost+found.txt @ master~3222^2~2
#   4       blob 0cb8e3bb...       33     1876 Documentation/git-lost+found.txt @ master~3222^2~3
#   2     blob e48607f0...      311     2088 Documentation/git-lost-found.txt @ tags/v1.5.2-rc3~4
#      size: count 6 total 2187 min 10 max 1767 mean 364.50 median 51 std_dev 635.85
# path size: count 6 total 11179 min 1767 max 2088 mean 1863.17 median 1843 std_dev 107.26

# The first number after the sha1 is the object size, the second
# number is the path size.  The statistics are across all objects in
# the previous delta tree.  Obviously they are omitted for trees of
# one object.

# A path size is the sum of the size of the delta chain, including the
# base object.  In other words, it's how many bytes need be read to
# reassemble the file from deltas.

This is also quite slow, as it runs git-ls-tree -t -r on every commit in
the repository to assign file names to blobs.  You can leave out the
-filenames option to not do this (if you don't care about seeing
filenames, that is).

-bcd
