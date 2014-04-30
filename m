From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rerere: fix for merge.conflictstyle
Date: Wed, 30 Apr 2014 02:08:35 -0400
Message-ID: <20140430060835.GA21698@sigill.intra.peff.net>
References: <1398830909-24680-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 08:08:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfNhB-00012L-OS
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 08:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbaD3GIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 02:08:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:41841 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751787AbaD3GIh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 02:08:37 -0400
Received: (qmail 26246 invoked by uid 102); 30 Apr 2014 06:08:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Apr 2014 01:08:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Apr 2014 02:08:35 -0400
Content-Disposition: inline
In-Reply-To: <1398830909-24680-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247676>

On Tue, Apr 29, 2014 at 11:08:29PM -0500, Felipe Contreras wrote:

> If we use a different conflict style `git rerere forget` is not able to
> find the matching conflict SHA-1 because the diff generated is actually
> different from what `git merge` generated.

Can you show an example or test case?

I could not reproduce the problem with a trivial case, and rerere
specifically tries to handle the differences between "merge" and "diff3"
styles by throwing away the base content between "|" and "=" lines.
However, I wonder if it could still miss a match in some cases because
the "merge" style uses XDL_MERGE_ZEALOUS, whereas diff3 bumps it
down to XDL_MERGE_EAGER, which could lead to a slightly different
preimage.

If so, I think this points to a slightly more pervasive problem in
"rerere", then: data recorded under one merge level might not be usable
later (whether for "rerere forget" or for actually applying a
resolution).

The level can change if:

  1. you have run something like "checkout --conflict=diff3" (and rerere
     reads in the working tree file, which it does for regular
     resolution, but not for "forget").

  2. you use "git merge-file", which uses XDL_MERGE_ZEALOUS_ALNUM

  3. you record resolutions and then change merge.conflictstyle

For (1), this is hopefully rarely going to be an issue, since "merge"
applies rerere itself before you get a chance to run checkout. So you
would have to manually run "git rerere" yourself (you might do that with
"rerere forget", but "forget" always re-runs the merge from the index).

For (2), we can hopefully ignore it, as merge-file does not run rerere
(and probably not many people use merge-file at all these days).

For (3), we can hopefully ignore this as rare; changing the variable
invalidates your cache, but only the hunks for which the ZEALOUS/EAGER
level makes a difference.

There isn't currently a way to tweak the merge-level manually, which
would be the other obvious way to trigger the situation.

We already get around the merge/diff3 format by trying to normalize the
merge/diff3 hunks we see. It would be nice if we could normalize away
the merge-levels, too, but I don't think that is possible just from the
conflict data. We'd have to actually re-run the low-level merge with
known settings. For git-merge, that would mean doubling the work when
"rerere" is in use.  And it would mean that we could not run "rerere" on
a partially-resolved file.

So given all of the "hopefully rare" statements above and the complexity
of the complete solution, it's probably not worth pursuing. In which
case your patch seems like the best we can do. At least it covers the
more common case when you have set merge.conflictstyle but _didn't_
change it since the postimage was recorded.

-Peff
