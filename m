From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix unclosed here document in t3301.sh
Date: Thu, 22 Jan 2015 07:38:52 -0500
Message-ID: <20150122123851.GA19681@peff.net>
References: <20150122115936.GA2358@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 13:38:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEH2I-00056t-F7
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 13:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbbAVMiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 07:38:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:37262 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751146AbbAVMix (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 07:38:53 -0500
Received: (qmail 16388 invoked by uid 102); 22 Jan 2015 12:38:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jan 2015 06:38:53 -0600
Received: (qmail 8831 invoked by uid 107); 22 Jan 2015 12:39:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jan 2015 07:39:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jan 2015 07:38:52 -0500
Content-Disposition: inline
In-Reply-To: <20150122115936.GA2358@camk.edu.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262824>

On Thu, Jan 22, 2015 at 12:59:36PM +0100, Kacper Kornet wrote:

> Commit 908a3203632a02568df230c0fccf9a2cd8da24e6 introduced  indentation
> to here documents in t3301.sh. However in one place <<-EOF was missing
> -, which broke this test when run with mksh-50d. This commit fixes it.

This is definitely the right direction, but I was a little surprised it
worked at all on other shells! Both bash and dash end the here-doc at
the end of the input (in this case the end of the eval string). They end
up sucking the EOF and the follow-on commands into the here-doc, and the
test literally does nothing except the call to cat.

Bash does print a warning in this case. It would be nice to upgrade it
to an error (so at least bash users could easily detect the buggy
script), but I don't see any way to do so. I guess running with mksh is
a good substitute. :)

However, in most such instances of this problem, the shell will notice
and barf, because it syntactically expects more on the next line:

  $ sh -c '
    cat >foo <<EOF &&
    whatever
    EOF
    do_something
  '
  sh: 6: Syntax error: end of file unexpected

So the problem in this instance is that the here-doc marker is wrong
_and_ the test accidentally broke the &&-chaining:

>  test_expect_success '--no-standard-notes' '
> -	cat >expect-commits <<EOF
> +	cat >expect-commits <<-EOF

The ideal line here would be:

  cat >expect-commits <<-EOF &&

-Peff
