From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 04 Sep 2010 00:39:56 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009032304560.19366@xanadu.home>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
 <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
 <4C7FC3DC.3060907@gmail.com>
 <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
 <alpine.LFD.2.00.1009021249510.19366@xanadu.home>
 <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
 <alpine.LFD.2.00.1009021624170.19366@xanadu.home>
 <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
 <7voccezr7m.fsf@alter.siamese.dyndns.org> <20100903183120.GA4887@thunk.org>
 <alpine.LFD.2.00.1009031522590.19366@xanadu.home>
 <AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com>
 <AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com>
 <4C81A67B.2060400@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 06:40:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrkXw-0003Uj-G0
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 06:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925Ab0IDEj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 00:39:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24531 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab0IDEj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 00:39:58 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L8700IWPGYGEFN1@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 04 Sep 2010 00:39:53 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4C81A67B.2060400@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155302>

On Sat, 4 Sep 2010, Artur Skawina wrote:

> Hmm, taking a few steps back, what is the expected usage of git-p2p?
> Note it's a bit of a trick question; what i'm really asking is what _else_,
> other than pulling/tracking Linus' kernel tree will/can be done with it?

Dunno.

> Because once you accept that all peers are equal, but some peers are more
> equal than others, deriving a canonical representation of the object store
> becomes relatively simple.

That depends what you consider a canonical representation.  I don't 
think the actual object store should ever be "canonicalized".

> Then, it's just a question of fetching the missing
> bits, whether using a dumb (rsync-like) transport, or a git-aware protocol.

But Git does that already.

> (I've no idea why you'd want to base a transfer protocol on the unstable packs,
> building it on top of objects seems to be the only sane choice)

There seems to be quite some confusion around objects and packs.

The Git "database" is _only_ a big pile of objects that is content 
addressable i.e. each object has a name which is derived from its 
content.  This is the 40 hexadecimal string.

There are only 4 types of objects. Roughly they are:

1) A "blob" object contains plain data, usually used for file content.

2) A "tree" object contains a list of entries made of a file or 
   directory name, and the object name that corresponds to it.  For 
   files, the referenced objects are "blobs". For directories, the 
   referenced objects are some other "trees".  This is how the file and 
   directory hierarchy are represented.

3) A "commit" object contains a reference to the top tree object 
   corresponding to the root directory of the project, a reference to 
   the previous "commit" object, and a text message to describe this 
   commit.  If this commit represents a merge, then there will be more 
   than one reference to previous commits.  This is how the commit 
   history is represented.

4) And finally a "tag" object contains a reference to any other object 
   and a text message.  Most of the time, only commit objects are 
   referenced that way.  This is used to identify some particular 
   commits.

And finally, there are a few files, one for each "branch", used to 
contain a reference to the latest commit object for each of those 
branches.

That's it!  Here you have the *whole* architecture of Git!

Now... one way to store those objects on disk is to simply deflate them 
with zlib and put the result in a file, one file per object.  The first 
2 chars from the object name are used to create ssubdirectories under 
.git/objects/ and the remaining 38 chars are used for the actual file 
name within those subdirectories.  This is the "loose" object format or 
encoding.

Another way to store those objects is to cram them together in one or 
multiple (or many) pack files.  The advantage with the pack file is that 
we can encode any object as a delta against any other object in the same 
pack file.  This is the "packed" object format or encoding.

> I'm mostly git-ignorant and i'm assuming the following two things -- if someone
> more familiar w/ git internals could confirm/deny, that would be great:
> 
> 1) "git pull git:..." would (or could be made to) work w/ a client that asks for
>    "A..E", but also tells the server to omit "B,C and D" from the wire traffic.    

What Git does when transferring data on the wire is actually to create a 
special pack file that contains _only_ those objects that the sender has 
but that the receiver doesn't, and stream that over the net.  So if the 
client tells the server that it already has commit A, then the server 
will create a pack that contains only those objects that were created 
after commit A, and omit all the objects that can be reached through 
commit A that are also used by later commits (think unchanged files).  
If you also have commits B, C and D, then the server will also exclude 
all the objects that are reachable through those commits from that 
special pack.

On the receiving end, Git simply writes the received pack into a file 
along with the other existing packs, and compute a pack index for it.

> 2) Git doesn't use chained deltas. IOW given commits "A --d1-> B --d2-> C",
>    "C" can be represented as a delta against "A" or "B", but _not_ against "d1". 
>    (Think of the case where "C" reverts /part of/ "B")

Git does use chained deltas indeed.  But deltas are used only at the 
object level within a pack file.  Any blob object can be represented as 
a delta against any other blob in the pack, regardless of the commit(s) 
those blob objects belong to.  Same thing for tree objects.  So you can 
have deltas going in total random directions if you look them from a 
commit perspective.  So "C" can have some of its objects being deltas 
against objects from "B", or "A", or any other commit for that matter, 
or even objects belonging to the same commit "C". And some other objects 
from "B" can delta against objects from "C" too. There is simply no 
restrictions at all on the actual delta direction.  The only rule is 
that an object may only delta against another object of the same type.

Of course we don't try to delta each object against all the other 
available objects as that would be a O(n^2) operation (imagine with n = 
1.7 million objects).  So we use many heuristics to make this delta 
packing efficient without taking an infinite amount of time.

For example, if we have objects X and Y that need to be packed together 
and sent to a client over the net, and we find that Y is already a delta 
against X in one pack that exists locally, then we simply and literally 
copy the delta representation of Y from that local pack file and send it 
out without recomputing that delta.

> Then there are security implications... Which pretty much mandate having "special"
> peers anyway, at least for transferring heads (branches/tags etc). Which means
> the second paragraph above applies.

Well... Actually, all you need is only one trusted peer to provide those 
heads i.e. the top commit SHA1 name for each branches you need.  From 
that one SHA1 name per branch, you can validate the entire repository as 
every object reference throughout is based on the content of the object 
it refers to.  For example, to validate the authenticity of everything 
from a random copy of the Linux kernel repository, I need only 20 bytes 
from a trusted source.  No need to have this information distributed 
amongst multiple peers.

And even if the delta encoding is different from the one used in Linus' 
repository, or even if the packing is done differently (different number 
of packs, etc.) then the final SHA1 will always be the same.  This is 
because the actual content from all referenced objects is the same 
regardless of their effective encoding or format.


Nicolas
