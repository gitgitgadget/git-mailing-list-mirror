From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v14 0/8] bisect: Add support for --no-checkout option
Date: Wed,  3 Aug 2011 08:15:54 +1000
Message-ID: <1312323362-20096-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 00:16:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoNGK-0003t3-8t
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 00:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728Ab1HBWQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 18:16:21 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:47511 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611Ab1HBWQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 18:16:16 -0400
Received: by pzk37 with SMTP id 37so375496pzk.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 15:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=+/9MIDldAaGTMXA98d34+6mH4Y8clUf00hpehAg+CCE=;
        b=wh/1mBrHWdboYTQUVMBVvQgqjmkctySqGEKPGu232NHf3bGxzKkNF+H8Jsl7NuebBX
         X/UhtZg/HeUWg6VMl2Py9WR6ZqWoXCJn/GxBFtS2W1FsiapU9IvzltHEiy9g8fOmm9HT
         G2kpyQvq/x0/w+JItmC9SztZqgg9yaSBsmt8M=
Received: by 10.68.58.197 with SMTP id t5mr20218pbq.480.1312323375176;
        Tue, 02 Aug 2011 15:16:15 -0700 (PDT)
Received: from localhost.localdomain ([120.16.93.94])
        by mx.google.com with ESMTPS id d3sm269987pbg.44.2011.08.02.15.16.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 15:16:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.353.gb3ae7e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178519>

Motivation
==========
For some bisection tasks, checking out the commit at each stage of the bisection process is unecessary or undesirable.

This series adds support for a --no-checkout option to git-bisect.

If specified on a start command, --no-checkout causes 'git bisect' to update HEAD at each stage of the bisection process instead of checking out the commit at that point. 

One application of the --no-checkout option is to find, within a partially damaged repository, a commit that has at least one parent whose graph is fully reachable in the sense of 'git pack-objects'.

For example:

	git bisect start BISECT_HEAD <some-known-good-commit> <boundary-commits> --no-checkout
	git bisect run eval '
		rc=1;
		if git rev-list --objects BISECT_HEAD >tmp.$$; then
		   git pack-objects --stdout >/dev/null < tmp.$$ && rc=0;
		fi;
		rm tmp.$$;
		test $rc -eq 0;'

<some-known-good-commit> is a known good commit, for which the test passes.
<boundary-commits> are commits chosen to prevent the bisection visiting missing or corrupt commit objects.

Assuming this git bisect run completes successfully, bisect/bad will refer to a commit which has at least one parent that is fully reachable in the sense of 'git pack-objects'.

Patch Synopsis
==============

Remediation
-----------
Patch 1/8 changes existing behaviour in the case that an invalid revision argument is supplied to 'git bisect start'. In particular, in this case, bisection state is neither created or modified if argument validation fails. Previously, existing bisection state would be cleared even if the revision arguments were subsequently determined to be invalid. 	

Patch 2/8 remediates a potential flaw that might hide a failure in a chain of pasted statements.

Patch 3/8 adds a test which documents the existing behaviour of git bisect in the presence of tree damage.

New Function
------------
Patch 4/8 modifies the C code that supports bisection.
Patch 5/8 modifies porcelain to enable option exposed by 4/8.
Patch 6/8 adds some tests.
Patch 7/8 adds some documentation.
Patch 8/8 --no-checkout bisections now update BISECT_HEAD rather than HEAD.

Revision History
----------------
v14:
	Reverted --bisect-mode aspect of v13 change so C code matches v11.
v13:
	Following suggestions from Junio:
	 * Replaced BISECT_NO_CHECKOUT control file with BISECT_MODE. 
	 * Changed name of internal option on bisect--helper from --no-checkout to --bisect-mode=checkout|update-ref.
	 * Changed --no-checkout bisections to update BISECT_HEAD instead of HEAD.	
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

Jon Seymour (8):
  bisect: move argument parsing before state modification.
  bisect: use && to connect statements that are deferred with eval.
  bisect: add tests to document expected behaviour in presence of
    broken trees.
  bisect: introduce support for --no-checkout option.
  bisect: introduce --no-checkout support into porcelain.
  bisect: add tests for the --no-checkout option.
  bisect: add documentation for --no-checkout option.
  bisect: change bisect function to update BISECT_HEAD, rather than
    HEAD.

 Documentation/git-bisect.txt |   32 ++++++++++-
 bisect.c                     |   33 +++++++----
 bisect.h                     |    2 +-
 builtin/bisect--helper.c     |    7 ++-
 git-bisect.sh                |  113 ++++++++++++++++++++++--------------
 t/t6030-bisect-porcelain.sh  |  132 +++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 258 insertions(+), 61 deletions(-)

-- 
1.7.6.353.gb3ae7e
