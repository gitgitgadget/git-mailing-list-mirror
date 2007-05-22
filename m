From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Tue, 22 May 2007 09:59:29 -0700
Message-ID: <56b7f5510705220959x1b37a4adk537cc0cba1a27530@mail.gmail.com>
References: <46528A48.9050903@gmail.com>
	 <7vtzu58i4c.fsf@assigned-by-dhcp.cox.net>
	 <56b7f5510705220100h77e91196r1784b33772911660@mail.gmail.com>
	 <f2uigr$ufj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, danahow@gmail.com,
	"Junio C Hamano" <junkio@cox.net>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 18:59:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqXhx-0000ZW-Od
	for gcvg-git@gmane.org; Tue, 22 May 2007 18:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757067AbXEVQ7c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 12:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758770AbXEVQ7c
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 12:59:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:45954 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757067AbXEVQ7b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 12:59:31 -0400
Received: by ug-out-1314.google.com with SMTP id 44so350000uga
        for <git@vger.kernel.org>; Tue, 22 May 2007 09:59:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OfkpcHf6HNAK/Nr7HbBKcr1Sj3iZhUDS8yphwfqahcwgxiAHJA4meKfaimaXNBfhCljHW7iCwRJcXQSWsGTx4Uukm6iQY5/aR8Ofv9xRT+IptQNYS1K4njNyJ2k/JIpa9HlzqnRjeJsmZvdtb5daG+aUVT0ZMMnW4zf1V1WYD7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YY4KyF9l9jVoOL1us1a8XoaLs/UXl2ISksdzfmC3vSmkrgD36lXzeUJYdt5CbHXnxPEVgBOuV9p0uBSqolskoqi5x38EF03y+aeGA0WaJAJolDHghDOUuvjtGZxhUpcOhzcL9Dr5PZGTJP0gWafJdGvGM0KVoAo1HHJNoq7wxMY=
Received: by 10.78.107.8 with SMTP id f8mr1515183huc.1179853169863;
        Tue, 22 May 2007 09:59:29 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Tue, 22 May 2007 09:59:29 -0700 (PDT)
In-Reply-To: <f2uigr$ufj$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48110>

On 5/22/07, Jakub Narebski <jnareb@gmail.com> wrote:
> Dana How wrote:
> > There's actually an even more extreme example from my day job.
> > The software team has a project whose files/revisions would be
> > similar to those in the linux kernel (larger commits, I'm sure).
> > But they have *ONE* 500MB file they check in because it takes
> > 2 or 3 days to generate and different people use different versions of it.
> > I'm sure it has 50+ revisions now. If they converted to git and included
> > these blobs in their packfile, that's a 25GB uncompressed increase!
> > *Every* git operation must wade through 10X -- 100X more packfile.
> > Or it could be kept in 50+ loose objects in objects/xx ,
> > requiring a few extra syscalls by each user to get a new version.
> Or keeping those large objects in separate, _kept_ packfile, containing
> only those objects (which can delta well, even if they are large).

Yes, I experimented with various changes to git-repack and
having it create .keep files just before coming up with the maxblobsize
approach.  The problem with a 12GB+ repo is not only the large
repack time,  but the fact that the repack time keeps growing with
the repo size.  So, with split packs, I had repack create .keep
files for all new packs except the last (fragmentary) one.  The next
repack would then only repack new stuff plus the single fragmentary
pack, keeping repack time from growing (until you deleted the .keep
files [just the ones with "repack" in them] to start over from scratch).
But this approach is not going to distribute commits and trees all that well.

Last night before signing off Junio proposed some partitioning ideas.
He presented them as ordering things *within* one pack;  what I had
tried was making repack operate in 2 passes: the first one would create
pack(s) containing commits+trees+tags, the 2nd would create
pack(s) containing only blobs.  Of course the first group would contain
only 1 tiny pack, and the latter 6 or 7 enormous packs.  I also combined
this with the previous paragraph, putting .keep files on all but the last
pack in each group.  Then the metadata always got repacked,
and the blob data only got its "tail" repacked.

Let's just stipulate that you've convinced me that putting everything
in packs, and not ejecting megablobs, is better or equivalent on
the "central" git repository which will replace (part of) our Perforce
repository.  What about the users' repositories?

Each person at my day job has his own workstation.  They are all
on a grid and are constantly running jobs in the background.
Each person would have at least one personal repo.  What should the
packing strategy be there?

(1) If we must put everything in packs,  then we could:
(1a) Repack everything in local repos, incurring large local runtimes.
       This extra work then denies the CPU cycles to the grid,
       which WILL be noticed and cause much whining.
       So the response will be to reduce window and/or turn
       on nodelta for some group of objects, worsening packing
       and failing to squash the whining.  This happens across
       20 to 30 workstations.  Or we reduce the frequency of
       repacking and stagger it across the network.  Since daily
       pull/fetch/checkout ("sync" in p4 parlance) grabs 400+ new
       revisions each day,  if we make repacking weekly we have
       a policy that results in 400*5/2=1000 extra loose blobs on average,
       and there will still be whining.  Why not just set maxblobsize
       to some size resulting in ~1000 loose blobs, leave window/depth
       at default, and enjoy <1hr repacking?
(1b) Repack everything ONLY in the central repo, and have the users' repos
      point to it as an alternate.  Now we have enormous network traffic.
       However, this is better than (1a), and was what I thought I'd be
       stuck with.  We still do have the possible problem of excessive
       packing time on the central repo,  but it's easier to solve/hide
      in just one place.
(2) We repack everything but leave megablobs loose.  Now packfiles
     are 13MB, repack time with default window/depth is <1hr,  and we
     can repack each users' repository from his own cron job.  This will
     be noticed,  but it won't cause too much complaining.  Most git
     operations by users will be against their local repos,  but the
     server's db will still be an alternate to fetch at least megablobs.
     This is not a problem compared to Perforce,  which stores *NO*
     repository state locally at all.

I really think megablob ejection from packs makes a lot of sense for local
repos on a network of workstations.  It lets me keep almost all repo
state locally very cheaply.  It is just another consequence of the tendency
that an adequate solution that operates principally on only 13MB of data
doesn't have to work as hard or as carefully as something
operating on the full 12GB -- three orders of magnitude larger.

If there's interest,  I could submit my other alterations to git-repack.
They still have bugs which would take a while to work out since
each run operates on 12GB of data.  With quicker runtimes,
maxblobsize was much quicker to debug even though I made
more stupid mistakes at first ;-)

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
