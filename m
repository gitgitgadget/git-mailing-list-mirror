From: Jeff King <peff@peff.net>
Subject: Re: git pull & git gc
Date: Thu, 19 Mar 2015 00:09:57 -0400
Message-ID: <20150319040957.GA29437@peff.net>
References: <5509836D.2020304@aegee.org>
 <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com>
 <55098A49.1020003@aegee.org>
 <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
 <CACsJy8DCdF1YmfFF1aCuhMJ0v4+FW7EkDiwBnBF2OFhE=kcbFg@mail.gmail.com>
 <20150318145815.GN1369@serenity.lan>
 <20150318210458.GA3376@peff.net>
 <CACsJy8AJfx8id+oHmhsLODBJeNLgRqD+5B295TtS+c-hrC5raQ@mail.gmail.com>
 <20150319012722.GA26867@peff.net>
 <CAPc5daWmppS_PrvMurEUfvZ2c_bhMnLb-zmck0wzFpgJ4maxZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, John Keeping <john@keeping.me.uk>,
	=?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 05:10:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYRma-0007MD-1j
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 05:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbbCSEKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 00:10:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:34999 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751129AbbCSEKA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 00:10:00 -0400
Received: (qmail 31762 invoked by uid 102); 19 Mar 2015 04:10:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 23:10:00 -0500
Received: (qmail 9717 invoked by uid 107); 19 Mar 2015 04:10:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 00:10:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 00:09:57 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daWmppS_PrvMurEUfvZ2c_bhMnLb-zmck0wzFpgJ4maxZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265778>

On Wed, Mar 18, 2015 at 07:27:46PM -0700, Junio C Hamano wrote:

> > I guess leaving a bunch of loose objects around longer than necessary
> > isn't the end of the world. It wastes space, but it does not actively
> > make the rest of git slower (whereas having a large number of packs does
> > impact performance). So you could probably make "recent enough" be "T <
> > now - gc.pruneExpire / 4" or something. At most we would try to gc 4
> > times before dropping unreachable objects, and for the default period,
> > that's only once every couple days.
> 
> We could simply prune unreachables more aggressively, and it would
> solve this issue at the root cause, no?

Yes, but not too aggressively. You mentioned object archaeology, but my
main interest is avoiding corruption. The mtime check is the thing that
prevents us from pruning objects being used for an operation-in-progress
that has not yet updated a ref.  For some long-running operations, like
adding files to a commit, we take into account references like a blob
being mentioned in the index. But I do not know offhand if there are
other long-running operations that would run into problems if we
shortened the expiration time drastically.  Anything building a
temporary index is potentially problematic.

But if we assume that operations like that tend to create and reference
their objects within a reasonable time period (say, seconds to minutes)
then the current default of 2 weeks is absurd for this purpose.  For
raciness within a single operation, a few seconds is probably enough
(e.g., we may write out a commit object and then update the ref a few
milliseconds later).

The potential for problems is exacerbated by the fact that object `X`
may exist in the filesystem with an old mtime, and then a new operation
wants to reference it. That's made somewhat better by 33d4221
(write_sha1_file: freshen existing objects, 2014-10-15), as before we
could silently turn a file write into a noop. But it's still racy to do:

  git cat-file -e $commit
  git update-ref refs/heads/foo $commit

as we do not update the mtime for a read-only operation like cat-file
(and even if we did, it's still somewhat racy as prune does not
atomically check the mtime and remove the file).

So I think there's definitely some possible danger with dropping the
default prune expiration time.

For a long time GitHub ran with it as 1.hour.ago. We definitely saw some
oddities and corruption over the years that were apparently caused by
over-aggressive pruning and/or raciness. I've fixed a number of bugs,
and things did get better as a result. But I could not say whether all
such problems are gone. These days we do our regular repacks with
"--keep-unreachable" and almost never prune anything.

It's also not clear whether GitHub represents anything close to "normal"
use. We have a much smaller array of operations that we perform (most
objects are either from a push, or from a test-merge between a topic
branch and HEAD). But we also have busy repos that are frequently doing
gc in the background (especially because we share object storage, so
activity on another fork can trigger a gc job that affects a whole
repository network). On workstations, I'd guess most git-gc jobs run
during a fairly quiescent period.

All of which is to say that I don't really know the answer, and there
may be dragons. I'd imagine that dropping the default expiration time
from 2 weeks to 1 day would probably be fine. A good way to experiment
would be for some brave souls to set gc.pruneexpire themselves, run with
it for a few weeks or months, and see if anything goes wrong.

-Peff
