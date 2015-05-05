From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] lock_packed_refs(): allow retries when acquiring the
 packed-refs lock
Date: Tue, 5 May 2015 15:21:10 -0400
Message-ID: <20150505192110.GD10463@peff.net>
References: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu>
 <1430491977-25817-3-git-send-email-mhagger@alum.mit.edu>
 <CAGZ79kZnhv+aW_GW8mBDyhfv_k54ScAFsHQz=8zfHBUJ8WrVUw@mail.gmail.com>
 <20150501182257.GA27728@peff.net>
 <55445E60.6010205@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 05 21:21:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpiP8-0005H9-MA
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 21:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbbEETVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 15:21:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:54412 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751332AbbEETVN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 15:21:13 -0400
Received: (qmail 23406 invoked by uid 102); 5 May 2015 19:21:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 May 2015 14:21:13 -0500
Received: (qmail 9656 invoked by uid 107); 5 May 2015 19:21:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 May 2015 15:21:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 May 2015 15:21:10 -0400
Content-Disposition: inline
In-Reply-To: <55445E60.6010205@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268416>

On Sat, May 02, 2015 at 07:19:28AM +0200, Michael Haggerty wrote:

> 100 ms seems to be considered an acceptable delay between the time that
> a user, say, clicks a button and the time that the button reacts. What
> we are talking about is the time between the release of a lock by one
> process and the resumption of another process that was blocked waiting
> for the lock. The former is probably not under the control of the user
> anyway, and perhaps not even observable by the user. Thus I don't think
> that a perceivable delay between that event and the resumption of the
> blocked process would be annoying. The more salient delay is between the
> time that the user started the blocked command and when that command
> completed. Let's look in more detail.

Yeah, you can't impact when the other process will drop the lock, but if
we assume that it takes on the order of 100ms for the other process to
do its whole operation, then on average we experience half that. And
then tack on to that whatever time we waste in sleep() after the other
guy drops the lock. And that's on average half of our backoff time.

So something like 100ms max backoff makes sense to me, in that it keeps
us in the same order of magnitude as the expected time that the lock is
held.

Of course these numbers are all grossly hand-wavy, and as you point out,
the current formula never even hits 100ms with the current 1s timeout,
anyway. So for the record, I'm fine leaving your patch as-is.

I think for our disgusting 1GB packed-refs files at GitHub, we will end
up bumping the maximum timeout, but by my own argument above, it will be
fine for the backoff to increase at the same time (i.e., they will
remain in the same rough order of magnitude).

-Peff
