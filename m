From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3] refs.c: enable large transactions
Date: Fri, 24 Apr 2015 16:17:34 -0400
Message-ID: <20150424201734.GA4747@peff.net>
References: <1429738227-2985-1-git-send-email-sbeller@google.com>
 <xmqqzj5y3f0a.fsf@gitster.dls.corp.google.com>
 <CAGZ79kYO9NifvWQ7nWHP6==ZFmrMj47-94rEHOhWooR5Nh7EUw@mail.gmail.com>
 <xmqq8udi2tn8.fsf@gitster.dls.corp.google.com>
 <CAGZ79kYGDOUgzKmQOLAXkYYb-HZJCw3Y=iSLXWHVXcQ0pAiDBw@mail.gmail.com>
 <20150424181236.GK5467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 22:17:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylk2f-0000Mp-HC
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 22:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966779AbbDXURh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 16:17:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:49815 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965367AbbDXURg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 16:17:36 -0400
Received: (qmail 32185 invoked by uid 102); 24 Apr 2015 20:17:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Apr 2015 15:17:36 -0500
Received: (qmail 18900 invoked by uid 107); 24 Apr 2015 20:18:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Apr 2015 16:18:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2015 16:17:34 -0400
Content-Disposition: inline
In-Reply-To: <20150424181236.GK5467@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267755>

On Fri, Apr 24, 2015 at 11:12:36AM -0700, Jonathan Nieder wrote:

> Actually, I wouldn't mind an environment variable that tells error()
> to include a backtrace if someone wants it.  (See backtrace(3)
> for implementation hints if interested in doing that.)

Thanks, I didn't know about backtrace(3), and figured we'd be stuck with
an ELF library or similar to get at the symbols.

That being said, the resulting backtrace is not nearly as nice as what
is produced by gdb (which includes pretty-printed variables, or even
local variables with "bt full"). Not everybody will have gdb, of course,
but nor will everybody have backtrace().

So if anything, I think my inclination would be to make it easier to
help people (and ourselves) get a backtrace from gdb.

One can get a core for a running process with gcore, or trigger a
coredump by killing with SIGABRT. But catching it at the exact moment of
a die() is a bit hard without support from the program. What about
something like this:

diff --git a/usage.c b/usage.c
index ed14645..fa92190 100644
--- a/usage.c
+++ b/usage.c
@@ -34,6 +34,8 @@ static NORETURN void usage_builtin(const char *err, va_list params)
 static NORETURN void die_builtin(const char *err, va_list params)
 {
 	vreportf("fatal: ", err, params);
+	if (git_env_bool("GIT_DIE_ABORT", 0))
+		abort();
 	exit(128);
 }
 

Usage would be something like:

  ulimit -c unlimited ;# optional, but many distros seem to ship with
                      ;# cores disabled these days
  GIT_DIE_ABORT=1 git some-command-that-fails
  gdb --quiet -ex 'bt full' -ex quit git core

We could even wrap that up in a git-debug script. I suspect there may be
some complications with finding the core file, though, as the git
process may chdir before dumping. I'm not sure if there's a good way
around that (obviously setting /proc/sys/kernel/core_pattern is not
exactly friendly).

I dunno. Certainly there is room for a less-full-featured system that
would run more seamlessly, or on more people's systems (i.e., so that we
can easily say "set GIT_FOO and tell us what it outputs" in response to
bug reports). Maybe that system is backtrace(), or maybe it is just
__FILE__ and __LINE__ markers for each printed error.

-Peff
