From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http-push: trim trailing newline from remote symref
Date: Tue, 13 Jan 2015 14:58:06 -0500
Message-ID: <20150113195806.GA13282@peff.net>
References: <20150113022857.GA4087@peff.net>
 <4E1001F7-2D26-483A-9339-E2570559ECF0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 20:58:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB7bQ-0004JV-4x
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 20:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbbAMT6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 14:58:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:34051 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753068AbbAMT6H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 14:58:07 -0500
Received: (qmail 13554 invoked by uid 102); 13 Jan 2015 19:58:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jan 2015 13:58:07 -0600
Received: (qmail 29700 invoked by uid 107); 13 Jan 2015 19:58:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jan 2015 14:58:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Jan 2015 14:58:06 -0500
Content-Disposition: inline
In-Reply-To: <4E1001F7-2D26-483A-9339-E2570559ECF0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262352>

On Tue, Jan 13, 2015 at 08:26:31AM -0800, Kyle J. McKay wrote:

> I have this line in my 2.1.4 test output log:
> 
> t5540-http-push-webdav.sh .......................... ok
> [...]
> I do not build with NO_EXPAT.  This is running the tests on OS X without
> this patch applied.  Is something else required to get a failure?

Hmm. I think it is probably this:

  http://curl.haxx.se/docs/adv_20150108B.html

where curl has started complaining about URLs with newlines in them. So
ae021d8 did introduce a bug, but older versions of curl did not really
care. The combination of ae021d8 with a new version of curl triggers the
problem.

And that also explains why it worked prior to eecc8367f4; curl was more
forgiving. Also, interestingly, if you "git log -S'- 6' http-push.c",
you can see the exact same bug reappear and go away in 2006/2007. The
implicit "chop one character" behavior is there in the original
3dfaf7bc, adding http-push support. Then it disappears as a side effect
of bfbd0bb6, and then comes back again in eecc8367.

Anyway. I think my patch is still the right thing. But that does explain
why we didn't notice the test failure.

-Peff
