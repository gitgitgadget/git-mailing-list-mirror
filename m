From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 2/2] add "ok=sigpipe" to test_must_fail and use it to
 fix flaky tests
Date: Sat, 28 Nov 2015 12:10:04 -0500
Message-ID: <20151128171004.GC27264@sigill.intra.peff.net>
References: <1448615714-43768-1-git-send-email-larsxschneider@gmail.com>
 <1448615714-43768-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Sat Nov 28 18:10:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2j0v-0004p5-BF
	for gcvg-git-2@plane.gmane.org; Sat, 28 Nov 2015 18:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbbK1RKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2015 12:10:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:34686 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752553AbbK1RKH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2015 12:10:07 -0500
Received: (qmail 19549 invoked by uid 102); 28 Nov 2015 17:10:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Nov 2015 11:10:07 -0600
Received: (qmail 23540 invoked by uid 107); 28 Nov 2015 17:10:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Nov 2015 12:10:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Nov 2015 12:10:04 -0500
Content-Disposition: inline
In-Reply-To: <1448615714-43768-3-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281790>

On Fri, Nov 27, 2015 at 10:15:14AM +0100, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> t5516 "75 - deny fetch unreachable SHA1, allowtipsha1inwant=true" is
> flaky in the following case:
> 1. remote upload-pack finds out "not our ref"
> 2. remote sends a response and closes the pipe
> 3. fetch-pack still tries to write commands to the remote upload-pack
> 4. write call in wrapper.c dies with SIGPIPE
> 
> t5504 "9 - push with transfer.fsckobjects" is flaky, too, and returns
> SIGPIPE once in a while. I had to remove the final "To dst..." output
> check because there is no output if the process dies with SIGPUPE.

s/PUPE/PIPE/ :)

I think it would be nice for future readers to understand a bit better
_why_ this is flaky, and why the fix is to the test suite and not to git
itself. I added this paragraph in between the two above:

    The test is flaky because the sending fetch-pack may or may not have
    finished writing its output by step (3). If it did, then we see a
    closed pipe on the next read() call. If it didn't, then we get the
    SIGPIPE from step (4) above. Both are fine, but the latter fools
    test_must_fail.

-Peff
