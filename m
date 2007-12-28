From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] git-pull: warn if only fetching tags with the -t
 switch
Date: Fri, 28 Dec 2007 12:32:43 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0712281141450.13593@iabervon.org>
References: <20071221124400.20725.qmail@db93e79e204cd8.315fe32.mid.smarden.org> <7v8x3oatvi.fsf@gitster.siamese.dyndns.org> <20071227093016.18337.qmail@e6d9fb481b7087.315fe32.mid.smarden.org> <7vwsr0ifqi.fsf@gitster.siamese.dyndns.org>
 <20071227144618.32373.qmail@5b51609f839e87.315fe32.mid.smarden.org> <7vve6je349.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 18:33:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8J56-00046u-By
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 18:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbXL1Rcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 12:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753823AbXL1Rcp
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 12:32:45 -0500
Received: from iabervon.org ([66.92.72.58]:54094 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798AbXL1Rco (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 12:32:44 -0500
Received: (qmail 6462 invoked by uid 1000); 28 Dec 2007 17:32:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Dec 2007 17:32:43 -0000
In-Reply-To: <7vve6je349.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69291>

On Thu, 27 Dec 2007, Junio C Hamano wrote:

> Gerrit Pape <pape@smarden.org> writes:
> 
> > Subject: [PATCH] git-pull: warn if only fetching tags with the -t switch
> >
> > git-pull -t|--tags isn't supposed to be run, remove that option from
> > fetch-options.txt, and explicitely add it to git-fetch.txt.  Have git pull
> > still fetch tags with the -t switch, but warn afterwards to better use
> > git fetch --tags, and error out.
> > ---
> >
> > How about this?
> 
> Thanks.
> 
> We coulc go with this for the time being for 1.5.4, but I am not
> absolutely confident that ...
> 
> > +	# warn if only tags have been fetched
> > +	not_for_merge=$(sed -e '/	not-for-merge	tag/d' \
> > +			"$GIT_DIR"/FETCH_HEAD)
> > +	if test "$not_for_merge" = ''; then
> 
> ... FETCH_HEAD having nothing but not-for-merge tags would
> happen _only_ when "pull --tags" is done.  If there are (bogus)
> command line other than "pull --tags" that results in this
> situation, we would be issuing a wrong error message.
> 
> A trivial example.  If you misconfigure your .git/config like
> this:
> 
>         [remote "origin"]
>                 url = ...
>                 fetch = refs/head/*:refs/remotes/origin/*
> 
> and say:
> 
> 	git pull
> 
> without even "--tags", then the resulting .git/FETCH_HEAD would
> be empty, and the above test will trigger, even though the
> correct diagnosis is the error message we currently give the
> user.

Doesn't git-fetch return an error if the only pattern doesn't match 
anything? I think it's a bug in git-fetch if it returns with no helpful 
message and no error status, and a bug in git-pull if the fetch's 
complaint doesn't override any messages git-pull might give afterward. 
After all, the user will still have an unsolved problem if "git fetch" 
above were to succeed silently.

So the only interesting case for git-pull is when MERGE_HEAD is not empty 
after the fetch, but doesn't contain anything marked for merging.

This means that either (1) the default things-to-merge doesn't include 
anything in the default things-to-fetch, and neither was replaced; or (2) 
the default things-to-merge doesn't include anything in the specified 
things-to-fetch, and the things-to-merge wasn't replaced; or (3) the 
specified things-to-merge doesn't include anything in the specified 
things-to-fetch.

(3) is impossible, since you can only specify things-to-merge as what 
you're specifying for things-to-fetch, and the latter is non-empty.

(2) is only possible with --tags, which is (currently) the only thing that 
can remove items from things-to-fetch without replacing things-to-merge as 
well. This is where we want the special error message.

(1) is what we give the usual error message for.

So the sole case I can see where this patch gives the wrong message is 
when the default things-to-fetch, so far as it matches anything, 
matches only tags, and these are not for merging. That is, if you are, in 
fact, fetching tags only, but by virtue of a configuration file that 
fetches tags and doesn't (successfully) fetch anything else.

I'd say, just add a check that --tags was given on the git-pull command 
line to this test.

> Come to think of it, "git pull <anything>" is "git fetch
> <anything>" followed by "git merge <something>", and what is
> fetched by the first step "git fetch" and what is used by the
> second step "git merge" are determined by what that <anything>
> is.  The rules for the case where <anything> is empty are
> clearly defined in the documentation for "git pull" (partly
> because it was clear what should happen if <anything> was not
> empty back when the documentation was written).
> 
> It appears that the explicit case also needs documentation.
> 
> The refs fetched are:
> 
>  + Having --tags on the command line is the same as replacing
>    remote.$remote.fetch with refs/tags/*:refs/tags/* in the
>    configuration.
> 
>  + If refspecs are explicitly given from the command line, they
>    will be the ones that are fetched, and remotes.$remote.fetch
>    is consulted unless they come from the above --tags.
> 
>  * Otherwise, remotes.$remote.fetch (and its equivalent in
>    .git/remotes/$remote) are the ones that are fetched.
> 
>  * In addition, if branch.$current_branch.merge is specified but
>    is not covered by the above, it also is fetched.
> 
> The refs merged are:
> 
>  + If refspecs are explicitly given from the command line, they
>    will be the ones that are merged (nothing else is merged).
> 
>  * Otherwise branch.$current_branch.merge, if exists, is what is
>    merged;
> 
>  * Otherwise,
> 
>    * globbing refspecs are ignored;
> 
>    * the first refspec from the configuration (or the equivalent
>      from .git/remotes/$remote) is what is merged.
> 
> "git pull --tags" tells "git fetch" to fetch tags (and nothing
> else -- because there is no explicit refspecs from the command
> line, remotes.$remote.fetch which was replaced with the globbing
> "grab all tags" is used), and as a result, there will not be
> anything that is explicitly specified to be merged.  Because the
> user initiated such a "pull", he deserves to be told about the
> "mistake".
> 
> So (technically) there is no bug but PEBCAK here.  
> 
> HOWEVER.
> 
> It probably makes sense to change "git fetch [$remote] --tags"
> to fetch tags _in addition to_ what are configured to be fetched
> by default, instead of replacing as we currently do.  We could
> call the current behaviour of --tags a misfeature that invites
> the user "mistake".
> 
> Such a change will make "--tags" more transparent to the second
> "git merge" phase of "git pull".  "git pull --tags [$remote]"
> would become equivalent to "git pull [$remote]", except that as
> an unrelated side effect it also fetches all tags.  I suspect
> that would match the user expectation better.  Daniel, Shawn,
> what do you think?

I think that would be an improvement. I think it would be good if --tags 
weren't a special case (aside from disabling auto-following, which is an 
implementation detail because it's sure not to find anything). The choices 
are:

1) --tags adds tags, not-for-merge to what gets fetched without replacing 
   the usual stuff
2) --tags is equivalent to refs/tag/*:refs/tags/*; tags are fetched and 
   marked for merging (this is unhelpful, of course)
3) As for (2), but make patterns on the command line not-for-merge as a 
   general rule.

I personally like (3), but I think it would be a pain to implement with a 
useful message for git-pull user error unless git-pull had access to the 
info of which defaults fetch used and which were overridden by the command 
line.

On the other hand, the command that's difficult with (1) is "get all of 
the latest tags, but not even the default other refs", and I don't think 
that's something that people actually want to do in general, so it should 
be fine to go with (1).

> This is a bit more involved change than I would want to have
> during -rc freeze.

Certainly. I think, though, that the OP's patch, plus a check that --tags 
was given on the command line in the first place, would be worthwhile.

	-Daniel
*This .sig left intentionally blank*
