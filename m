From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 7/8] Make O(n) algorithm the default implementation of --bisect [rev 2]
Date: Sat, 02 Jul 2005 15:38:12 +1000
Message-ID: <20050702053812.11560.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Sat Jul 02 07:31:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Doaai-00088i-9P
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 07:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVGBFiY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 01:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVGBFiY
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 01:38:24 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:24193 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261803AbVGBFiP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2005 01:38:15 -0400
Received: (qmail 11570 invoked by uid 500); 2 Jul 2005 05:38:12 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch makes the O(n) the default implementation of the git-rev-list
--bisect switch.

The original O(n^2) algorithm is still available as --bisect-orig.

It is left around to provide a quick and simple way to verify the
accuracy of the O(n) algorithm.

A subsequent patch is supplied to remove support for --bisect-orig
completely.

Signed-off: Jon Seymour <jon.seymour@gmail.com>
---
Linus: you may choose to defer application of this patch if you are
not confident that the O(n) algorithm is good.

[rev 2]
  * included necessary change to t/t6002... that was accidentally
    ommitted on the first attempt.

The patch series to be applied is now:

[PATCH 1/8] Factor out useful test case infrastructure from t/t6001... into t/t6000-lib.sh
[PATCH 2/8] Introduce unit tests for git-rev-list --bisect
[PATCH 3/8] Add a topological sort procedure to commit.c [rev 3]
[PATCH 4/8] This patch introduces a O(n) bisection algorithm to git.
[PATCH 5/8] Removes DEBUG code from rev-list.c and -DDEBUG from Makefile
[PATCH 6/8] Move bisection algorithms into commit.c
[PATCH 7/8] Make O(n) algorithm the default implementation of --bisect [rev 2]
[PATCH 8/8] Removes support for O(n^2) algorithm from git-rev-list completely [rev 2]
[PATCH] Change the sed seperator in t/t6000-lib.sh
---

 rev-list.c                 |    5 +++--
 t/t6002-rev-list-bisect.sh |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

203e690e7d7a2aa75f0336744dc6b4455ad51844
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -16,6 +16,7 @@ static const char rev_list_usage[] =
 		      "  --min-age=epoch\n"
 		      "  --header\n"
 		      "  --pretty\n"
+                      "  --bisect\n"
 		      "  --merge-order [ --show-breaks ]";
 
 static int bisect_list = 0;
@@ -365,11 +366,11 @@ int main(int argc, char **argv)
 			show_parents = 1;
 			continue;
 		}
-		if (!strcmp(arg, "--bisect-by-cut")) {
+		if (!strcmp(arg, "--bisect")) {
 			bisect_by_cut_option = 1;
 			continue;
 		}
-		if (!strcmp(arg, "--bisect")) {
+		if (!strcmp(arg, "--bisect-orig")) {
 			bisect_list = 1;
 			continue;
 		}
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -241,7 +241,7 @@ EOF
 }
 
 test_sequence "--bisect"
-test_sequence "--bisect-by-cut"
+test_sequence "--bisect-orig"
 
 #
 #
------------
