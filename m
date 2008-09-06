From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git Community Book
Date: Fri, 5 Sep 2008 23:33:25 -0700
Message-ID: <20080906063325.GD28035@spearce.org>
References: <d411cc4a0809051208k2a15c4a7te09a6979929e52f7@mail.gmail.com> <7vmyimv0qr.fsf@gitster.siamese.dyndns.org> <d411cc4a0809051434g4e92790fsa38d12487630aa9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 08:36:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbrPP-0001OR-0H
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 08:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbYIFGd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 02:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbYIFGd1
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 02:33:27 -0400
Received: from george.spearce.org ([209.20.77.23]:34916 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbYIFGd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 02:33:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id AEFC238353; Sat,  6 Sep 2008 06:33:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <d411cc4a0809051434g4e92790fsa38d12487630aa9f@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95064>

Scott Chacon <schacon@gmail.com> wrote:
> On Fri, Sep 5, 2008 at 12:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > "Scott Chacon" <schacon@gmail.com> writes:
> >
> >> Also, the last section of the book is on some of the plumbing - mostly
> >> stuff I've found difficult to pick up with the existing documentation
> >> while re-implementing stuff in Ruby.  I would really appreciate it if
> >> someone could proofread some of these chapters for errors:
> >>
> >> http://book.git-scm.com/7_the_packfile.html

OK, time for me to throw in comments.  ;-)

I do like this book, its organized and concise.  Thanks for doing it.


http://book.git-scm.com/7_how_git_stores_objects.html:

The loose object formatting of

 header = "#{type} #{size}#body"
 store = header + content

I can't read Ruby so I'm not sure what the header value computes
out to here.  #body should be a \0.  I'm also not sure that the
prior line setting size = content.length.to_s is very clear for
the non-Ruby people to understand how a size is formatted.

If the code shown here is the Ruby implementation I'm a little
concerned about it writing directly into the loose object.  If the
write is partial then you have a partial object which is at the
right name, but is unusable.  That can give you corruption that
is difficult to track down and fix.  C Git and JGit both write
to temporary files then atomically move the temporary file into
position under its proper name only after it has been fully written.

If an implementor is implementing they should be offered this advice,
and probably do so right here in this section of the book.

"When objects are written to disk, it is often in the loose format,
since that format is less expensive to access."

I'm not sure that statement is true.  Access from packs tends
to scream compared to access from loose objects.  The overheads
of opening and closing the file descriptors, even on Linux, is
what kills performance for data access.  However Git writes to
loose objects first and packs later for _safety_ not efficiency.
Although it is a lot more efficient to write a 2 KB loose object
and avoid rewriting a 50 MB pack, but its also less likely to fail
and make you lose your work.


http://book.git-scm.com/7_the_git_index.html:

I wouldn't say that the index stores permissions.  More like it
stores the "class" or "type" of the thing located at that path.
There are 4 major classes:

	- regular file
	- executable file
	- symbolic link
	- git submodule

The 5th class is the subtree, but only appears in trees and not
in the index since the index file is actually flat.


http://book.git-scm.com/7_the_packfile.html:

You should probably point out that the .idx file uses network byte
order for the numeric fields like the version number and the file
offsets.

I'd also point out that the offsets in index v1 are unsigned and
from the start of the pack file.  The offsets in index v2 are
also unsigned, but the 1<<31 is tested in the 32 bit offset to
see if a 64 bit offset is used.  The algorithm there is:

	if offset32 & 1<<31:
		offset = ofs64_table[offset32 & ~(1<<31)]
	else
		offset = offset32

Its also rather unclear how the fan out table can be used to limit
the binary search.  What you are missing is describing that fanout[X]
holds the number of objects whose first byte of their SHA-1 is <= X.
Hence fanout[0] has the number of objects whose SHA-1 starts with
"00" and fanout[0x15] has the number of objects whose SHA-1 starts
with "15", "14", "13", ..., "00".  Thus fanout[0xff] has the total
number of objects in the pack.

In the pack file section I'd also point out the version and entry
count are unsigned network byte order.  This is not clear from the
Ruby code, although one can guess at it if one knows the git.git
code very very well (like I do).

"After that, you get a series of packed objects, in order of thier SHAs"

Aside from s/thier/their/ this is not a correct statement _AT ALL_.

The ordering of objects in the packfile is very carefully planned
by the packer to maximize data locality from most recent -> least
recent information, making the most recent revisions of a project
the fastest to access.  This has _NOTHING_ to do with their SHA-1
names.

Technically a pack may store objects in any random order.  Heck,
you can wire up an RNG to the packer to always produce a different
ordering each time you pack.  Practically an implementation shouldn't
be that stupid and should instead try to order objects by recency,
like git.git and JGit both do.

"At the end of the packfile is a 20-byte SHA1 sum of all the shas
(in sorted order) in that packfile."

Also incorrect.  The 20-byte checksum at the end of the pack file
is a checksum of all bytes preceeding the checksum itself.  We use
it as an end-to-end data integrity check, especially on the network
transport to verify that every bit sent by the one side is received
correctly on the other side.

BTW, can I just say, I love the graphics in this book.  They are
quite well done.  Very worthwhile.


http://book.git-scm.com/7_transfer_protocols.html:

You might as well explain that the stream returned by upload-pack
uses the same 4 byte line length framing to form "packets", with
the 5th byte (really first byte of the payload) indicating the
"stream":

	- stream 1 ('\001') is the PACK data
	- stream 2 ('\002') is progress data/information
	- stream 3 ('\003') is the OH S**T we are aborting, died, dead

You may also want to explain that the way you know the end of the
pack is to read the header, get the entry count, and then read that
many objects from the stream, and then verify the pack checksum.

-- 
Shawn.
