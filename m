Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CACB2208B4
	for <e@80x24.org>; Wed,  9 Aug 2017 07:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbdHIH5u (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 03:57:50 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:46659 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752199AbdHIH5t (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Aug 2017 03:57:49 -0400
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net ([81.98.98.104] helo=dagon.hellion.org.uk)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ijc@hellion.org.uk>)
        id 1dfLsB-0000OG-Ln; Wed, 09 Aug 2017 08:57:47 +0100
Message-ID: <1502265467.2735.32.camel@hellion.org.uk>
Subject: Re: [PATCH 1/2] filter-branch: Add --state-branch to hold pickled
 copy of ref map
From:   Ian Campbell <ijc@hellion.org.uk>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Wed, 09 Aug 2017 08:57:47 +0100
In-Reply-To: <xmqq4lthbwyi.fsf@gitster.mtv.corp.google.com>
References: <1502179560.2735.22.camel@hellion.org.uk>
         <20170808080620.9536-1-ijc@hellion.org.uk>
         <xmqq4lthbwyi.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-08-08 at 13:56 -0700, Junio C Hamano wrote:
> Ian Campbell <ijc@hellion.org.uk> writes:
> 
> > Allowing for incremental updates of large trees.
> 
> "by doing what" is missing.  And ...
> 
> >
> > I have been using this as part of the device tree extraction from
> the Linux
> > kernel source since 2013, about time I sent the patch upstream!
> 
> ... this does not help understanding what is going on.  It belongs
> to the space after three dashes.
> 
> Perhaps
> 
> 	Subject: filter-branch: stash away ref map in a branch
> 
> 	With "--state-branch=<branchname>" option, the mapping from
> 	old object names and filtered ones in ./map/ directory is
> 	stashed away in the object database, and the one from the
> 	previous run is read to populate the ./map/ directory,
> 	allowing for incremental updates of large trees.
> 
> or something?

Yes, thanks that is a lot better.

I'll address the feedback (style nits and all) in the coming weeks,
heads up that I might be a bit slow, got a busy week this week followed
by 3 weeks of travel (which might mean no time for hacking or lots,
hard to say ;-))

> Don't we want to make sure the value given to --state-branch is a
> full refname, not just a branch name?  What happens when you say 
> 
> 	filter-branch --state-branch master
> 
> by mistake?  "show-ref -s" is likely to show your refs/heads/master,
> and other master branches that appear as remote-tracking branches for
> the remotes you interact with.

I've been using this as `--state-branch refs/heads/filter-state` which
creates a local/visible filter-state branch which I also push to a
remote, so I also have a `refs/remotes/state/filter-state` too.

What is the correct way to check for a full ref name? Is it as simple
as checking for a refs/heads/ prefix or is there a better way?

> > +	if [ -n "$state_commit" ] ; then
> > +		echo "Populating map from $state_branch
> ($state_commit)" 1>&2
> > +		git show "$state_commit":filter.map |
> > +		    perl -n -e 'm/(.*):(.*)/ or die;
> > +				open F, ">../map/$1" or die;
> > +				print F "$2" or die;
> > +				close(F) or die'
> 
> The process calling this perl script, which carefully diagnoses
> malformed input and dies, does not seem to do anything when it sees
> errors.  Intended?

I hadn't realised the script wasn't using `set -e`. I'll sort this with
some local error handling.

> 
> > +	else
> > +		echo "Branch $state_branch does not exist. Will
> create" 1>&2
> > +	fi
> > +fi
> > +
> >  # we need "--" only if there are no path arguments in $@
> >  nonrevs=$(git rev-parse --no-revs "$@") || exit
> >  if test -z "$nonrevs"
> > @@ -544,6 +562,25 @@ if [ "$filter_tag_name" ]; then
> >  	done
> >  fi
> >  
> > +if [ -n "$state_branch" ] ; then
> > +	echo "Saving rewrite state to $state_branch" 1>&2
> > +	STATE_BLOB=$(ls ../map |
> > +	    perl -n -e 'chomp();
> > +			open F, "<../map/$_" or die;
> > +			chomp($f = <F>); print "$_:$f\n";' |
> 
> I see it somewhat gross to pipe the output of "/bin/ls" to a Perl
> script, instead of iterating over "while (<../map/*>)" inside the
> script itself.

I considered cleaning this up too as I was forward porting, but weirdly
it appeared to microbenchmark slower that way, I don't remember the
magnitude of the difference (and the test script is on another machine
right now). I'll revisit that and if it isn't too much slower I'll
switch to the saner looking all in Perl method.

> > +	unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
> > +	unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL
> GIT_COMMITTER_DATE
> 
> Hmph.  I can see that you are trying not to be affected by the
> committers and authors of the commits on the branch being filtered
> (which are set by finish_ident shell function), but I wonder if we
> could (and more importantly "want to") do better to preserve the
> real committer the user who runs the script may have in the
> environment before running it.  I guess it does not matter that
> much, as long as the user has properly user.{name,email} configured
> elsewhere without relying on the environment variable.

I'm glad you spotted this because I couldn't remember ;-)

I'll stash these in a bunch of ORIG_FOO near the top and then reset
them at an appropriate point (I'll use ORIG_GIT_DIR as the pattern).

> Despite all the above comments, I like what you are trying to
> achieve here.  Thanks for sharing.

Thanks for the review and feedback.


Ian.
