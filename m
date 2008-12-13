From: Jeff King <peff@peff.net>
Subject: Re: characterizing commits
Date: Sat, 13 Dec 2008 03:52:28 -0500
Message-ID: <20081213085228.GA20282@coredump.intra.peff.net>
References: <4943721C.7070200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 09:53:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBQFz-0007vR-FA
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 09:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637AbYLMIwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 03:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbYLMIwb
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 03:52:31 -0500
Received: from peff.net ([208.65.91.99]:3916 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbYLMIwb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 03:52:31 -0500
Received: (qmail 20198 invoked by uid 111); 13 Dec 2008 08:52:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 13 Dec 2008 03:52:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Dec 2008 03:52:28 -0500
Content-Disposition: inline
In-Reply-To: <4943721C.7070200@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102994>

On Sat, Dec 13, 2008 at 08:28:12AM +0000, William Pursell wrote:

> A lot of commits in any given project can be grouped into
> different types.  eg, looking at the history for git,
> there are a lot of merge commits, a lot of commits
> that only touch gitk, a lot of 'auto-generated manpages',
> a lot of 'typo in documentation' etc.  In my own
> projects, I have a fairly high percentage of commits
> that are trivial (eg whitespace only, typos, etc).
> What I'm after is the ability to do something like:
> 
> git log --group=!trivial
> git log --group=importance:3+
>
> [...]

> Is there already a mechanism for filtering
> commits that I could extend to accomplish this?

Generally you would put a pseudo-header into your commit message, like:

  Status: trivial
  Importance: 3

and then use --grep to filter matching commits:

  git log --grep="Status: trivial"
  git log --grep="Importance: [3-9]"

Obviously the syntax is a little bit clunkier. You could fix that with
an option to parse arbitrary pseudo-headers (and even support numeric
relations), something like:

  git log --filter='importance > 3'

which would be converted internally to a grep of the commit message like
this:

  /^importance: (\d+)/i

and compare the result to 3.

The nice thing about that approach is that the storage remains the same:
text in the commit message. That means it gets displayed when you look
at the commit, people with older versions of git can still read it, etc.

One thing this _doesn't_ get you is annotating commits after the fact.
This has been discussed in the past; try searching the list for "notes".

-Peff
