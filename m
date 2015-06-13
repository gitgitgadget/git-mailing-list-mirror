From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH (resend)] git-gui: make gc warning threshold match 'git gc
 --auto'
Date: Sat, 13 Jun 2015 22:22:17 +0200
Message-ID: <557C90F9.8000200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>, Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 22:22:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3rwa-0004rp-1U
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 22:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbbFMUWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 16:22:16 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38510 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbbFMUWO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 16:22:14 -0400
Received: by wibdq8 with SMTP id dq8so43089432wib.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 13:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=YlmL+wPPpFfjBPyI9CXFzs13oAAAIwrsesyvrUCenjA=;
        b=DNEFSsIrTGCwQD/26A6SYKgsuUypsl03AeUyOlDayXXm5pxDNH0pDuTZWrC/2tLkXC
         YBGqE35DWZl7+tBL1ErhHWstgxrTkexsE4Sr4NUkMvJgpOFbhuoza4xpRCuGJm+Sxeu6
         V69VIOpjtTqClGrgs7PiyXtFezk22sARpGLpJg0gLaLk8IOcRdCxiFRZJWAcXJIpBQSx
         kRVyod6/y941oswMbQnDEkoZI9hoI0C1q9GqYpG1meZZHYNg6AJjZQ8itZLVr1HwdQYk
         zF3vKad+ACLiMqEtN5dSMZO0L1SS1KMDiGxeH0BtasDvdQ/q2y+hh3U1XGWyJ8B5U7+s
         RyDw==
X-Received: by 10.194.222.137 with SMTP id qm9mr38234593wjc.43.1434226933436;
        Sat, 13 Jun 2015 13:22:13 -0700 (PDT)
Received: from [10.1.116.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id 12sm11689542wjw.17.2015.06.13.13.22.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jun 2015 13:22:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271587>

Date: Wed, 6 Aug 2014 20:43:46 +0200

The number of loose objects at which git-gui shows a gc warning has
historically been hardcoded to ~2000, or ~200 on Windows. The warning can
only be disabled completely via gui.gcwarning=false.

Especially on Windows, the hardcoded threshold is so ridiculously low that
git-gui often complains even immediately after gc (due to loose objects
only referenced by the reflog).

'git gc --auto' uses a much bigger threshold to check if gc is necessary.
Additionally, the value can be configured via gc.auto (default 6700).
There's no special case for Windows.

Change git-gui so that it only warns if 'git gc --auto' would also do an
automatic gc, i.e.:
 - calculate the threshold from the gc.auto setting (default 6700,
   disabled if <= 0)
 - check directory .git/objects/17

We still check four directories (14-17) if gc.auto is very small, to get a
better estimate.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 git-gui/lib/database.tcl | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/git-gui/lib/database.tcl b/git-gui/lib/database.tcl
index 1f187ed..212b195 100644
--- a/git-gui/lib/database.tcl
+++ b/git-gui/lib/database.tcl
@@ -89,19 +89,26 @@ proc do_fsck_objects {} {
 }
 
 proc hint_gc {} {
+	global repo_config
+	set auto_gc $repo_config(gc.auto)
+	if {$auto_gc eq {}} {
+		set auto_gc 6700
+	} elseif {$auto_gc <= 0} {
+		return
+	}
+
 	set ndirs 1
-	set limit 8
-	if {[is_Windows]} {
+	set limit [expr {($auto_gc + 255) / 256}]
+	if {$limit < 4} {
 		set ndirs 4
-		set limit 1
 	}
 
 	set count [llength [glob \
 		-nocomplain \
 		-- \
-		[gitdir objects 4\[0-[expr {$ndirs-1}]\]/*]]]
+		[gitdir objects 1\[[expr {8-$ndirs}]-7\]/*]]]
 
-	if {$count >= $limit * $ndirs} {
+	if {$count > $limit * $ndirs} {
 		set objects_current [expr {$count * 256/$ndirs}]
 		if {[ask_popup \
 			[mc "This repository currently has approximately %i loose objects.
-- 
2.4.1.windows.1
