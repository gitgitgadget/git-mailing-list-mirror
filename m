From: Theodore Tso <tytso@mit.edu>
Subject: Re: A simpler approach to tracking directories (was: The philosophy behind my directory proposal in a nutshell)
Date: Sun, 22 Jul 2007 13:57:31 -0400
Message-ID: <20070722175731.GA16658@thunk.org>
References: <85fy3hqtwl.fsf@lola.goethe.zz> <85abtola79.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 19:57:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICfgZ-00006Q-IS
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 19:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517AbXGVR5g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 13:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755753AbXGVR5f
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 13:57:35 -0400
Received: from thunk.org ([69.25.196.29]:43511 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753920AbXGVR5f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 13:57:35 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1ICfoh-0000Ey-6n; Sun, 22 Jul 2007 14:06:03 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1ICfgR-0004vf-UO; Sun, 22 Jul 2007 13:57:31 -0400
Content-Disposition: inline
In-Reply-To: <85abtola79.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53281>

On Sun, Jul 22, 2007 at 05:39:06PM +0200, David Kastrup wrote:
> Now my proposal basically boils down to using the u+x bit on
> directory/tree entries for tracking "keep around when empty".
> 
> I think we are on the safe side to assume a directory with access
> permissions zero (a-rwx) is something we never want to be able to
> track with git.

Ok, so I think you are still missing the fundamental issue about why
Linus is upset with your proposals.  One of the fundamental things
which falls out of the "Git Tracks Contents" mantra is that
information which you expect to be pushed forward future revisions (as
opposed to metadata which is specific to a commit, such as the Author
and Committer of a patch, the Commit log, etc.) *MUST* be information
which is realized in the working tree.

That way, if you diff between working trees, one of which has either
your "." entry or your "u+x" bit, and of which doesn't, they need to
be *different* when run "git diff" on the two working trees.

Another way of putting is this single bit of information meaning "keep
this directory around when empty" is something that ***must*** be
representable in three different places: in a git tree object, in the
index, *AND* in the working tree.  The problem with "." is that since
all directories contain the "." entry, you can't represent the bit of
information you want to record in the working tree in that way.

There is a same problem with using the u+x permission, for the same
reason.  Unless you want to make directories you want to keep around
with access permissions of zero in the working tree, you're *still*
not able to record presence or absence of the "keep around when empty
bit" in the working tree.

That's why the ".gitignore" entry is acceptable, where as your
proposals are not.  The absence or presence of the ".gitignore" entry
in the working tree is a natural way of representing the "keep around
when empty".  So would a ".do_not_erase" file in the directory ---
sort of like the "Do Not Erase" that professors would write on
whiteboards in order to request janitors to not erase them.  It seems
that you are objecting to having something tangible written on the
whiteboard --- or, in the directory, to indicate the "do not erase"
note.   

But the problem is that Linus very much wants the "do not erase" bit
to be visible in the working directory, since to do otherwise would
violate fundamental design assumptions all over the git source files.
Metadata such as the executable bit is actually stored in the working
directory.  But we can't store the "do not erase bit" by leaving the
executable permission off, since that will prevent the directory from
being useful.

So your new proposal suffers from the same fundamental flaw as your
previous one.  

Maybe you disagree with Linus's design constraint, but you've never
addressed his specific concern on-point, which is that since Git
Tracks Content, if you want something to be tracked across revisions,
it must be visible in the working tree.  That is, metadata in the
sense of data which is not visible in the working tree, is not allowed
to exist inside Git and carried across revisions.  So fundamentally,
Git does not currently today support "svn propset" in terms of setting
metadata on a particular file which isn't visible in the working tree.

With SVN, today you can use svn propset to what you could think of as
extended attributes.  So one proposal that you *could* try proposing
is using extended attributes to represent arbitrary properties,
including the one which you want, which is the "do not erase"
property.  And one of the arguments might be that this way we could
better preserve arbitrary properties currently set inside SVN, so that
such repository could be faithfully translated into a Git repository.  

The problem with such a proposal is that it now requires that the
filesystem used to store the working directory MUST support extended
attributes, and some filesystems, such as FAT filesystems, do not.
And Git already has been accused of not being Windows friendly enough,
and this would make things worse.

It's also a lot of hair for two very marginal features, namely being
able to support arbitrary SVN property values, and the "do not erase
when empty" directory bit.  Personally, I don't htink it's worth it,
but at least using filesystem xattrs to store that one bit of
information would at least be faithful to the fundamental git design
principal.

Regards,

						- Ted
