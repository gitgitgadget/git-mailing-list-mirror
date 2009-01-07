From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in a
 pack file
Date: Wed, 07 Jan 2009 10:31:29 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901071008150.26118@xanadu.home>
References: <20081209093627.77039a1f@perceptron>
 <1231282320.8870.52.camel@starfruit>
 <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
 <1231292360.8870.61.camel@starfruit>
 <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
 <1231314099.8870.415.camel@starfruit>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 16:33:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKaPN-00071G-9P
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 16:33:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757680AbZAGPbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 10:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760036AbZAGPbs
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 10:31:48 -0500
Received: from relais.videotron.ca ([24.201.245.36]:14269 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760028AbZAGPbr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 10:31:47 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KD300FR0XSH3IC0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 07 Jan 2009 10:31:30 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1231314099.8870.415.camel@starfruit>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104804>

On Tue, 6 Jan 2009, R. Tyler Ballance wrote:

> On Tue, 2009-01-06 at 20:54 -0800, Linus Torvalds wrote:
> > 
> > On Tue, 6 Jan 2009, R. Tyler Ballance wrote:
> > > 
> > > I'll back the patch out and redeploy, it's worth mentioning that a
> > > coworker of mine just got the issue as well (on 1.6.1). He was able to
> > > `git pull` and the error went away, but I doubt that it "magically fixed
> > > itself"
> > 
> > Quite frankly, that behaviour sounds like a disk _cache_ corruption issue. 
> > The fact that some corruption "comes and goes" and sometimes magically 
> > heals itself sounds very much like some disk cache problem, and then that 
> > particular part of the cache gets replaced and then when re-populated it 
> > is magically correct.
> > 
> > We had that in one case with a Linux NFS client, where a rename across 
> > directories caused problems.
> > 
> > This was a networked filesystem on OS X, right? File caching is much more 
> > "interesting" in networked filesystems than it is in normal private 
> > on-disk ones.
> 
> Not quite, what I meant was that some users (not all) who've experienced
> this issue are using Samba to copy files over directly into the Git
> repository. I was mentioning this in case somewhere between Finder,
> Samba, ext3 and Git, some file system change events were pissing Git off
> and causing it.

As long as those files are not within the .git directory that should be 
fine.

> I don't think this is the case as the coworker that I
> mentioned earlier doesn't use Samba and neither do I (we both experience
> the issue today, mine disappeared by upgrading to 1.6.1, his by `git
> pull`).

Problem is that none of that "makes sense".  If a real git corruption 
was there, it wouldn't disappear without explicit action from your part.  
What git v1.6.1 is able to do over earlier versions is to still function 
properly if some corrupted objects have a redundant copy in the same 
repository, but it wouldn't stop complaining about the existence of 
corrupted data.  Doing a 'git gc' or 'git repack -a' might get rid of 
the corruption.  And a 'git pull' might hide it if the received pack 
during the pull operation happens to contain another copy of the object 
that was corrupted before, but it wouldn't prevent 'git fsck --full' 
from seeing it.

The fact that you cannot reproduce the corruption issues after 
unarchiving a repository that was known to have problems right before it 
was archived is really really strange.  That does not rule out git bugs 
of course, but at least this shows that no actual corruption on disk was 
initially involved.

Again, I'd suggest you perform your git usage within a script session so 
to capture the exact operation performed and error messages produced 
when/if similar problems do occur again.  Otherwise we're only running 
after our tail.


Nicolas
