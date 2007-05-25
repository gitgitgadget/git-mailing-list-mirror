From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Fri, 25 May 2007 01:44:58 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705250010350.3366@xanadu.home>
References: <46528A48.9050903@gmail.com>
 <7v7iqz19d2.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705231655o589de801w88adc1aa6c18162b@mail.gmail.com>
 <7vps4ryp02.fsf@assigned-by-dhcp.cox.net> <20070524071235.GL28023@spearce.org>
 <56b7f5510705241629n192a41adi4c0d63c53cf8472b@mail.gmail.com>
 <20070525020642.GS28023@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 25 07:45:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrScH-00067g-MK
	for gcvg-git@gmane.org; Fri, 25 May 2007 07:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbXEYFpF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 01:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbXEYFpF
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 01:45:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33947 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbXEYFpC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 01:45:02 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIL007DL1AYZ520@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 25 May 2007 01:44:59 -0400 (EDT)
In-reply-to: <20070525020642.GS28023@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48343>


OK..... I ignore git@vger.kernel.org for a day or two and things really 
start to go wild!  ;-)

I'll try to cover only those points that are still debatable.  I think 
everybody agrees with huge blobs as loose objects using extra inodes 
being the least of our worries.

On Thu, 24 May 2007, Shawn O. Pearce wrote:

> Dana How <danahow@gmail.com> wrote:
> > On 5/24/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > >Junio C Hamano <junkio@cox.net> wrote:
> > >> "Dana How" <danahow@gmail.com> writes:
> > >> > We have three options in this case:
> > >> > (1) Drop the object (do not put it in the new pack(s)).
> > >> > (2) Pass the object into the new pack(s).
> > >> > (3) Write out the object as a new loose object.
> > >> > Option (1) is unacceptable.  When you call git-repack -a,
> > >> > it blindly deletes all the non-kept packs at the end.  So
> > >> > the megablobs would be lost.
> > >> Ok, I can buy that -- (1) nor (2) are unacceptable and (3) is
> > >> the only sane thing to do for a previously packed objects that
> > >> exceed the size limit.

OK... I sort of agree, but not entirely.

First, let's examine the reasons for wanting to expulse a big blob out 
of a pack.

The first reason I've seen is that big blobs put surrounding objects way 
apart and pack access performance gets bad, especially tree walking.  
The solution to this problem is trivial: let's simply store big blobs 
together at the end of the pack!  Problem solved.

The other reason for keeping huge blobs out is that they bring repack 
performance down and create unnecessary IO.  Well, in that case I think 
that you should simply avoid (re)packing them in the first place.  I 
think it should be possible to combine both features: the split packs 
and the big-blobs-go-at-the-end solution I mentioned above so that those 
big blobs could end up in one or more packs of their own.

But writing loose objects from git-pack-objects... Nah, this is just too 
hacky and ugly.  The tool is about packing objects and starting to 
create loose objects from there is pushing the packing concept a bit too 
far for my taste.

I wouldn't mind a _separate_ tool that would load a pack index, 
determine object sizes from it, and then extract big objects to write 
them as loose objects (although I question its usefulness).  But not 
within pack-objects please.

So I think the best solution really involves a new parameter to 
git-pack-objects allowing for objects which size exceed a certain 
treshold to go at the end of the pack.  If they end up in a different 
pack because of pack size limit then so be it, at which point you could 
always explode that huge-blob pack into loose objects, avoiding the need 
for the extra tool I mention above, but again I don't think that would 
be that useful.

> > Again Geert made a good argument that didn't occur to me that
> > you definitely DON'T want to do deltification on such large objects.
> > Junio recently added delta/nodelta attribute; this would be useful
> > to me,  but unfortunately I have several continua of files,  each with
> > the same suffix,  but with largely varying sizes, so attributes won't
> > help me unless the name globs in .gitattributes are expanded to full
> > expressions similar to find(1) [i.e. include testing based on size,
> > perms, type],  which I think would be insane.

I think having a parameter to exclude object which size exceed a 
specified size treshold from deltification attempts would also be a 
valid option. But...

> Which brings up the comment I think I made (below) about skipping
> deltas on very large objects.  Things over a certain size are not
> likely to delta well, or in any reasonable time.  We probably should
> default to not trying to delta those, but let the user force us to
> do so with a .gitattributes option.  Maybe.

I don't agree with the presumption that huge objects are unlikely to 
delta well.  It really depends on the data you have.  If, for example, 
you want to store, say, different versions of a filesystem image, then 
those different images have the potential to be really huge. Yet they 
might delta extremely well against each other and provide a tremendous 
space saving.

It all depends on the kind of data you work with.
It is good to have the possibility to skip deltification based on a file 
attribute.  It is also good to have the possibility to skip 
deltification based on object size (through a command line switch or 
config entry).  But those must remain _options_.

> > >Huge packfiles probably should be scheduled for keeping with a .keep
> > >automatically.  We probably should teach pack-objects to generate a
> > >.keep file if the resulting .pack was over a certain size threshold
> > >(say 1.5 GiB by default) and teach git-repack to rename the .keep
> > >file as it also renames the .idx and .pack.

Nah.  Those kind of arbitrary defaults are most likely to be fine for 
some cases and bad for many others.  These "sick" cases such as Dana's 
are so special that they better be manually tuned for best operations 
according to the data set, and more importantly to the work flow used, 
because different work flows are likely to require different "defaults".  
Better not put any arbitrary default and create a "Advanced tuning for 
best performances with insane repositories" section in the documentation 
instead.

> > >Better that we degrade gracefully when faced with massive inputs
> > >than we do something stupid by default and make the poor user pay
> > >for their mistake of not throughly reading plumbing documentation
> > >before use.

Well, I think that if someone is seriously considering GIT for a 
multi-gigabyte repository, that person has better read a little 
documentation before starting to play.  Of course this advanced tuning 
for huge repository section I'm suggesting should stand out in the main 
index.  And most "poor users" usually don't have such a big repo to 
fool themselves with.

> > >Now I would agree that we should punt on deltification of anything
> > >that is just too large, and let the user decide what too large means,
> > >and default it around 500 or 1024 MiB.  But I would still stuff it
> > >into a packfile.

Well, thing is, once deltified, those huge objects won't be subject to 
deltification attempts anymore, unless -f is used.  So the deltification 
cost will happen only once anyway.  Then it is only the issue of 
flagging a particular pack with .keep to exclude it from any further 
repacking which would simply end up wasting disk IO anyway.

There is certainly a hard default on deltification attempt that we 
should impose right now though, which is 4GB.  The reason is that the 
delta encoding doesn't do offsets larger than 32 bits at the moment.

> > I previously offered to Junio that the "write loose object" thing
> > could be restricted:  it would only happen if -f were supplied to
> > git-repack,  otherwise the bad blob would pass through to the new pack.
> > Does this "reduction in strength" make this feature more palatable to you?

Not really.

Like I said before, I'd much prefer to have a split pack for huge 
objects, and a separate unpack-object pass on it if you really want them 
loose.  If you want to deny entry of loose objects into a pack based on 
their size that's understandable, but only if they're already loose.

> > I don't agree that once in a packfile,  a blob should stay there.
> > Its presence is degrading access to "normal" blobs co-habiting with it.

As mentioned at the top I don't think this is a big issue.

> Or is it just because we like to repack the smaller metadata
> frequently, but that's horribly expensive because the megablobs
> are in the same packfile?  If its really just about repacking then
> .keep marked megablob packs are the way to go.

I think so as well.


Nicolas
