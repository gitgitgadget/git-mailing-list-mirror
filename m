From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] merge-one-file: fix "expr: non-numeric argument"
Date: Thu,  6 Oct 2011 14:25:55 -0400
Message-ID: <1317925555-65237-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 20:26:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBse0-0003su-Lt
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 20:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758910Ab1JFS0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 14:26:03 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45313 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178Ab1JFS0B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 14:26:01 -0400
Received: by ggnv2 with SMTP id v2so1999325ggn.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=IgZqY5Mqacl4Jc58pXonTnZ5MTq8HDpRdwR2yYDOAk4=;
        b=pnhuk5TM/Isg+NBVh1h15nLr1oWBqGEpsFjtFhH2qnslkzpkdynIa7IFa1aM1OzD/D
         kT3te5Mw+DpYAmDaKYSPaUGk5jME2AnXUvDbkQyuqUUcogq3mCTnQzBt75nwY/HNG384
         9Z59NSDQazG3cNXXASPJ/9TUnACtxI1sWz6Qs=
Received: by 10.150.47.9 with SMTP id u9mr822049ybu.139.1317925561049;
        Thu, 06 Oct 2011 11:26:01 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com. [174.97.218.168])
        by mx.google.com with ESMTPS id 16sm15628567ant.10.2011.10.06.11.25.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 11:26:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.144.gbfcf9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183013>

When invoking expr to compare two numbers, don't quote the
variables which are the output of 'wc -c'. On OS X, this output
includes spaces, which expr balks at:

  $ sz0=`wc -c </etc/passwd`
  $ sz1=`wc -c </etc/passwd`
  $ echo "'$sz0'"
  '    3667'

  $ expr "$sz0" \< "$sz1" \* 2
  expr: non-numeric argument

  $ expr $sz0 \< $sz1 \* 2
  1

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Noticed this while working on the CHERRY_PICK_HEAD issue.

 git-merge-one-file.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 7aeb96952f..f612cb847a 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -117,7 +117,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 
 		# If we do not have enough common material, it is not
 		# worth trying two-file merge using common subsections.
-		expr "$sz0" \< "$sz1" \* 2 >/dev/null || : >$orig
+		expr $sz0 \< $sz1 \* 2 >/dev/null || : >$orig
 		;;
 	*)
 		echo "Auto-merging $4"
-- 
1.7.7.144.gbfcf9.dirty
