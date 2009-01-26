From: Jeff King <peff@peff.net>
Subject: Re: backwards compatibility, was Re: [PATCH v1 1/3] Introduce
	config variable "diff.primer"
Date: Mon, 26 Jan 2009 15:35:08 -0500
Message-ID: <20090126203508.GC27604@coredump.intra.peff.net>
References: <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <7v1vurf7lq.fsf@gitster.siamese.dyndns.org> <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu> <20090126031206.GB14277@sigill.intra.peff.net> <alpine.DEB.1.00.0901261154330.14855@racer> <20090126111605.GB19993@coredump.intra.peff.net> <76718490901260729m21ba140dke157d1d461aed2d5@mail.gmail.com> <20090126184829.GA27543@coredump.intra.peff.net> <76718490901261149xfedc415j8f5dab677b90d693@mail.gmail.com> <7vd4e96dh7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Keith Cascio <keith@cs.ucla.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 21:37:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRYCE-0002uE-4P
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 21:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbZAZUfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 15:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbZAZUfM
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 15:35:12 -0500
Received: from peff.net ([208.65.91.99]:45232 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753354AbZAZUfL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 15:35:11 -0500
Received: (qmail 6257 invoked by uid 107); 26 Jan 2009 20:35:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Jan 2009 15:35:18 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Jan 2009 15:35:08 -0500
Content-Disposition: inline
In-Reply-To: <7vd4e96dh7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107269>

On Mon, Jan 26, 2009 at 12:04:20PM -0800, Junio C Hamano wrote:

> > Well, this issue seems to come up every so often, so the idea would be:
> >
> > - We're adding a mechanism for scripts to communicate that they need
> > plumbing context
> > - Start using it in your scripts when calling git if you rely on a
> > stable interface
> > - In the next major release, git may introduce changes to commands
> > which are not clearly plumbing if you haven't adopted the mechanism
> 
> Where do all of these nonsense come from?  We are not adding any mechanism
> for scripts to say they need plumbing context.  By calling plumbing they
> are already asking for stable plumbing behaviour.

I think this is my fault a little for mentioning "blurred plumbing and
porcelain" and not explaining further. This really has nothing to do
with actual plumbing commands. Scripts should use diff-tree and not
diff, and that has always and probably will always be the case.

But what about something like "git grep"? Is it plumbing or porcelain?
The functionality isn't exposed in any other way, so I can imagine that
some scripts are using it. But it's sad to think that we could never
have config that might change its behavior, because it is used directly
by users all the time.  I think the same applies for "git archive".
There may be others.

So something like Jay's proposal could future-proof those commands
better by allowing scripts to say "BTW, I am a script. Turn off your new
features." And there are two classes of alternatives:

  - as you described, instead of making scripts turn _off_ features,
    make them turn them _on_, effectively declaring these commands as
    plumbing. This is obviously much nicer because it Just Works with
    current scripts. But it means that these mixed porcelain/plumbing
    commands suffer in their porcelain capacity; we can never add a
    config option that might change the behavior without the user
    specifying "it's ok to use this feature" at each invocation.

  - we can provide support _now_ for splitting the functionality into
    porcelain and plumbing, scripts can adapt over time to using the
    plumbing version, and then eventually we can declare it safe to make
    changes to the porcelain. And that is more or less what Jay's
    proposal is doing.

    However, I don't think a command-line option is the best way to say
    "I am a script". It's too easy to type "git grep" in a script and
    "git grep -J" (either because you are clueless about "-J", or
    because you simply forget). Other signal methods include:

      - just making two different commands to expose the same
        functionality, one plumbing and one porcelain. This is what has
        evolved in other areas, such as diff (though note that there
        _isn't_ exactly a "git diff" plumbing command -- there is the
        plumbing that "git diff is based on). I'm not sure what the
        plumbing name for "git grep" would be.

      - set an environment variable like GIT_STRICT. It's easy to set
        once at the top of your script, and it trickles down
        automatically as we call other git commands and scripts.
        We could even set it in git-sh-setup, though that of course
        covers only shell scripts, and not other callers.

> The scripts can, if they want to, use newer options updated versions of
> the plumbing commands offer, by passing them when they want to.
> 
> And the trigger to do so is up to the scripts.  They can get new options
> from the end user, or they can peek into user's configuration variables
> similar to the diff.primer mentioned earlier in the discussion.

Right, I think that is absolutely the right thing for commands which are
clearly plumbing.

> One way could be a new option --screw-me-with=name that can be given to a
> plumbing command and tells it pretend as if the command line options
> specified by the configuration variable of the given name were given
> (e.g. a script runs "git diff-files --screw-me-with=diff.primer").
> 
> The important point is that it has to be opt _IN_.

Our precedent so far has been to just add a new command line option that
enables the feature (e.g., --ext-diff and --textconv). Functionally it
is no different than --screw-me-with=diff.*.textconv. :)

-Peff
