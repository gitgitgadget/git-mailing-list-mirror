From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] hooks/pre-commit: check for cycles in dependencies
Date: Mon,  4 Oct 2010 23:07:27 +0200
Message-ID: <1286226447-3390-1-git-send-email-bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Oct 04 23:07:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2sG3-0005nB-IH
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 23:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292Ab0JDVHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 17:07:34 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48641 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756474Ab0JDVHd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 17:07:33 -0400
Received: by bwz11 with SMTP id 11so4009690bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=kT3jNn5UvmTcBDMpi0lBAWF0LVkFzrEfp4pKwbi7S5U=;
        b=nME+sANqu9irn7ozWtdPjiqI+3JPI8ksOyxOWy6fp+VhLh2LcElh0eQY+bKTHq/dLZ
         uqrQ0QO4NTEyR/fGOaah7XOCekujRRq2ebu8KwsbAyVwd+McTGlo78ru1Zjh231wgBzm
         T548PdzayfQLPDyk5P8XcqmqBJvHexEmTkTWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kbDnrrvkgc6FxWd7KpjUT5MqgaukHSEDUXO6glIjzvuid1SqBq6SPSqgCa+r+q2600
         eO+uIm8gVxqo02WOqdS8uTqNQ4x0SvhjzSlP16ZUbO/nSyrpkC0QmuGBpQ1QkOPY4VL/
         PTVDXh8apn1HPDUXOPMfjl00AAFZeg8BgGwmU=
Received: by 10.204.131.132 with SMTP id x4mr7649485bks.50.1286226452181;
        Mon, 04 Oct 2010 14:07:32 -0700 (PDT)
Received: from localhost (p5B0F7A6E.dip.t-dialin.net [91.15.122.110])
        by mx.google.com with ESMTPS id 24sm4182394bkr.7.2010.10.04.14.07.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 14:07:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158120>

We need only to consider newly added dependencies.  For each of these deps we
need to check if there is a path from this dep to the current HEAD.

We use recursive_dep() for this task.  Even if recursive_dep() uses a DFS
traversal it will not run into an endless loop if there would be a cycle,
because recursive_dep() takes .topdeps only from committed trees.  And we
require that the committed dependency graph has no cycles.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

Note, the dependency on bw/tred is only historical, it only depends on master.

 hooks/pre-commit.sh |   35 +++++++++++++++++++++++++++++++++--
 1 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/hooks/pre-commit.sh b/hooks/pre-commit.sh
index 9d677e9..fd960a4 100644 hooks/pre-commit.sh
--- a/hooks/pre-commit.sh
+++ b/hooks/pre-commit.sh
@@ -20,7 +20,8 @@ tg_util
 if head_=$(git symbolic-ref -q HEAD); then
 	case "$head_" in
 		refs/heads/*)
-			git rev-parse -q --verify "refs/top-bases${head_#refs/heads}" >/dev/null || exit 0;;
+			head_="${head_#refs/heads/}"
+			git rev-parse -q --verify "refs/top-bases/$head_" >/dev/null || exit 0;;
 		*)
 			exit 0;;
 	esac
@@ -35,4 +36,34 @@ fi
 [ -s "$root_dir/.topmsg" ] ||
 	die ".topmsg is missing"
 
-# TODO: Verify .topdeps for valid branch names and against cycles
+check_cycle_name()
+{
+	[ "$head_" != "$_dep" ] ||
+		die "TopGit dependencies form a cycle: perpetrator is $_name"
+}
+
+# we only need to check newly added deps and for these if a path exists to the
+# current HEAD
+git diff --cached "$root_dir/.topdeps" |
+	awk '
+BEGIN      { in_hunk = 0; }
+/^@@ /     { in_hunk = 1; }
+/^\+/      { if (in_hunk == 1) printf("%s\n", substr($0, 2)); }
+/^[^@ +-]/ { in_hunk = 0; }
+' |
+	while read newly_added; do
+		# check for self as dep
+		[ "$head_" != "$newly_added" ] ||
+			die "Can't have myself as dep"
+
+		# deps can be non-tgish but we can't run recurse_deps() on them
+		ref_exists "refs/top-bases/$newly_added" ||
+			continue
+
+		# recurse_deps uses dfs but takes the .topdeps from the tree,
+		# therefore no endless loop in the cycle-check
+		no_remotes=1 recurse_deps check_cycle_name "$newly_added"
+	done
+
+
+# TODO: Verify .topdeps for valid branch names
-- 
tg: (550c37a..) bw/check-for-dep-cycle (depends on: bw/tred)
