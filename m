From: Nicolas Pitre <nico@cam.org>
Subject: Re: Continue git clone after interruption
Date: Sat, 22 Aug 2009 04:13:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908220155240.6044@xanadu.home>
References: <1250509342.2885.13.camel@cf-48>
 <200908200937.05412.jnareb@gmail.com>
 <alpine.LFD.2.00.0908201358010.6044@xanadu.home>
 <200908211207.38555.jnareb@gmail.com>
 <alpine.LFD.2.00.0908211614220.6044@xanadu.home>
 <1250896025.19039.7.camel@maia.lan>
 <alpine.LFD.2.00.0908212324130.6044@xanadu.home>
 <1250920259.3644.11.camel@maia.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_QTpHW+rR0nRcpVLQK0xHGg)"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Tomasz Kontusz <roverorna@gmail.com>,
	git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Aug 22 10:17:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MelmZ-0000iR-Ex
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 10:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830AbZHVINz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 04:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754821AbZHVINz
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 04:13:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52977 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301AbZHVINw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 04:13:52 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOR004VCQC9IEB0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 22 Aug 2009 04:02:33 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1250920259.3644.11.camel@maia.lan>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126802>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_QTpHW+rR0nRcpVLQK0xHGg)
Content-type: TEXT/PLAIN; charset=ISO-8859-15
Content-transfer-encoding: 8BIT

On Sat, 22 Aug 2009, Sam Vilain wrote:

> On Fri, 2009-08-21 at 23:37 -0400, Nicolas Pitre wrote:
> > > What did you think about the bundle slicing stuff?
> > 
> > If I didn't comment on it already, then I probably missed it and have no 
> > idea.
> 
> I really tire of repeating myself for your sole benefit.  Please show
> some consideration for other people in the conversation by trying to
> listen.  Thank-you.

I'm sorry but I have way too many emails to consider reading.  This is 
like ethernet: not a reliable transport, and lost packets means you have 
to retransmit.  Cut and paste does wonders, or even a link to previous 
post.

> > > I think the first step here would be to allow thin pack generation to
> > > accept a bounded range of commits, any of the objects within which may
> > > be used as delta base candidates.  That way, these "top down" thin packs
> > > can be generated.  Currently of course it just uses the --not and makes
> > > "bottom up" thin packs.
> > 
> > The pack is still almost top-down.  It's only the missing delta base 
> > that are in the other direction, refering to objects you have locally 
> > and therefore older.
> 
> Ok, but right now there's no way to specify that you want a thin pack,
> where the allowable base objects are *newer* than the commit range you
> wish to include.

Sure you can.  Try this:

	( echo "-$(git rev-parse v1.6.4)"; \
	  git rev-list --objects v1.6.2..v1.6.3 ) | \
		git pack-objects --progress --stdout > foo.pack

That'll give you a thin pack for the _new_ objects that _appeared_ 
between v1.6.2 and v1.6.3, but which external delta base objects are 
found in v1.6.4.

If you want _all_ the objects that are referenced from commits between 
v1.6.2 and v1.6.3 then you just have to list them all for v1.6.2 in 
addition to the rest:

	( echo "-$(git rev-parse v1.6.4)"; \
	  git rev-list --objects v1.6.2..v1.6.3; \
	  git ls-tree -t -r v1.6.2 | cut  -d' ' -f 3- | tr "\t" " "; ) | \
		git pack-objects --progress --stdout > foo.pack

> What I said in my other e-mail where I showed how well it works taking
> a given bundle, and slicing it into a series of thin packs, was that it
> seems to add a bit of extra size to the resultant packs - best I got for
> slicing up the entire git.git run was about 20%.  If this can be
> reduced to under 10% (say), then sending bundle slices would be quite
> reasonable by default for the benefit of making large fetches
> restartable, or even spreadable across multiple mirrors.

In theory you could have about no overhead.  That all depends how you 
slice the pack.  If you want a pack to contain a fixed number of commits 
(such that all objects introduced by a given commit are all in the same 
pack) then you are of course putting a constraint on the possible delta 
matches and compression result might be suboptimal.  In comparison, with 
a single big pack a given blob can delta against a blob from a 
completely distant commit in the history graph if that provides a better 
compression ratio.

If you slice your pack according to a size treshold, then you might 
consider the --max-pack-size= argument to pack-objects.  This currently 
doesn't produce thin pack as delta objects whose base are stored in a 
different pack than their base because of a pack split are simply not 
stored as delta.  Only a few line of code would need to be modified in 
order to store those deltas nevertheless and turn those packs into thin 
packs, preserving the optimal delta match.  Of course cross pack delta 
reference have to be REF_DELTA objects with headers about 16 to 17 bytes 
larger than those of OFS_DELTA objects, so you will still have some 
overhead.

> The object sorting stuff is something of a distraction; it's required
> for download spreading but not for the case at hand now.

Well, the idea of spreading small packs has its drawbacks.  You still 
might need to get a sizeable portion of them to get at least one usable 
commit.  And ideally you want the top commit in priority, which pretty 
much impose an ordering on the packs you're likely to want first, unlike 
with BitTorrent where you don't care as you normally want all 
the blocks anyway.

If the goal is to make for faster downloads, then you could simply make 
a bundle, copy it on multiple server, and slice your download across 
those servers.  This has the disadvantage of being static data that 
doubles the disk (and cache) usage.  That doesn't work too well with 
shallow clones though.

If you were envisioning _clients_ à la BitTorrent putting up pack slices 
instead, then in that case the slices have to be well defined entities, 
like packs containing objects for known range of commits, but then we're 
back to the delta inefficiency I mentioned above. And again this might 
work only if a lot of people are interested in the same repository at 
the same time, and of course most people have no big insentive to "seed" 
once they got their copy. So I'm not sure if that might work that well 
in practice.

This certainly still looks like a pretty cool project.  But it is not 
all the cool stuff that works well in real conditions I'm afraid.  Just 
my opinion of course.


Nicolas

--Boundary_(ID_QTpHW+rR0nRcpVLQK0xHGg)--
