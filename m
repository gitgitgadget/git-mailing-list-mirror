From: Jeff King <peff@peff.net>
Subject: Re: git checkout --theirs fails
Date: Wed, 16 Mar 2016 17:12:54 -0400
Message-ID: <20160316211254.GB2200@sigill.intra.peff.net>
References: <56E845F0.9020609@gmail.com>
 <CAGZ79kbzrpHowSLfCjB6wVfeX_3MUXAjD0rQdcugryWPMrTazQ@mail.gmail.com>
 <xmqqd1qv76rn.fsf@gitster.mtv.corp.google.com>
 <56E95585.30409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Susi <phillsusi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:13:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agIkY-0004u7-RV
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 22:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571AbcCPVM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 17:12:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:32794 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755496AbcCPVM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 17:12:57 -0400
Received: (qmail 23912 invoked by uid 102); 16 Mar 2016 21:12:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 17:12:57 -0400
Received: (qmail 20098 invoked by uid 107); 16 Mar 2016 21:13:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 17:13:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Mar 2016 17:12:54 -0400
Content-Disposition: inline
In-Reply-To: <56E95585.30409@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289039>

On Wed, Mar 16, 2016 at 08:45:57AM -0400, Phil Susi wrote:

> On 3/15/2016 5:47 PM, Junio C Hamano wrote:
> > would fail when the path file/name is unmerged and does not have
> > stage #3 entry, wouldn't it?  So with ".", unless all paths that
> > match that pathspec (i.e. all available files) are either merged
> > (i.e. without conflict) or have stage #3 entry, it is expected that
> > the command would fail consistently to the case where a pathspec
> > "file/name" that happens to match only one path is given, and that
> > is the behaviour Phil saw, I would think.
> 
> Right... why is this though?  Why doesn't it just check out those files
> that *do* have a #3 entry?

Certainly "git checkout --theirs foo" should complain if "foo" does not
have a "theirs" entry. But in your case, you are picking the entries up
only via a recursive pathspec, so you'd probably be fine if _any_
entries were updated.

We do something like that in git-add, where "git add 'foo*'" will
complain only if "foo*" didn't match anything. I suspect we could do the
same here, but nobody has bothered to implement it.

Probably (and now I am in the realm of pure speculation) because
"checkout --theirs" was intended to be done on specific paths, once you
had looked at the conflicts. If you want to do a blanket "checkout
--theirs .", wouldn't merging with `-Xtheirs` be simpler?

> And also why the nonsense about switching
> branches when you don't specify any path or branch?

Because the default for checkout without any arguments has always been
to "switch" branches to HEAD. That's obviously a noop, but people have
long done it to see the switching message.

Nobody until now bothered to think about how that decision would
interact with "--theirs". So it does _a_ logical thing, but not the one
that would be most useful to you. I do not think it would be harmful to
DWIM "git checkout --theirs" to "git checkout --theirs .".

-Peff
