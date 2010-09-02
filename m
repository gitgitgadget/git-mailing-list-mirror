From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 02 Sep 2010 13:21:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009021249510.19366@xanadu.home>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
 <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
 <4C7FC3DC.3060907@gmail.com>
 <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_hGCZXwIqtWwRiCwEjNM9ng)"
Cc: gitzilla@gmail.com, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 19:21:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrDTh-0000BL-2y
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 19:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490Ab0IBRV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 13:21:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42638 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab0IBRV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 13:21:26 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L840020MQVO7S30@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 02 Sep 2010 13:21:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155152>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_hGCZXwIqtWwRiCwEjNM9ng)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Thu, 2 Sep 2010, Luke Kenneth Casson Leighton wrote:

> On Thu, Sep 2, 2010 at 4:33 PM, A Large Angry SCM <gitzilla@gmail.com> wrote:
> > On 09/02/2010 09:37 AM, Luke Kenneth Casson Leighton wrote:
> >>
> >> On Wed, Sep 1, 2010 at 11:04 PM, Nguyen Thai Ngoc Duy<pclouds@gmail.com>
> >>  wrote:
> >
> > [...]
> >>>
> >>> There were discussions whether a pack is stable enough to
> >>> be shared like this,
> >>
> >>  it seems to be.  as long as each version of git produces the exact
> >> same pack object, off of the command "git pack-objects --all --stdout
> >> --thin {ref}<  {objref}"
> >
> > This is not guaranteed.
> 
>  ok.  greeeat.
> 
>  so, some sensible questions:
> 
>  * what _can_ be guaranteed?

You can guarantee that if the SHA1 name of different packs is the same 
then they contain the same set of objects.  Obviously their packed 
encoding will be different, and even the pack sizes might be quite 
different too.

>  * diffs?

Again that depends.  Over the evolution of Git, its diff library was 
modified resulting in slightly different but valid equivalent diff 
outputs.

>  * git-format-patches? (which i am aware can do binary files and also
> rms)?

Same as above.

> * individual files in the .git/objects directory?

Well, even then you can't guarantee they will be identical from one 
system to another.  That may depend on the zlib library version used for 
example.

>  and, asking perhaps some silly questions:
> 
> * why is it not guaranteed?

Because it doesn't need to.

> * under what circumstances is it not guaranteed?  and, crucially, is
> it necessary to care?   i.e. if someone does a shallow git clone, i
> couldn't give a stuff.

Like I said, even repeating some repacking on the same machine with same 
input is likely to produce slightly different packs because of 
threading.  This is because the work set is divided between threads, and 
since thread scheduling is not deterministic then some threads might not 
have the same amount of CPU cycles given to them in relation with the 
other threads.  And when a thread is done with its work set, it will go 
and steal half of the work set from another thread with the most 
amount of work 
still left.  This has the effect of changing the delta pairing outcome 
on the workset edges.

> * is it possible to _make_ the repository guaranteed to produce
> identical pack objects?

Sure, but performance will suck.

> * does for example "git gc" change the object store in such a way such
> that one git repo will produce a different pack-object from the same
> ref?  if so, can running "git gc" prior to producing the pack-objects
> gurantee that the pack-objects will be the same?

No.  The gc operation will combine multiple small packs into one and try 
to reuse as much data from those existing packs as possible without 
recomputing it.  So you'll end up reusing whatever delta pairing you 
were given from your peer the last time you cloned a repo or fetched an 
update.  And of course that clone/fetch was the result of a pack 
combining operation on the sending end which itself tried to reuse as 
much of the existing data from different packs without recomputing it 
too.  Only the edges between different packs will be delta compressed in 
those cases, using the particular heuristics that happen to be 
implemented in the involved Git versions. So you may end up with a 
totally different pack content containing data segments that originated 
from wildly random places on the net.

The only way to get a bit-for-bit reproducible pack one one specific 
system is to use 'git repack' with the -f switch, and limit it to only 
one thread.

> * is it a versioning issue?  is it because there are different
> versions (2 and 3)?  if so, that's ok, you just force people to use
> the same pack-object versions.

Not at all.  FYI version 3 never was actually deployed so there is 
effectively only version 2 in play.  There are "features" such as 
OFS_DELTA that are negotiated when a pack is transferred over the git 
protocol and if the receiver doesn't advertise them then the sender will 
convert them on the fly into a compatible form.

But as the actual pack bitstream goes, it is totally unstable for all 
the reasons I've stated so far.  Of course, Git being distributed must 
rely on some stable and universal representation of object content, 
hence their SHA1 references.  But their encoding doesn't have to be when 
all peers can cope with all the variations.

I'm sorry as this isn't going to help you much unfortunately.










> 
> etc. etc.
> 
> l.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--Boundary_(ID_hGCZXwIqtWwRiCwEjNM9ng)--
