From: Jeff King <peff@peff.net>
Subject: Re: sporadic git failures on interactive rebase
Date: Wed, 14 Jan 2015 07:19:15 -0500
Message-ID: <20150114121915.GB30383@peff.net>
References: <trinity-5098e61e-b59a-4225-9d4c-8879dc78bb53-1421146472532@3capp-gmx-bs08>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Henning Moll <newsScott@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 13:19:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBMuw-0004VP-4o
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 13:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbbANMTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 07:19:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:34296 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752266AbbANMTR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 07:19:17 -0500
Received: (qmail 24242 invoked by uid 102); 14 Jan 2015 12:19:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 06:19:18 -0600
Received: (qmail 2483 invoked by uid 107); 14 Jan 2015 12:19:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 07:19:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jan 2015 07:19:15 -0500
Content-Disposition: inline
In-Reply-To: <trinity-5098e61e-b59a-4225-9d4c-8879dc78bb53-1421146472532@3capp-gmx-bs08>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262380>

On Tue, Jan 13, 2015 at 11:54:32AM +0100, Henning Moll wrote:

> . error: short SHA1 c4095c1 is ambiguous.
> . fatal: Needed a single revision
> . Invalid commit name: c4095c1
> 
> Now that the command failed, i checked for ambigous c4095c1. But there is only one:
> $ git log -1 c4095c1
> . commit c4095c1f5e7c126accf93ba68e2fa72bb055f567
> . ...
> 
> Just as a test:
> $ git log -1 c409
> . error: short SHA1 c409 is ambiguous.
> . error: short SHA1 c409 is ambiguous.

Hmm. There are some instances in git where we know we are looking for an
object of a particular type, and we can disambiguate a short-sha1 based
on the type. And "git log" is just such a place, whereas a generic "git
rev-parse" used by the git-rebase script would not be.

Try:

  git rev-list --objects --all |
  grep ^c4095c1 |
  cut -d' ' -f1 |
  git cat-file --batch-check

If my hunch is right, then you may find multiple objects, only one of
which is a commit.

And if so, the solution is likely one of:

  1. Teach rev-parse a "prefer committish" option and use it in the
     appropriate spot in git-rebase.

  2. Teach whatever is generating the shortended sha1s to report a truly
     unambiguous result, not one that depends on the type. I don't think
     we _have_ a codepath to do type-dependent shortening, though, which
     is maybe an indication that this is a red herring.

It's also possible that part of the rebase sequence generates a new
object that creates the ambiguity. That would be consistent with your
statement that rolling back and running the commands again makes it
work. I'm not sure how to defend against that, aside from adding a
character or two to the shortened ids, which reduces the likelihood of a
collision.

-Peff
