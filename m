From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: brtfs COW links and git
Date: Mon, 21 Mar 2011 22:44:21 -0400
Message-ID: <20110322024421.GA15134@cthulhu>
References: <20110319201532.GA6862@cthulhu>
 <20110321120051.GG16334@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 03:51:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1rh2-00042o-7C
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 03:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756347Ab1CVCva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 22:51:30 -0400
Received: from cthulhu.elder-gods.org ([72.66.21.34]:58827 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494Ab1CVCv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 22:51:29 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Mar 2011 22:51:28 EDT
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 28C798220A7; Mon, 21 Mar 2011 22:44:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110321120051.GG16334@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169697>

* Jeff King (peff@peff.net) [110321 08:00]:
> I'm not exactly clear on what you want to implement.

Neither was I, that's why I sent the vague email :-)

I think I have a better understanding now of what would need to be done:

* reading unadorned blobs, as a last resort if the object isn't found elsewhere.
  use reflink (if available) to copy an unadorned blob into the working directory 

* writing unadorned blobs, according to size limit / attribute.
  this also means computing the sha1 for the blob without reading
  the entire thing into memory all at once.

* leaving unadorned blobs alone in gc, unless explicitly told not to

* supporting the easy cases of binary diffs for git-upload-pack.  it shouldn't 
  have to send an entire copy of a huge file if only a little bit of the file 
  changed.   This could use fiemap, or maybe bup's rolling checksum, or maybe 
  either, depending on what's available.

* support for applying those binary diffs directly to the on-disk reflink.
  this could probably just mmap the file and call patch-delta.

I think these features would make some, but not all of the big file use cases
much more usable.  What do you think?
