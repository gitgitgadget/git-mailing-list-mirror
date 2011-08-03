From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v16 0/7] bisect: Add support for --no-checkout option
Date: Thu,  4 Aug 2011 07:56:59 +1000
Message-ID: <1312408626-8600-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 23:57:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QojRs-0007Dl-OA
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 23:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434Ab1HCV5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 17:57:52 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:45607 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab1HCV5v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 17:57:51 -0400
Received: by yia27 with SMTP id 27so747475yia.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=aXPGZhKHodr7o2LbcFQwcIGY/GrsM2dv4zn0GNl+Qro=;
        b=m/n7Ugl0QbdFvPflC5YjORRfrkelEP1AlSYDYM7iKWogrEOLENVKlhbamBcVUAxf3w
         G4I6UhT2BnZRMlG0dtabenChIVCgpCtjtOHN0WRM294XG1p+9wE2JlfepxFzU/exLDcD
         4jBU6FKTTxCIsGOjBkFkV3/7nyh3cQgag0Cx4=
Received: by 10.151.101.1 with SMTP id d1mr1230254ybm.152.1312408670522;
        Wed, 03 Aug 2011 14:57:50 -0700 (PDT)
Received: from localhost.localdomain ([120.16.210.46])
        by mx.google.com with ESMTPS id e7sm625568ybg.18.2011.08.03.14.57.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 14:57:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g172e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178629>

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
 git-bisect.sh                |  112 +++++++++++++++++++-------------
 t/t6030-bisect-porcelain.sh  |  144 +++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 267 insertions(+), 63 deletions(-)

-- 
1.7.6.352.g172e
