From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 1/2] git: make "git -C '' <cmd>" not to barf
Date: Thu,  5 Mar 2015 16:26:07 +0530
Message-ID: <1425552967-22091-1-git-send-email-karthik.188@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 11:56:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTTSC-0008Bb-Jp
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 11:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880AbbCEK41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 05:56:27 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34601 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbbCEK4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 05:56:25 -0500
Received: by paceu11 with SMTP id eu11so27767542pac.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 02:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=S1WJg4x5DDZNONuD+xr7aOFK3j4bcWkgi7UiMcNvK/E=;
        b=l4LXwuTGCIDCySGz707X+Qv4+LtEawP5Kjkfmn9nyN5ub1yXolF6v/1uNht87ZoEDB
         qdPknjS3sZFYsCR2ScoJPUI/dP8F+qTTCD3yV/KH84Kt19BJM11piu5fye0hZW1I+bX2
         6F4TE2gvT1+q+5fD7ZYi/rCZC9XrJ40dlb45bPG5q+yyo+tY0CABhCOoU6Jm1k1vVCxk
         8nKvk1CItwEts2a9zt8xq9OT1KHdVRxd+0gfl6Rg6A/L0v4/grBmR97P+ZrNl34lR1Xp
         +8lOgzsRI6qQL0jdMd1zUKou28X2HmrEOWW39mBrIXAnSir0nu6GRtM56PodkBhxB4Oc
         osGg==
X-Received: by 10.66.159.138 with SMTP id xc10mr14673862pab.141.1425552985428;
        Thu, 05 Mar 2015 02:56:25 -0800 (PST)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id dt10sm6561534pdb.82.2015.03.05.02.56.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Mar 2015 02:56:24 -0800 (PST)
X-Mailer: git-send-email 2.3.1.169.g2532f2d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264828>

It now acts like "cd ''" and does not barf and treats
it as a no-op, this is usefull if a caller function
does not want to change directory and hence gives no
path value, which would have generally caused git to
output an undesired error message.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 git.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index 8c7ee9c..ea92a64 100644
--- a/git.c
+++ b/git.c
@@ -204,10 +204,14 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				fprintf(stderr, "No directory given for -C.\n" );
 				usage(git_usage_string);
 			}
-			if (chdir((*argv)[1]))
-				die_errno("Cannot change to '%s'", (*argv)[1]);
-			if (envchanged)
-				*envchanged = 1;
+			if (*(*argv)[1] == 0)
+				; /* Ignore "" as a directory */
+			else {
+				if (chdir((*argv)[1]))
+					die_errno("Cannot change to '%s'", (*argv)[1]);
+				if (envchanged)
+					*envchanged = 1;
+			}
 			(*argv)++;
 			(*argc)--;
 		} else {
-- 
2.3.1.167.g7f4ba4b.dirty
