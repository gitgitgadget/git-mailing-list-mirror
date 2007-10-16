From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 01:56:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710160032020.7638@iabervon.org>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: raa.lkml@gmail.com, Johannes.Schindelin@gmx.de, ae@op5.se,
	tsuna@lrde.epita.fr, git@vger.kernel.org, make-w32@gnu.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 07:57:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhfQN-0007xI-AN
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 07:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761034AbXJPF4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 01:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760993AbXJPF4t
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 01:56:49 -0400
Received: from iabervon.org ([66.92.72.58]:40809 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760610AbXJPF4s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 01:56:48 -0400
Received: (qmail 15014 invoked by uid 1000); 16 Oct 2007 05:56:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Oct 2007 05:56:46 -0000
In-Reply-To: <uodezisvg.fsf@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61082>

On Tue, 16 Oct 2007, Eli Zaretskii wrote:

> > Date: Mon, 15 Oct 2007 20:45:02 -0400 (EDT)
> > From: Daniel Barkalow <barkalow@iabervon.org>
> > cc: Alex Riesen <raa.lkml@gmail.com>, Johannes.Schindelin@gmx.de, ae@op5.se, 
> >     tsuna@lrde.epita.fr, git@vger.kernel.org, make-w32@gnu.org
> > 
> > I believe the hassle is that readdir doesn't necessarily report a README in 
> > a directory which is supposed to have a README, when it has a readme 
> > instead.
> 
> Sorry I'm asking potentially stupid questions out of ignorance: why
> would you want readdir to return `README' when you have `readme'?

Say the project upstream has the file being "README", but, for some 
reason, it has ended up checked out as "readme" in your directory. Since 
your filesystem is case insensitive, it's supposed to be the same file, 
but when git goes through the list of files in the directory, it sees 
"readme", and there's nothing between reachable.h and read-cache.c in the 
list of tracked files. We've got a sorted list of filenames we're tracking 
along with their most-recently-seen content, and we want to merge the 
results of readdir with them, and this is obviously more straightforward 
if the filename that's the match for "README" is provided byte-for-byte 
the same, and therefore sorts the same.

> > I think we want O(n) comparison of sorted lists, which doesn't 
> > work if equivalent names don't sort the same.
> 
> You comparison function should be case-insensitive on Windows, or am I
> missing something?

We want both lists sorted, so that we can step through the pair together 
and always reach matches together. This requires that the equivalent names 
sort together, as well as comparing equal.

> > > > - no acceptable level of performance in filesystem and VFS (readdir,
> > > >   stat, open and read/write are annoyingly slow)
> > > 
> > > With what libraries?  Native `stat' and `readdir' are quite fast.
> > > Perhaps you mean the ported glibc (libgw32c), where `readdir' is
> > > indeed painfully slow, but then you don't need to use it.
> > 
> > We want getting stat info, using readdir to figure out what files exist, 
> > for 106083 files in 1603 directories with a hot cache to take under 1s; 
> > otherwise "git status" takes a noticeable amount of time with a medium-big 
> > project, and we want people to be able to get info on what's changed 
> > effectively instantly. My impression is that Windows' native stat and 
> > readdir are plenty fast for what normal Windows programs want, but we 
> > actually expect reasonable performance on an unreasonably-big 
> > metadata-heavy input.
> 
> If that's the issue, then it's not a good idea to call `stat' and
> `readdir' on Windows at all.  `stat' is a single system call on Posix
> systems, while on Windows it usually needs to go out of its way
> calling half a dozen system services to gather the `struct stat' info.
> You need to call something like FindFirstFile, which can do the job of
> `stat' and `readdir' together (and of `fnmatch', if you need to filter
> only some files) in one go.  I don't know whether this will scan 100K
> files under one second (maybe I will try it one of these days), but it
> will definitely be faster than `readdir'+`stat' by maybe as much as an
> order of magnitude.

Ah, that's helpful. We don't actually care too much about the particular 
info in stat; we just want to know quickly if the file has changed, so we 
can hash only the ones that have been touched and get the actual content 
changes.

> > > > - no real "mmap" (which kills perfomance and complicates code)
> > > 
> > > You only need mmap because you are accustomed to use it on GNU/Linux.
> > 
> > I believe the need here is quick setup and fast access to sparse portions 
> > of several 100M files. It's hard to beat a page fault for read speed.
> 
> If you need memory-mapped files, they are available on Windows.  I
> thought the original comment about `mmap' was because it was used to
> allocate memory, not read files into memory.

No, we get our memory with malloc like normal people. The mmap is because 
we want to feed files and parts of files to zlib, and mmap makes that 
easy.

> > We also expect to be able to make a sequence of file system operations 
> > such that programs starting at any time see the same database as the files 
> > containing the database get restructured.
> 
> Sorry, I don't understand this; please tell more about the operations,
> ``the same database'' issue (what database?) and what do you mean by
> ``the files containing the database get restructured''.

Git is built around a database of objects, which includes "blobs" (file 
content), "trees" (directory structure), "commits" (history linkage), and 
"tags" (additional annotations). Each of these objects gets hashed, and is 
referenced by hash. So we need to be able to get the object with a given 
hash quickly, and write an object and take its hash (ideally, stream the 
write and find out the hash at the end, with the database key set at that 
point). Also, this database should be compressed effectively, because it 
ought to compress really well, since a lot of the blobs and trees are only 
slightly different from other blobs or trees (by whatever changes were 
made between that revision and other revisions).

The current implementation of the persistant storage of this database is a 
bit complicated, with the goal being that creating objects is really fast, 
and looking up objects doesn't degrade too quickly, and there are 
optimization operations available that take some time and speed up future 
lookups and reduce the storage overhead (especially so that data can be 
transferred efficiently). The tricky thing is that, while the optimization 
process is running, other programs may be reading the database, so (1) the 
files that are no longer needed, because better-optimized versions are in 
place, may be open in another task, and (2) complete and correct new 
files have to appear and be such that pre-existing tasks will find them 
before old files can be removed. The optimization creates "pack files" and 
"pack indices", where the pack file has a lot of objects with delta 
compression between them and zlib compression of them, and the index files 
tell where everything in the pack file is. So we mmap the index files to 
search through, and mmap portions of the pack files to get the data out 
of, and we may be using them as they're replaced with more comprehensive 
pack files by another task.

Now, it's entirely possible that a completely different database 
implementation would be better on Windows, but our current one does a lot 
of creating files under different names, moving them to names where 
they'll be seen (since this is atomic under POSIX, and partial files are 
never seen by other tasks). Also, once we have new files in place, we 
unlink the files that they replace, so that new tasks will use the new 
ones and tasks that already have old ones open can still get the data out 
of them. Also, the files generally get mmaped, 

> > A unixy pipeline was convenient
> 
> Windows supports pipelines with almost 100% the same functionality as
> Posix.  Again, perhaps I'm missing something.

I'm probably the one missing something here; I don't really know anything 
about Windows, and I only know what code other people have had problems 
porting. Mostly what we use for IPC is pipelines, so, if they work well, I 
don't know what the problem is.

	-Daniel
*This .sig left intentionally blank*
