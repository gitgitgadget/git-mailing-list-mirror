From: Jeff King <peff@peff.net>
Subject: Re: how to determine version of binary
Date: Sat, 5 May 2012 05:24:43 -0400
Message-ID: <20120505092443.GB8172@sigill.intra.peff.net>
References: <jo2jtd$m6c$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 11:25:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQbF4-00038k-G0
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 11:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137Ab2EEJYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 05:24:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58524
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752283Ab2EEJYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 05:24:45 -0400
Received: (qmail 31347 invoked by uid 107); 5 May 2012 09:25:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 05 May 2012 05:25:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 May 2012 05:24:43 -0400
Content-Disposition: inline
In-Reply-To: <jo2jtd$m6c$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197102>

On Sat, May 05, 2012 at 02:12:44AM -0500, Neal Kreitzinger wrote:

> Scenario:  I detect a binary file that is 'dirty'.  I don't know how
> it got there.  However, I know it came from a git repo.  So I
> calculate the sha1 of the binary.  What is the git command to
> determine which commit that binary version first appeared in?  And
> the last commit that binary appeared in?

There is no pre-made git commit. I would look at the output of "git log --raw
--no-abbrev" in a pager and search for the sha1 in question. That will show you
the commits that made it come and go. Note that there may be multiple instances
in which the sha1 comes and goes (e.g., two parallel lines of development which
both introduce or modify a sha1, or even linear development with reverting).

You can script it like this:

  git log --format=%H --no-abbrev --raw |
  perl -lne '
    BEGIN { $sha1 = shift }
    if (/^[0-9a-f]{40}$/) {
      $commit = $_;
    }
    elsif (/^:\d+ \d+ ([0-9a-f]{40}) ([0-9a-f]{40}) \S+\t(.*)/) {
      if ($2 eq $sha1) {
        # sha1 on "after" side; content probably came into existence
        if ($1 eq $sha1) {
          # unless it was that way before, in which case it was a mode change
          # or rename. Ignore.
        }
        else {
          print "$commit: $sha1 appears (as $3)";
        }
      }
      elsif ($1 eq $sha1) {
        # sha1 on "before" side; content went away
        print "$commit: $sha1 went away (from $3)";
      }
    }
  ' $sha1_of_interest

though I wouldn't bother to do so unless I was going to do some analysis over
many files.

> Why:  we have people ftp'ing binaries around.  I want to see the
> commit message and source change of that commit to see what the
> binary version is.

This won't necessarily show you the version they have; it will only show you
the version that introduced that particular version of a file. A more general
question is "given a set of files, which revision did they come from?".  For
that, you would want to find the set of commits that contain sha1 A, then
intersect them with the set of commits that contain sha1 B, and so forth. You
can do that by scripting around "rev-list" and "ls-tree", but it's a little
more complicated.

-Peff
