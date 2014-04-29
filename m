From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t3910: show failure of core.precomposeunicode with
 decomposed filenames
Date: Tue, 29 Apr 2014 14:02:10 -0400
Message-ID: <20140429180210.GB11832@sigill.intra.peff.net>
References: <20140428161630.GA9435@sigill.intra.peff.net>
 <xmqqvbtskqjv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 20:02:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfCMD-00086p-76
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 20:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933977AbaD2SCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 14:02:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:41440 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932491AbaD2SCM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 14:02:12 -0400
Received: (qmail 20313 invoked by uid 102); 29 Apr 2014 18:02:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Apr 2014 13:02:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Apr 2014 14:02:10 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbtskqjv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247597>

On Tue, Apr 29, 2014 at 10:12:52AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This patch just adds a test to demonstrate the breakage.
> > Some possible fixes are:
> >
> >   1. Tell everyone that NFD in the git repo is wrong, and
> >      they should make a new commit to normalize all their
> >      in-repo files to be precomposed.
> >
> >      This is probably not the right thing to do, because it
> >      still doesn't fix checkouts of old history. And it
> >      spreads the problem to people on byte-preserving
> >      filesystems (like ext4), because now they have to start
> >      precomposing their filenames as they are adde to git.
> 
> Hmm, have we taught the "compare precomposed" for codepaths that
> compare two trees and a tree and the index, too?  Otherwise, we
> would have the same issue with commits in the old history.

Ugh, yeah, I didn't think about that codepath. I think we would not want
to precompose in that case. IOW, git works byte-wise internally, but it
is only at the filesystem layer that we do such munging. The index
straddles the line between the filesystem and git's internal
representations.

I think my "keep the normalized names alongside index entries" approach
might still work there. But it means that we compare against the "real"
byte-wise names on the tree side, and against the normalized names on
the path side. But that means having two comparison/lookup functions for
the index, and always using the right one. And algorithms that rely on
traversing two sorted lists cannot work in both directions.

> Do we have a similar issue for older commit in a history under
> "ignore-case" as well?

I don't think so, because we handle ignorecase completely differently.
There we use the name-hash with a case-insensitive hash and a
case-insensitive comparison function. And we use strcasecmp liberally
throughout the code.

I don't think we have a "str_utf8_cmp" that ignores normalizations (or
maybe strcoll will do this?). But in theory we could use it everywhere
we use strcasecmp for ignore_case. And then we would not need to have
our readdir wrapper, maybe? I admit I haven't thought that much about
_either_ approach. But aside from some bugs in the hash system, I do not
recall seeing any design problems in the ignorecase code.

-Peff
