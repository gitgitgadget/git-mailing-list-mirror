From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v15 0/7] bisect: Add support for --no-checkout option
Date: Thu,  4 Aug 2011 01:03:24 +1000
Message-ID: <1312383811-7130-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 17:04:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoczW-0001b2-UK
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 17:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772Ab1HCPEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 11:04:10 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40184 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579Ab1HCPEH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 11:04:07 -0400
Received: by yxj19 with SMTP id 19so261305yxj.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 08:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=XHc/x/hBP7N37TFDRH8HcOWrZKRe9tOgWZCh3bCXJ4w=;
        b=NQ2BjDoS+9jKDj3WuhpHN6JzvbEvYNM0ZyefuI2HByeZQa6ZFei++wwA/YrTyms/KK
         OZYjSwNaTbb+F/4enNmwz908o13a340TOcLJElTfznd1RrhFQP3Yj4cgMlC0ZjRkbPXt
         ZNd3gmgnDCkIjX8aQbini3nWKyHmBCUft9X2Q=
Received: by 10.142.131.20 with SMTP id e20mr4973252wfd.181.1312383846300;
        Wed, 03 Aug 2011 08:04:06 -0700 (PDT)
Received: from localhost.localdomain ([120.16.210.46])
        by mx.google.com with ESMTPS id d1sm1133916pbj.88.2011.08.03.08.04.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 08:04:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.gd542a2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178581>

Motivation
==========
For some bisection tasks, checking out the commit at each stage of the bisection process is unecessary or undesirable.

This series adds support for a --no-checkout option to git-bisect.

If specified on a start command, --no-checkout causes 'git bisect' to update BISECT_HEAD at each stage of the bisection process instead of checking out the commit at that point. 

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

Todo
-----
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
 git-bisect.sh                |  110 +++++++++++++++++++-------------
 t/t6030-bisect-porcelain.sh  |  144 +++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 265 insertions(+), 63 deletions(-)

-- 
1.7.6.352.g5540e
