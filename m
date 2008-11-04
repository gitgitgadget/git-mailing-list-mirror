From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: libxdiff and patience diff
Date: Tue, 4 Nov 2008 15:34:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: davidel@xmailserver.org, Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 15:29:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxMtV-0000dS-0V
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 15:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbYKDO1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 09:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbYKDO1U
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 09:27:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:43147 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753599AbYKDO1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 09:27:16 -0500
Received: (qmail invoked by alias); 04 Nov 2008 14:27:14 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp027) with SMTP; 04 Nov 2008 15:27:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+xII4fCYCxIFNRM/iA+BgsUPqG/ffxm9o00YnAg3
	gxtkfmDJkdR8bS
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081104083042.GB3788@artemis.corp>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100079>

Hi,

On Tue, 4 Nov 2008, Pierre Habouzit wrote:

> On Tue, Nov 04, 2008 at 05:39:48AM +0000, Johannes Schindelin wrote:
> 
> > On Tue, 4 Nov 2008, Pierre Habouzit wrote:
> > 
> > > I've been working tonight, trying to make libxdiff support the 
> > > patience diff algorithm, but I've totally failed, because I 
> > > _thought_ I understood what xdl_split was doing, but it appears I 
> > > don't.
> > 
> > I thought about it, too, at the GitTogether, although I want to finish 
> > my jGit diff first.
> > 
> > The main idea I had about patience diff is that you can reuse a lot of 
> > functions in libxdiff.
> > 
> > But the requirement of taking just unique lines/hashes into account, 
> > and _after_ splitting up, _again_ determine uniqueness _just_ in the 
> > between-hunk part made me think that it may be wiser to have a 
> > separate function for the patience diff stuff.
> > 
> > Basically, you would start to have libxdiff split the lines and hash 
> > them as normal, but then determine the unique hashes (I'd start with 
> > the smaller text, just to have a better chance to end up with unique 
> > hashes).
> > 
> > Once they are determined, you can search for those exact lines (hash 
> > first) in the post-document.
> 
> Actually my current implementation just puts all the hashes into an 
> array, sorts them by hash (which is O(n log(n)) with the position from 
> left or right file it's in, ordered by increasing right position. (and 
> the struct is filled with the left pos to -1 if the right pos is set, 
> and vice versa).

Yeah, that would be much more efficient using a hash-multiset.  Still 
linear size (albeit twice as much).  And you can already discard double 
entries early (although you have to keep one pointer in the hash-multiset 
to prevent other identical lines from being misdetected as "unique").

> The I scan the array to find patterns of two consecutive hashes exactly, 
> and collapse it into the proper {left pos, right pos} tuple if it was 
> indeed a unique line in both files.
> 
> This results into an array I sort again by right pos then, and we can 
> work on that for the stack sorting, and I do it, and then I have my LCS.
> 
> 
> This is the complete brute-force algorithm which requires a temporary 
> array of the size of the number of lines on the left + the right, and a 
> temporary array for the stacks which _may_ end up being as large as the 
> smallest number of lines between the left or right file in the worst 
> case I'd say (roughly).
> 
> Then I just remember a list of split points, and I recurse in all the
> sub splits again. It has a fixed point which may or may not need
> libxdiff recursion in it.

I am not sure that you really end up with patience diff that way.  I 
_think_ that you need to determine the longest sequence of unique lines 
which has the property of being ordered in both texts first, and only 
_then_ recurse into the not-yet-handled lines.

> > Once that is done, you'd have to find the longest common subsequence, 
> > which you could do using the existing infrastructure, but that would 
> > require more work (as we already know the lines are unique).
> 
> Patience diff gives you the algorithm to do that, it's pretty simple,
> and is more efficient than the current infrastructure (in time, I don't
> know for space though).

Actually, IIRC it is pretty easy to see that the time complexity is linear 
(and therefore, the space complexity, too).

> > After that, you would have to recurse to the same algorithm _between_ 
> > known chunks.  Eventually, that would have to resort to classical 
> > libxdiff (if there are no, or not enough, unique lines).
> 
> Yeah, that's the point, the problem is, I believe more and more that I 
> should prepare the LCS from patience diff in xprepare.c, but I grok 
> absolutely nothing at what the chastore_t and similar stuff is. I 
> understand it's about hashing, but the exact stuff it does eludes me.

Yes, I do not like the short and unintuitive names either.

AFAIU chastore_t is just a generic extensible array of elements that have 
size "isize", and initially there are "icount" of them.

> In fact when I look at the records I have in xdiffi.c I had the 
> impression they were already somehow collapsed, which makes it a too 
> late point to apply the patience diff ...

AFAICS xdiffi.c contains the classical diff algorithm (incidentally, I the 
inventor of that algorithm is about 50 meters away from me at this very 
moment).  It should not have anything of interest to you, except for the 
fall-back case.

So I think that you should add a new file xpatience.c.

In that, I'd implement that hash multi-set, and use a prepared xdfenv_t to 
fill it (smaller file first, then you can traverse the other file, 
checking for uniqueness in that file and for a match in the other file at 
the same time).

You _could_ build the longest list of ordered pairs at the same time, too, 
but that may make the code a bit too complex.

Ciao,
Dscho
