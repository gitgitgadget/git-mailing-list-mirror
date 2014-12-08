From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 00/18] Introduce an internal API to interact with the fsck
 machinery
Date: Mon, 8 Dec 2014 17:13:55 +0100 (CET)
Message-ID: <cover.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 08 17:14:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0wp-0005Us-Mz
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444AbaLHQOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:14:03 -0500
Received: from mout.gmx.net ([212.227.17.21]:53218 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbaLHQOB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 11:14:01 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MUTSJ-1YOeU30odf-00RFii;
 Mon, 08 Dec 2014 17:13:56 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:W2V2WyOBXjSqPDYxFLt2sbepYU9f5edANjJ1CsdZK4tGzPsFJjN
 4T3UfDuSa6IahhJLwJSz4SGYDnOaPZ1UkmPn7/r3gn+UnLfjNeamMbHWpBATOdEhKVmDZD9
 r25sCsfZBWHpo6ZD21rp5TaParZwb3kOXPP+s267qf7SDmoeLTR73ny+LXpnOdemOhNIH80
 DFBEPPINq1jNuqBqNi5nA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261053>

At the moment, the git-fsck's integrity checks are targeted toward the
end user, i.e. the error messages are really just messages, intended for
human consumption.

Under certain circumstances, some of those errors should be allowed to
be turned into mere warnings, though, because the cost of fixing the
issues might well be larger than the cost of carrying those flawed
objects. For example, when an already-public repository contains a
commit object with two authors for years, it does not make sense to
force the maintainer to rewrite the history, affecting all contributors
negatively by forcing them to update.

This branch introduces an internal fsck API to be able to turn some of
the errors into warnings, and to make it easier to call the fsck
machinery from elsewhere in general.

I am proud to report that this work has been sponsored by GitHub.


Johannes Schindelin (18):
  Introduce fsck options
  Introduce identifiers for fsck messages
  Provide a function to parse fsck message IDs
  Offer a function to demote fsck errors to warnings
  Allow demoting errors to warnings via receive.fsck.<key> = warn
  fsck: report the ID of the error/warning
  Make fsck_ident() warn-friendly
  Make fsck_commit() warn-friendly
  fsck: handle multiple authors in commits specially
  Make fsck_tag() warn-friendly
  Add a simple test for receive.fsck.*
  Disallow demoting grave fsck errors to warnings
  Optionally ignore specific fsck issues completely
  fsck: allow upgrading fsck warnings to errors
  Document the new receive.fsck.* options.
  fsck: support demoting errors to warnings
  Introduce `git fsck --quick`
  git receive-pack: support excluding objects from fsck'ing

 Documentation/config.txt        |  27 +++
 Documentation/git-fsck.txt      |   7 +-
 builtin/fsck.c                  |  66 ++++--
 builtin/index-pack.c            |  13 +-
 builtin/receive-pack.c          |  36 ++-
 builtin/unpack-objects.c        |  16 +-
 fsck.c                          | 512 +++++++++++++++++++++++++++++++---------
 fsck.h                          |  28 ++-
 t/t1450-fsck.sh                 |  33 +++
 t/t5302-pack-index.sh           |   2 +-
 t/t5504-fetch-receive-strict.sh |  46 ++++
 11 files changed, 624 insertions(+), 162 deletions(-)

-- 
2.0.0.rc3.9669.g840d1f9
