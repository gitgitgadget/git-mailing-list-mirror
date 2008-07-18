From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Fri, 18 Jul 2008 18:48:28 +0200
Message-ID: <20080718164828.GT10151@machine.or.cz>
References: <4876B223.4070707@gmail.com> <1215738665-5153-1-git-send-email-LeWiemann@gmail.com> <20080714014051.GK10151@machine.or.cz> <200807150141.39186.jnareb@gmail.com> <4876B223.4070707@gmail.com> <1215738665-5153-1-git-send-email-LeWiemann@gmail.com> <20080714014051.GK10151@machine.or.cz> <487BD0F3.2060508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>
To: Lea Wiemann <lewiemann@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 18:49:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJt99-0002UN-9E
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 18:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797AbYGRQsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 12:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756327AbYGRQsb
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 12:48:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58376 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756208AbYGRQsa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 12:48:30 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 2B947393B489; Fri, 18 Jul 2008 18:48:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807150141.39186.jnareb@gmail.com> <487BD0F3.2060508@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89051>

In order to keep this mail within sensible size, I have trimmed some of
the bits - basically, the default reply is usually ranging from "Fair
enough" to "Great!" :-)

On Tue, Jul 15, 2008 at 12:19:31AM +0200, Lea Wiemann wrote:
> > First, I don't think it's good idea at all to put the pipe-related stuff
> > to Git::Repo - this is botched up API just like the current one.
> 
> Well, they're more like helper methods.  Since they don't fit into the
> design goals of the Git::Repo API at all, I'd suggest we just
> underscore-prefix them and take them out of the man page.  (The only
> reason why I hadn't done this is that gitweb uses $repo->cmd_output
> extensively, so it'd end up with a lot of underscore calls.  But I
> suppose we can either alias _cmd_output to cmd_output in gitweb's
> CachedRepo subclass, or live with $repo->_cmd_output calls.)  Does
> underscore-prefixing sound good to you?

I think this is one problematic point we keep hitting - my opinion is
that we _need_ such a wrapper _publically_, because it tends to be
actually the main use-case of Git.pm, and that this wrapper should be:

	(i) both available standalone for commands like ls-remote

	(ii) and available as part of Git::Repo instance, to have the
	right arguments passed to Git automagically

So you define cmd_output() and seem to argue that this command should
not be called directly and is not interesting for the outside. But the
experience shows that the pipe interface is actually the _most_ used
part of the Git Perl API, and in fact you mentioned that as part of your
gitweb migration to Git::Repo, you will temporarily introduce calls to
_cmd_output(), the "internal" API. :-) Sure, it's only temporary, but
many won't have the luxury to adjust the Git::Repo API to provide all
the operations they need, and ultimately they will need to defer to the
pipe interface.

> > It should be actually very easy to start with moving all the pipe
> > functionality to Git::Command.
> 
> Creating a new (Git::Command) API is very much non-trivial, apart from
> the fact that I'm not convinced that we need Git::Command, and that a
> clean command interface neither falls out of Git.pm nor Git::Repo.

As I said, majority of Git API usage is actually the pipe API. So we
should figure out how to provide it. I agree that it's not immediately
within your scope, but you are introducing new Perl API and this just
needs to be embedded somewhere there consistently.

> >> [Git::Commit->new, Git::Tag->new:]
> >> +Calls to this method are free, since it does not check whether $sha1
> >> +exists and has the right type.  However, accessing any of the commit
> >> +object's properties will fail if $sha1 is not a valid commit object.
> > 
> > This is nice idea, but I'd also provide a well-defined way for the user
> > to verify the object's validity at a good moment; basically, make load()
> > a public method. The user can deal with errors then and rely on
> > error-free behavior later.
> 
> No, you should never pass in an invalid SHA1 in the first place.  The
> above piece of documentation is just a warning that bugs will show up
> delayed.  IOW, this is not the right place to have your error handling.
> 
> If you're getting a SHA1 through the user-interface, check its existence
> with get_sha1 before passing it to the constructor.

But that's an expensive operation, you need extra Git exec for this,
while all the Git commands can do the checks for you, if you give them
the chance.

I was doing pretty much this thing in Cogito (initially out of
necessity) and it made it ungodly slow for any kind of batch operations.

> >> +Note that $sha1 must be the SHA1 of a commit object; tag objects are
> >> +not dereferenced.
> > 
> > Why not?
> 
> Because the SHA1 might resolve to an object of the wrong type, which
> means you have to do error handling in Git::Object objects; that's the
> wrong place.
> 
> If tag-resolving is really needed, we can add an optional $type
> parameter to get_sha1, which will cause get_sha1 to resolve the object
> until a $type object is found, or return undef if the object is or
> resolves to an object of the wrong type.

See above why I think you should reconsider requiring the explicit
"resolving" step.

> I have resolving code in gitweb's git_get_sha1_or_die (which I didn't
> implement in Git::Repo since it uses some customized error reporting).
> The resolving code could conceivably be extracted and moved to get_sha1.
>  I think there are a few things to ponder and maybe discuss, so I'd do
> that in a separate patch (if I get around it before the end of the project).

The thing that concerns me about this is that this might show that your
approach to error handling is not flexible enough for some real-world
usage and this might be a design mistake - is that not so? I didn't look
at the code.

> >> [Snipped a lot of quoting --LW]
> >> +=item $repo->repo_dir
> >> +=item $repo->git_binary
> >> +=item $repo->version
> >> +sub _get_git_cmd {
> > 
> > This definitely does not belong to a Git::Repo object.
> 
> Which of those methods are you referring to?  I think $repo->version
> might reasonably be removed (and the code re-added to gitweb); I'll do
> so unless you object.  _get_git_cmd is already underscored, and repo_dir
> and git_binary only access attributes passed in through the constructor,
> so I think those three should stay.

Sorry, you're right about repo_dir and possibly git_binary. My main
concern was about the command pipe handling itself, but I elaborated on
that above already.

> >> +=item $repo->get_refs
> >> +=item $repo->get_refs($pattern)
> > 
> > Again, the refs should be properly integrated into the object structure.
> 
> Really?  I think it's generally fine for get_refs to exist and to live
> in Git::Repo.
> 
> Its return value (currently an an arrayref of [$sha1, $object_type,
> $ref_name] arrayrefs) might need improvement though, and I find the
> $pattern parameter pretty suspect (in that it smells like a for-each-ref
> wrapper).  Since get_refs is unused at the moment (gitweb ended up
> needing the slightly different show-ref), I'll remove it for now.  (Same
> thing about me not being a fan of premature API design applies.)

Just a note, the thing is that you might want to add some methods for
inspecting and mutating the refs, and at the same time this is not a
repository-specific concept, but you can get the same structure from
git ls-remote call. That's why I think it would make sense to make
a separate object out of it. But that's moot point now that the API
won't be there yet.

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
