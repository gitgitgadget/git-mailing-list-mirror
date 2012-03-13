From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 3/4] contrib/diffall: teach diffall to handle working copy changes without tar
Date: Tue, 13 Mar 2012 13:45:32 -0400
Message-ID: <1331660734-10538-3-git-send-email-tim.henigan@gmail.com>
References: <1331660734-10538-1-git-send-email-tim.henigan@gmail.com>
Cc: tim.henigan@gmail.com
To: git@vger.kernel.org, gitster@poxbox.com
X-From: git-owner@vger.kernel.org Tue Mar 13 18:54:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Vvf-0006IE-F1
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 18:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758939Ab2CMRy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 13:54:29 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47474 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759207Ab2CMRy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 13:54:29 -0400
Received: by ghrr11 with SMTP id r11so831950ghr.19
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=w9HX4VCfmIvv6nnCJfDBZtOUYRTFxMIMwd6bQ2yWeGI=;
        b=VOI0YTcjkUg474sMqXMvMaF/kvgAdgZAkQoeq+sYap5rRkZ9+BR1x6ECmvAfYnaTe8
         UykmMdSHj9JW3ox3qSEFLWzso89xcvXNZOLI2nKijv6RK24IS2DYzYZg1FYN//Yvnbck
         U8GkEzlTmEi7DSG3Jji+hRl6KrbUTziXdeiAwfuH6WSIK9dvDFCaV0dMEtLsOMLnTWvL
         EgCPvt9SJq1KaoFHCp2J6v6FWKPm8FVYke81CNB4mtl3vLJWXMIoL9d4c65Sno9T15Bp
         hxfGCeH87+3V1Z2uta3ubukU7c0yQ2hLxT2LvKhO0O9YrWbn9teddJMXUyFXIyZ+izgX
         aJZA==
Received: by 10.224.195.201 with SMTP id ed9mr14043332qab.65.1331660787768;
        Tue, 13 Mar 2012 10:46:27 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id ha10sm4383532qab.14.2012.03.13.10.46.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 10:46:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0
In-Reply-To: <1331660734-10538-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193048>

The 'tar' utility is not available on all platforms (some only support
'gnutar').  An earlier commit created a work-around for this problem,
but a better solution is to eliminate the use of 'tar' completely.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 contrib/diffall/git-diffall |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/contrib/diffall/git-diffall b/contrib/diffall/git-diffall
index 443f646..8d243c7 100755
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
+			cp "$name" "$tmp/$right_dir"
+		fi
+	done < "$tmp/filelist"
 fi
 
 # Populate the tmp/left_dir directory with the files to be compared
-- 
1.7.10.rc0
