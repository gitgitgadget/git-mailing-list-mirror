From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Aug 2011, #07; Wed, 24)
Date: Thu, 25 Aug 2011 16:20:57 -0400
Message-ID: <20110825202057.GB6165@sigill.intra.peff.net>
References: <7vk4a2mjx6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 22:21:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwgQG-0000YK-CC
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 22:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614Ab1HYUVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 16:21:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36292
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753178Ab1HYUVA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 16:21:00 -0400
Received: (qmail 18572 invoked by uid 107); 25 Aug 2011 20:21:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Aug 2011 16:21:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Aug 2011 16:20:57 -0400
Content-Disposition: inline
In-Reply-To: <7vk4a2mjx6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180108>

On Wed, Aug 24, 2011 at 05:09:09PM -0700, Junio C Hamano wrote:

> * jk/add-i-hunk-filter (2011-07-27) 5 commits
>   (merged to 'next' on 2011-08-11 at 8ff9a56)
>  + add--interactive: add option to autosplit hunks
>  + add--interactive: allow negatation of hunk filters
>  + add--interactive: allow hunk filtering on command line
>  + add--interactive: factor out regex error handling
>  + add--interactive: refactor patch mode argument processing
> 
> Needs documentation updates.

I think Duy already mentioned this, but you may want to update your
"what's cooking" note: it needs not just doc updates, but code to
actually pass the options along from real git commands that use
add--interactive, like add, checkout, reset, and stash.

> * jk/generation-numbers (2011-07-14) 7 commits
>  - limit "contains" traversals based on commit generation
>  - check commit generation cache validity against grafts
>  - pretty: support %G to show the generation number of a commit
>  - commit: add commit_generation function
>  - add metadata-cache infrastructure
>  - decorate: allow storing values instead of pointers
>  - Merge branch 'jk/tag-contains-ab' (early part) into HEAD
> 
> The initial "tag --contains" de-pessimization without need for generation
> numbers is already in; backburnered.

So...what next? I don't really like leaving the contains traversal
as-is. It's often much faster than the original version (because we do
at most one to-the-roots traversal), but in some cases is slower
(because the depth-first search doesn't cut itself off sanely, so an
unlucky traversal means going to the roots instead of ending early).

Here are the options:

  1. Stick with timestamps as a proxy for generation numbers.

     a. Assume they're good enough. Possibly provide options to turn off
        this optimization (here, and possibly in name-rev) if you want
        to be more correct in the face of skew (at the cost of
        efficiency).

     b. Implement some kind of "this commit timestamp is bogus" cache.

     c. Make it easier to use and share replace objects with correct
        commit timestamps.

  2. Add generation numbers to headers, and try to calculate them on the
     fly as much as possible (i.e., Linus's approach).

  3. Add separate storage of generation numbers.

     a. As an on-the-fly cache (i.e., my patches).

     b. Combined with packfiles somehow (more efficient, less flaky, but
        may require a bump in index format version; alternatively, you
        could have pack-*.generation, which is a sparsely populated list
        of 32-bit ints, in the exact same order as the pack-*.idx file.
        No backwards compatibility issues, but slightly less efficient).

Thoughts?

> * jk/http-auth-keyring (2011-08-03) 13 commits
>   (merged to 'next' on 2011-08-03 at b06e80e)
>  + credentials: add "getpass" helper
>  + credentials: add "store" helper
>  + credentials: add "cache" helper
>  + docs: end-user documentation for the credential subsystem
>  + http: use hostname in credential description
>  + allow the user to configure credential helpers
>  + look for credentials in config before prompting
>  + http: use credential API to get passwords
>  + introduce credentials API
>  + http: retry authentication failures for all http requests
>  + remote-curl: don't retry auth failures with dumb protocol
>  + improve httpd auth tests
>  + url: decode buffers that are not NUL-terminated
> 
> Looked mostly reasonable except for the limitation that it is not clear
> how to deal with a site at which a user needs to use different passwords 
> for different repositories. Will keep it in "next" at least for one cycle,
> until we start hearing real-world success reports on the list.
> 
> Not urgent; will not be in 1.7.7.

I'm OK with holding this off for another round. I'd really like to get
more feedback from third-party helper writers. OTOH, I think we have a
little bit of a chicken-and-egg problem with testing. Most experienced
git users aren't that interested in this, because they are just using
ssh keys and ssh-agent, anyway. I wonder if we would do better to put it
in a released version with a big "warning: this is ridiculously
experimental and the interface to helpers is subject to change" warning.
And that puts something in the hands of the people it was meant to help,
and can get the attention of people to write helpers. I dunno.

-Peff
