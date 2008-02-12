From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] pack-objects: Default to zero threads, meaning auto-assign
 to #cpus
Date: Mon, 11 Feb 2008 20:59:09 -0600
Message-ID: <47B10B7D.2030702@nrlssc.navy.mil>
References: <47B01FE7.8010207@op5.se> <1202784078-23700-1-git-send-email-casey@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: ae@op5.se
X-From: git-owner@vger.kernel.org Tue Feb 12 04:00:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOlNG-0004bu-Qn
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 03:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755696AbYBLC7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 21:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756165AbYBLC7Z
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 21:59:25 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58192 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755627AbYBLC7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 21:59:24 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1C2x9qU022427;
	Mon, 11 Feb 2008 20:59:09 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 11 Feb 2008 20:59:09 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <1202784078-23700-1-git-send-email-casey@nrlssc.navy.mil>
X-OriginalArrivalTime: 12 Feb 2008 02:59:09.0489 (UTC) FILETIME=[3D021A10:01C86D23]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15722001
X-TM-AS-Result: : Yes--9.642600-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwMjE0My03MDE0?=
	=?us-ascii?B?MDctNzA1NTgxLTcwMDMwMC03MDAxNjAtNzAzNzg4LTcxMDU3MS03?=
	=?us-ascii?B?MDUxNzgtNzA0OTI3LTcwMTI5OC03MDQyNTctMTg4MDE5LTcwNjI5?=
	=?us-ascii?B?MC03MDMzNzItNzAwMjY0LTcwMzk2NS03MDIzNzktNzAwMDA4LTcw?=
	=?us-ascii?B?MTg1NC03MDA5NzAtNzAwNDA5LTcwNzc1MC03MDU0NTAtMTQ4MDM5?=
	=?us-ascii?B?LTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73622>

Additionally, update some tests for which the multi-threaded result
differs from the single-threaded result and the single-threaded
result is expected.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Two of the tests in t5300-pack-object.sh failed when multiple
threads were used. My fix was to set --threads=1 for all pack-objects
calls. I didn't look into it any further than that. All other tests
passed.

-brandon


 builtin-pack-objects.c |    2 +-
 t/t5300-pack-object.sh |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 5c55c11..743de52 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -70,7 +70,7 @@ static int progress = 1;
 static int window = 10;
 static uint32_t pack_size_limit, pack_size_limit_cfg;
 static int depth = 50;
-static int delta_search_threads = 1;
+static int delta_search_threads = 0;
 static int pack_to_stdout;
 static int num_preferred_base;
 static struct progress *progress_state;
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index cd3c149..16ee940 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -35,7 +35,7 @@ test_expect_success \
 
 test_expect_success \
     'pack without delta' \
-    'packname_1=$(git pack-objects --window=0 test-1 <obj-list)'
+    'packname_1=$(git pack-objects --threads=1 --window=0 test-1 <obj-list)'
 
 rm -fr .git2
 mkdir .git2
@@ -66,7 +66,7 @@ cd "$TRASH"
 test_expect_success \
     'pack with REF_DELTA' \
     'pwd &&
-     packname_2=$(git pack-objects test-2 <obj-list)'
+     packname_2=$(git pack-objects --threads=1 test-2 <obj-list)'
 
 rm -fr .git2
 mkdir .git2
@@ -96,7 +96,7 @@ cd "$TRASH"
 test_expect_success \
     'pack with OFS_DELTA' \
     'pwd &&
-     packname_3=$(git pack-objects --delta-base-offset test-3 <obj-list)'
+     packname_3=$(git pack-objects --threads=1 --delta-base-offset test-3 <obj-list)'
 
 rm -fr .git2
 mkdir .git2
@@ -271,7 +271,7 @@ test_expect_success \
 test_expect_success \
     'honor pack.packSizeLimit' \
     'git config pack.packSizeLimit 200 &&
-     packname_4=$(git pack-objects test-4 <obj-list) &&
+     packname_4=$(git pack-objects --threads=1 test-4 <obj-list) &&
      test 3 = $(ls test-4-*.pack | wc -l)'
 
 test_done
-- 
1.5.4.1.40.gdb90
