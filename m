From: Jeff King <peff@peff.net>
Subject: Re: Bug report : bad filter-branch (OSX only)
Date: Wed, 29 Apr 2015 00:56:00 -0400
Message-ID: <20150429045600.GA10781@peff.net>
References: <CAM=W1NkZr6o-DCxXskeWC8xjRMiT2P9qXeeUe91qLBqOxzqNtg@mail.gmail.com>
 <20150428055506.GJ24580@peff.net>
 <CAM=W1NnR2-T7vpMSM-3-VypnR-T235tMudyjJowtj5utNmoKNQ@mail.gmail.com>
 <20150429043947.GA10702@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Olivier ROLAND <cyrus-dev@edla.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 06:56:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnK38-0004as-LO
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 06:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbbD2E4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 00:56:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:51514 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751264AbbD2E4D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 00:56:03 -0400
Received: (qmail 10135 invoked by uid 102); 29 Apr 2015 04:56:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 23:56:03 -0500
Received: (qmail 24438 invoked by uid 107); 29 Apr 2015 04:56:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 00:56:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2015 00:56:01 -0400
Content-Disposition: inline
In-Reply-To: <20150429043947.GA10702@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267957>

On Wed, Apr 29, 2015 at 12:39:47AM -0400, Jeff King wrote:

> So I can't figure out how to replicate the problem here.

Actually, that's not quite true. I could get hold of an OS X system to
replicate, which I just did.

The problem is that commit 3b754f212 does not have a newline at the end
of its commit message, and the OS X version of sed doesn't preserve
that.

Here's a much smaller reproduction recipe:

  git init
  echo content >file
  git add file
  tree=$(git write-tree)
  commit=$(printf 'no newline' | git commit-tree $tree)
  git update-ref HEAD $commit
  git filter-branch

On my Linux system, this results in an unchanged history, but on OS X,
the commit is rewritten to have a newline at the end of the commit
message.

The culprit is this line from git-filter-branch:

        sed -e '1,/^$/d' <../commit | \
                eval "$filter_msg" > ../message ||
                        die "msg filter failed: $filter_msg"

The "sed" command silently appends an extra newline to the final line of
the message.  You can see the sed behavior more directly with:

  printf foo | sed -ne 1p

which adds a newline on OS X, but not when using GNU sed on Linux. It
looks like OS X has just BSD sed, so the same behavior probably happens
on FreeBSD and elsewhere.

I'm not sure of a solution short of replacing the use of sed here with
something else. perl would be a simple choice, but filter-branch does
not otherwise depend on it. We could use a shell "read" loop, but those
are quite slow (and filter-branch is slow enough as it is!).

-Peff
