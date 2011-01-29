From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC] Add --create-cache to repack
Date: Fri, 28 Jan 2011 23:08:23 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101282055190.8580@xanadu.home>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net>
 <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <alpine.LFD.2.00.1101281304270.8580@xanadu.home>
 <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com>
 <alpine.LFD.2.00.1101281502170.8580@xanadu.home>
 <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_22cLCt45GlrdiELlL/Za8w)"
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	John Hawley <warthog19@eaglescrag.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 29 05:10:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pj28d-0000cn-FC
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 05:10:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199Ab1A2EIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 23:08:25 -0500
Received: from relais.videotron.ca ([24.201.245.36]:8919 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab1A2EIY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 23:08:24 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFR00GRBNHN7MB0@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 28 Jan 2011 23:08:11 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Content-id: <alpine.LFD.2.00.1101282111080.8580@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165652>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_22cLCt45GlrdiELlL/Za8w)
Content-id: <alpine.LFD.2.00.1101282111081.8580@xanadu.home>
Content-type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-transfer-encoding: 8BIT

On Fri, 28 Jan 2011, Shawn Pearce wrote:

> On Fri, Jan 28, 2011 at 13:09, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Fri, 28 Jan 2011, Shawn Pearce wrote:
> >
> >> On Fri, Jan 28, 2011 at 10:46, Nicolas Pitre <nico@fluxnic.net> wrote:
> >> > On Fri, 28 Jan 2011, Shawn Pearce wrote:
> >> >
> >> >> This started because I was looking for a way to speed up clones coming
> >> >> from a JGit server.  Cloning the linux-2.6 repository is painful,
> 
> Well, scratch the idea in this thread.  I think.
> 
> I retested JGit vs. CGit on an identical linux-2.6 repository.  The
> repository was fully packed, but had two pack files.  362M and 57M,
> and was created by packing a 1 month old master, marking it .keep, and
> then repacking -a -d to get most recent last month into another pack.
> This results in some files that should be delta compressed together
> being stored whole in the two packs (obviously).
> 
> The two implementations take the same amount of time to generate the
> clone.  3m28s / 3m22s for JGit, 3m23s for C Git.  The JGit created
> pack is actually smaller 376.30 MiB vs. C Git's 380.59 MiB.  I point
> out this data because improvements made to JGit may show similar
> improvements to CGit given how close they are in running time.

What are those improvements?

Now, the fact that JGit is so close to CGit must be because the actual 
cost is outside of them such as within zlib, otherwise the C code should 
normally always be faster, right?

Looking at the profile for "git rev-list --objects --all > /dev/null" 
for the object enumeration phase, we have:

# Samples: 1814637
#
# Overhead          Command  Shared Object  Symbol
# ........  ...............  .............  ......
#
    28.81%              git  /home/nico/bin/git  [.] lookup_object
    12.21%              git  /lib64/libz.so.1.2.3  [.] inflate
    10.49%              git  /lib64/libz.so.1.2.3  [.] inflate_fast
     7.47%              git  /lib64/libz.so.1.2.3  [.] inflate_table
     6.66%              git  /lib64/libc-2.11.2.so  [.] __GI_memcpy
     5.66%              git  /home/nico/bin/git  [.] find_pack_entry_one
     2.98%              git  /home/nico/bin/git  [.] decode_tree_entry
     2.73%              git  /lib64/libc-2.11.2.so  [.] _int_malloc
     2.71%              git  /lib64/libz.so.1.2.3  [.] adler32
     2.63%              git  /home/nico/bin/git  [.] process_tree
     1.58%              git  [kernel]       [k] 0xffffffff8112fc0c
     1.44%              git  /lib64/libc-2.11.2.so  [.] __strlen_sse2
     1.31%              git  /home/nico/bin/git  [.] tree_entry
     1.10%              git  /lib64/libc-2.11.2.so  [.] _int_free
     0.96%              git  /home/nico/bin/git  [.] patch_delta
     0.92%              git  /lib64/libc-2.11.2.so  [.] malloc_consolidate
     0.86%              git  /lib64/libc-2.11.2.so  [.] __GI_vfprintf
     0.80%              git  /home/nico/bin/git  [.] create_object
     0.80%              git  /home/nico/bin/git  [.] lookup_blob
     0.63%              git  /home/nico/bin/git  [.] update_tree_entry
[...]

So we've got lookup_object() clearly at the top.  I suspect the 
hashcmp() in there, which probably gets inlined, is responsible for most 
cycles.  There is certainly a better way here, and probably in JGit you 
rely on some optimized facility provided by the language/library to 
perform that lookup.  So there is probably some easy improvements that 
can be made here.

Otherwise it is at least 12.21 + 10.49 + 7.47 + 2.71 = 32.88% spent 
directly in the zlib code, making it the biggest cost.  This is rather 
unavoidable unless the data structure is changed.  And pack v4 would 
probably move things such as find_pack_entry_one, decode_tree_entry, 
process_tree and tree_entry off the radar as well.

The object writeout phase should pretty much be network bound.

> I fully implemented the reuse of a cached pack behind a thin pack idea
> I was trying to describe in this thread.  It saved 1m7s off the JGit
> running time, but increased the data transfer by 25 MiB.  I didn't
> expect this much of an increase, I honestly expected the thin pack
> portion to be well, thinner.  The issue is the thin pack cannot delta
> against all of the history, its only delta compressing against the tip
> of the cached pack.  So long-lived side branches that forked off an
> older part of the history aren't delta compressing well, or at all,
> and that is significantly bloating the thin pack.  (Its also why that
> "newer" pack is 57M, but should be 14M if correctly combined with the
> cached pack.)  If I were to consider all of the objects in the cached
> pack as potential delta base candidates for the thin pack, the entire
> benefit of the cached pack disappears.

Yeah... this sucks.

> I'm not sure I like it so much anymore.  :-)
> 
> The idea was half-baked, and came at the end of a long day, and after
> putting my cranky infant son down to sleep way past his normal bed
> time.  I claim I was a sleep deprived new parent who wasn't thinking
> things through enough before writing an email to git@vger.

Well, this is still valuable information to archive.

And I wish I had been able to still write such quality emails when I was 
a new parent.  ;-)

> >> sendfile() call for the bulk of the content.  I think we can just hand
> >> off the major streaming to the kernel.
> >
> > While this might look like a good idea in theory, did you actually
> > profile it to see if that would make a noticeable difference?  The
> > pkt-line framing allows for asynchronous messages to be sent over a
> > sideband,
> 
> No, of course not.  The pkt-line framing is pretty low overhead, but
> copying kernel buffer to userspace back to kernel buffer sort of sucks
> for 400 MiB of data.  sendfile() on 400 MiB to a network socket is
> much easier when its all kernel space.

Of course.  But still... If you save 0.5 second by avoiding the copy to 
and from user space of that 400 MiB (based on my machine which can do 
1670MB/s) that's pretty much insignificant compared to the total time 
for the clone, and therefore the wrong thing to optimize given the 
required protocol changes.

> I figured, if it all worked
> out already to just dump the pack to the wire as-is, then we probably
> should also try to go for broke and reduce the userspace copying.  It
> might not matter to your desktop, but ask John Hawley (CC'd) about
> kernel.org and the git traffic volume he is serving.  They are doing
> more than 1 million git:// requests per day now.

Impressive.  However I suspect that the vast majority of those requests 
are from clients making a connection just to realize they're up to date 
already.  I don't think the user space copying is really a problem.

Of course, if we could have used sendfile() freely in, say, 
copy_pack_data() then we would have done so long ago.  But we are 
checksuming the data we create on the fly with the data we reuse from 
disk so this is not necessarily a gain.

> >> Plus we can safely do byte range requests for resumable clone within
> >> the cached pack part of the stream.
> >
> > That part I'm not sure of.  We are still facing the same old issues
> > here, as some mirrors might have the same commit edges for a cache pack
> > but not necessarily the same packing result, etc.  So I'd keep that out
> > of the picture for now.
> 
> I don't think its that hard.  If we modify the transfer protocol to
> allow the server to denote boundaries between packs, the server can
> send the pack name (as in pack-$name.pack) and the pack SHA-1 trailer
> to the client.  A client asking for resume of a cached pack presents
> its original want list, these two SHA-1s, and the byte offset he wants
> to restart from.  The server validates the want set is still
> reachable, that the cached pack exists, and that the cached pack tips
> are reachable from current refs.  If all of that is true, it validates
> the trailing SHA-1 in the pack matches what the client gave it.  If
> that matches, it should be OK to resume transfer from where the client
> asked for.

This is still an half solution.  If your network connection drops after 
the first 52 MiB of transfer given the scenario you provided then you're 
still screwed.


Nicolas

--Boundary_(ID_22cLCt45GlrdiELlL/Za8w)--
