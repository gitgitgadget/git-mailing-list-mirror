From: Jeff King <peff@peff.net>
Subject: Re: git-log --cherry-pick gives different results when using tag or
 tag^{}
Date: Wed, 15 Jan 2014 04:49:45 -0500
Message-ID: <20140115094945.GD14335@sigill.intra.peff.net>
References: <52CFF27C.1090108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 10:49:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3N6g-0003RJ-Rb
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 10:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbaAOJtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 04:49:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:60978 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751566AbaAOJtr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 04:49:47 -0500
Received: (qmail 12902 invoked by uid 102); 15 Jan 2014 09:49:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jan 2014 03:49:47 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 04:49:45 -0500
Content-Disposition: inline
In-Reply-To: <52CFF27C.1090108@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240447>

[+cc Junio, as the bug blames to him]

On Fri, Jan 10, 2014 at 02:15:40PM +0100, Francis Moreau wrote:

> In mykernel repository, I'm having 2 different behaviours with git-log
> but I don't understand why:
> 
> Doing:
> 
>     $ git log --oneline --cherry-pick --left-right v3.4.71-1^{}...next
> 
> and
> 
>     $ git log --oneline --cherry-pick --left-right v3.4.71-1...next
> 
> give something different (where v3.4.71-1 is a tag).
> 
> The command using ^{} looks the one that gives correct result I think.

Yeah, this looks like a bug. Here's a simple reproduction recipe:

  commit() {
    echo content >$1 &&
    git add $1 &&
    git commit -m $1
  }

  git init repo && cd repo &&
  commit one &&
  commit two &&
  sleep 1 &&
  git tag -m foo mytag &&
  git checkout -b side HEAD^ &&
  git cherry-pick mytag &&
  commit three

The sleep seems to be necessary, to give the commit and its
cherry-picked version different commit times (presumably because it
impacts the order in which we visit them during the traversal).

Running:

  git log --oneline --decorate --cherry-pick --left-right mytag^{}...HEAD

produces the expected:

  > e36cc32 (HEAD, side) three

but running it with the tag, as:

  git log --oneline --decorate --cherry-pick --left-right mytag...HEAD

yields:

  > e36cc32 (HEAD, side) three
  > 5e96f7d two
  > db92fca (tag: mytag, master) two

Not only do we get the cherry-pick wrong (we should omit both "twos"),
but we seem to erroneously count the tagged "two" as being on the
right-hand side, which it clearly is not (and which is probably why we
don't find the match via --cherry-pick).

This worked in v1.8.4, but is broken in v1.8.5. It bisects to Junio's
895c5ba (revision: do not peel tags used in range notation, 2013-09-19),
which sounds promising.

I think what is happening is that we used to apply the SYMMETRIC_LEFT
flag directly to the commit. Now we apply it to the tag, and it does not
seem to get propagated. The patch below fixes it for me, but I have no
idea if we actually need to be setting the other flags, or just
SYMMETRIC_LEFT. I also wonder if the non-symmetric two-dot case needs to
access any pointed-to commit and propagate flags in a similar way.

diff --git a/revision.c b/revision.c
index 7010aff..1d99bfc 100644
--- a/revision.c
+++ b/revision.c
@@ -1197,6 +1197,8 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 				free_commit_list(exclude);
 
 				a_flags = flags | SYMMETRIC_LEFT;
+				a->object.flags |= a_flags;
+				b->object.flags |= flags;
 			}
 
 			a_obj->flags |= a_flags;

-Peff
