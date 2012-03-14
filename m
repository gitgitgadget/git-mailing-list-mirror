From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 3/5 v2] contrib/diffall: eliminate use of tar
Date: Wed, 14 Mar 2012 12:38:04 -0400
Message-ID: <1331743086-32304-4-git-send-email-tim.henigan@gmail.com>
References: <1331743086-32304-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 14 17:40:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7rF6-0004j9-W7
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 17:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030762Ab2CNQjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 12:39:54 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:52024 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965222Ab2CNQjy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 12:39:54 -0400
Received: by qcqw6 with SMTP id w6so981qcq.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 09:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uygNzapAVVg7B60OJUOAdmgMer/DWhZVLiz96PcwRGw=;
        b=W5WLC/HN1gOomGWoKj9/Y6Tbq/WhU5ZL1HTxaAk5/8X1GKw6wJEk/Jwk0FnxFG/b7E
         oxMriFzgAilV5XmXC39kBQt3XAKbcXsxjK8x463qAbLAikcX4M/6eT9YZaf2eefBbJkW
         V11YjAA3YdxLNq/bZ+bWdZRM/wxulr3JFEqWk1yGu3kMF18fvsLxQ+M8suv/rUkQNB9h
         wdsiglFIw4txoUSjDMOxMOtxuvJbQWKcFKCUBvntRlotIUcLX+lhKSBFznMno2NG+OyQ
         UEIgAbxCwDHlPbO1wGz0WJkMmbyOSszfRIuPloQXCWGRerrt195HQftTvSjbqkmlZLLv
         7mPA==
Received: by 10.229.78.227 with SMTP id m35mr1128894qck.0.1331743193154;
        Wed, 14 Mar 2012 09:39:53 -0700 (PDT)
Received: from localhost ([99.38.69.118])
        by mx.google.com with ESMTPS id fq1sm9646727qab.10.2012.03.14.09.39.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Mar 2012 09:39:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0
In-Reply-To: <1331743086-32304-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193130>

The 'tar' utility is not available on all platforms (some only support
'gnutar').  An earlier commit created a work-around for this problem,
but a better solution is to eliminate the use of 'tar' completely.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

Changes in v2:
  - Added missing '$name' component to the 'cp' target.  This bug
    resulted in modified working copy files being copied to the wrong
    location in the tmp directory.  It only affected files in sub-
    directories of the repo root.


 contrib/diffall/git-diffall |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/contrib/diffall/git-diffall b/contrib/diffall/git-diffall
index 443f646..f981ac1 100755
--- a/contrib/diffall/git-diffall
+++ b/contrib/diffall/git-diffall
@@ -202,10 +202,14 @@ then
 		fi
 	done < "$tmp/filelist"
 else
-	# Mac users have gnutar rather than tar
-	(tar --ignore-failed-read -c -T "$tmp/filelist" | (cd "$tmp/$right_dir" && tar -x)) || {
-		gnutar --ignore-failed-read -c -T "$tmp/filelist" | (cd "$tmp/$right_dir" && gnutar -x)
-	}
+	while read name
+	do
+		if test -e "$name"
+		then
+			mkdir -p "$tmp/$right_dir/$(dirname "$name")"
+			cp "$name" "$tmp/$right_dir/$name"
+		fi
+	done < "$tmp/filelist"
 fi
 
 # Populate the tmp/left_dir directory with the files to be compared
-- 
1.7.10.rc0
