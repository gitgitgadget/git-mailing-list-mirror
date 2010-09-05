From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 04 Sep 2010 22:16:02 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009042132500.19366@xanadu.home>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
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
 <4C81A67B.2060400@gmail.com> <alpine.LFD.2.00.1009032304560.19366@xanadu.home>
 <4C81DC34.2090800@gmail.com> <alpine.LFD.2.00.1009040153280.19366@xanadu.home>
 <AANLkTi=7jUSCNiPf+HfEQuxaf16Jt06--bFE7=Of9wp=@mail.gmail.com>
 <AANLkTik9awEd40s3r-O8t9DwZBh34Z0ozsxMm1QNjNoT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Artur Skawina <art.08.09@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 04:16:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os4mA-0002MU-B1
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 04:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676Ab0IECQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 22:16:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30685 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337Ab0IECQD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 22:16:03 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L89009WP4YQRX10@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 04 Sep 2010 22:16:03 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTik9awEd40s3r-O8t9DwZBh34Z0ozsxMm1QNjNoT@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155410>

On Sat, 4 Sep 2010, Luke Kenneth Casson Leighton wrote:

> * git-index-pack requires a pack file in order to re-create the index:
> i don't want that
> * git-pack-objects appears to have no way of telling it "just gimme
> index file please"
> * fast-import.c appears not to be what's needed either.
> 
> so - any other methods for just getting the index file (exclusively?)
> any other commands i've missed?  if not, are there any other ways of
> getting a pack's index of objects without err... getting the index
> file?  (i believe the answer to be no, but i'm just making sure) and
> on that basis i believe it is safe to ask: any objections to a patch
> which adds "--index-only" to builtin/pack-objects.c?

No patch is needed.

First, what you want is an index of objects you are willing to share, 
and not the index of whatever pack file you might have on your disk, 
especially if you have multiple packs which is typical.

Try this instead:

    git rev-list --objects HEAD | cut -c -40 | sort

That will give you a sorted list of all objects reachable from the 
current branch.  With the Linux repo, you may replace "HEAD" with 
"v2.6.34..v2.6.35" if you wish, and that would give you the list of the 
new objects that were introduced between v2.6.34 and v2.6.35.  This will 
provide you with 84642 objects instead of the 1.7 million objects that 
the Linux repo contains (easier when testing stuff).

That sorted list of objects is more or less what the pack index file 
contains, plus an offset in the pack for each entry.  It is used to 
quickly find the offset for a given object in the corresponding pack 
file, and the fanout is only a way to cut 3 iterations in the binary 
search.

But anyway, what you want is really to select the precise set of objects 
you wish to share, and not blindly using the pack index file.  If you 
have a public branch and a private branch in your repository, then 
objects from both branches may end up in the same pack and you probably 
don't want to publish those objects from the private branch. The only 
reliable way to generate a list of object is to use the output from 'git 
rev-list'.  Those objects may come from one or multiple packs, or be 
loose in the object subdirectories, or even borrowed from another 
repository through the alternates mechanism.  But rev-list will dig 
those object SHA1s for you and only those you asked for.

You should look at the Git documentation for plumbing commands.  The 
plumbing is actually a toolset that allows you to manipulate and extract 
information from a Git repository.  This is really handy for prototyping 
new functionalities. Initially, the Git user interface was all 
implemented in shell scripts on top of that plumbing.

Back to that rev-list output... OK, you want the equivalent of a fanout 
table.  You may do something like this then:

    git rev-list --objects v2.6.34..v2.6.35 | cut -c -2 | sort | uniq -c

And so on.


Nicolas
