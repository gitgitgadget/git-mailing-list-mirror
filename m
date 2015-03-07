From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 00/10] Use a structure for object IDs.
Date: Sat,  7 Mar 2015 23:23:55 +0000
Message-ID: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 00:24:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUO4z-0001T5-Dh
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 00:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbbCGXYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 18:24:16 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49817 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752955AbbCGXYP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2015 18:24:15 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 62E792808F;
	Sat,  7 Mar 2015 23:24:14 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265010>

This is a patch series to convert some of the relevant uses of unsigned
char [20] to struct object_id.

The goal of this series to improve type-checking in the codebase and to
make it easier to move to a different hash function if the project
decides to do that.  This series does not convert all of the codebase,
but only parts.  I've dropped some of the patches from earlier (which no
longer apply) and added others.

Certain parts of the code have to be converted before others to keep the
patch sizes small, maintainable, and bisectable, so functions and
structures that are used across the codebase (e.g. struct object) will
be converted later.  Conversion has been done in a somewhat haphazard
manner by converting modules with leaf functions and less commonly used
structs first.

Since part of the goal is to ease a move to a different hash function if
the project decides to do that, I've adopted Michael Haggerty's
suggestion of using variables named "oid", naming the structure member
"sha1", and using GIT_SHA1_RAWSZ and GIT_SHA1_HEXSZ as the constants.

I've been holding on to this series for a long time in hopes of
converting more of the code before submitting, but realized that this
deprived others of the ability to use the new structure and required me
to rebase extremely frequently.

brian m. carlson (10):
  Define a structure for object IDs.
  Define utility functions for object IDs.
  bisect.c: convert leaf functions to use struct object_id
  archive.c: convert to use struct object_id
  zip: use GIT_SHA1_HEXSZ for trailers
  bulk-checkin.c: convert to use struct object_id
  diff: convert struct combine_diff_path to object_id
  commit: convert parts to struct object_id
  patch-id: convert to use struct object_id
  apply: convert threeway_stage to object_id

 archive-zip.c      |  4 ++--
 archive.c          | 18 +++++++++---------
 bisect.c           | 40 +++++++++++++++++++-------------------
 builtin/apply.c    | 14 +++++++-------
 builtin/patch-id.c | 34 ++++++++++++++++-----------------
 bulk-checkin.c     | 12 ++++++------
 cache.h            | 37 ++++++++++++++++++++++++++++++++----
 combine-diff.c     | 56 +++++++++++++++++++++++++++---------------------------
 commit.c           | 32 +++++++++++++++----------------
 commit.h           |  4 ++--
 diff-lib.c         | 10 +++++-----
 diff.h             |  5 +++--
 hex.c              | 16 +++++++++++++---
 log-tree.c         |  2 +-
 object.h           |  8 ++++++++
 send-pack.c        |  2 +-
 shallow.c          |  8 ++++----
 tree-diff.c        | 10 +++++-----
 upload-pack.c      |  2 +-
 19 files changed, 181 insertions(+), 133 deletions(-)

-- 
2.2.1.209.g41e5f3a
