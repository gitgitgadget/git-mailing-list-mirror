From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [RFC/PATCH 0/3] Teach revert/cherry-pick the --no-verify option
Date: Fri, 05 Sep 2014 23:05:28 +0200
Message-ID: <540A2598.8000101@gmail.com>
References: <1409753034-9459-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Lars_Gullik_Bj=F8nnes?= <larsbj@gullik.org>,
	Junio C Hamano <gitster@pobox.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johan Herland <johan@herland.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 23:05:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ0hN-0004HX-Ny
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 23:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbaIEVFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 17:05:34 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:48483 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbaIEVFd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 17:05:33 -0400
Received: by mail-la0-f43.google.com with SMTP id gi9so3522478lab.16
        for <git@vger.kernel.org>; Fri, 05 Sep 2014 14:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=JsUZVLu+ZoYFmDMDt66ORN9q9oFon4UWvtnOlBgE+4U=;
        b=v4/+VsfYSK+EwdRtdnoZcNc0N7obD0PJR14SM+oKOhTrAC7cFy2QmtN7W4mxGIEF3O
         2QPoj9NFU3wKubiXcojHWe8rTSJlics7vbwb1TkIcI0KJd+ltEKFKRN62TBTtGuussl6
         MiNQuGyfreq1aL2ciBiskVrY2QcOFlJGR5a+1tz8swLGtqr3jBCN+AsiF0f5L1kPNFvA
         Crlo/craU/Y6a6xAwy/PNTU290c6OCAZGiwvlHlG1KMLpbqVI8XXi81fm6GW46jw4C+7
         7ub0Bb86WggnBZKTIWFTPYPG6yBf/Re16kWXZbeziLmaseLjSyMJqBKkxFRjZ022fpKL
         F9eg==
X-Received: by 10.152.18.166 with SMTP id x6mr14259078lad.1.1409951131596;
        Fri, 05 Sep 2014 14:05:31 -0700 (PDT)
Received: from client.googlemail.com (putty.olf.sgsnet.se. [46.239.119.252])
        by mx.google.com with ESMTPSA id js10sm1030098lab.23.2014.09.05.14.05.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 05 Sep 2014 14:05:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1409753034-9459-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256541>

Hi Johan,

Johan Herland writes:
> A colleague of mine noticed that cherry-pick does not accept the
> --no-verify option to skip running the pre-commit/commit-msg hooks.

neither git-cherry-pick nor git-revert execute the pre-commit or
commit-msg hooks at the moment. The underlying rationale can be found in
the log message of commit 9fa4db5 ("Do not verify
reverted/cherry-picked/rebased patches."). Indeed, the sequencer uses
git-commit internally which executes the two verify hooks by default.
However, the particular command line being used implicitly specifies the
--no-verify option. This behaviour is implemented in
sequencer.c#run_git_commit as well, right before the configurable
git-commit options are handled. I guess that's easily overlooked since
the documentation doesn't mention it and the implementation uses the
short version -n of --no-verify.

The reasons why the new test cases succeed nonetheless are manifold. I
hope they're still understandable even though I don't put the comments
next to the code.

The "revert with failing hook" test case fails if run in isolation,
which can be achieved by using the very cool --run option of test-lib.
More specifically, git-revert does not fail because it executes the
failing hook but because the preceding test case leaves behind an
uncommitted index.

In the "cherry-pick with failing hook" test case, git-cherry-pick really
fails because it doesn't know the --no-verify option yet, which
presumably ended up there only by accident. This test case is
meaningless if run in isolation because it assumes that "revert with
failing hook" creates a commit (else HEAD^ points nowhere).

I like your patchset for that it makes it explicit in both the
documentation and the tests whether the commits resulting from
cherry-picks are being verified or not.

Kind regards,
   Fabian

> Here's a first attempt at adding --no-verify to the revert/cherry-pick.
> 
> Have fun! :)
> 
> ...Johan
> 
> Johan Herland (3):
>   t7503/4: Add failing testcases for revert/cherry-pick --no-verify
>   revert/cherry-pick: Add --no-verify option, and pass it on to commit
>   revert/cherry-pick --no-verify: Update documentation
> 
>  Documentation/git-cherry-pick.txt |  4 ++++
>  Documentation/git-revert.txt      |  4 ++++
>  Documentation/githooks.txt        | 20 ++++++++++----------
>  builtin/revert.c                  |  1 +
>  sequencer.c                       |  7 +++++++
>  sequencer.h                       |  1 +
>  t/t7503-pre-commit-hook.sh        | 24 ++++++++++++++++++++++++
>  t/t7504-commit-msg-hook.sh        | 24 ++++++++++++++++++++++++
>  8 files changed, 75 insertions(+), 10 deletions(-)
