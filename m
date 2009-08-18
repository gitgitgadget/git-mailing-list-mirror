From: Nicolas Pitre <nico@cam.org>
Subject: Re: Continue git clone after interruption
Date: Tue, 18 Aug 2009 13:56:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908181246470.6044@xanadu.home>
References: <1250509342.2885.13.camel@cf-48>
 <alpine.DEB.1.00.0908171430010.4991@intel-tinevez-2-302>
 <vpqskfphe2k.fsf@bauges.imag.fr> <1250578735.2885.40.camel@cf-48>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>
To: Tomasz Kontusz <roverorna@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 19:56:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdSv7-0003Fa-92
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 19:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758538AbZHRR4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 13:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754037AbZHRR4V
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 13:56:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51730 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbZHRR4U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 13:56:20 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOL009W82N4K4C0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 Aug 2009 13:45:05 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1250578735.2885.40.camel@cf-48>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126431>

On Tue, 18 Aug 2009, Tomasz Kontusz wrote:

> Ok, so it looks like it's not implementable without some kind of cache
> server-side, so the server would know what the pack it was sending
> looked like.
> But here's my idea: make server send objects in different order (the
> newest commit + whatever it points to first, then next one,then
> another...). Then it would be possible to look at what we got, tell
> server we have nothing, and want [the newest commit that was not
> complete]. I know the reason why it is sorted the way it is, but I think
> that the way data is stored after clone is clients problem, so the
> client should reorganize packs the way it wants.

That won't buy you much.  You should realize that a pack is made of:

1) Commit objects.  Yes they're all put together at the front of the pack,
   but they roughly are the equivalent of:

	git log --pretty=raw | gzip | wc -c

   For the Linux repo as of now that is around 32 MB.

2) Tree andblob objects.  Those are the bulk of the content for the top 
   commit.  The top commit is usually not delta compressed because we 
   want fast access to the top commit, and that is used as the base for 
   further delta compression for older commits.  So the very first 
   commit is whole at the front of the pack right after the commit 
   objects.  you can estimate the size of this data with:

	git archive --format=tar HEAD | gzip | wc -c

   On the same Linux repo this is currently 75 MB.

3) Delta objects.  Those are making the rest of the pack, plus a couple 
   tree/blob objects that were not found in the top commit and are 
   different enough from any object in that top commit not to be 
   represented as deltas.  Still, the majority of objects for all the 
   remaining commits are delta objects.

So... if we reorder objects, all that we can do is to spread commit 
objects around so that the objects referenced by one commit are all seen 
before another commit object is included.  That would cut on that 
initial 32 MB.

However you still have to get that 75 MB in order to at least be able to 
look at _one_ commit.  So you've only reduced your critical download 
size from 107 MB to 75 MB.  This is some improvement, of course, but not 
worth the bother IMHO.  If we're to have restartable clone, it has to 
work for any size.

And that's where the real problem is.  I don't think having servers to 
cache pack results for every fetch requests is sensible as that would be 
an immediate DoS attack vector.

And because the object order in a pack is not defined by the protocol, 
we cannot expect the server to necessarily always provide the same 
object order either.  For example, it is already undefined in which 
order you'll receive objects as threaded delta search is non 
deterministic and two identical fetch requests may end up with slightly 
different packing.  Or load balancing may redirect your fetch requests 
to different git servers which might have different versions of zlib, or 
even git itself, affecting the object packing order and/or size.

Now... What _could_ be done, though, is some extension to the 
git-archive command.  One thing that is well and strictly defined in git 
is the file path sort order.  So given a commit SHA1, you should always 
get the same files in the same order from git-archive.  For an initial 
clone, git could attempt fetching the top commit using the remote 
git-archive service and locally reconstruct that top commit that way.  
if the transfer is interrupted in the middle, then the remote 
git-archive could be told how to resume the transfer by telling it how 
many files and how many bytes in the current file to skip.  This way the 
server doesn't need to perform any sort of caching and remains 
stateless.

You then end up with a pretty shallow repository.  The clone process 
could then fall back to the traditional native git transfer protocol to 
deepen the history of that shallow repository.  And then that special 
packing sort order to distribute commit objects would make sense since 
each commit would then have a fairly small set of new objects, and most 
of them would be deltas anyway, making the data size per commit really 
small and any interrupted transfer much less of an issue.


Nicolas
