From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] diff --no-index: fix --name-status with added files
Date: Tue, 3 Jul 2007 16:01:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707031559510.4071@racer.site>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org>
 <20070702142557.eba61ccd.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org>
 <20070702145601.a0dcef0f.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org>
 <7vhcomuofl.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0707022114000.9434@woody.linux-foundation.org>
 <Pine.LNX.4.64.0707031303130.4071@racer.site> <86y7hxr591.fsf@lola.quinscape.zz>
 <Pine.LNX.4.64.0707031437560.4071@racer.site> <86hcolr3sb.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 17:01:23 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5jsU-0007IN-Dw
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 17:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759238AbXGCPBP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 11:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759065AbXGCPBP
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 11:01:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:58777 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757606AbXGCPBN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 11:01:13 -0400
Received: (qmail invoked by alias); 03 Jul 2007 15:01:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 03 Jul 2007 17:01:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+smt4e932sVpreFjEJA0doP+dQXwvJZvVhBse7qf
	pdIg91vXsi1uph
X-X-Sender: gene099@racer.site
In-Reply-To: <86hcolr3sb.fsf@lola.quinscape.zz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51504>


Without this patch, an added file would be reported as /dev/null.

Noticed by David Kastrup.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Would be nice, next time, to have a bug report which is not 
	embedded in a thread.

 diff.c                                   |    3 ++-
 t/t4013-diff-various.sh                  |    2 ++
 t/t4013/diff.diff_--name-status_dir2_dir |    3 +++
 3 files changed, 7 insertions(+), 1 deletions(-)
 create mode 100644 t/t4013/diff.diff_--name-status_dir2_dir

diff --git a/diff.c b/diff.c
index b6eb72b..1958970 100644
--- a/diff.c
+++ b/diff.c
@@ -2418,7 +2418,8 @@ static void diff_flush_raw(struct diff_filepair *p,
 		printf("%s ",
 		       diff_unique_abbrev(p->two->sha1, abbrev));
 	}
-	printf("%s%c%s", status, inter_name_termination, path_one);
+	printf("%s%c%s", status, inter_name_termination,
+			two_paths || p->one->mode ?  path_one : path_two);
 	if (two_paths)
 		printf("%c%s", inter_name_termination, path_two);
 	putchar(line_termination);
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index b453b42..9eec754 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -17,6 +17,7 @@ test_expect_success setup '
 	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
 
 	mkdir dir &&
+	mkdir dir2 &&
 	for i in 1 2 3; do echo $i; done >file0 &&
 	for i in A B; do echo $i; done >dir/sub &&
 	cat file0 >file2 &&
@@ -254,6 +255,7 @@ diff --patch-with-stat initial..side
 diff --patch-with-raw initial..side
 diff --patch-with-stat -r initial..side
 diff --patch-with-raw -r initial..side
+diff --name-status dir2 dir
 EOF
 
 test_done
diff --git a/t/t4013/diff.diff_--name-status_dir2_dir b/t/t4013/diff.diff_--name-status_dir2_dir
new file mode 100644
index 0000000..ef7fdb7
--- /dev/null
+++ b/t/t4013/diff.diff_--name-status_dir2_dir
@@ -0,0 +1,3 @@
+$ git diff --name-status dir2 dir
+A	dir/sub
+$
-- 
1.5.3.rc0.2637.g1dd84-dirty
