From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] Add contrib/rerere-train script
Date: Sat, 27 Sep 2008 20:44:15 +0900
Message-ID: <20080927204415.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 27 13:49:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjYIN-0005sr-9A
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 13:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbYI0Loz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 07:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbYI0Loz
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 07:44:55 -0400
Received: from karen.lavabit.com ([72.249.41.33]:50309 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbYI0Loy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 07:44:54 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id E6B32C7B1E;
	Sat, 27 Sep 2008 06:44:53 -0500 (CDT)
Received: from 9957.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id XBF8SR5KDID2; Sat, 27 Sep 2008 06:44:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Umd850C0GoD/UBKIdw9/9iJuf8G8gRXgK2r+D+O4QsETMxDbiRgLg0OFwR0xAMpdxieo2KT8AdGutp6b6lNuMhI7JUjLMziDIeBA/mJQUHXc5pWWFsKtTrW1mP7PsSEv4nfO5gbNebWfFDjlQUGnwfwNoChbd/VygcKj9ctTxfs=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96911>

This script takes a range of commits (e.g. maint..next) as its arguments,
recreates merge commits in the range to prime rr-cache database.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 contrib/rerere-train.sh |   52 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)
 create mode 100755 contrib/rerere-train.sh

diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
new file mode 100755
index 0000000..2cfe1b9
--- /dev/null
+++ b/contrib/rerere-train.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+# Copyright (c) 2008, Nanako Shiraishi
+# Prime rerere database from existing merge commits
+
+me=rerere-train
+USAGE="$me rev-list-args"
+
+SUBDIRECTORY_OK=Yes
+OPTIONS_SPEC=
+. git-sh-setup
+require_work_tree
+cd_to_toplevel
+
+# Remember original branch
+branch=$(git symbolic-ref -q HEAD) ||
+original_HEAD=$(git rev-parse --verify HEAD) || {
+	echo >&2 "Not on any branch and no commit yet?"
+	exit 1
+}
+
+mkdir -p "$GIT_DIR/rr-cache" || exit
+
+git rev-list --parents "$@" |
+while read commit parent1 other_parents
+do
+	if test -z "$other_parents"
+	then
+		# Skip non-merges
+		continue
+	fi
+	git checkout -q "$parent1^0"
+	if git merge $other_parents >/dev/null 2>&1
+	then
+		# Cleanly merges
+		continue
+	fi
+	if test -s "$GIT_DIR/MERGE_RR"
+	then
+		git show -s --pretty=format:"Learning from %h %s" "$commit"
+		git rerere
+		git checkout -q $commit -- .
+		git rerere
+	fi
+	git reset -q --hard
+done
+
+if test -z "$branch"
+then
+	git checkout "$original_HEAD"
+else
+	git checkout "${branch#refs/heads/}"
+fi
-- 
1.6.0.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
