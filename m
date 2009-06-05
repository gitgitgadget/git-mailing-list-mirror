From: Theodore Tso <tytso@mit.edu>
Subject: Re: [BUG ext4?] Working tree getting out of date "spontaneously"
Date: Fri, 5 Jun 2009 17:38:24 -0400
Message-ID: <20090605213824.GD6442@mit.edu>
References: <20090605122444.GA11035@atjola.homenet> <20090605132126.GB11035@atjola.homenet> <20090605145508.GA6442@mit.edu> <20090605150212.GC764@atjola.homenet> <20090605180630.GC6442@mit.edu> <20090605183538.GE764@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 05 23:41:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MChA3-0003tb-5g
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 23:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799AbZFEVin convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 17:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754270AbZFEVim
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 17:38:42 -0400
Received: from thunk.org ([69.25.196.29]:39078 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754315AbZFEVih (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 17:38:37 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1MCh7L-0007Bf-5o; Fri, 05 Jun 2009 17:38:28 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1MCh7I-000283-Rl; Fri, 05 Jun 2009 17:38:24 -0400
Content-Disposition: inline
In-Reply-To: <20090605183538.GE764@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120838>

On Fri, Jun 05, 2009 at 08:35:38PM +0200, Bj=F6rn Steinbrink wrote:
> > So the next step is to create an ext3 filesystem with a git reposit=
ory
> > on it, and then to gradually turn on various ext4 specific features
> > and see when the bug ends up getting replicated.  If I had to guess
> > it's the lack (or absense) of the extents feature, but I'll have to
> > run the test and find out for sure.
>=20
> Yep, seems to be extents. Test script:

OK, I see what's going on.  When doing delayed allocation, and we're
not using extents, the call to ext4_get_blocks() which does the
allocation ultimately ends up calling ext4_slice_branch if the inode
is using direct/indirect blocks instead of extents.
ext4_splice_branch() sets ctime.  Taking out the this line in
fs/ext4/inode.c:ext4_splice_branch() should fix things:


	/* We are done with atomic stuff, now do the rest of housekeeping */

-	inode->i_ctime =3D ext4_current_time(inode);
	ext4_mark_inode_dirty(handle, inode);

	/* had we spliced it onto indirect block? */

I'm pretty sure we don't need to set i_ctime anywhere else, since we
don't have a similar line in the extents code and we
fs/inode.c:file_update_time() should take care updating i_ctime where
it needs it, but I want to take a closer look to be sure.

   	     	   	   	  	 - Ted
