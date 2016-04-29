From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 1/4] rev-parse: fix some options when executed from subpath of main tree
Date: Fri, 29 Apr 2016 16:21:31 +0200
Message-ID: <20160429142131.16282-1-szeder@ira.uka.de>
References: <1461361992-91918-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	gitster@pobox.com, sunshine@sunshineco.com, pclouds@gmail.com,
	git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 16:22:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw9Ip-00030a-27
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 16:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbcD2OVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 10:21:51 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:57451 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753094AbcD2OVv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2016 10:21:51 -0400
Received: from x590cc487.dyn.telefonica.de ([89.12.196.135] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aw9Ia-0001dk-NI; Fri, 29 Apr 2016 16:21:42 +0200
X-Mailer: git-send-email 2.8.1.404.g5513ce8
In-Reply-To: <1461361992-91918-2-git-send-email-rappazzo@gmail.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1461939702.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293001>

[Resend to list, sorry for the duplicates.]

> Executing `git-rev-parse` with `--git-common-dir`, `--git-path <path>`,
> or `--shared-index-path` from the root of the main worktree results in
> a relative path to the git dir.
> 
> When executed from a subdirectory of the main tree, however, it incorrectly
> returns a path which starts 'sub/path/.git'.

This is not completely true, because '--git-path ...' returns a
relative path starting with '.git':

  $ git -C t/ rev-parse --git-dir --git-path objects --git-common-dir
  /home/szeder/src/git/.git
  .git/objects
  t/.git

It's still wrong, of course.

> Change this to return the
> proper relative path to the git directory.

I think returning absolute paths would be better.  It is consistent
with the already properly working '--git-dir' option, which returns an
absolute path in this case.  Furthermore, both '--git-path ...' and
'--git-common-dir' already return absolute paths when run from a
subdirectory of the .git directory:

  $ git -C .git/refs rev-parse --git-dir --git-path objects --git-common-dir
  /home/szeder/src/git/.git
  /home/szeder/src/git/.git/objects
  /home/szeder/src/git/.git

> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
>  builtin/rev-parse.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

This patch doesn't add any new tests, while subsequent patches of the
series do nothing but add more tests.  Splitting up your changes this
way doesn't add any value, it only increases the number of commits.  I
think either:

  - all those new tests could be added with this patch, or

  - if you want to add the test separately, then add them before
    this patch and mark them with 'test_expect_failure' to clearly
    demonstrate what the series is about to fix, and flip them to
    'test_expect_success' in this patch.

  - An alternative way to split this series, following the "Make
    separate commits for logically separate changes" guideline, would
    be to fix and test these options in separate patches, i.e. fix and
    test '--git-path ...' in one patch, then fix and test
    '--git-common-dir' in the next, ...
