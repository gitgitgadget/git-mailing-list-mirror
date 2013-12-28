From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] t0000: set TEST_OUTPUT_DIRECTORY for sub-tests
Date: Sat, 28 Dec 2013 14:13:13 -0800
Message-ID: <20131228221313.GB5544@google.com>
References: <20131228092731.GA26337@sigill.intra.peff.net>
 <20131228092915.GA21109@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Thomas Rast <tr@thomasrast.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 28 23:13:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vx28K-0005a0-Dd
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 23:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab3L1WNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 17:13:19 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:54002 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab3L1WNS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 17:13:18 -0500
Received: by mail-yh0-f50.google.com with SMTP id b6so2164997yha.23
        for <git@vger.kernel.org>; Sat, 28 Dec 2013 14:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jJAQLFy6Vdut8y4xzI2Azk6SH3NMH9RGlngK1/HgL/I=;
        b=Dgyk/anPWyrlFSpSstRNQvJ7jTzDaXnmefA4dJ8QI6QPQ+lcChdVz6Y1lA5rCVh38f
         dWrFKHjFBbf0P6/MJ/A743a5H17KFMrH7Kec5zG4RcYnw6YpvQtPVOHzakmnfi/AwYW6
         DzrvxHpvspmLxBhxX5CYEA3W85+ZqZrAJeW51TJFdB0uA9MD/yd63A8RzjuodZmkXrr1
         Dg9PPzVyIi0e5pfcizkEZIf+1v6s7K0r6GGjUuUhauabkxU4TswxhFGd0XJ51Nk6Kofu
         ZlYCCWVNqk+ujwdmU2ZvZDccKDcHuJkyaSCn0NszBP3+p9da6caie2SlcWGkkFITfqkX
         o3qw==
X-Received: by 10.236.85.237 with SMTP id u73mr14093503yhe.67.1388268797645;
        Sat, 28 Dec 2013 14:13:17 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 9sm53439689yhe.21.2013.12.28.14.13.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 28 Dec 2013 14:13:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131228092915.GA21109@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239790>

Hi,

Jeff King wrote:

> Once upon a time, the test-lib library would create trash
> directories in the current working directory, unless we were
> explicitly told to put it elsewhere via --root. As a result,
> t0000 created the sub-test trash directories inside its own
> trash directory.
>
> However, we noticed that this did not cover all cases, since
> we would need to respect $TEST_OUTPUT_DIRECTORY even if
> --root is not given (or is relative). Commit 38b074d fixed
> this to consistently use the full path.

So the idea if I am reading correctly is "Instead of relying on the
implicit output directory chosen with chdir, which doesn't even work
any more, set TEST_OUTPUT_DIRECTORY to decide where output for the
sub-tests used by t0000's sanity checks for the test harness go".

I'm not sure I completely understand the regression caused by 38b074d.
Is the idea that before that commit, TEST_OUTPUT_DIRECTORY was only
used for the test-results/ directory so the only harm done was some
mixing of test results?

What is the symptom this patch alleviates?

> As a result, t0000's sub-tests are now created in git's
> original test output directory rather than in our trash
> directory.

This might be the source of my confusion.  Is "sub-tests" an
abbreviation for "sub-test trash directories" here?

>            Furthermore, since some of the sub-tests simulate
> failures, the trash directories do not get cleaned up, and
> the cruft is left in the t/ directory.
>
> We could fix this by passing a new "--root=$TRASH_DIRECTORY"
> option to the sub-test. However, we do not want the sub-tests
> to write anything at all to git's directory (e.g., they
> should not be writing to t/test-results, either, although
> this is already handled by separate code).

Ah, HARNESS_ACTIVE prevents output of test-results.

Does the git test harness write something else to
TEST_OUTPUT_DIRECTORY?  Is the idea that using --root would be
functionally equivalent but (1) more confusing and (2) less
futureproof?

>                                            So the best
> solution is to simply reset $TEST_OUTPUT_DIRECTORY entirely
> in the sub-test, which covers this case, as well as any
> future ones.

So, to sum up: if I understand correctly

 - git used to only use TEST_OUTPUT_DIRECTORY to decide where test
   results go.  You'd have to use --root to set a custom location for
   trash directories.

 - in that old setup, t0000 leaves around extra trash directories with
   --root, since the sub-tests inherit the parent test's $root and put
   trash directories there.

 - after 38b074d, that old problem still exists and furthermore
   t0000 leaves around extra trash directories even when --root is not
   in use, since the sub-tests inherit the value of
   TEST_OUTPUT_DIRECTORY from the parent test.

 - this patch fixes the TEST_OUTPUT_DIRECTORY problem (but not the $root
   problem) by setting TEST_OUTPUT_DIRECTORY explicitly

Does that sound right?  If so, should sub-tests unset $root, too?

Thanks and hope that helps,
Jonathan
