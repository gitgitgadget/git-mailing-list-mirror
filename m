From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 25/48] merge-recursive: Split was_tracked() out of would_lose_untracked()
Date: Wed,  8 Jun 2011 01:30:55 -0600
Message-ID: <1307518278-23814-26-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEm-0006q0-Re
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755061Ab1FHHak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:30:40 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:37577 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251Ab1FHHac (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:30:32 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so191910pxi.10
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=68u6Z5SVc/Pxa1fdHrTxVn/nFp0fsBPEyRqpnprQUQA=;
        b=ofC5YqGq4+nw16xWqnHkeauBp0Y+ckg1tirksYX8PZS51GFu8lrAhqtHKrkeXzCJpU
         KDOcBjri/+IlGq2ijEIEDInP6z4n7SgEjc1MBi8fSxnvP/eQVFbKz6PFyd1cp0/3+riG
         gK6LdQpc89hQf5dGTTWd3GY+la17YX+ypqBts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rm/cRo/oGyzH1tfwTCsfohNDb50XjMbJBYT4wXPw+RkSY/fouF1H7IfyydkJOtn8wQ
         7q8A9USpqoqwOJFVzlskeIVu8nhzHyWLgD1rfwU+M5FXS5lhsLEFVesyE82n4Mlz3DUX
         VeK5k14A+gA8lOv56eiXprsAfb+Xyfnj2SGSg=
Received: by 10.142.151.36 with SMTP id y36mr9849wfd.329.1307518186036;
        Wed, 08 Jun 2011 00:29:46 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.44
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175323>

Checking whether a filename was part of stage 0 or stage 2 is code that we
would like to be able to call from a few other places without also
lstat()-ing the file to see if it exists in the working copy.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e59eec0..d19c519 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -622,7 +622,7 @@ static int dir_in_way(const char *path, int check_working_copy)
 	return check_working_copy && !lstat(path, &st) && S_ISDIR(st.st_mode);
 }
 
-static int would_lose_untracked(const char *path)
+static int was_tracked(const char *path)
 {
 	int pos = cache_name_pos(path, strlen(path));
 
@@ -639,11 +639,16 @@ static int would_lose_untracked(const char *path)
 		switch (ce_stage(active_cache[pos])) {
 		case 0:
 		case 2:
-			return 0;
+			return 1;
 		}
 		pos++;
 	}
-	return file_exists(path);
+	return 0;
+}
+
+static int would_lose_untracked(const char *path)
+{
+	return !was_tracked(path) && file_exists(path);
 }
 
 static int make_room_for_path(const char *path)
-- 
1.7.6.rc0.62.g2d69f
