From: larsxschneider@gmail.com
Subject: [PATCH v4 0/4] Add Travis CI support
Date: Fri,  6 Nov 2015 09:58:39 +0100
Message-ID: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com>
Cc: sunshine@sunshineco.com, sschuberth@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, avila.jn@gmail.com, luke@diamand.org,
	dturner@twopensource.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 09:59:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZucrK-0007cS-Cq
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 09:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032802AbbKFI6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 03:58:48 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34928 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031997AbbKFI6r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 03:58:47 -0500
Received: by wicll6 with SMTP id ll6so25748980wic.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 00:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NGjbU874rjDlobT3nPRSOvinpZVAsCRRfWkzxdj+MgY=;
        b=EWsS42wPoFflaFlgs2hrLj2X2+GzVn5JzaHT+KkKl9T1+epIvk5XTg5CN1WjjitoZ9
         LKHHHnXumoXCGwzMkXLY5SRMD505M2tRscXeRpfU2YSgawZD3/jrogaPSBxbzl2A+nXu
         jozCDwWwRpoMmyvaay+S7iOBxNt9Mnzbg1XTEdSc4ZXQVpjy1hDDXY1ger3BxDeTeRQN
         oxvind/rirMFw+wfZ/mIJDgT2iBrx8RI1DiNr14j/QNId9gMqxxL9PSHoaAjmtwPRFcX
         nBJFrs7DW0GaKxnNtWSBl2rtzn/1nUaa6b01xeOcqcBtjWo2ScSrEOnhaks8EY4U8gQC
         G6CA==
X-Received: by 10.194.80.42 with SMTP id o10mr12829614wjx.31.1446800326129;
        Fri, 06 Nov 2015 00:58:46 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB59AE.dip0.t-ipconnect.de. [93.219.89.174])
        by smtp.gmail.com with ESMTPSA id cr5sm11098003wjb.16.2015.11.06.00.58.44
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Nov 2015 00:58:45 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280963>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v3:
* Removed git-p4 OS X test fixes and submitted them in a separate roll as
  request by Junio [1].
* Fix brew formula typo.
  (thanks Eric)
* Move "make configure && ./configure" from "install" to "before_script" phase.
  (thanks Sebastian)
* Run a build configuration with all kinds of "NO_*" flags. I don't understand
  all of them. Please let me know if some of them don't make sense. I also
  noticed that "NO_ICONV" will cause various tests to fail [2]. Is this a bug
  that should be fixed as part of this roll? If this is no bug, would it make
  sense to remove this flag?
  (thanks Junio, Matthieu)
* Run make with multiple jobs. I found that -j2 is the fastest for building
  git on Travis. -j6 is the fastest to run the unit tests. I limited that to
  -j3 because I had the impression that I got more test failures with higher
  utilization.
  (thanks Jean-Noel, Matthieu)
* Run Linux builds on new Travis CI container infrastructure .
  (thanks Matthieu)
* Print Perforce/Git-LFS binary versions
* Run tests with test extension flags enabled. Unfortunately "GIT_TEST_LONG"
  caused "t0021" to fail on Linux [3]. I wasn't able to reproduce this on my
  local machine, yet. Ideas anyone? Furthermore "GETTEXT_POISON" causes a bunch
  of failed tests on Linux and OS X [4]. Is this intentional or a bug?
* Print verbose output of failed tests in the "after_failure" phase. Please
  note the little triangle on the left in the TravisCI log to expand the failed
  test output.
* Update LFS to 1.0.2
* Accept SIGPIPE output in some tests (similar to [5] by Junio)
* Make git-p4 tests more robust with a general timeout and retry logic for
  cleanup commands (I now the "rm" and "mkdir" retry looks stupid but I was
  able to reproduce this error on TravisCI consistently - does anyone have
  a possible explanation why this could be necessary? Open file handles?)
* Disable email notifications (at least initially). I found and fixed a few
  issues that caused flaky tests. However, I expect there are more and we can
  only find them over time. If you add this patch then TravisCI can run
  silently in the background. If people want to look at the TravisCI result
  then they can. All other people are not bothered by emails. If we find in
  six months from now that TravisCI has too many false failures then we could
  remove the .travis.yml, again, and move on.

I had to apply this patch on master to get David Turner's fix for flaky
t7063 [6]/[7].

You can find the TravisCI run for this roll here:
https://travis-ci.org/larsxschneider/git/builds/89598194

Cheers,
Lars

[1] http://thread.gmane.org/gmane.comp.version-control.git/279348/focus=279362
[2] https://travis-ci.org/larsxschneider/git/builds/89555114
[3] https://travis-ci.org/larsxschneider/git/builds/89554983
[4] https://travis-ci.org/larsxschneider/git/builds/89554899
[5] http://thread.gmane.org/gmane.comp.version-control.git/280120/focus=280543
[6] http://thread.gmane.org/gmane.comp.version-control.git/279647
[7] http://thread.gmane.org/gmane.comp.version-control.git/279889

Lars Schneider (4):
  add function test_must_fail_or_sigpipe and use it to fix flaky tests
  git-p4: add p4d timeout in tests
  git-p4: retry kill/cleanup operations in tests with timeout
  Add Travis CI support

 .travis.yml                     | 131 ++++++++++++++++++++++++++++++++++++++++
 t/lib-git-p4.sh                 |  51 +++++++++++++---
 t/t5504-fetch-receive-strict.sh |   3 +-
 t/t5516-fetch-push.sh           |   8 +--
 t/test-lib-functions.sh         |  23 +++++++
 5 files changed, 201 insertions(+), 15 deletions(-)
 create mode 100644 .travis.yml

--
2.5.1
