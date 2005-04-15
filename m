From: Ray Heasman <lists@mythral.org>
Subject: Re: space compression (again)
Date: Fri, 15 Apr 2005 12:33:03 -0700
Message-ID: <1113593583.29624.46.camel@maze.mythral.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Apr 15 21:30:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMWVj-0004pu-Va
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 21:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVDOTdV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 15:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVDOTdV
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 15:33:21 -0400
Received: from soggy199.drizzle.com ([216.162.199.199]:59398 "EHLO mythral.org")
	by vger.kernel.org with ESMTP id S261924AbVDOTdH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 15:33:07 -0400
Received: (qmail 1879 invoked from network); 15 Apr 2005 12:33:05 -0700
Received: from dsl254-013-025.sea1.dsl.speakeasy.net (HELO maze.mythral.org) (authuser@216.254.13.25)
  by 192.168.0.8 with RC4-MD5 encrypted SMTP; 15 Apr 2005 12:33:05 -0700
To: git@vger.kernel.org
X-Mailer: Evolution 2.0.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

For for this email not threading properly, I have been lurking on the
mail list archives and just had to reply to this message.

I was planning to ask exactly this question, and Scott beat me to to. I
even wanted to call them "chunks" too. :-)

It's probably worthwhile for anyone discussing this subject to read this
link: http://www.cs.bell-labs.com/sys/doc/venti/venti.pdf . I know it's
been posted before, but it really is worth reading. :-)

On Fri, 15 Apr 2005, Linus Torvalds wrote:
> On Fri, 15 Apr 2005, C. Scott Ananian wrote:
> > 
> > Why are blobs per-file?  [After all, Linus insists that files are an 
> > illusion.]  Why not just have 'chunks', and assemble *these* 
> > into blobs (read, 'files')?  A good chunk size would fit evenly into some 
> > number of disk blocks (no wasted space!).
>
> I actually considered that. I ended up not doing it, because it's not 
> obvious how to "block" things up (and even more so because while I like 
> the notion, it flies in the face of the other issues I had: performance 
> and simplicity).

I don't think it's as bad as you think.

Let's conceptually have two types of files - Pobs (Proxy Objects, or
Pointer Objects), and chunks. Both are stored and referenced by their
content hash, as usual. Pobs just contain a list of hashes referencing
the chunks in a file. When a file is initially stored, we chunk it so
each chunk fits comfortably in a block, but otherwise we aren't too
critical about sizes. When a file is changed (say, a single line edit),
we update the chunk that contains that line, hash it and store it with
its new name, and update the Pob, which we rehash and restore. If a
chunk grows to be very large (say > 2 disk blocks), we can rechunk it
and update the Pob to include the new chunks.

> The problem with chunking is:
>  - it complicates a lot of the routines. Things like "is this file 
>    unchanged" suddenly become "is this file still the same set of chunks",
>    which is just a _lot_ more code and a lot more likely to have bugs.

You're half right; it will be more complex, but I don't think it's as
bad as you think. Pobs are stored by hash just like anything else. If
some chunks are different, the pob is different, which means it has a
different hash. It's exactly the same as dealing with changed file now.
Sure, when you have to fetch the data, you have to read the pob and get
a list of chunks to concatenate and return, but your example given
doesn't change.

>  - you have to find a blocking factor. I thought of just going it fixed 
>    chunks, and that just doesn't help at all. 

Just use the block size of the filesystem. Some filesystems do tail
packing, so space isn't an issue, though speed can be. We don't actually
care how big a chunk is, except to make it easy on the filesystem.
Individual chunks can be any size.

>  - we already have wasted space due to the low-level filesystem (as 
>    opposed to "git") usually being block-based, which means that space 
>    utilization for small objects tends to suck. So you really want to 
>    prefer objects that are several kB (compressed), and a small block just
>    wastes tons of space.

If a chunk is smaller than a disk block, this is true. However, if we
size it right this is no worse than any other file. Small files (less
than a block) can't be made any larger, so they waste space anyway.
Large files end up wasting space in one block unless they are a perfect
multiple of the block size.

When we increase the size of a chunk, it will waste space, but we would
have created an entire new file, so we win there too.

Admittedly, Pobs will be wasting space too.

On the other hand, I use ReiserFS, so I don't care. ;-)

>  - there _is_ a natural blocking factor already. That's what a file 
>    boundary really is within the project, and finding any other is really 
>    quite hard.

Nah. I think I've made a good case it isn't.

> So I'm personally 100% sure that it's not worth it. But I'm not opposed to
> the _concept_: it makes total sense in the "filesystem" view, and is 100%
> equivalent to having an inode with pointers to blocks. I just don't think 
> the concept plays out well in reality.

Well, the reason I think this would be worth it is that you really win
when you have multiple parallel copies of a source tree, and changes are
cheaper too. If you store all the chunks for all your git repositories
in one place, and otherwise treat your trees of Pobs as the real
repository, your copied trees only cost you space for the Pobs.
Obviously this also applies for file updates within past revisions of a
tree, but I don't know how much it would save. It fits beautifully into
the current abstraction, and saves space without having to resort to
rolling hashes or xdeltas.

The _real_ reason why I am excited about git is that I have a vision of
using this as the filesystem (in a FUSE wrapper or something) for my
home directory. MP3s and AVIs aside, it will make actual work much
easier for me. I have a dream; a dream where I save files using the same
name, safe in the knowledge that I can get to any version I want. I will
live in a world of autosaves, deletes without confirmation, and /etcs
immune from the vagaries of my package management systems, not to
mention users not asking me leading questions about backups. *sigh*
*sniff* Excuse me, I think I have to go now.

-Ray


