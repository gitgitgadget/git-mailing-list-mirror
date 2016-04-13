From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1500-rev-parse: rewrite each test to run in isolation
Date: Wed, 13 Apr 2016 14:29:29 -0400
Message-ID: <20160413182928.GA31787@sigill.intra.peff.net>
References: <1460200767-32864-1-git-send-email-rappazzo@gmail.com>
 <1460200767-32864-2-git-send-email-rappazzo@gmail.com>
 <CAPig+cT8oD1jJdDrk+YPoquGfTh6m3m-ha0J+er42jOoxnVxzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Rappazzo <rappazzo@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 20:29:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqPXk-0003YG-Lf
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 20:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990AbcDMS3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 14:29:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:48923 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754922AbcDMS3c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 14:29:32 -0400
Received: (qmail 24813 invoked by uid 102); 13 Apr 2016 18:29:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Apr 2016 14:29:31 -0400
Received: (qmail 20829 invoked by uid 107); 13 Apr 2016 18:29:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Apr 2016 14:29:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Apr 2016 14:29:29 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cT8oD1jJdDrk+YPoquGfTh6m3m-ha0J+er42jOoxnVxzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291475>

On Wed, Apr 13, 2016 at 12:54:16AM -0400, Eric Sunshine wrote:

> > -# label is-bare is-inside-git is-inside-work prefix git-dir absolute-git-dir
> > +test_expect_success '.git/: is-inside-git-dir' '
> > +       (cd .git && test true = "$(git rev-parse --is-inside-git-dir)")
> 
> Simpler:
> 
>     test true = "$(git -C .git rev-parse --is-inside-git-dir)"

While we are modernizing, I wonder if it is a good idea to drop the use
of "test" for string comparisons here. We usually save output to a file
and use test_cmp, for two reasons:

  1. It tests the exit code of the command substitution.

  2. It's easier to debug when it goes wrong (the test produces useful
     output, and the state is left in the filesystem).

It is more verbose to do so, but we could easily wrap that in:

  test_stdout "true" git -C .git rev-parse --is-inside-git-dir

or something. The other problem is that it uses an extra process to do
the test_cmp, which might make the tests slower (especially on Windows).
We could do something like:

  test_stdout () {
          expect=$1; shift
	  if ! actual=$("$@")
	  then
		echo >&2 "test_stdout: command failed: $*"
		return 1
	  fi
	  if test "$expect" != "$actual"
	  then
	          echo >&2 "test_stdout: unexpected output for $*"
		  echo >&2 "test_stdout: $expect != $actual"
		  return 1
	  fi
	  return 0
  }

which is more thorough without incurring extra processes (we lose the
nice diff output of test_cmp, but since this interface is only useful
for short outputs anyway, I don't think that's a big deal.

-Peff
