From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/3] git-add --intent-to-add (-N)
Date: Fri, 22 Aug 2008 00:34:13 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808220023170.19665@iabervon.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com> <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181628420.19665@iabervon.org> <7viqtukbec.fsf@gitster.siamese.dyndns.org>
 <7v3akykb96.fsf_-_@gitster.siamese.dyndns.org> <Pine.GSO.4.62.0808211608020.26161@harper.uchicago.edu> <Pine.GSO.4.62.0808212304200.9108@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Fri Aug 22 06:35:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWOMo-00073n-Jy
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 06:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbYHVEeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 00:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbYHVEeP
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 00:34:15 -0400
Received: from iabervon.org ([66.92.72.58]:54279 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500AbYHVEeO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 00:34:14 -0400
Received: (qmail 29235 invoked by uid 1000); 22 Aug 2008 04:34:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Aug 2008 04:34:13 -0000
In-Reply-To: <Pine.GSO.4.62.0808212304200.9108@harper.uchicago.edu>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93251>

On Thu, 21 Aug 2008, Jonathan Nieder wrote:

> Hi,
> 
> Jonathan Nieder wrote:
> 
> > I quite like the idea of this patch series.  When I try to test it with
> > "git merge jc/ita; make test", t0020-crlf setup fails
> [...]
> > This could be me doing something [stupid]
> 
> and it was.  In a sleepy daze, I resolved a conflict
> 
> <<<<<<<
> #define ADD_CACHE_IGNORE_REMOVAL 8
> =======
> #define ADD_CACHE_INTENT 8
> >>>>>>>
> 
> by using the same bit for both.  Sorry for the noise.
> 
> Others can experience that unpleasant error message for themselves
> with next + jc/add-ita merged properly:
> 
> 	$ mkdir test-repo && cd test-repo
> 	$ git init
> 	Initialized empty Git repository in /var/tmp/jrnieder/test-repo/.git/
> 	$ : >a
> 	$ git add -N a
> 	$ git commit
> 	error: invalid object e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> 	error: Error building trees
> 
> I think the first error comes from update_one, which creates a tree
> object from the index.  It is complaining, because after all, that
> object is not in any sha1 file.

I think [1/3] was supposed to make this not an issue, with that particular 
object being implicitly in all objects databases.

> If the empty blob happened to be in our object database, the user's
> mistake would be hidden:
> 
> 	$ git add a && git commit
> 	error: invalid object e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> 	error: Error building trees
> 	$ git rm -f --cached a
> 	rm 'a'
> 	$ git add a
> 	$ git commit -m initial
> 	$ echo hi >b
> 	$ git add -N b
> 	$ git commit && echo ok
> 	Created commit 91325db: some commit message
> 	 0 files changed, 0 insertions(+), 0 deletions(-)
> 	 create mode 100644 b
> 	ok
> 
> Maybe it would be better to use some other magic blob (or a bit
> somewhere) to remember that the file has not been added yet.

An actual magic value (maybe the all-zeros hash) would make it an actual 
error for the file to not have been added; the current code behaves as if 
you did:

$ touch b
$ git add b

right before putting anything in b. Aside, perhaps, from retrieval bugs, 
it's just like you actually added an empty blob.

Last time I tried something along these lines, using the all-zeros hash 
actually came pretty close to working, except that diff uses this value 
for "look at the working tree" in its representation, and stuff gets 
confused by it; these are actually distinguishable, IIRC, by whether the 
mode bits are set or not, but current code doesn't check that.

	-Daniel
*This .sig left intentionally blank*
