From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] builtin-branch - allow deleting a fully specified branch-name
Date: Thu,  9 Apr 2009 20:28:55 -0400
Message-ID: <1239323335-4684-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 02:31:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls4e8-0006LO-JK
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 02:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbZDJA3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 20:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752685AbZDJA3b
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 20:29:31 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:52192 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbZDJA3a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 20:29:30 -0400
Received: by qyk16 with SMTP id 16so1882595qyk.33
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 17:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=FcKBDTCzcrBdtk+CPO2BDxjxfjoPdJpmt3+JE446gt0=;
        b=j2v+Eou1J/dH7RIoa9/lMghiE7kirsw1hrtzLx65UrvQWCFs1icpHhddQxzERuuwY3
         zlJ0yexWceMLzJlSkem6Pq5iXRV07HRPT7eZkgUw9MUbLcrCQW+zsLFn+6kHcjFVOzsI
         CCXWAH5zsU1L2IYbsgdOjopTUQKyoMbkV1hZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=GeNHb66AQC2NS5w5pl1YnK9mpSsNbuClRY2COWLlqCeZ1TS+uSs5VXmD6ja8NfSSYZ
         Mj1d7W/PkrS8xgDd/oQZWoqVFI/JRHAGsIiS0N0NkP+34Qa5e0lBkzrrctGyc0Yz4QEi
         Oc6sL2c0rEKBYsh/UXcjDH0kd7H7QR5Zn2uTo=
Received: by 10.224.6.82 with SMTP id 18mr3618917qay.1.1239323368705;
        Thu, 09 Apr 2009 17:29:28 -0700 (PDT)
Received: from localhost.localdomain (pool-173-79-135-88.washdc.fios.verizon.net [173.79.135.88])
        by mx.google.com with ESMTPS id 2sm1010002qwi.43.2009.04.09.17.29.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Apr 2009 17:29:28 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.27.g034b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116222>

This change allows, for instance
	git branch -d refs/heads/foo
to succeed. Without this patch, the code just assumes that the
given branch name should be appended to "refs/heads" or
"refs/remotes", thus attempting (and failing) in the above case
to delete "refs/heads/refs/heads/foo"

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 builtin-branch.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index ca81d72..f433bc5 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -131,7 +131,11 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 
 		free(name);
 
-		name = xstrdup(mkpath(fmt, bname.buf));
+		if (bname.len < 5 || memcmp("refs/", bname.buf, 5))
+			name = xstrdup(mkpath(fmt, bname.buf));
+		else
+			name = xstrdup(bname.buf);
+
 		if (!resolve_ref(name, sha1, 1, NULL)) {
 			error("%sbranch '%s' not found.",
 					remote, bname.buf);
-- 
1.6.2.2.27.g034b
