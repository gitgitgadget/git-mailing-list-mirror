From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Revert "rev-parse: remove restrictions on some
 options"
Date: Fri, 26 Feb 2016 22:22:37 -0500
Message-ID: <20160227032236.GA10313@sigill.intra.peff.net>
References: <20160226232507.GA9404@sigill.intra.peff.net>
 <20160226232957.GB9552@sigill.intra.peff.net>
 <20160226233449.GA9622@sigill.intra.peff.net>
 <xmqqbn73hwam.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 04:26:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZVWi-000789-VD
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 04:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422673AbcB0DWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 22:22:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:50503 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755933AbcB0DWk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 22:22:40 -0500
Received: (qmail 20231 invoked by uid 102); 27 Feb 2016 03:22:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 22:22:39 -0500
Received: (qmail 9987 invoked by uid 107); 27 Feb 2016 03:22:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 22:22:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 22:22:37 -0500
Content-Disposition: inline
In-Reply-To: <xmqqbn73hwam.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287653>

On Fri, Feb 26, 2016 at 03:44:01PM -0800, Junio C Hamano wrote:

> But why do you even need to run local-env-vars from outside a
> repository in the first place?

The short answer is: because it is about clearing the state to move into
a new repository, and we do not necessarily know what the old state was.

Here's a longer answer.

We (GitHub) have some scripts that preemptively clear the git env when
moving into another repository directory, so that the environment
doesn't lead to us operating in the wrong repository.

For example, we use alternates to share object storage between a series
of forks. So frequently in such scripts we may need to switch between
repositories (e.g., to sync a fork to the shared storage, and then go
back to the shared storage and run repack). To do so safely, we have to
clear the git env for each "cd" (otherwise things work fine when
$GIT_DIR is not set and we rely on auto-finding the repo, and break
horribly if the script is run with $GIT_DIR set).

There are a few corner cases where library code wants to "cd", but
doesn't know if it's coming from another repo or not.  So it clears the
git env to be on the safe side. We could fix it by always going to the
new repo and running "unset $(git rev-parse --local-env-vars)" there,
but I think that just has the opposite problem (you may be _leaving_ a
repository, and want to make sure you are no longer in one).

For us, it's mostly just an annoyance. rev-parse produces no output so
we don't clear any variables, and its stderr gets logged somewhere. We
really only care about $GIT_DIR, and if that is set to something valid,
then you are in a repo, rev-parse works, and we clear it. But you can
come up with cases where it does the wrong thing, like:

  # Work in some repo; set some git vars in the environment, but
  # rely on auto-discovery to find the actual repo.
  cd some-git-repo
  export GIT_WORK_TREE=/whatever
  git ...

  # Now go back to our root and do some work elsewhere.
  # We're no longer in a git repo.
  cd ..
  ... run some non-git commands ...

  # Now we want to go into a new repo. Clear the environment.
  unset $(git rev-parse --local-env-vars)
  cd ../another-git-repo
  git ...

In the third directory, you'd still have GIT_WORK_TREE set, even though
you asked to clear existing git state.

I don't think we have any scripts that do that, but it doesn't seem that
implausible to me.

-Peff
