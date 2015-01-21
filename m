From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] setting ulimit in test suite broken for me
Date: Wed, 21 Jan 2015 14:03:49 -0500
Message-ID: <20150121190348.GA29891@peff.net>
References: <1421866746-29444-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, jeanjacques.lafay@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 20:03:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0ZK-0006hn-Eo
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbbAUTDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 14:03:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:36893 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752466AbbAUTDu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:03:50 -0500
Received: (qmail 23167 invoked by uid 102); 21 Jan 2015 19:03:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jan 2015 13:03:50 -0600
Received: (qmail 31704 invoked by uid 107); 21 Jan 2015 19:04:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jan 2015 14:04:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2015 14:03:49 -0500
Content-Disposition: inline
In-Reply-To: <1421866746-29444-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262744>

On Wed, Jan 21, 2015 at 10:59:06AM -0800, Stefan Beller wrote:

> so I wanted to create a new test for large transactions, which should look like:
> 
> 	run_with_limited_open_files () {
> 		(ulimit -n 64 && "$@")
> 	}
> 
> 	test_lazy_prereq ULIMIT 'run_with_limited_open_files true'
> 
> 	test_expect_success ULIMIT 'large transaction creating branches does not burst open file limit' '
> 	(
> 		echo $(ulimit -n)
> 		for i in $(seq 65)
> 		do
> 			echo "create refs/heads/$i HEAD"
> 		done >large_input &&
> 		git update-ref --stdin <large_input &&
> 		git rev-parse --verify -q refs/heads/65
> 	)
> 	'
> 
> Mind the "echo $(ulimit -n)" in there as a debugging output.
> So if I run the test with "-d -v" to actually see the debugging output,
> I see ulimit -n set to 32768 instead of the desired 64.

You define run_with_limited_open_files, which starts a subshell, drops
the limit inside the subshell, and then spawns the child. But you never
call it in the test. Were you expecting that tests with the ULIMIT
prereq to automatically respect the limit? The prereq is just about
checking whether we can set the ulimit at all.

Try:

  run_with_limited_open_files ulimit -n

in your debugging statement (and of course use run_with... for the
actual git command you want to limit).

-Peff
