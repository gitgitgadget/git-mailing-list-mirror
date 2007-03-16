From: Matt Mackall <mpm@selenic.com>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 11:42:41 -0500
Message-ID: <20070316164241.GC4892@waste.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org> <45F9EED5.3070706@garzik.org> <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org> <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org> <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com> <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org> <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com> <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org> <45FAC75B.3030902@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Davide Libenzi <davidel@xmailserver.org>,
	Git Mailing List <git@vger.kernel.org>, bcrl@kvack.org
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 17:55:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSFiA-0008JE-UU
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 17:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965635AbXCPQzY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 12:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965640AbXCPQzY
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 12:55:24 -0400
Received: from waste.org ([66.93.16.53]:36409 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965635AbXCPQzX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 12:55:23 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l2GGggnF004667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 16 Mar 2007 11:42:42 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id l2GGgfWO004666;
	Fri, 16 Mar 2007 11:42:41 -0500
Content-Disposition: inline
In-Reply-To: <45FAC75B.3030902@garzik.org>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42379>

On Fri, Mar 16, 2007 at 12:35:39PM -0400, Jeff Garzik wrote:
> Linus Torvalds wrote:
> >The normal size for the performance-critical git objects are in the couple 
> >of *hundred* bytes. Not kilobytes, and not megabytes.
> >
> >The most performance-critical objects for uncompression are commits and 
> >trees. At least for the kernel, the average size of a tree object is 678
> >bytes. And that's ignoring the fact that most of them are then deltified, 
> >so about 80% of them are likely just a ~60-byte delta.
> 
> 
> Ahhh.  At least for me, that explains a lot.  Rather than spending all 
> its time in inflate_fast(), git is dealing with lots of zlib 
> startup/shutdown overhead.
> 
> Although it sounds like zlib could indeed be optimized to reduce its 
> startup and shutdown overhead, I wonder if switching compression 
> algorithms to a pure Huffman or even RLE compression (with associated 
> lower startup/shutdown costs) would perform better in the face of all 
> those small objects.

Mercurial simply stores uncompressed objects below a threshold of 44
bytes, based on benchmarks I did in April 2005. I'd probably up that
number if I redid my measurements today. There's just not a whole lot
zlib can do at these small sizes. Given that a SHA hash is an
uncompressible 20 bytes already, you're well into the domain of
diminishing returns.

> And another random thought, though it may be useless in this thread:  I 
> bet using a pre-built (compiled into git) static zlib dictionary for git 
> commit and tree objects might improve things a bit.

Ideally, you'd compress all deltas in a chain with the same context.
You've got to decompress the delta base to do the delta
calculation, so this should allow you to recover the context up to
that point. Zlib isn't really set up for this sort of thing though.

-- 
Mathematics is the supreme nostalgia of our time.
