From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 1/2] difftool: only copy back files modified during directory diff
Date: Thu, 28 Jun 2012 15:39:54 -0400
Message-ID: <1340912395-16990-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 28 21:40:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkKZz-00014l-8A
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 21:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537Ab2F1Tkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 15:40:35 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50826 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab2F1Tke (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 15:40:34 -0400
Received: by yenl2 with SMTP id l2so2166196yen.19
        for <git@vger.kernel.org>; Thu, 28 Jun 2012 12:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Z4MkJyIWOjpMaH92JnLcQm6z8mOwXlulopFCU1BA+E8=;
        b=WaUIvWSnjqRxuBEBznVxuc5FCt3cvpMY/YXgNvV4UcxiT22s5KWi0EHGRNsGZLEJS4
         295XwtjkdN2zM2d5dRpMTqJmA4tGBz4hIWWckpG/gDzDaVsydO21cJtyWOS/pITbNfOU
         gfRMNKf5DKM/0DQoxZzwbC7i1RVer3tEhV7DOGKsOuw1do2vDycGse43zonNEEWvol/r
         S9qSXPxcWGnrbobtRC7Qn5wjWVfIGVtFx2fhml6W8D5Jf0j74Z4IlmDCOUAgLKmLiwcE
         /dr56it4nN1ErjxPHAqSYD3zKI9kLB4GWZgWooQNNDwSYxJMSXrjYlvOTFH3OxlNeG6l
         CR8w==
Received: by 10.50.190.230 with SMTP id gt6mr520963igc.48.1340912433368;
        Thu, 28 Jun 2012 12:40:33 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id z3sm195124igc.7.2012.06.28.12.40.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jun 2012 12:40:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.134.gda62046
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200791>

When 'difftool --dir-diff' is used to compare working tree files,
it always copies files from the tmp dir back to the working tree
when the diff tool is closed, even if the files were not modified
by the diff tool.

This causes the file timestamp to change. Files should only be
copied from the tmp dir back to the working copy if they were
actually modified.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This patch must be applied after commit 304970d on next (diff-no-index:
exit(1) if 'diff --quiet <repo file> <external file>' finds changes).
because it relies on 'git diff --quiet' to compare files outside the
repository.


 git-difftool.perl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index ae1e052..679a56d 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -336,8 +336,11 @@ if (defined($dirdiff)) {
 	# files were modified during the diff, then the changes
 	# should be copied back to the working tree
 	for my $file (@working_tree) {
-		copy("$b/$file", "$workdir/$file") or die $!;
-		chmod(stat("$b/$file")->mode, "$workdir/$file") or die $!;
+		if ((-e "$b/$file") &&
+		    (system('git', 'diff', '--quiet', "$b/$file", "$workdir/$file") != 0)) {
+			copy("$b/$file", "$workdir/$file") or die $!;
+			chmod(stat("$b/$file")->mode, "$workdir/$file") or die $!;
+		}
 	}
 } else {
 	if (defined($prompt)) {
-- 
1.7.11.1.134.gda62046
