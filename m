From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Add --create-cache to repack
Date: Fri, 28 Jan 2011 17:32:01 -0800
Message-ID: <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net> <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <alpine.LFD.2.00.1101281304270.8580@xanadu.home> <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com>
 <alpine.LFD.2.00.1101281502170.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	John Hawley <warthog19@eaglescrag.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Jan 29 02:32:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pizg1-0006SD-3Z
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 02:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859Ab1A2Bc1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 20:32:27 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42346 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab1A2BcZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jan 2011 20:32:25 -0500
Received: by fxm20 with SMTP id 20so3972928fxm.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 17:32:24 -0800 (PST)
Received: by 10.103.241.16 with SMTP id t16mr1638331mur.23.1296264742958; Fri,
 28 Jan 2011 17:32:22 -0800 (PST)
Received: by 10.103.1.2 with HTTP; Fri, 28 Jan 2011 17:32:01 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1101281502170.8580@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165647>

On Fri, Jan 28, 2011 at 13:09, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 28 Jan 2011, Shawn Pearce wrote:
>
>> On Fri, Jan 28, 2011 at 10:46, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
>> > On Fri, 28 Jan 2011, Shawn Pearce wrote:
>> >
>> >> This started because I was looking for a way to speed up clones c=
oming
>> >> from a JGit server. =A0Cloning the linux-2.6 repository is painfu=
l,

Well, scratch the idea in this thread.  I think.

I retested JGit vs. CGit on an identical linux-2.6 repository.  The
repository was fully packed, but had two pack files.  362M and 57M,
and was created by packing a 1 month old master, marking it .keep, and
then repacking -a -d to get most recent last month into another pack.
This results in some files that should be delta compressed together
being stored whole in the two packs (obviously).

The two implementations take the same amount of time to generate the
clone.  3m28s / 3m22s for JGit, 3m23s for C Git.  The JGit created
pack is actually smaller 376.30 MiB vs. C Git's 380.59 MiB.  I point
out this data because improvements made to JGit may show similar
improvements to CGit given how close they are in running time.

I fully implemented the reuse of a cached pack behind a thin pack idea
I was trying to describe in this thread.  It saved 1m7s off the JGit
running time, but increased the data transfer by 25 MiB.  I didn't
expect this much of an increase, I honestly expected the thin pack
portion to be well, thinner.  The issue is the thin pack cannot delta
against all of the history, its only delta compressing against the tip
of the cached pack.  So long-lived side branches that forked off an
older part of the history aren't delta compressing well, or at all,
and that is significantly bloating the thin pack.  (Its also why that
"newer" pack is 57M, but should be 14M if correctly combined with the
cached pack.)  If I were to consider all of the objects in the cached
pack as potential delta base candidates for the thin pack, the entire
benefit of the cached pack disappears.


Which leaves me with dropping this idea.  I started it because I was
actually looking for a way to speed up JGit.  But we're already
roughly on-par with CGit performance.  Dropping 1m7s on a clone is
great, but not at the expense of 6.5% larger network transfer.  For
most clients, 25 MiB of additional data transfer may be much more
significant time than 1m7s saved doing server-side computation.

>> That's what I also liked about my --create-cache flag.
>
> I do agree on that point. =A0 And I like it too.

I'm not sure I like it so much anymore.  :-)

The idea was half-baked, and came at the end of a long day, and after
putting my cranky infant son down to sleep way past his normal bed
time.  I claim I was a sleep deprived new parent who wasn't thinking
things through enough before writing an email to git@vger.

>> sendfile() call for the bulk of the content. =A0I think we can just =
hand
>> off the major streaming to the kernel.
>
> While this might look like a good idea in theory, did you actually
> profile it to see if that would make a noticeable difference? =A0The
> pkt-line framing allows for asynchronous messages to be sent over a
> sideband,

No, of course not.  The pkt-line framing is pretty low overhead, but
copying kernel buffer to userspace back to kernel buffer sort of sucks
for 400 MiB of data.  sendfile() on 400 MiB to a network socket is
much easier when its all kernel space.  I figured, if it all worked
out already to just dump the pack to the wire as-is, then we probably
should also try to go for broke and reduce the userspace copying.  It
might not matter to your desktop, but ask John Hawley (CC'd) about
kernel.org and the git traffic volume he is serving.  They are doing
more than 1 million git:// requests per day now.

>> Plus we can safely do byte range requests for resumable clone within
>> the cached pack part of the stream.
>
> That part I'm not sure of. =A0We are still facing the same old issues
> here, as some mirrors might have the same commit edges for a cache pa=
ck
> but not necessarily the same packing result, etc. =A0So I'd keep that=
 out
> of the picture for now.

I don't think its that hard.  If we modify the transfer protocol to
allow the server to denote boundaries between packs, the server can
send the pack name (as in pack-$name.pack) and the pack SHA-1 trailer
to the client.  A client asking for resume of a cached pack presents
its original want list, these two SHA-1s, and the byte offset he wants
to restart from.  The server validates the want set is still
reachable, that the cached pack exists, and that the cached pack tips
are reachable from current refs.  If all of that is true, it validates
the trailing SHA-1 in the pack matches what the client gave it.  If
that matches, it should be OK to resume transfer from where the client
asked for.

Then its up to the server administrators of a round-robin serving
cluster to ensure that the same cached pack is available on all nodes,
so that a resuming client is likely to have his request succeed.  This
isn't impossible.  If the server operator cares they can keep the
prior cached pack for several weeks after creating a newer cached
pack, giving clients plenty of time to resume a broken clone.  Disk is
fairly inexpensive these days.

But its perhaps pointless, see above.  :-)

--=20
Shawn.
