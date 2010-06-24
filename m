From: Jeff King <peff@peff.net>
Subject: Re: Confusion about content of conflicted file after : git
 remove/add
Date: Thu, 24 Jun 2010 02:10:29 -0400
Message-ID: <20100624061029.GA11020@coredump.intra.peff.net>
References: <AANLkTimqrfeNEmlfHGxWTdLgS7tAMOA66N4nV8b5I8F6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sabyasachi Ruj <ruj.sabya@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 08:10:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORfe3-0007S7-Mu
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 08:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372Ab0FXGKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 02:10:34 -0400
Received: from peff.net ([208.65.91.99]:40951 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753185Ab0FXGKe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 02:10:34 -0400
Received: (qmail 18152 invoked by uid 107); 24 Jun 2010 06:11:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 24 Jun 2010 02:11:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jun 2010 02:10:29 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimqrfeNEmlfHGxWTdLgS7tAMOA66N4nV8b5I8F6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149562>

On Thu, Jun 24, 2010 at 10:23:49AM +0530, Sabyasachi Ruj wrote:

> I have asked the question in detail in Stack Overflow.
> http://stackoverflow.com/questions/3100032/git-rename-delete-confusion
> Can anyone here explain that situation. Please also read the comments
> I wrote there.
> 
> I am totally baffled and can't predict what will be the content of a
> file after "git rm and git add" in branch and "git mv" in another
> branch.

Those two actions are the same. So there would be no conflict. But in
the situation you gave at stackoverflow, it is not just "git rm and git
add" versus "git mv". On one side, you actually change the file entirely
(well beyond what any rename detection could guess at, as you rewrite
the single line in the file).

So your situation is "moved file" versus "moved and changed file". You
get a rename/delete conflict because one side renamed the file, but the
other side apparently deleted it (because we cannot link the old "a" to
the new "b", as they are too different).

We seem to mark this in the index as:

  1. "a" is totally gone. This makes some sense, as it did go away on
     both sides, but given that it is part of a conflict-causing rename,
     I wonder if it should simply stay.

  2. We mark "b" as unmerged, but only put the "renamed to" entry in
     stage 3. For a pure rename/delete conflict, this makes sense. But
     this _isn't_ purely that. We also add "b" on our branch, so there
     should be a further rename/add conflict, but we never see it. At
     the very least, the new contents of "b" should go into stage 2 of
     the index.

So I think there may be a bug. I don't really see any code in
merge-recursive.c to handle conflicts on _both_ sides of a rename, but
obviously that is possible here.

-Peff
