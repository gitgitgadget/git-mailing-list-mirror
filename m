From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v17 0/7] bisect: Add support for --no-checkout option
Date: Thu,  4 Aug 2011 22:00:56 +1000
Message-ID: <1312459263-16911-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 14:01:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qowcf-0003qe-Af
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 14:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408Ab1HDMBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 08:01:42 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:47679 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab1HDMBk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 08:01:40 -0400
Received: by pzk37 with SMTP id 37so1943426pzk.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 05:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=sLa9g8vD8mI6o3OpmBQM+OQuodkLXaJrKvMHYebeCYs=;
        b=mMrc43c9Wk3zOhPjLrTcvrq07wl6muQAWyZe9l6f/C35kogSX8mx57Us3plzP1rzH/
         yglhux+15rTdR2JmUkRyzELwjYuLDjtPgoaNYkABkvQxbLdiEAKzbbj/yqQtph+x45Wm
         VprRUAlLTMm1b+Ozuyu/DoAg5U3pBnt7uDQHA=
Received: by 10.142.196.18 with SMTP id t18mr763673wff.152.1312459299933;
        Thu, 04 Aug 2011 05:01:39 -0700 (PDT)
Received: from localhost.localdomain ([120.16.214.215])
        by mx.google.com with ESMTPS id i5sm249965wff.18.2011.08.04.05.01.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 05:01:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.353.g50d6f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178738>

Motivation
==========
For some bisection tasks, checking out the commit at each stage of the bisection process is unecessary or undesirable.

This series adds support for a --no-checkout option to git-bisect.

If specified on a start command, --no-checkout causes 'git bisect' to update BISECT_HEAD at each stage of the bisection process instead of checking out the commit at that point. 

One application of the --no-checkout option is to find, within a partially damaged repository, a commit that has at least one parent whose graph is fully reachable in the sense of 'git pack-objects'.

For example:

	git bisect start BISECT_HEAD <some-known-good-commit> <boundary-commits> --no-checkout
	git bisect run sh -c '
	       GOOD=$(git for-each-ref "--format=%(objectname)" refs/bisect/good-*) &&
	       git rev-list --objects BISECT_HEAD --not $GOOD >tmp.$$ &&
	       git pack-objects --stdout >/dev/null <tmp.$$
	       rc=$?
	       rm -f tmp.$$
	       test $rc = 0'

<some-known-good-commit> is a known good commit, for which the test passes.
<boundary-commits> are commits chosen to prevent the bisection visiting missing or corrupt commit objects.

Assuming this git bisect run completes successfully, bisect/bad will refer to a commit which has at least one parent that is fully reachable in the sense of 'git pack-objects'.

Patch Synopsis
==============

Remediation
-----------
Patch 1/7 changes existing behaviour in the case that an invalid revision argument is supplied to 'git bisect start'. In particular, in this case, bisection state is neither created or modified if argument validation fails. Previously, existing bisection state would be cleared even if the revision arguments were subsequently determined to be invalid. 	

Patch 2/7 remediates a potential flaw that might hide a failure in a chain of pasted statements.

Patch 3/7 adds a test which documents the existing behaviour of git bisect in the presence of tree damage.

New Function
------------
Patch 4/7 modifies the C code that supports bisection.
Patch 5/7 modifies porcelain to enable option exposed by 4/7.
Patch 6/7 adds some tests.
Patch 7/7 adds some documentation.

Revision History
----------------
v17:
	Removed 2 trailing semi-colons.
	Fix errors found by Junio in documented example and test.
	Fixed instances of "; then" in new and modified code.
v16:
	Use --no-def with update-ref -d. 
	Ensure update-ref BISECT_HEAD is created after BISECT_START and destroyed before BISECT_START. (Christian Couder)
	dash compatability (Jonathan Nieder).
	Documentation and test tweaks (Junio Hamano).
v15:
	Fixed reset behaviour in --no-checkout case. Added one test for same.
	Simplified implementation so that no-checkout mode is inferred by presence of 
	$GIT_DIR/BISECT_HEAD eliminating the need for a separate BISECT_MODE control file.
	Patch 8/8 from v13/14 was redistributed and squashed into earlier commits.
	Style and documentation edits based on feedback from Christian Coulder.
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

Future series
-------------
* Implement full support for bisection in bare repositories.
* Fix whitespace, "; then" issues in git-bisect.h (patch that applies on v17 is available).

Jon Seymour (7):
  bisect: move argument parsing before state modification.
  bisect: use && to connect statements that are deferred with eval.
  bisect: add tests to document expected behaviour in presence of
    broken trees.
  bisect: introduce support for --no-checkout option.
  bisect: introduce --no-checkout support into porcelain.
  bisect: add tests for the --no-checkout option.
  bisect: add documentation for --no-checkout option.

 Documentation/git-bisect.txt |   32 +++++++++-
 bisect.c                     |   33 +++++++---
 bisect.h                     |    2 +-
 builtin/bisect--helper.c     |    7 ++-
 git-bisect.sh                |  116 +++++++++++++++++++++-------------
 t/t6030-bisect-porcelain.sh  |  144 +++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 271 insertions(+), 63 deletions(-)

-- 
1.7.6.353.g50d6f
