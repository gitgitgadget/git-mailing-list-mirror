From: Richard Quirk <richard.quirk@gmail.com>
Subject: [PATCH] git-gui: Fix accidental staged state toggle when clicking top pixel row
Date: Fri, 20 Jun 2008 16:58:15 +0200
Message-ID: <1213973895-10264-1-git-send-email-richard.quirk@gmail.com>
Cc: spearce@spearce.org, Richard Quirk <richard.quirk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:59:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9i5C-0007lw-MB
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 16:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834AbYFTO6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 10:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755624AbYFTO6Z
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 10:58:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:19060 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368AbYFTO6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 10:58:24 -0400
Received: by ug-out-1314.google.com with SMTP id h2so6308ugf.16
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=bGTml4xfATQSRY3jQTY2Waf/xx+kgxKUHy/WX9raPp0=;
        b=xOWETv5yMpLo/SRS+wk8LMzRb6uzIs8truZxdwUmYF52CLlRWj8mOCuFCdpNt1nRkx
         /ve2lCwJDsFDRz58KPwaJb3Vpu6SShHnJ9d/ZYGDcsrsv6kCkql1MZV7m7EvOXkKPkJl
         yqJVD29X8VfmkdxNV9ZGGh7zW63F73rJY8FsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=IFikRjw3OTCW0P3viebCU8PWCd8UDtTMZp9YjvdqA9d46HOwUFAvc6OF+eJaD7yqz6
         wgqmtukxvepMGj9oBc5BrnVkQl+tlhXUad+pb0dB8L0z1bbh2E1FdJzrBbhyj2RPF3py
         Ih6VLp8Mk+4egJy3+HmRYOqWx4pgHEGML62oU=
Received: by 10.67.29.4 with SMTP id g4mr11469106ugj.84.1213973900271;
        Fri, 20 Jun 2008 07:58:20 -0700 (PDT)
Received: from localhost ( [84.77.20.234])
        by mx.google.com with ESMTPS id m1sm21612005uge.36.2008.06.20.07.58.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Jun 2008 07:58:17 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.9.g26943
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85651>

If a text widget is asked the index at x,y with y == 0 or y == 1 it will
always return 1.0 as the nearest index, regardless of the x position.

This means that clicking the top 2 pixels of the Unstaged/Staged Changes
lists caused the state of the file there to be toggled. This patch
checks that the pixel clicked is greater than 1, so there is less chance
of accidentally staging or unstaging changes.

Signed-off-by: Richard Quirk <richard.quirk@gmail.com>
---

To test the unpatched changes, make a change in a git-controlled repo and run
git-gui. Click the Unstaged Changes list away from the first column, but near
(within 1 pixel) to the pink header part. The file underneath is staged, rather
surprisingly. Similarly, for staged files click a pixel or 2 underneath the
green Staged Changes header and the changes are unstaged, even if the first
column is not clicked.

This change looks like a hack - but I'm pretty sure it's a bug in the Tk text
widget that's causing the strange behaviour. I couldn't see any other way to
fix this accidental (un)staging, which seems to get me at least once a day
lately.

 git-gui.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 23d7dfe..980dc0b 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1797,7 +1797,7 @@ proc toggle_or_diff {w x y} {
 	$ui_index tag remove in_sel 0.0 end
 	$ui_workdir tag remove in_sel 0.0 end
 
-	if {$col == 0} {
+	if {$col == 0 && $y > 1} {
 		set i [expr {$lno-1}]
 		set ll [expr {[llength $file_lists($w)]-1}]
 
-- 
1.5.6.9.g26943
