From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git checkout $commit -- somedir doesn't drop files
Date: Thu, 19 Sep 2013 18:13:23 -0400
Message-ID: <20130919221323.GA18085@sigill.intra.peff.net>
References: <20130917201259.GB16860@sigill.intra.peff.net>
 <xmqq61tzxkgz.fsf@gitster.dls.corp.google.com>
 <20130917202917.GA20020@sigill.intra.peff.net>
 <xmqq1u4nxjv2.fsf@gitster.dls.corp.google.com>
 <20130917212106.GB20178@sigill.intra.peff.net>
 <xmqqk3ifw1km.fsf@gitster.dls.corp.google.com>
 <20130917220345.GA22914@sigill.intra.peff.net>
 <xmqqd2o7w0xc.fsf@gitster.dls.corp.google.com>
 <20130919074616.GA29773@sigill.intra.peff.net>
 <xmqqbo3ou1ue.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 00:13:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMmTh-0002UH-Hs
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 00:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636Ab3ISWNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 18:13:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:38861 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386Ab3ISWNd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 18:13:33 -0400
Received: (qmail 7921 invoked by uid 102); 19 Sep 2013 22:13:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Sep 2013 17:13:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Sep 2013 18:13:23 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbo3ou1ue.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235035>

On Thu, Sep 19, 2013 at 11:02:17AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > An alternative would be to write the new entries to a temporary index
> > in memory. And then you can throw away the entries in the current index
> > that match the pathspec, and add in the entries from the temporary
> > index. I was just hoping that unpack-trees would do all of that for me.
> > :)
> 
> Isn't a "go there" one-way merge with pathspecs very similar to what
> happens in "reset -- pathspec" except for the working tree part?

I thought so at first, but now I'm not so sure...

> suspect that it may be sufficient to mimic the read_from_tree() and
> adapt update_index_from_diff() callback in builtin/reset.c to also
> update the working tree (and we can do so unconditionally without
> checking if we have any local modification in this case, which
> simplifies things a lot), but I may be missing something.

It almost works to simply update the index as "reset" does via
diff_cache, marking each updated entry with CE_UPDATE, and then let the
rest of checkout_paths proceed, which handles updating the working tree
based on the new index.

But I found two problems:

  1. The diff never feeds us entries that are unchanged, so we never
     mark them for update. But that interferes with later code to check
     whether our pathspecs matched anything (so we complain on "git
     reset --hard; git checkout HEAD foo" would barf on the checkout,
     since we do not need to touch foo).

     But I think that points to a larger problem, which is that we do
     not want to just look at the entries that are different between the
     tree and the index. We also need to care about the entries that are
     different in the working tree and index, because those need written
     out, too.

  2. The code in checkout_paths cannot handle the deletion for us,
     because it doesn't even know about the path any more (we removed it
     during the index diff). I think we could get around this by leaving
     an entry with the CE_WT_REMOVE flag set. But it looks like there is
     a bit more magic to removing a path than just remove_or_warn().
     unpack-trees has unlink_entry, which queues up leading directories
     for removal.

I think (2) is a matter of refactoring (but again, if we could convince
unpack-trees to do this for us, that might be the nicest way to reuse
the code). But (1) points to a larger problem in thinking about this as
a "diff"; it is really about re-loading bits of the index, and then
checking it out into the working tree.

-Peff
