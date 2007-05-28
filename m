From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Mon, 28 May 2007 14:31:40 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705281314440.11491@xanadu.home>
References: <20070526052419.GA11957@spearce.org>
 <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com>
 <20070527033429.GY28023@spearce.org>
 <56b7f5510705262140rea5e1e5r49bdd5e99c466daa@mail.gmail.com>
 <alpine.LFD.0.99.0705271127110.3366@xanadu.home>
 <20070527213525.GC28023@spearce.org>
 <56b7f5510705271835m5a375324p3a908fe766fdf902@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 28 20:31:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsk0c-00068Z-Pf
	for gcvg-git@gmane.org; Mon, 28 May 2007 20:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbXE1Sbq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 14:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbXE1Sbq
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 14:31:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44652 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbXE1Sbp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 14:31:45 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIR00KYEKSSO610@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 28 May 2007 14:31:41 -0400 (EDT)
In-reply-to: <56b7f5510705271835m5a375324p3a908fe766fdf902@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48634>

On Sun, 27 May 2007, Dana How wrote:

> Perhaps I have stumbled on another issue related to
> including SHA-1s in packfiles.  This is completely independent
> of the handling of megablobs (my current focus),  but the presence
> of large blobs do make this issue more apparent.
> 
> Some history of what I've been doing with git:
> First I simply had to import the repo,
> which led to split packs (this was before index v2).
> Then maintaining the repo led to the unfinished maxblobsize stuff.
> Distributing the repo included users pulling (usually) from the central repo,
> which would be trivial since it was also an alternate.
> Local repacking would avoid heavy load on it.
> 
> Now I've started looking into how to push back into the
> central repo from a user's repo (not everything will be central;
> some pulling between users will occur
> otherwise I wouldn't be as interested).
> 
> It looks like the entire sequence is:
> A. git add file [compute SHA-1 & compress file into objects/xx]
> B. git commit [write some small objects locally]
> C. git push {using PROTO_LOCAL}:
> 1. read & uncompress objects
> 2. recompress objects into a pack and send through a pipe
> 3. read pack on other end of pipe and uncompress each object
> 4. compute SHA-1 for each object and compress file into objects/xx
> 
> So, after creating an object in the local working tree,
> to get it into the central repo,  we must:
> compress -> uncompress -> compress -> uncompress -> compress.
> In responsiveness this won't compare very well to Perforce,
> which has only one compress step.
> 
> The sequence above could be somewhat different currently in git.
> The user might have repacked their repo before pushing,
> but this just moves C1 and C2 back earlier in time,
> it doesn't remove the need for them.  Besides,  the blobs in
> a push are more likely to be recent and hence unpacked.
> 
> Also,  C3 and C4 might not happen if more than 100 blobs get pushed.
> But this seems very unusual; only 0.3% of commits in the history
> had 100+ new files/file contents.  If the 100 level is reduced,
> then the central repo fills up with packfiles and their index files,
> reducing performance for everybody (using the central repo as an alternate).

But it makes repacking on the central repo much easier, easily regaining 
performance for everybody, even more so than if objects were left loose.  
You could even use one of GIT's many hooks to asynchronously launch a 
repack whenever a push has been completed to keep the number of server 
side packs low.

Also, the treshold of 100 is for all objects, not only files.  So if you 
do multiple commits before pushing (a workflow that GIT strongly 
encourage) then you need only 12 commits modifying only 3 file each 
with those files located in a subdirectory of their own to create 96 
objects already.  It grows even faster if the modified files are more 
deeply nested.

The 100 object treshold was arbitrarily determined and no performance 
tests were ever done to confirm if this is the best value.

> Thus there really is 5X more compression activity going on
> compared to Perforce.  How can this be reduced?
> 
> One way is to restore the ability to write the "new" loose object format.
> Then C1, C2, and C4 disappear.  C3 must remain because we need
> to uncompress the object to compute its SHA-1;  we don't need
> to recompress since we were already given the compressed form.

C4 isn't mandatory if you keep object packed on the remote end like I 
suggest above.

Note that C1 is unavoidable when locally repacking.  It is the only way 
to make sure the new pack won't blindly reuse data that might have been 
corrupted on disk (think random bit flip), and wrap it with a valid SHA1 
that includes the corrupted data which is even worse.  And yes it 
happened at least once with a report on this list.  This is why we are a 
bit paranoid about data integrity.  And even if the server currently 
recompute object SHA1 upon reception of a pack, I think C1 during a push 
is a good thing too just so you don't bother the server if your own repo 
is locally corrupted.

And yet you need C1 anyway for deltification in most normal cases.

As for C2, you should see it as helping the server repack objects.  If 
C2 is distributed amongst all client (including C1 and deltification) it 
is then much less visible and the server doesn't need to do that part 
when repacking.

> And that final sentence is why I sent this email:  if the packfile
> contained the SHA-1s,  either at the beginning or before each object,
> then they wouldn't need to be recomputed at the receiving end
> and the extra decompression could be skipped as well.  This would
> make the total zlib effort the same as Perforce.

This cannot be done.  GIT, being distributed, means that you should not 
trust the remote end.  The notion of validation and trust comes from the 
fact that GIT actively validate the SHA1 of what it is fed so a rogue 
server (or even client) cannot just substitute an object for another 
(with or without malice) and pretend everything is fine.

> The fact that a loose object is never overwritten would still be retained.
> Is that sufficient security?  Or does the SHA-1 always need to be
> recomputed on the receiving end?  Could that be skipped just for
> specific connections and/or protocols (presumably "trusted" ones)?

Even trusted connections can sometimes transmit bad bits.  Corruption 
_will_ happen someday to someone.  It already happened to people on this 
list.  Hardware is not immune to faults, and the bigger is your repo, 
the more likely you're susceptible to such things.  If SHA1 is validated 
on each hop then any corruption won't be able to propagate.

> Shawn:  I think you mentioned something related to this a few days ago.
> Also, you didn't like split packs putting SHA-1s at the end because
> that messed up streaming for transport, but packs are not split for transport.

Like I stated elsewhere the SHA1 table has no advantage being at the end 
anyway since it cannot be trimmed down even for split packs.


Nicolas
