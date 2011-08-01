From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v11 0/7] bisect: Add support for --no-checkout option.
Date: Mon,  1 Aug 2011 21:56:10 +1000
Message-ID: <1312199777-10144-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 13:57:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnr7X-00062W-VF
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 13:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab1HAL5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 07:57:05 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:36433 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab1HAL4v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 07:56:51 -0400
Received: by yia27 with SMTP id 27so3374383yia.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 04:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=PsIxC3M87VzWEREs5rOvubP61ROU7ZkIbwCGbv8Wqk4=;
        b=Dk37wUfX8GmTMFbsiq28esj4m+Gx9wfGT3S1VcyxmbpGCZFxjNRVKU21k0a9+ww5Ow
         VMhjN7yxNTg9/pyMs79bXVpSZouJOzhbcxRX6Fo4s0b3RjkdBoRN1WR9y6iGuWraZ7mD
         Bmyp0WFpEOrwPnrz+1u06QdewmNVeYDm0I4mk=
Received: by 10.142.7.3 with SMTP id 3mr3033284wfg.137.1312199810710;
        Mon, 01 Aug 2011 04:56:50 -0700 (PDT)
Received: from localhost.localdomain ([120.16.6.238])
        by mx.google.com with ESMTPS id a4sm3060009wfm.4.2011.08.01.04.56.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 04:56:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g0c69b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178335>

Motivation
----------
For some bisection tasks, checking out the commit at each stage of the bisection process is unecessary or undesirable.

This series adds support for a --no-checkout option to git-bisect.

If specified on a start command, --no-checkout causes 'git bisect' to update HEAD at each stage of the bisection process instead of checking out the commit at that point. 

One application of the --no-checkout option is to find, within a partially damaged repository, a commit that has at least one parent whose graph is fully reachable in the sense of 'git pack-objects'.

For example:

	git bisect start HEAD <some-known-good-commit> <boundary-commits> --no-checkout
	git bisect run eval '
		rc=1;
		if git rev-list --objects HEAD >tmp.$$; then
		   git pack-objects --stdout >/dev/null < tmp.$$ && rc=0;
		fi;
		rm tmp.$$;
		test $rc -eq 0;'

<some-known-good-commit> is a known good commit, for which the test passes.
<boundary-commits> are commits chosen to prevent the bisection visiting missing or corrupt commit objects.

Assuming this git bisect run completes successfully, bisect/bad will refer to a commit which has at least one parent that is fully reachable in the sense of 'git pack-objects'.

Patch Synopsis
--------------
Patch 1/7 - "bisect: move argument parsing before state modification." - changes existing behaviour in the case that an invalid revision argument is supplied to 'git bisect start'. In particular, in this case, bisection state is neither created or modified if argument validation fails. Previously, existing bisection state would be cleared even if the revision arguments were subsequently determined to be invalid.
Patch 2/7 remediates a potential flaw that might hide a failure in a chain of pasted statements.
Patch 3/7 adds a test which documents the existing behaviour of git bisect in the presence of tree damage.
Patch 4/7 modifies the C code that supports bisection.
Patch 5/7 modifies porcelain to enable option exposed by 4/7.
Patch 6/7 adds some tests.
Patch 7/7 adds some documentation.

Revision History
----------------
v11:
	Removed support for --update-ref=<ref>, per Junio's preference.
v10:
	Changed the way deferred statements are connected. Reverted some whitespace minimization.
v8:
	Further feedback from Christian Couder. Support --update-ref <ref>.
v6: 
	This series includes numerous improvements suggested by Christian Couder.
Reworks: 
	"bisect: allow git bisect to be used with repos containing damaged trees." 
	Replaced --ignore-checkout-failure with --no-checkout option suggested by Junio.

Jon Seymour (7):
  bisect: move argument parsing before state modification.
  bisect: use && to connect statements that are deferred with eval.
  bisect: add tests to document expected behaviour in presence of
    broken trees.
  bisect: introduce support for --no-checkout option.
  bisect: introduce --no-checkout support into porcelain.
  bisect: add tests for the --no-checkout option.
  bisect: add documentation for --no-checkout option.

 Documentation/git-bisect.txt |   32 ++++++++++-
 bisect.c                     |   32 +++++++----
 bisect.h                     |    2 +-
 builtin/bisect--helper.c     |    7 ++-
 git-bisect.sh                |  104 ++++++++++++++++++++-------------
 t/t6030-bisect-porcelain.sh  |  132 +++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 249 insertions(+), 60 deletions(-)

-- 
1.7.6.352.g0c69b
