From: Theodore Tso <tytso@mit.edu>
Subject: Re: How git affects kernel.org performance
Date: Mon, 8 Jan 2007 07:58:19 -0500
Message-ID: <20070108125819.GA32756@thunk.org>
References: <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org> <20070107085526.GR24090@1wt.eu> <20070107011542.3496bc76.akpm@osdl.org> <20070108030555.GA7289@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>, Willy Tarreau <w@1wt.eu>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
X-From: linux-ext4-owner@vger.kernel.org Mon Jan 08 14:15:18 2007
Return-path: <linux-ext4-owner@vger.kernel.org>
Envelope-to: gcfe-linux-ext4@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3uLH-0008BJ-97
	for gcfe-linux-ext4@gmane.org; Mon, 08 Jan 2007 14:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbXAHNPK (ORCPT <rfc822;gcfe-linux-ext4@m.gmane.org>);
	Mon, 8 Jan 2007 08:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbXAHNPK
	(ORCPT <rfc822;linux-ext4-outgoing>); Mon, 8 Jan 2007 08:15:10 -0500
Received: from thunk.org ([69.25.196.29]:48941 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515AbXAHNPI (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
	Mon, 8 Jan 2007 08:15:08 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1H3uOH-0003NB-DQ; Mon, 08 Jan 2007 08:18:17 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1H3u4x-0001NQ-CV; Mon, 08 Jan 2007 07:58:19 -0500
To: Suparna Bhattacharya <suparna@in.ibm.com>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Willy Tarreau <w@1wt.eu>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070108030555.GA7289@in.ibm.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36253>

On Mon, Jan 08, 2007 at 08:35:55AM +0530, Suparna Bhattacharya wrote:
> > Yeah, slowly-growing directories will get splattered all over the disk.
> > 
> > Possible short-term fixes would be to just allocate up to (say) eight
> > blocks when we grow a directory by one block.  Or teach the
> > directory-growth code to use ext3 reservations.
> > 
> > Longer-term people are talking about things like on-disk rerservations.
> > But I expect directories are being forgotten about in all of that.
> 
> By on-disk reservations, do you mean persistent file preallocation ? (that
> is explicit preallocation of blocks to a given file) If so, you are
> right, we haven't really given any thought to the possibility of directories
> needing that feature.

The fastest and probably most important thing to add is some readahead
smarts to directories --- both to the htree and non-htree cases.  If
you're using some kind of b-tree structure, such as XFS does for
directories, preallocation doesn't help you much.  Delayed allocation
can save you if your delayed allocator knows how to structure disk
blocks so that a btree-traversal is efficient, but I'm guessing the
biggest reason why we are losing is because we don't have sufficient
readahead.  This also has the advantage that it will help without
needing to doing a backup/restore to improve layout.

Allocating some number of empty blocks when we grow the directory
would be a quick hack that I'd probably do as a 2nd priority.  It
won't help pre-existing directories, but combined with readahead
logic, should help us out greatly in the non-btree case.  

						- Ted
