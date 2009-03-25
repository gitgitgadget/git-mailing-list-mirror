From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/5] Draft of API for git-vcs-*, transport.c code to use
 it.
Date: Wed, 25 Mar 2009 12:20:13 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903251050430.19665@iabervon.org>
References: <alpine.LNX.1.00.0903242303410.19665@iabervon.org> <7vskl284bt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 17:22:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmVrT-00078D-Eo
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 17:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761446AbZCYQUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 12:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755677AbZCYQUR
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 12:20:17 -0400
Received: from iabervon.org ([66.92.72.58]:41931 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760128AbZCYQUP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 12:20:15 -0400
Received: (qmail 23972 invoked by uid 1000); 25 Mar 2009 16:20:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Mar 2009 16:20:13 -0000
In-Reply-To: <7vskl284bt.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114617>

On Wed, 25 Mar 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > +'capabilities'::
> > +	Prints the capabilities of the helper, one per line. These are:
> > +	 - import: the basic import command
> > +	 - marks: import should be done with a saved marks file
> > +	 - find-new-branches: detect new branches
> > +	 - export: the general export command
> > +	 - fork: create a new branch and export to it
> > +	 - anonymous-fork: make commits on a branch without an inherent name
> > +	 - merge: merge branches (of whatever type the system supports)
> > +
> > +	If the helper doesn't support "merge", the default for pull is
> > +	to rebase instead of merging.
> > +
> > +'list'::
> > +	Takes the remote name, and outputs the names of refs. These
> > +	may be followed, after a single space, by "changed" or
> > +	"unchanged", indicating whether the foreign repository has
> > +	changed from the state in the ref. If the helper doesn't know,
> > +	it doesn't have to provide a value. (In particular, it
> > +	shouldn't do expensive operations, such as importing the
> > +	content, to see whether it matches.)
> 
> Does this roughly corresponds to get_remote_refs(), with "unchanged"
> return turned into the current value of the ref while "changed" returned
> as 0{40} in old_sha1 value?

Yes, with the [1/5] change to make 0{40} tell git to consider it different 
but unknown. Also, not giving either of these flags counts as 0{40}, but 
we might someday want to have the native side report the difference 
between knowing that it changed and not knowing at all.

> For a vcs backend that lacks find-new-branches capability, when does the
> set of refnames returned by this operation change?  Can the end user
> request an expensive operation to make the list up-to-date?  Does the end
> user need to?

What I've done for my p4 backend is have an option for whether it should 
search for new branches (which is somewhat expensive, at least currently, 
because it involves connecting to the server in this step). If the backend 
actually lacks the capability, the user has to do something (probably add 
them to the config file) to include new branches. In some cases, what the 
backend exposes as branches may be something that there isn't a complete 
list of; there may be systems that are structured sort of like repo.or.cz, 
where the URL is for the whole system, and there are some things on it 
that are branches of the project (like various people's git.git 
repositories) and some things that are completely unrelated and not 
interesting, and there's no machine-readable way to distinguish them.

> > +'import'::
> > +	Takes the remote name and a list of names of refs, and imports
> > +	whatever it describes, by outputting it in git-fast-import
> > +	format.
> > +
> > +'export'::
> > +	Sends the branch to the foreign system and reimports it in
> > +	fast-import format.
> 
> The above two description is inconsistent; say "git-fast-import" for both.

Not "fast-import" for both, now that other systems have adopted the format 
as input?

> This seems to follow the model of git-svn in that we treat our history as
> throw-away, export the history and give the authority to the other system
> by discarding and replacing our history with whatever the other end gives
> back to us by re-importing.  Because git is more flexible than anything
> else, we could afford to do so, but I wonder if it is the right model and
> mentality.

I think that there is always the requirement that the other system 
(whether it's foreign, git through filter-branch, or even a regular remote 
git repository) contains a sane, consistant, and normal-looking history. 
It's rarely going to be possible to export a history that will import as 
the same hash (and incremental imports on top of local history that isn't 
what a fresh complete import would contain seems even crazier). I don't 
think there's any particular use for using a foreign system to store 
history that only makes sense in git.

But, as a general principle, the reason a git developer would push to a 
non-git remote repository is because the remote repository is 
authoritative. I don't think it makes sense to have an environment where 
the authoritative history is in git, but people are sharing it through a 
bzr server (even if the bzr server can accurately represent the git 
history).

Of course, we may want a different mechanism some day to generalize 
git-cvsserver, where the authoritative history is in git, but we're 
supporting foreign clients. But that requires very different code from 
what I'm working on.

> One downside is that you end up rebasing the git side by operating this
> way, and a topology where multiple developers use one git repository as a
> synchronization point and use that git repository to interface with the
> foreign system becomes impossible.  Instead, these multiple developers
> need to treat the foreign system as the central repository, and interface
> with it individually.

Yeah, this is unfortunate. You can at least import through a shared 
system, which is pretty close to how git.git development goes (we pull 
from your public repo, make changes locally, and email patches, which you 
put in upstream, and we get back commits that are not the same hash we 
created locally).

I think it might be possible to do something where the synchronization 
point has a list of authoritative commit-swaps, where it can tell the 
multiple developers: "commit Y is really the same thing as commit X; they 
have the same tree, and their parents Y1..Yn are the same as X1..Xn 
(either based on the same criterion applied recursively, or having 
identical hashes)". This list of commit-swaps allows the developers to be 
comfortable with trivial rebases (in a commit Z with X as a parent, make a 
commit Z' with Y replacing X and no other changes, and replace Z with Z' 
in refs and other commits). Of course, this depends on being able to get 
the foreign system to agree on both complete content and history topology, 
but otherwise we kind of have to throw away our history, because the 
public history simply can't be like what we've made locally.

	-Daniel
*This .sig left intentionally blank*
