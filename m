From: Mark Burton <markb@ordern.com>
Subject: [PATCH] git-gui: Teach start_push_anywhere_action{} to notice when
 remote is a mirror.
Date: Tue, 2 Dec 2008 15:15:02 +0000
Organization: Order N Ltd.
Message-ID: <20081202151502.3f30ced4@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 16:16:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7WzA-0005lQ-Bh
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 16:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516AbYLBPPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 10:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754474AbYLBPPI
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 10:15:08 -0500
Received: from c2beaomr01.btconnect.com ([213.123.26.179]:24951 "EHLO
	c2beaomr01.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242AbYLBPPG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 10:15:06 -0500
Received: from crow.ordern.com (host86-128-197-104.range86-128.btcentralplus.com [86.128.197.104])
	by c2beaomr01.btconnect.com (MOS 3.8.6-GA)
	with ESMTP id CIS27864;
	Tue, 2 Dec 2008 15:15:02 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id 77D59190CFB
	for <git@vger.kernel.org>; Tue,  2 Dec 2008 15:15:02 +0000 (GMT)
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2beaomr01.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A010202.493550F7.0060,ss=1,fgs=0,
	ip=86.128.197.104,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102141>

When the destination repository is a mirror, this function goofed by still
passing a refspec to git-push. Now it notices that the remote is a mirror
and holds the refspec.

Signed-off-by: Mark Burton <markb@ordern.com>
---

 This patch stops git-gui from annoying git-push when the remote is a
 mirror. A further enhancement would be to disable the branch names list
 in the dialog when the selected destination is a mirror. As it stands, you can
 select a branch name from the list but it will be ignored (this could possibly
 confuse/annoy people). But that's a bunch more work so I'm stopping here for
 now.

 git-gui/lib/transport.tcl |   43 +++++++++++++++++++++++++++----------------
 1 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/git-gui/lib/transport.tcl b/git-gui/lib/transport.tcl
index e419d78..b18d9c7 100644
--- a/git-gui/lib/transport.tcl
+++ b/git-gui/lib/transport.tcl
@@ -33,10 +33,15 @@ proc push_to {remote} {
 proc start_push_anywhere_action {w} {
 	global push_urltype push_remote push_url push_thin push_tags
 	global push_force
+	global repo_config
 
+	set is_mirror 0
 	set r_url {}
 	switch -- $push_urltype {
-	remote {set r_url $push_remote}
+	remote {
+		set r_url $push_remote
+		catch {set is_mirror $repo_config(remote.$push_remote.mirror)}
+	}
 	url {set r_url $push_url}
 	}
 	if {$r_url eq {}} return
@@ -53,23 +58,29 @@ proc start_push_anywhere_action {w} {
 		lappend cmd --tags
 	}
 	lappend cmd $r_url
-	set cnt 0
-	foreach i [$w.source.l curselection] {
-		set b [$w.source.l get $i]
-		lappend cmd "refs/heads/$b:refs/heads/$b"
-		incr cnt
-	}
-	if {$cnt == 0} {
-		return
-	} elseif {$cnt == 1} {
-		set unit branch
+	if {$is_mirror} {
+		set cons [console::new \
+			[mc "push %s" $r_url] \
+			[mc "Mirroring to %s" $r_url]]
 	} else {
-		set unit branches
-	}
+		set cnt 0
+		foreach i [$w.source.l curselection] {
+			set b [$w.source.l get $i]
+			lappend cmd "refs/heads/$b:refs/heads/$b"
+			incr cnt
+		}
+		if {$cnt == 0} {
+			return
+		} elseif {$cnt == 1} {
+			set unit branch
+		} else {
+			set unit branches
+		}
 
-	set cons [console::new \
-		[mc "push %s" $r_url] \
-		[mc "Pushing %s %s to %s" $cnt $unit $r_url]]
+		set cons [console::new \
+			[mc "push %s" $r_url] \
+			[mc "Pushing %s %s to %s" $cnt $unit $r_url]]
+	}
 	console::exec $cons $cmd
 	destroy $w
 }
-- 
1.6.0.4
