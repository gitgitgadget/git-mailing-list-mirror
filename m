From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 3/3] Support fetching from foreign VCSes
Date: Mon, 12 Jan 2009 13:19:37 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901121246320.19665@iabervon.org>
References: <alpine.LNX.1.00.0901110335520.19665@iabervon.org> <7vfxjpmhow.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0901120041260.19665@iabervon.org> <20090112154224.GD10179@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 19:21:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMRPL-0004uI-PB
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 19:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbZALSTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 13:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752709AbZALSTl
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 13:19:41 -0500
Received: from iabervon.org ([66.92.72.58]:49057 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506AbZALSTk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 13:19:40 -0500
Received: (qmail 5750 invoked by uid 1000); 12 Jan 2009 18:19:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jan 2009 18:19:37 -0000
In-Reply-To: <20090112154224.GD10179@spearce.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105371>

On Mon, 12 Jan 2009, Shawn O. Pearce wrote:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > On Sun, 11 Jan 2009, Junio C Hamano wrote:
> > > Daniel Barkalow <barkalow@iabervon.org> writes:
> > > > This supports a useful subset of the usual fetch logic, mostly in the
> > > > config file.
> > > 
> > > I like the direction this series is going.  In the longer term, it would
> > > be nice if we can have git-svn and git-cvsimport replaced with something
> > > like this.
> 
> The series seems to require that the foreign tool speak fast-import.  I've
> tried to get git-svn to use it, but its currently not possible because the
> git-svn process needs to be able to read objects it has written during this
> session.  Those objects are stored in the output pack, where only the active
> fast-import process can get to them.  Thus git-svn can't use fast-import.
>
> As import as the git-p4 stuff is, git-svn is our "killer feature" when it
> comes to foreign system integration.  I think we need to make SVN work for
> this foreign vcs thing to work.

I think fast-import should be made sufficient for git-svn, rather than 
having the integration about to speak other things. As you say, git-svn is 
the killer feature, and I'd like to have it using (and therefore 
contributing to the testing of) all of the applicable tools.

Maybe fast-import should be able to run with a bi-directional connection 
to its input, so it can acknowledge checkpoints? When the pipeline is set 
up in the main git code, it should be easy enough to do this sort of 
complicated stuff.

> > > Is the current foreign vcs interface sufficiently rich to support git as a
> > > foreign scm by using fast-import and fast-export?
> > 
> > I think so, although it would be pretty strange, since it would generally 
> > have a whole lot of local data (a complete clone of any remote 
> > repository).
> 
> It might not be that bad.  If the foreign system is git and the
> local system is git, we should have a massive amount of object reuse.
> At least all of the blobs from the foreign system should be reused
> by the local system, and that's like 80-90% of most project's
> object state.

The part I think is weird is that the helper would be first going to the 
network to get all of the data, and then extracting the history from it 
locally in a separate process (that is, passing data to it only through 
the filesystem). Other systems generally get the data on demand, which 
sort of makes more sense for the case where you will then run exactly one 
command (fast-export) to it. I suppose sticking the data into the 
destination object store would make this not so strange.

> If the import is flawless (no mangling of commit messages or history)
> then you should get 100% object reuse and the git-git import would
> give you the same SHA-1, but just slower than going over git://.
> 
> Its strange only because it would be sucking more CPU time on the
> client than is necessary to do the fetch.  But if something like
> a filter-branch tool existed to massage a fast-import stream, it
> might be useful to fetch someone else's tree, massage it a bit,
> and then import it with a subtree merge.  :-)

That is true, and would be a good actual use for this. It would make it 
possible for Wine to have a remote for the upstream Kconfig repository 
(that being a filtering of the linux-2.6 repository).

That is, a git repository can be "foreign" in that it disagrees with you 
over the project layout or contents.

	-Daniel
*This .sig left intentionally blank*
