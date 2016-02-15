From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/3] config: add '--sources' option to print the
 source of a config value
Date: Mon, 15 Feb 2016 13:05:52 -0500
Message-ID: <20160215180552.GC26443@sigill.intra.peff.net>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com, Johannes.Schindelin@gmx.de,
	gitster@pobox.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 15 19:06:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVNX5-0004Zk-HR
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 19:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbcBOSFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 13:05:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:42253 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751389AbcBOSFz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 13:05:55 -0500
Received: (qmail 24405 invoked by uid 102); 15 Feb 2016 18:05:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 13:05:54 -0500
Received: (qmail 9883 invoked by uid 107); 15 Feb 2016 18:05:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 13:05:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 13:05:52 -0500
Content-Disposition: inline
In-Reply-To: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286220>

On Mon, Feb 15, 2016 at 11:17:43AM +0100, larsxschneider@gmail.com wrote:

> I like the idea of a "test set up block" within a test script. In order
> to clean up nicely before any subsequent tests I would like to propose
> a "tear down" block. Would that work as a compromise in our "test cases
> depend on earlier test cases" discussion?

I don't have any real problem with what you've written in the final
patch, but I also don't think it's accomplishing much (and is more lines
of code, and more running processes).

If you want to run test N without having run all of 1..N-1, what you
really want is some known, reliable state when that test starts. But the
tests before it do not necessarily know what that state is.  The best
they can do is roughly restore the original state before they ran. But:

  1. What does the state consist of? Which files (and their contents)
     are important to the test?

     In your tear-down you get rid of $INCLUDE_DIR, and you zero-out the
     config files. But you leave expect, output, output.raw, and the
     oddly named $CUSTOM_CONFIG_FILE. Nor do you clean up the
     environment variables.

     To be clear, I think it's perfectly fine to leave those. But you
     are still making assumptions about what the next test relies on.

  2. We may create a clean slate, but that is probably not what the next
     test wants. It will want to do its own setup. I.e., it will
     probably not want a blank .git/config, and will create it itself,
     just as you did in your setup step.

So rather than tearing down, I think we are better off trying to make
tests themselves (or blocks of them) set up their own assumptions. E.g.,
by overwriting files rather than appending to them. By using unique
filenames, commit messages, etc for their tests. That's less of a big
deal here, but in many tests that create commits, "test_commit foo"
would fail a second time, because there are no changes to "foo". Doing
"test_commit subdir/check-diff-in-subdir" is less likely to clash
without another test.

Sometimes we _are_ better off with a teardown step, because subsequent
tests would not reasonably think to clear some state we've set (e.g., in
non-config tests, if we set some random config variable, we use
test_config to tear it down afterwards rather than have each test clean
out all of the config). So there's definitely a subjective judgement
call on what is "reasonable" there. But I find it unlikely that your
tear-down will help anybody in this case. Further tests will not care
about $INCLUDE_DIR unless they reference it, and any further tests would
set up their own .git/config, etc.

-Peff
