Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C296B20189
	for <e@80x24.org>; Sat, 18 Jun 2016 22:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbcFRWOS (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 18:14:18 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37414 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751114AbcFRWOQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2016 18:14:16 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [72.20.141.51])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5F83F2809F;
	Sat, 18 Jun 2016 22:14:12 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1466288052;
	bh=r4gg8mMBtw9D0fNfQAeMdNHot2ci/5panGl/jDqRyu0=;
	h=From:To:Cc:Subject:Date:From;
	b=PR3iGfM3vme5mXhA2ftODehOYE9dyGh7T5hakHTPjm14LX3VaH36uy7OHj/pJ6UNa
	 l+aK51Lq9Mc+bqiAiutG+dplqlMIOeHihckFVOQDQcE1DeS3cVdJ8JwjR77sUXQCse
	 M4KlndN3ew6Lh8D9Txc/vSIU+VooNGkbxVG9rsiPMKxknS0MCYWKwvPamhXHIn5YP+
	 1sqETWb6Q3p+Xu1oNsW6YLKPlirgS3pNI0kScSu5lm6IqI9yhTt07PhEd0iqoG9iLf
	 ttN6fj3duZeAvY2ProjTYKmgDAcjvotMO5JijLEG44hyvDdPn5YoU+aKnDCO3v9glW
	 3wnUnHnQ0x8mhtRLLo2ZKmaHQ1yY1hUYH5E9RHeEUA1BZoIiCMDvJLQSNR0cHtkpRL
	 IuWlwXfBzoboyPIiLbhYFICbeYlqQDCc4vsOC1z0UDgpOWcBah94DF1NDHyE42iKFR
	 L+Bqb1i5Itw//zATo61H3W6FeyyWOAoYMsPEDcXNJ4RcaRcdU0x
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	git@vger.kernel.org
Cc:	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 0/8] object_id part 4
Date:	Sat, 18 Jun 2016 22:13:59 +0000
Message-Id: <20160618221407.1046188-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.0
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This series is part 4 in a series of conversions to replace instances of
unsigned char [20] with struct object_id.  Most of this series touches
the merge-recursive code.

New in this series is the use of Coccinelle (http://coccinelle.lip6.fr/)
semantic patches.  These semantic patches can make automatic
transformations to C source code for cleanup or refactoring reasons.

This series introduces a set of transforms for the struct object_id
transition, cleans up some existing code with them, and applies a small
number of semantic patches to transform parts of the merge-recursive
code.  Some manual refactoring work follows.

Note that in the patches created with the semantic patches, the only manual
change was the definition of the struct member.  Opinions on whether this is a
viable technique for further work to ease both the creation and review of
patches are of course welcomed.

The testsuite continues to pass at each step, and this series rebases
cleanly on both pu and next.

I moved the Coccinelle transforms to contrib/examples/coccinelle, but if
it's decided that the Coccinelle transforms simply don't belong in the
repository, it's fine to simply drop the first patch (and maybe fix up
the commit messages).  I can create a GitHub Gist and let reviewers
refer to that at their convenience.

Changes from v1:
* Move the object ID transformations to contrib/examples/coccinelle.
* Add a README to that folder explaining what they are.
* Adjust the Coccinelle patches to transform plain structs before
  pointers to structs to avoid misconversions.  This addresses the issue
  that Peff caught originally.

brian m. carlson (8):
  Add basic Coccinelle transforms.
  Apply object_id Coccinelle transformations.
  Convert struct diff_filespec to struct object_id
  Rename struct diff_filespec's sha1_valid member.
  merge-recursive: convert struct stage_data to use object_id
  merge-recursive: convert struct merge_file_info to object_id
  merge-recursive: convert leaf functions to use struct object_id
  merge-recursive: convert merge_recursive_generic to object_id

 bisect.c                                    |   2 +-
 builtin/blame.c                             |   6 +-
 builtin/fast-export.c                       |  10 +-
 builtin/merge-recursive.c                   |  20 +-
 builtin/merge.c                             |  13 +-
 builtin/reset.c                             |   4 +-
 combine-diff.c                              |  14 +-
 contrib/examples/coccinelle/README          |   2 +
 contrib/examples/coccinelle/object_id.cocci |  83 ++++++++
 diff.c                                      |  95 +++++----
 diffcore-break.c                            |   4 +-
 diffcore-rename.c                           |  16 +-
 diffcore.h                                  |   4 +-
 line-log.c                                  |  12 +-
 merge-recursive.c                           | 310 ++++++++++++++--------------
 merge-recursive.h                           |   6 +-
 notes-merge.c                               |  42 ++--
 refs/files-backend.c                        |   4 +-
 submodule.c                                 |   4 +-
 wt-status.c                                 |   3 +-
 20 files changed, 378 insertions(+), 276 deletions(-)
 create mode 100644 contrib/examples/coccinelle/README
 create mode 100644 contrib/examples/coccinelle/object_id.cocci
