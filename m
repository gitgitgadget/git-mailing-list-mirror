From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3] refs.c: enable large transactions
Date: Sat, 25 Apr 2015 01:00:58 -0400
Message-ID: <20150425050058.GA20256@peff.net>
References: <1429738227-2985-1-git-send-email-sbeller@google.com>
 <xmqqzj5y3f0a.fsf@gitster.dls.corp.google.com>
 <CAGZ79kYO9NifvWQ7nWHP6==ZFmrMj47-94rEHOhWooR5Nh7EUw@mail.gmail.com>
 <xmqq8udi2tn8.fsf@gitster.dls.corp.google.com>
 <CAGZ79kYGDOUgzKmQOLAXkYYb-HZJCw3Y=iSLXWHVXcQ0pAiDBw@mail.gmail.com>
 <20150424181236.GK5467@google.com>
 <20150424201734.GA4747@peff.net>
 <xmqqzj5w25vv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 07:01:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlsDF-0004KL-KQ
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 07:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090AbbDYFBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 01:01:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:49973 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752786AbbDYFBC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 01:01:02 -0400
Received: (qmail 21660 invoked by uid 102); 25 Apr 2015 05:01:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Apr 2015 00:01:01 -0500
Received: (qmail 22667 invoked by uid 107); 25 Apr 2015 05:01:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Apr 2015 01:01:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Apr 2015 01:00:58 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzj5w25vv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267772>

On Fri, Apr 24, 2015 at 09:23:16PM -0700, Junio C Hamano wrote:

> The proposals so far, including this one, assume that the bug
> reporter will first fail the operation with "normal" invocation
> of Git (e.g. without GIT_DIE_ABORT exported) and then retry the
> same operation in a different way (e.g. with GIT_DIE_ABORT) to
> give us something that would help diagnosis.  Such a user could
> just rerun Git under gdb with breakpoint set to die_builtin, no?

Good point. I was trying to automate the gathering of the backtrace so
that even bug-reporters who have not used gdb could easily get us more
information. But of course if a coredump only gets us halfway there and
we have to script gdb to convert the core into a backtrace anyway, it is
not buying us much over just scripting gdb in the first place.

A better solution to what I proposed earlier is perhaps:

  git config alias.debug '!gdb --quiet \
	    -ex "break exit" \
	    -ex "run" \
	    -ex "bt full" \
	    -ex "continue" \
	    -ex "quit" \
	    --args git \
  '
  git debug rev-parse foobar

It has the minor irritation that gdb will control the process stdio
(slurping from stdin and polluting stdout, whereas we would prefer no
input and output to stderr). There might be a way to convince gdb to do
otherwise, or you could probably go pretty far with some shell fd
redirects and using "set args" inside gdb. Or maybe something with
gdbserver.

But the point is that yeah, we shouldn't try to build really good
introspection inside git. Debuggers already do a way better job of this.
If they're hard for people to use to obtain simple information like a
backtrace, we should work on wrapping that difficulty up in a script.

It might still be useful to provide a much lesser form of introspection,
if it would be available in a lot more places than gdb would. E.g.,
__FILE__ and __LINE__ markers on error messages might be useful. A
mediocre backtrace() that is only available on glibc systems is probably
not.

-Peff
