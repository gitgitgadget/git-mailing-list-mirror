From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH] git-gui: make gc warning threshold match 'git gc --auto'
Date: Wed, 06 Aug 2014 20:51:01 +0200
Message-ID: <53E27915.9040305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Shawn Pearce <spearce@spearce.org>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 06 20:51:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF6In-0001zW-44
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 20:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797AbaHFSvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 14:51:04 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:40068 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756263AbaHFSvC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 14:51:02 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so3100329wgh.14
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 11:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=DiWz+DPpTHv+uuUcXo91OePSD8JpKQ1bpMw7ste2YRc=;
        b=P7z8+Uf0l+U7mPxbLmG8rlUt6yHLj/vZ/5H55gUnevgh/9OQMBE6cXkMFy6jkZjkGd
         ftzpuoSM9B0iu8GmWYsODTkBHjimQdhQTwud1iHPZ7zJ5m5xsDP2bV4ntmUTJgxwoXwt
         RwpcgZgKKX5+/2l8yx4dinV9U5V7RTfHa69OK7gx7OGMRgW9Z2E2R38gGSQalSp5HhfT
         F7LaMhR9FMTLujKeHMK4oa4R4tiHDUYolf7M2Ea6Ui0AaM49RasgepLPXOxGDg+4QhUe
         78RN9uQSrZtz+PUptKb0FW4ApTR/wNwFazUTFsqPVNZ7er5bqDAh4la8YJaG/+A43F0W
         6OTA==
X-Received: by 10.180.74.198 with SMTP id w6mr18596615wiv.7.1407351060858;
        Wed, 06 Aug 2014 11:51:00 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ex2sm4290563wjd.30.2014.08.06.11.50.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Aug 2014 11:51:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254891>

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
2.0.3.921.ga7e731a.dirty
