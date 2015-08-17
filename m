From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v8 0/8] implement notes.mergeStrategy option
Date: Mon, 17 Aug 2015 01:46:23 -0700
Message-ID: <1439801191-3026-1-git-send-email-jacob.e.keller@intel.com>
Cc: Johan Herland <johan@herland.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 10:47:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRG4f-0002kE-Kd
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 10:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbbHQIrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 04:47:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:40512 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073AbbHQIrP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 04:47:15 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 17 Aug 2015 01:47:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,693,1432623600"; 
   d="scan'208";a="770177864"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by fmsmga001.fm.intel.com with ESMTP; 17 Aug 2015 01:47:14 -0700
X-Mailer: git-send-email 2.5.0.280.g4aaba03
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276037>

From: Jacob Keller <jacob.keller@gmail.com>

- Changes since v7 -
* add patches to make rewrite and merge take same options
* camel case mergeStrategy
* move init_notes_check above reading git-config in merge()
  This is necessary as it ensures refs are inside refs/notes/*

It should be noted that git-notes already blocks all operations outside
of refs/notes, including merging from refs outside of refs/notes. This
series leaves the ability to merge from non-refs/notes refs as an
enhancement for a future author. However, git-notes also (correctly)
prevents merge (and any other option) into non refs/notes/* refs. You
may notice a "BUG:" print statement after skip_prefix, this is only as a
failsafe and is marked BUG since it should never be true.

Hopefully everything looks good now. I chose to add patches which
combine rewrite and notes-merge options to take the same parameters.
This does cause some weirdness since ours and theirs is swapped much
like in a rebase merge conflict.

If we dont' like this, I am ok with re-writing this to not document the
synonyms. However, I think that a good future direction would be to make
rewrite use the exact same flow as merge, and support the `manual` mode
as well using the full notes-merge harness.

Jacob Keller (8):
  notes: document cat_sort_uniq rewriteMode
  notes: extract enum notes_merge_strategy to notes-utils.h
  note: extract parse_notes_merge_strategy to notes-utils
  notes: allow use of the "rewrite" terminology for merge strategies
  notes: implement parse_combine_rewrite_fn using
    parse_notes_merge_strategy
  notes: add tests for --commit/--abort/--strategy exclusivity
  notes: add notes.mergeStrategy option to select default strategy
  notes: teach git-notes about notes.<ref>.mergeStrategy option

 Documentation/config.txt              |  22 +++++-
 Documentation/git-notes.txt           |  43 +++++++++--
 builtin/notes.c                       |  43 +++++++----
 notes-merge.h                         |  10 +--
 notes-utils.c                         |  50 ++++++++++---
 notes-utils.h                         |   9 +++
 t/t3301-notes.sh                      |  55 ++++++++++++++
 t/t3309-notes-merge-auto-resolve.sh   | 135 ++++++++++++++++++++++++++++++++++
 t/t3310-notes-merge-manual-resolve.sh |  12 +++
 9 files changed, 341 insertions(+), 38 deletions(-)

-- 
2.5.0.280.g4aaba03
