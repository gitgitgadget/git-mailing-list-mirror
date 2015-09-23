From: Jeff King <peff@peff.net>
Subject: Re: t5561 failing after make PROFILE=GEN
Date: Wed, 23 Sep 2015 19:24:43 -0400
Message-ID: <20150923232443.GA21755@sigill.intra.peff.net>
References: <5601E283.2030507@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Sep 24 01:24:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZetP9-000696-Mq
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 01:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138AbbIWXYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 19:24:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:35458 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755014AbbIWXYq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 19:24:46 -0400
Received: (qmail 13778 invoked by uid 102); 23 Sep 2015 23:24:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Sep 2015 18:24:46 -0500
Received: (qmail 20897 invoked by uid 107); 23 Sep 2015 23:24:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Sep 2015 19:24:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Sep 2015 19:24:43 -0400
Content-Disposition: inline
In-Reply-To: <5601E283.2030507@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278521>

On Wed, Sep 23, 2015 at 01:21:39AM +0200, Stephan Beyer wrote:

> I noticed that t5561 fails on my machine when compiling with
> "make PROFILE=GEN". Luckily, the reason seems to be the test only,
> not the tool it is testing.
> 
> I tracked it down that far that log_div() (defined in
> t/t5561-http-backend.sh but used in t/t556x_common) appends
> the given text to the access.log *before* the last GET log entry
> is written.

Yes, I have run into this before. I _think_ I've also seen it once in a
non-profile build. Which would make sense, if it is simply racy but the
race usually goes the right way, and something about the profile build
upsets that.

But I also can't get it to fail when running t5561 in a loop, so I may
have been mistaken (and it fails to consistently with PRORILE=GEN). And
it does seem to be mostly related to the log-flushing behavior of
apache, and I can't imagine how we would be affecting that.

It's nothing in the environment; if you have a profile build and run "cd
t && ./t5561-*", it will still fail. So it's something about the build.
I'd guess it would be that git-http-backend is taking extra time after
the session is over to write out the profile data, and that apache
delays writing the log entry until it is done.

Aha. That seems to be it. If I add

diff --git a/http-backend.c b/http-backend.c
index bac40ef..88610b4 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -699,5 +699,6 @@ int main(int argc, char **argv)
 					   max_request_buffer);
 
 	cmd->imp(cmd_arg);
+	sleep(1);
 	return 0;
 }

then it fails for me even without a profile build.

> Replacing the log_div() implementation by "return 0" and removing
> the implied output solves the problem without breaking any test
> functionality. (For more clarity, the log_div() calls and definitions
> should be removed.) I refrained from sending this trivial patch
> because I am not sure if this is the right way to cope with the issue.

I'd agree that the tests would be OK (albeit a little less readable) if
we drop the log_div. My initial worry was that we we were papering over
a real problem, but I don't think we are. Touching the apache logfile
ourselves is inherently racy. We know the _client_ has finished talking
to the server, but we don't know when the server side of the CGI has
exited.

And this isn't anything to do with git's behavior, but just the test
script. So I think dropping the log_div is probably our best bet. We may
want to keep the existing "expected" file with the "###" lines as
comments, and then simply strip them out when comparing to the actual
output (so the test script remains readable).

-Peff
