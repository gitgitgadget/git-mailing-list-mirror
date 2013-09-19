From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git checkout $commit -- somedir doesn't drop files
Date: Thu, 19 Sep 2013 03:46:16 -0400
Message-ID: <20130919074616.GA29773@sigill.intra.peff.net>
References: <20130917190659.GA15588@pengutronix.de>
 <xmqqeh8nxltc.fsf@gitster.dls.corp.google.com>
 <20130917201259.GB16860@sigill.intra.peff.net>
 <xmqq61tzxkgz.fsf@gitster.dls.corp.google.com>
 <20130917202917.GA20020@sigill.intra.peff.net>
 <xmqq1u4nxjv2.fsf@gitster.dls.corp.google.com>
 <20130917212106.GB20178@sigill.intra.peff.net>
 <xmqqk3ifw1km.fsf@gitster.dls.corp.google.com>
 <20130917220345.GA22914@sigill.intra.peff.net>
 <xmqqd2o7w0xc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 19 09:46:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMYwY-0000d2-DA
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 09:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738Ab3ISHq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 03:46:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:33224 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897Ab3ISHqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 03:46:25 -0400
Received: (qmail 26831 invoked by uid 102); 19 Sep 2013 07:46:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Sep 2013 02:46:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Sep 2013 03:46:16 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd2o7w0xc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235004>

On Tue, Sep 17, 2013 at 03:14:39PM -0700, Junio C Hamano wrote:

> Yeah, then I agree that "git checkout HEAD^ -- subdir" should be a
> one-way "go HEAD^" merge limited only to the paths that match
> subdir/.
> 
> If implemented in a straight-forward way, I suspect that we may end
> up not removing subdir/b in Uwe's sample transcript. I am not sure
> if that is a good thing or not, though.  If the index originally
> tracked and then "going to" tree does not, I think removing it would
> match "ignore local modifications" rule, as subdir/a that is tracked
> in the index and also in "going to" tree does get overwritten to
> match the state recorded in the tree.

I had assumed the goal was to subdir/b (by the reasoning above, and the
"rm -rf && tar" analogy you gave earlier).

I tried a very hacky attempt at shoving unpack-trees into the right spot
in checkout_paths. But its pathspec handling from unpack_trees is not
quite what we want.

In Uwe's case, it did delete subdir/b and overwrite subdir/a, which I'd
expect. But if there was an additional file outside of subdir, it got
deleted, too.  The problem is that I was giving the regular index to
unpack_trees as the destination; so it wrote out only the bits of the
index under the pathspec subdir/, and omitted the rest entirely. I had
hoped instead it would leave those parts untouched from the source.

An alternative would be to write the new entries to a temporary index
in memory. And then you can throw away the entries in the current index
that match the pathspec, and add in the entries from the temporary
index. I was just hoping that unpack-trees would do all of that for me.
:)

At this point, I'm giving up for now. I was hoping a naive application
of unpack-trees would just work (and reduce the code size to boot), but
it is obviously a bit more complicated than that. I still think it's a
good idea for checkout to behave as Uwe described, but I don't think
it's that high a priority, and I have other stuff I'd prefer to work on
at the moment.

-Peff
