From: Jeff King <peff@peff.net>
Subject: Re: 2.2.0-rc behavior changes (1/2)
Date: Mon, 10 Nov 2014 04:22:19 -0500
Message-ID: <20141110092219.GA11387@peff.net>
References: <CAGyf7-GxJ6XHjKqwktKqpo_mFuC_D3gzeOGNTdt4sweAnFqNRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 10:22:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnlBN-0000Eq-Kc
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 10:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbaKJJWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 04:22:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:38671 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751892AbaKJJWV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 04:22:21 -0500
Received: (qmail 22885 invoked by uid 102); 10 Nov 2014 09:22:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 03:22:22 -0600
Received: (qmail 1978 invoked by uid 107); 10 Nov 2014 09:22:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 04:22:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2014 04:22:19 -0500
Content-Disposition: inline
In-Reply-To: <CAGyf7-GxJ6XHjKqwktKqpo_mFuC_D3gzeOGNTdt4sweAnFqNRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 10, 2014 at 07:47:32PM +1100, Bryan Turner wrote:

> First change: git update-ref -d /refs/heads/nonexistent
> <some-valid-sha1> now produces an error about ref locking that it
> didn't produce before
> 
> Git 2.1.x and prior produced this output:
> error: unable to resolve reference refs/heads/nonexistent: No such
> file or directory
> 
> Now, in the 2.2.0 RCs, it says:
> error: unable to resolve reference refs/heads/nonexistent: No such
> file or directory
> error: Cannot lock the ref 'refs/heads/nonexistent'.
> 
> This one feels more like a bug, but again may not be. I say it feels
> like a bug because of the order of the messages: If git has decided
> the ref doesn't exist, why is it still trying to lock it?

I don't think this is a bug. The order you see is because the code goes
something like this:

  1. the parent function calls a sub-function to lock

  2. the sub-function generates the error "no such file or directory"
     and returns failure to the caller

  3. the caller reports that acquiring the lock failed

The only thing that has changed between the two is step (3), but it is
not an extra lock action after the error. It is just a more verbose
report of the same error.

That being said, the sub-function (lock_ref_sha1_basic) gives a much
more useful message. So it would be a nice enhancement to make sure that
it prints something useful in every return case, and then drop the
message from the caller.

As an aside, I'm also slightly confused by your output. Are you feeding
"/refs/heads/nonexistent" (with a leading slash), or
"refs/heads/nonexistent" (no leading slash)? If the latter, then that
should silently succeed (and seems to in my tests). If the former, then
the real problem is not ENOENT, but rather EINVAL; that name is not a
valid refname.

Older versions of git would produce:

  error: unable to resolve reference /refs/heads/nonexistent: No such file or directory

which is like the error you showed, but note that the refname is
reported with the leading slash. In v2.2.0-rc1, this is:

  error: unable to resolve reference /refs/heads/nonexistent: Invalid argument
  error: Cannot lock the ref '/refs/heads/nonexistent'.

which is more accurate. I could explain the differences in our output
from some simple transcription errors when writing your email, but I
wanted to make sure I am not missing something.

-Peff
