From: Jeff King <peff@peff.net>
Subject: Re: git quietly fails on https:// URL, https errors are never
 reported to user
Date: Thu, 16 Jan 2014 13:03:10 -0500
Message-ID: <20140116180310.GA27180@sigill.intra.peff.net>
References: <52D7D017.107@rawbw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Yuri <yuri@rawbw.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 19:03:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3rHi-0000SK-CQ
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 19:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbaAPSDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 13:03:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:33619 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750713AbaAPSDM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 13:03:12 -0500
Received: (qmail 12656 invoked by uid 102); 16 Jan 2014 18:03:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jan 2014 12:03:12 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jan 2014 13:03:10 -0500
Content-Disposition: inline
In-Reply-To: <52D7D017.107@rawbw.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240518>

On Thu, Jan 16, 2014 at 04:27:03AM -0800, Yuri wrote:

> While debugging, I find that remove_junk() deletes all directories
> from under __cxa_finalize.
> Before this, exit(128) is called from recvline_fh ("Debug: Remote
> helper quit.) And this function in turn is called from under
> refs = transport_get_remote_refs(transport);
> 
> I think you need to make sure that any https errors (in this and
> other locations) are reported to the user, and git never quits on
> error without saying what the error is.

We used to print "Reading from helper 'git-remote-https' failed" in this
instance. But in the majority of cases, remote-https has printed a
useful message already to stderr, and the extra line just confused
people. The downside, as you noticed, is that when the helper dies
without printing an error, the user is left with no message.

Unfortunately, detecting whether the helper printed a useful message is
non-trivial. It's possible we could do more detection based on the
helper's death (e.g., if it died by signal, print a message) and at
least say _something_.

But even if we do so, the message isn't going to tell you what went
wrong, only that something unexpected happened.  It is up to the helper
to print something useful, and if it didn't, it should be fixed.  So the
most important bug to fix here, IMHO, is figuring out why
git-remote-https died without printing an error message.

Is it possible to strace (or truss) the helper process? What it was
doing when it died may be helpful. Rather than picking through "strace
-f" output, you can use this hack to trace just the helper process:

  cat >/in/your/$PATH/git-remote-strace <<\EOF
  #!/bin/sh
  protocol=$(echo "$2" | cut -d: -f1)
  exec strace git-remote-$protocol "$@"
  EOF

  git clone strace::https://github.com/your/repo.git

-Peff
