From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git checkout $commit -- somedir doesn't drop files
Date: Tue, 17 Sep 2013 17:21:06 -0400
Message-ID: <20130917212106.GB20178@sigill.intra.peff.net>
References: <20130917190659.GA15588@pengutronix.de>
 <xmqqeh8nxltc.fsf@gitster.dls.corp.google.com>
 <20130917201259.GB16860@sigill.intra.peff.net>
 <xmqq61tzxkgz.fsf@gitster.dls.corp.google.com>
 <20130917202917.GA20020@sigill.intra.peff.net>
 <xmqq1u4nxjv2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 23:21:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM2hy-0002NQ-Gi
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 23:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787Ab3IQVVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 17:21:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:48046 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753359Ab3IQVVN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 17:21:13 -0400
Received: (qmail 24772 invoked by uid 102); 17 Sep 2013 21:21:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Sep 2013 16:21:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Sep 2013 17:21:06 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1u4nxjv2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234931>

On Tue, Sep 17, 2013 at 01:40:17PM -0700, Junio C Hamano wrote:

> > Hrm. Probably not. It is almost a one-way merge going to the named tree
> > (but limited by the pathspec), except that I think the current
> > git-checkout code may provide some safety checks related to where we are
> > coming from (e.g., do we unconditionally overwrite entries that are not
> > uptodate?).
> 
> I think we do unconditionally overwrite and that has been very much
> on purpose.

I thought so, too, but I was thrown off by the code in checkout_paths()
that warns/aborts if there are unmerged entries. But it looks like we
will have thrown out those entries already during the read_tree_some
call, which adds the new entries using OK_TO_REPLACE.

> "git checkout tree-ish -- file.txt" has always been about replacing
> whatever cruft is in paths in the worktree that match pathspec, just
> like "cat content-created-elsewhere >file.txt" is.  "Oops, you have
> a local change that do not match index" is the last thing we want to
> say, because getting rid of that local change is the primary reason
> why "checkout tree-ish -- file.txt" exists.
> 
> Taking the state of a subdirectory as a whole as "content", the
> change we are discussing will make it more like "rm -fr dir && tar
> xf some-content dir" to replace the directory wholesale, which I
> personally think is a good thing in the longer term.

Yeah, that makes sense. What about untracked files?

Right now we overwrite them if the tree-ish has an entry at the same
path; that is a bit more dangerous than the rest of git, but does match
the "ignore local modifications" rule. I assume if we handled deletions,
though, that we would simply leave them be.

So given that, is it fair to say that a one-way "go here" merge, limited
by pathspec, is the closest equivalent?

-Peff
