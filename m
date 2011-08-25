From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] RFC: patterns for branch list
Date: Thu, 25 Aug 2011 13:53:01 -0400
Message-ID: <20110825175301.GC519@sigill.intra.peff.net>
References: <4E5607E0.1050300@drmicha.warpmail.net>
 <cover.1314259226.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Schubert <mschub@elegosoft.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 19:53:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwe76-0001r9-CN
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 19:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016Ab1HYRxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 13:53:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40470
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754880Ab1HYRxF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 13:53:05 -0400
Received: (qmail 16818 invoked by uid 107); 25 Aug 2011 17:53:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Aug 2011 13:53:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Aug 2011 13:53:01 -0400
Content-Disposition: inline
In-Reply-To: <cover.1314259226.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180092>

On Thu, Aug 25, 2011 at 10:30:16AM +0200, Michael J Gruber wrote:

> This mini series is about introducing patterns to the list mode of
> 'git branch' much like the pattern for 'git tag -l'. There are several
> related things which are to be considered for the ui design:

> [log vs tag vs branch]

I agree that the ideal UI change would be to move git-branch's "-l" to
"-g", and make "-l|--list" work the same as it does for git-tag.

Even though branch is generally considered a porcelain, I worry a little
about making that change. A script that wants to create a branch has no
real choice other than to use "git branch" (OK, they can use
"update-ref" themselves, but I seriously doubt that most scripts do so).
However, I kind of doubt anyone actually uses "-l"; it is mostly
pointless in the default config, so maybe it is safe.

Searching google code for "git.branch.*-l" turns up only one hit, and it
is somebody who apparently thought that "-l" meant "list".

> Analogous to "git tag", "branch" has several modes, one of which is list mode.
> It is currently activated (and possibly modified) by "-v" and "-vv", and when
> there are no arguments. So, at the least,
> 
> git branch -v[v] <pattern>
> 
> should match just like "git tag -l <pattern>" does. And that is what the first
> patch in my series does.

The order of your patches seems backwards to me. You add
pattern-matching for "-v", but there is no way to get pattern-matching
for the non-verbose case. Shouldn't "--list" come first?

Maybe I am just nitpicking, as I think the end result after the series
is the same. I just found the first patch very confusing.

> "git tag" should probably learn the same long option and others. And why not
> verify tags given by a pattern?

Yeah, having them both do --list makes sense. Whether it is appropriate
to glob for other operations, I don't know. I think you'd have to
look at each operation individually.

> Both "tag" and "branch" could activate list mode automatically on an invalid
> tag name rather than dieing:
> 
> git tag v1.7.6\*
> Warning: tag 'v1.7.6*' not found.
> v1.7.6
> v1.7.6-rc0
> v1.7.6-rc1
> v1.7.6-rc2
> v1.7.6-rc3
> v1.7.6.1

That just seems confusing to me. What is the exit status? Shouldn't the
warning be "error: tag 'v1.7.6*' is not a valid tag name"?

> -v[v] sanity
> ============
> 
> '-v' and '-vv' both take considerable time (because they need to walk).
> It makes more sense to have '-v' display cheap output (upstream name)
> and '-vv' add expensive output (ahead/behind info). '-vvv' could add super
> expensive info (ahead/equivalent/behind a la cherry-mark).

I think the original rationale was not so much "how much time does it
take", but rather "how much space do you want each line to take on your
terminal". For many people, the upstream name in "-vv" is just
cluttering noise.

Tag and branch listing are really just specialized versions of
for-each-ref. I wonder if it makes sense to do:

  1. Teach for-each-ref formats replacement tokens for ahead/behind
     counts.

  2. Let the user specify a for-each-ref format for tag and branch
     listing output. Then the various levels of "-v" just become some
     special format strings, and the user is free to ask for whatever
     they want (or even have "branch.defaultListFormat" to get it
     without typing over and over).

-Peff
