From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0090: mark add-interactive test with PERL prerequisite
Date: Tue, 18 Nov 2014 12:43:09 -0500
Message-ID: <20141118174309.GB31672@peff.net>
References: <20141118172231.GA16387@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 18:43:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqmo8-0007K4-F1
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 18:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbaKRRnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 12:43:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:41788 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753563AbaKRRnL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 12:43:11 -0500
Received: (qmail 21814 invoked by uid 102); 18 Nov 2014 17:43:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 11:43:11 -0600
Received: (qmail 18239 invoked by uid 107); 18 Nov 2014 17:43:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 12:43:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Nov 2014 12:43:09 -0500
Content-Disposition: inline
In-Reply-To: <20141118172231.GA16387@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 12:22:31PM -0500, Jeff King wrote:

> The add-interactive system is built in perl. If you build
> with NO_PERL, running "git commit --interactive" will exit
> with an error and the test will fail.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Noticed by Michael while working around gitweb failures by setting
> NO_PERL. :)
> 
> It didn't reproduce for me in my existing build directory, presumably
> because I had an old git-add--interactive build product lying around.
> But running the tests in a clean clone with NO_PERL set reproduces
> easily.

I don't think fixing this is really a high priority. You can't ever be
free of odd interactions with previous build artifacts. After all, you
might have a built "git-foo" from a previous version of git (or one from
the future, or even an alternate reality from another branch), and our
Makefile should not have to know about every previous version you may
have built in the path. That is what "git clean" is for (or just using a
clean build directory).

But fixing this one in particular is pretty easy (and we _do_ know about
the wrongly-built file; our dependencies are just incomplete):

-- >8 --
Subject: Makefile: have perl scripts depend on NO_PERL setting

If NO_PERL is not set, our perl scripts are built as
usual. If it is set, then we build "dummy" versions that
tell you git was built without perl support and exit
gracefully.

However, if you switch to NO_PERL in a directory with
existing build artifacts, we do not notice that the files
need rebuilt. We see only that they are newer than the
"unimplemented.sh" wrapper and assume they are done. So
doing:

  make
  make NO_PERL=Nope

would result in a git-add--interactive script that uses perl
(and running the test suite would make use of it).

Instead, we should trigger a rebuild of the perl scripts
anytime NO_PERL changes.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 827006b..0fa02ff 100644
--- a/Makefile
+++ b/Makefile
@@ -1676,6 +1676,9 @@ git.res: git.rc GIT-VERSION-FILE
 	  $(join -DMAJOR= -DMINOR=, $(wordlist 1,2,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
 	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
 
+# This makes sure we depend on the NO_PERL setting itself.
+$(patsubst %.perl,%,$(SCRIPT_PERL)): GIT-BUILD-OPTIONS
+
 ifndef NO_PERL
 $(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
 
-- 
2.1.2.596.g7379948
