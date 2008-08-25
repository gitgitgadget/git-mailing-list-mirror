From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: "failed to read delta base object at..."
Date: Mon, 25 Aug 2008 17:31:04 -0400
Message-ID: <20080825213104.GI2213@fieldses.org>
References: <20080825164602.GA2213@fieldses.org> <alpine.LFD.1.10.0808251153210.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 23:32:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXjfb-0002Xk-3m
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 23:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbYHYVbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 17:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbYHYVbI
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 17:31:08 -0400
Received: from mail.fieldses.org ([66.93.2.214]:44293 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176AbYHYVbH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 17:31:07 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1KXjeS-0002KA-Sq; Mon, 25 Aug 2008 17:31:04 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808251153210.3363@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93683>

Thanks to you and Nicolas for the responses.

On Mon, Aug 25, 2008 at 12:01:42PM -0700, Linus Torvalds wrote:
> On Mon, 25 Aug 2008, J. Bruce Fields wrote:
> >
> > Today I got this:
> > 
> > fatal: failed to read delta base object at 3025976 from
> > /home/bfields/local/linux-2.6/.git/objects/pack/pack-f7261d96cf1161b1b0a1593f673a67d0f2469e9b.pack
> 
> This is almost certainly due to some corruption. Basically, the call to 
> "cache_or_unpack_entry()" failed, which in turn is because 
> 'unpack_entry()' will have failed. 
> 
> And since you didn't see any other error, that failure is almost certainly 
> due to unpack_compressed_entry() having failed. We don't print out _why_ 
> (which is a bit sad), but the only thing that unpack_compressed_entry() 
> does is to just "inflate()" the data at that offset.
> 
> So it probably got a zlib data error, or an adler32 crc failure.
> 
> > This has happened once before recently, I believe with a pack that had
> > just been created on a recent fetch.  (If I remember correctly, this was
> > soon after a failed suspend/resume cycle that might have interrupted an
> > in-progress fetch; could that possible explain the error?)  In that case
> > I reset origin/master, deleted a tag or two, and fetched, and the
> > problem seemed to be fixed.
> 
> An interrupted fetch shouldn't have caused this, it really should only 
> happen if you have some actual filesystem data error. Something didn't get 
> written back correctly, or the page cache isn't coherent (or it got 
> corrupted by something else like a wild kernel pointer, of course).

OK.  I seem to recall these pack files are created with something like

	open
	write
	sync
	close
	rename

?  This is just ext3 with data=writeback on a local laptop disk,
ubuntu's 2.6.24-21-generic.  Would it be any use trying to look more
closely at the pack in connection for any hints?

(But with my git repo back I'm happy enough to just forget this for now
if there's not anything obvious to try.)

--b.
