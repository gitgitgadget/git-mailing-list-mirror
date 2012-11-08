From: Jeff King <peff@peff.net>
Subject: Re: Support for a series of patches, i.e. patchset or changeset?
Date: Thu, 8 Nov 2012 14:09:44 -0500
Message-ID: <20121108190944.GO15560@sigill.intra.peff.net>
References: <CAMPhdO_33CPJv2hAvPuJ10KZ7v_fgP9P2kV_WLVK2tapjQQ5=A@mail.gmail.com>
 <5097C190.80406@drmicha.warpmail.net>
 <CAMPhdO-1ar52QGuSzbyFBSKMf48fDb6Bbxw5u3PCuVYxkO2=3w@mail.gmail.com>
 <5097CFCB.7090506@drmicha.warpmail.net>
 <CAMPhdO-Z3E352KbTvnrxJqCecAUGfHCwOoFRUKzObh35uLnrSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 20:10:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWXUI-0000R8-7Z
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 20:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387Ab2KHTJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 14:09:48 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36603 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504Ab2KHTJs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 14:09:48 -0500
Received: (qmail 31863 invoked by uid 107); 8 Nov 2012 19:10:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 14:10:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 14:09:44 -0500
Content-Disposition: inline
In-Reply-To: <CAMPhdO-Z3E352KbTvnrxJqCecAUGfHCwOoFRUKzObh35uLnrSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209185>

On Tue, Nov 06, 2012 at 08:58:35AM +0800, Eric Miao wrote:

> > So, then the question is: What do you know/have? Is your patch the
> > output of "git format-patch", "git diff", or just some sort of diff
> > without any git information?
> 
> That doesn't matter, all the info can be obtained from the SHA1 id, the
> question is: do we have a mechanism in git (or hopefully we could add)
> to record the patchset or series the patch belongs to, without people to
> guess heuristically.
> 
> E.g. when we merged a series of patches:
> 
>   [PATCH 00/08]
>   [PATCH 01/08]
>   ...
>   [PATCH 08/08]
> 
> How do we know this whole series after merged when only one of these
> commits are known?

Others have described how you can infer this structure from the history
graph, but as you noted, the graph does not always match the series that
was sent, nor does it contain some of the meta information about the
cover letter, associated discussions, etc.

If you want to track the mapping between mailed patches (or any other
form of changeset id) to commits, you can put it in git in one of two
places:

  1. In a pseudo-header at the end of the commit message. E.g., you
     could use the message-id of the cover letter as a unique identifier
     for the changeset, and put "Changeset: $MID" at the end of each
     commit message. Then you can use "--grep" to find other entries
     from the same changeset.

  2. You can use git-notes to store the same information outside of the
     commit message. This doesn't get pushed around automatically with
     the history, but it means your commit messages are not polluted,
     and you can make annotations after the commits are set in stone.

I do not use Gerrit, but I recall that they do something like (1) to
mark changesets. For git development, one of the contributors does (2)
to point notes at mailing list threads (I think he uses a script to
match up mails and commits after the fact).

But fundamentally the idea of "this is a set of logical changes" is not
represented in git's DAG. It's up to you to store changeset tokens
if you care about them.

-Peff
