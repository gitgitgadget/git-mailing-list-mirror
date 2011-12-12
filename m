From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] test-terminal: give the child an empty stdin TTY
Date: Mon, 12 Dec 2011 13:05:53 -0600
Message-ID: <20111212190553.GJ31793@elie.hsd1.il.comcast.net>
References: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch>
 <20111212181915.GD31793@elie.hsd1.il.comcast.net>
 <201112121934.40953.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Dec 12 20:06:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaBCR-0004Yd-Si
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 20:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab1LLTGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 14:06:04 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41750 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365Ab1LLTGB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 14:06:01 -0500
Received: by ggdk6 with SMTP id k6so1468917ggd.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 11:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RRUBe2zsOzjGOiZgtthscfvcvy7XpJWuvRmd7sqELnQ=;
        b=AzGR1XMqCRiFnMHclrMQtHnjf4RWuhe00vYxYB36r1Q4yL8s8rbiwuZE0x/9OofQQF
         wqlKKzfcTGvyWSD8qyk2/f7ChGe4PByAbwHMiqEIGksOQx3dquO1lbj1LXCrIeLdyzWd
         7qGHCPdOGhTJIy3d8/RydSXEsQwz4KakCJbvg=
Received: by 10.100.130.14 with SMTP id c14mr4528831and.114.1323716760417;
        Mon, 12 Dec 2011 11:06:00 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id n24sm10692311yhj.13.2011.12.12.11.05.59
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Dec 2011 11:05:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201112121934.40953.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186932>

Thomas Rast wrote:

> I'm not sure I understand what you are arguing for or why.  That I
> avoid wasting a Pty, and only replace stdin with /dev/null?

Sorry, I was thinking narrowly about the "git log" tests in
t7006-pager.sh.  I was saying that there, the fact that
lib-terminal.sh creates an environment in which stdin is not
guaranteed to be a terminal is a feature, not a bug, since it improves
the test coverage (and I tend to find the "stdin not a tty" case more
interesting).

That said, a test for the implicit HEAD behavior of "git shortlog"
would be a welcome addition to t4201-shortlog.sh, and we might need a
helper "test_with_stdin_as_a_terminal" for that.

The tests you mentioned in t7006 are just buggy --- it was just meant
to make sure we don't regress in the change introduced by 773b69bf
("shortlog: run setup_git_directory_gently() sooner"), and I doubt I
was thinking about the "implicit HEAD when stdin is a tty" behavior at
all.  So independently of everything else, I believe we should do the
following.

-- >8 --
Subject: test: do not let "git shortlog" DWIM based on tty

In the spirit of v1.7.3.3~14^2 (t4203: do not let "git shortlog" DWIM
based on tty, 2010-10-19), do not leave out the revision argument to
"git shortlog" and rely on the default of HEAD in the usual case that
standard input is not connected to a terminal.  Otherwise, tests break
when you do

  git rev-list <range> |
  while read sha; do
    git checkout sha
    make test
  done

Reported-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7006-pager.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 320e1d1d..6f05b11a 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -409,14 +409,14 @@ test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p'
 
 test_doesnt_paginate      expect_failure test_must_fail 'git -p nonsense'
 
-test_pager_choices                       'git shortlog'
+test_pager_choices                       'git shortlog HEAD'
 test_expect_success 'setup: configure shortlog not to paginate' '
 	git config pager.shortlog false
 '
-test_doesnt_paginate      expect_success 'git shortlog'
-test_no_local_config_subdir expect_success 'git shortlog'
-test_default_pager        expect_success 'git -p shortlog'
-test_core_pager_subdir    expect_success 'git -p shortlog'
+test_doesnt_paginate      expect_success 'git shortlog HEAD'
+test_no_local_config_subdir expect_success 'git shortlog HEAD'
+test_default_pager        expect_success 'git -p shortlog HEAD'
+test_core_pager_subdir    expect_success 'git -p shortlog HEAD'
 
 test_core_pager_subdir    expect_success test_must_fail \
 					 'git -p apply </dev/null'
-- 
1.7.8
