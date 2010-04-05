From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add option to git-commit to allow empty log messages
Date: Mon, 5 Apr 2010 01:51:39 -0400
Message-ID: <20100405055139.GA28730@coredump.intra.peff.net>
References: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com>
 <1270392557-26538-1-git-send-email-avarab@gmail.com>
 <20100404224324.GB12655@gmail.com>
 <y2j51dd1af81004041653g9a09915el60104c575dcf6481@mail.gmail.com>
 <7vy6h2wsvg.fsf@alter.siamese.dyndns.org>
 <buor5mu7acd.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Apr 05 07:52:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyfEN-0004Vc-VI
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 07:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954Ab0DEFv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 01:51:56 -0400
Received: from peff.net ([208.65.91.99]:51087 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749Ab0DEFvz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 01:51:55 -0400
Received: (qmail 18420 invoked by uid 107); 5 Apr 2010 05:52:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 05 Apr 2010 01:52:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Apr 2010 01:51:39 -0400
Content-Disposition: inline
In-Reply-To: <buor5mu7acd.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143970>

On Mon, Apr 05, 2010 at 02:10:58PM +0900, Miles Bader wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> > As a Porcelain, "git commit" has some leeway to enforce sensible policy on
> > the users, and "forbid commit that does not explain anything" is one such
> > policy.  It is not generally a good idea to expose the full capabilities
> > of plumbing to Porcelain if it leads to bad user behaviour, and such
> > "artificial" limitations are safety features we do not want to remove.
> 
> Isn't the requirement of using a longish option like
> "--allow-empty-message" enough of a warning to users though?
> 
> Although it seems reasonable for git _discourage_ bad practices, I think
> that should generally also be moderated with "... but if you _reallllly_
> want to, you can do this somewhat annoying thing....".  Forcing someone
> to use commit-tree, though, seems a bit much to me; an annoyingly long
> option seems about right.

Yes and no. There are other reasons not to use "git commit" in your
import script. You probably want to pass --allow-empty, too, and
--no-verify.  And you probably want to use --cleanup=none to keep
messages intact.

But most of all, even if you do everything right, we still don't promise
not to change it out from under you in a future version. Because it's
porcelain, and the plumbing method is to use commit-tree.  If
commit-tree is too hard to use, I would rather see the plumbing made
more friendly than encouraging people to build on top of porcelain.

All of that being said, I looked at the snerp-vortex source code (which
started this thread):

  http://github.com/rcaputo/snerp-vortex/blob/master/lib/SVN/Dump/Replayer/Git.pm

It uses several pieces of porcelain. Some in silly ways, like calling
"git status" to avoid calling git-commit when there are no changes and
getting an error code. Which is silly (if you are importing, you
probably want --allow-empty), wasteful (you just need the diff-index
part of status), and now broken (because status is no longer "commit
--dry-run", it always exits with status 0 whether there are changes or
not). Then there are things like calling "git add -f" with arguments,
and a "TODO: split arguments to handle larger filesets" comment. When he
should be using update-index, which takes updates on stdin.

He also notes in the README that it takes 250 seconds to convert his
test repo to git, but only 70 to make a flat filesystem, and that he
wants to move to using fast-import.

So yes, it sucks that his importer does not support empty comments, and
that the OP had to hack around it. But it already doesn't support many
things (like commits with a large number of files, and from what I can
see, files with spaces will break his `find` invocation). The right
answer is for him to move to fast-import, which will be way faster, more
robust, and is actually a supported plumbing interface.

I don't think it's worth adding new features to support a scripting
interface that we are trying to discourage. And I haven't seen another
argument in favor of empty commits besides importing.  Are people
really wanting to make empty commit messages while using git itself?

-Peff
