From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [RFC/PATCH] Better control of the tests run by a test suite
Date: Mon, 24 Mar 2014 01:49:44 -0700
Message-ID: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 09:50:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS0aX-00040M-3w
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 09:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114AbaCXIuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 04:50:23 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:52107 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbaCXIuU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 04:50:20 -0400
Received: by mail-pd0-f173.google.com with SMTP id z10so5039890pdj.4
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 01:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=o/Zyie1fCQEBLI0ulq3yQeJhxfHl3F759zRjxNLfJu8=;
        b=BtjYgZb+ZhEf4PlxKVr0sti3C8sTOsRYOYdyRWAW+g3tV3PoxU6CwvE6ZCr4NCWO7Q
         rC44dE0DUG7lTDx+FbPF5h2QH1luQPcPdAq80v0WcEf5WaBdYafNSGQt/7w5Dh1uMOke
         6oyFn+Sqa9RXoVR1G3NjLB4gS8eLPG2vmXsJS8bWZ1CxC8pbaVJXrcBdWmXldsEhZhOu
         3AbfPlkc9edCiYxkz15vEr7xj01qSrItcMd2pE7GLTUgLmdq5Sri9OlxFrJ9tMuYhWj9
         heCPCM11I4PzzJP/JdBk3m9bQsOEVKeec604NOqyF7EG4YZ3wzyhSvU4bl1LEILFrqd+
         r02Q==
X-Received: by 10.67.22.100 with SMTP id hr4mr70290608pad.112.1395651020219;
        Mon, 24 Mar 2014 01:50:20 -0700 (PDT)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id vx10sm56423680pac.17.2014.03.24.01.50.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Mar 2014 01:50:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244812>

Hello,

This is a second attempt on a functionality I proposed in

    [PATCH 2/2] test-lib: GIT_TEST_ONLY to run only specific tests
    http://www.mail-archive.com/git%40vger.kernel.org/msg44828.html

except that the implementation is quite different now.

I hope that I have accounted for the comments that were voiced so
far.  Let's see :)

The idea behind the change is that sometimes it is convenient to
run only certain tests from a test suite.  Specifically I am
thinking about the following two use cases:

 1. You are developing new functionality.  You add a test that
    fails and then you add and modify code to make it pass.
    
 2. You have a failed test and you need to understand what is
    wrong.
    
In the first case you when you run the test suite, you probably
want to run some setup tests and then only one test that you are
focused on.

For code written in C time between you make a change and see a
test result is considerably increased by the compilation.  But
for script code turn around time is mostly due to the run time of
the test suite itself. [1]

For the second case you actually want the test suite to stop
after the failing test, so that you can examine the trash
directory without any modifications from the subsequent tests.
You probably do not care about them.

In the previous patch I've added an environment variable to
control tests to be run in a test suite.  I thought that it would
be similar to an already existing GIT_SKIP_TESTS.  As I did not
provide a cover letter that caused some misunderstanding I think.

This patch adds new command line argument '--run' that accepts a
list of patterns and restrictions on the test numbers that would
be included or excluded from this run of the test suite.

During discussion of the previous patch there were some talks
about extending GIT_SKIP_TESTS syntax.  In particular here:

> That is
> 
>         GIT_SKIP_TESTS='t9??? !t91??'
> 
> would skip nine-thousand series, but would run 91xx series, and all
> the others are not excluded.
> 
> Simple rules to consider:
> 
>  - If the list consists of _only_ negated patterns, pretend that
>    there is "unless otherwise specified with negatives, skip all
>    tests", i.e. treat GIT_SKIP_TESTS='!t91??' just the same way you
>    would treat GIT_SKIP_TESTS='* !t91??'.
> 
>  - The orders should not matter for simplicity of the semantics;
>    before running each test, check if it matches any negative (and
>    run it if it matches, without looking at any positives), and
>    otherwise check if it matches any positive (and skip it if it
>    does not).
> 
> Hmm?

    http://www.mail-archive.com/git%40vger.kernel.org/msg44922.html


I've used that as a basis, but the end result is somewhat
different.  Plus I've added boundary checks as in "<123".

Here are some examples of how functionality added by the patch
could be used.  In order to run setup tests and then only a
specific test (use case 1) one can do:

    $ ./t0000-init.sh --run='1 2 25'

or:

    $ ./t0000-init.sh --run='<3 25'

('<=' is also supported, as well as '>' and '>=').

In order to run up to a specific test (use case 2) one can do:

    $ ./t0000-init.sh --run='<=34'

or:

    $ ./t0000-init.sh --run='!>34'

Simple semantics described above is easy to implement, but at the
same time is probably not that convenient.  Rules implemented by
the patch are as follows:

 - Order does matter.  Whatever is specified on the right has
   higher precedence.

 - When the first pattern is positive the initial set of the
   tests to be run is empty.  You are adding to an empty set as
   in '1 2 25'.

   When the first pattern is negative the initial set of the
   tests to run contains all the tests.  You are subtracting
   from that set as in '!>34'.

It seems that for simple cases that gives simple syntax and is
almost unbiased if you think about preferring inclusion over
exclusion.  While it is unlikely it also allows for complicated
expressions.  And the implementation is quite simple as well.

Main functionality is in the third patch.  First two are just
minor fixes in related parts of the code.

P.S. I did not reply to the previous patch thread as this one is
quite different.


[1] Here are some times I see on Cygin:

    $ touch builtin/rev-parse.c
    
    $ time make
    ...
    
    real    0m10.382s
    user    0m3.829s
    sys     0m5.269s

Running the t0000-init.sh test suite is like this:

    $ time ./t0001-init.sh
    [...]
    1..36

    real    0m6.693s
    user    0m1.505s
    sys     0m3.937s

If I run only the 1, 2, 4 and 5th tests, it only half the time to
run the tests:

    $ time GIT_SKIP_TESTS='t0001.[36789] t0001.??' ./t0001-init.sh
    [...]
    1..36

    real    0m3.313s
    user    0m0.769s
    sys     0m1.844s 

Overall the change is from 17 to 14 seconds it is not that big.

If you only consider the test suite, as you do while you develop
an sh based tool, for example, the change is from 6.6 to 3.3
seconds.  That is quite noticeable.


 t/README         |   75 ++++++++++++--
 t/t0000-basic.sh |  296 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh    |   96 +++++++++++++++++-
 3 files changed, 454 insertions(+), 13 deletions(-)
