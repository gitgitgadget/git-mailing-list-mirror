From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] write_index: optionally allow broken null sha1s
Date: Mon, 26 Aug 2013 10:27:04 -0400
Message-ID: <20130826142704.GA14858@sigill.intra.peff.net>
References: <20130824013310.GA9343@sigill.intra.peff.net>
 <20130825061500.GR2882@elie.Belkin>
 <20130825095818.GA12556@sigill.intra.peff.net>
 <20130825195412.GA2752@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 16:27:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDxlE-0008Ly-6f
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 16:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857Ab3HZO1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 10:27:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:37335 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723Ab3HZO1L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 10:27:11 -0400
Received: (qmail 11597 invoked by uid 102); 26 Aug 2013 14:27:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Aug 2013 09:27:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Aug 2013 10:27:04 -0400
Content-Disposition: inline
In-Reply-To: <20130825195412.GA2752@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232994>

On Sun, Aug 25, 2013 at 12:54:12PM -0700, Jonathan Nieder wrote:

> [setup split across three tests]
>
> This is kind of an old-fashioned test, since each step of the setup is
> treated as a separate test assertion.  I don't really mind until we
> get better automation to make it easy to skip or rearrange tests.
> Just for reference, I think the usual way to do this now is

I don't see that splitting it up more hurts this. If we wanted more
automatic rearranging or skipping of tests, we would need tests to
declare dependencies on their setup. And we would need to be able to
declare dependencies on multiple tests, since having a single setup test
does not work in all cases (e.g., sometimes you are testing each step,
and the final step relies on earlier steps).

And I do think splitting it up has more granularity. For example, in the
sequence here:

> 	test_expect_success 'setup' '
> 		# create base commits
> 		...
> 
> 		# create a commit with bogus null sha1 in the tree
> 		...
> 
> 		# We have to make one more commit on top removing the broken
> 		# entry, since otherwise our index does not match HEAD and
> 		# filter-branch will complain. We could make the index match
> 		# HEAD, but doing so would involve writing a null sha1 into
> 		# the index.
> 		...
> 	'

Right now it is not hard to do step 2. But I could easily imagine a
world in which git-mktree learns to complain about such bogus trees. And
the sequence would become:

  1. create base commits

  2. check that mktree barfs

  3. check that we can override mktree to create a broken tree

  4. clean up tip state

in which case you really want to have individual tests.

I do not care _that_ much, since mktree does not behave that way now,
and the setup is otherwise not that likely to fail.  But I do not think
more granularity actually hurts us, and it can sometimes help (as
described above, but also when something fails, the test output more
clearly pinpoints what happened).

-Peff
