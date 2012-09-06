From: Ken Dreyer <ktdreyer@ktdreyer.com>
Subject: [PATCH] cvsimport: strip all inappropriate tag strings
Date: Thu,  6 Sep 2012 10:36:53 -0600
Message-ID: <1346949413-17287-1-git-send-email-ktdreyer@ktdreyer.com>
References: <m2y5knjzh5.fsf@igel.home>
Cc: gitster@pobox.com, Ken Dreyer <ktdreyer@ktdreyer.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 18:37:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9f51-0005jW-OG
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 18:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757850Ab2IFQhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 12:37:15 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46642 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab2IFQhN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 12:37:13 -0400
Received: by obbuo13 with SMTP id uo13so2874723obb.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 09:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=jKFreAUGBrX4gxw1z2pj3tiNVmQM5Cg+0ZLEYwmp9Xo=;
        b=M1Nmj1qSwUxBWBXqgrW9ZWTJw6S4ChgdDgtMlxK1fnFIpwQDQBRVyRxML7rGzuRcMv
         p+DvrTLDyFhXZo/MI0nj7v6AA77qM7muRAMiQ5gT+3BqSfqDLwlxN9SZtXPTCMLc8MlS
         1uuq76v7/qxu8m84aa0+9/L/1s07OKS26B+GnShmdQOlK6k7Q3iAgqTf9i+u19nytSc+
         o40A2qLjfiigcd/+yB05BouXXSwUeKxJYVFqCk5ZmKjfxR26GKJzd4glDmDlPD9bz5Wk
         4mHoKRP5MlIZ7UcLhOVkKtWhdpB9Tl5EnlXUfqdkj6iP5BQtjjhNwTdcPXrq/J+mAu1d
         fjwg==
Received: by 10.60.32.136 with SMTP id j8mr3025483oei.0.1346949432772;
        Thu, 06 Sep 2012 09:37:12 -0700 (PDT)
Received: from phos.ktdreyer.com (c-67-190-20-168.hsd1.co.comcast.net. [67.190.20.168])
        by mx.google.com with ESMTPS id e9sm1858816oee.12.2012.09.06.09.37.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Sep 2012 09:37:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.4
In-Reply-To: <m2y5knjzh5.fsf@igel.home>
X-Gm-Message-State: ALoCoQnHXuiIY9dK5L7+48FZLLn0y1+rj7N76KzKwcwmVlwjizu0rtGcweenD4T/GVB9W3epG7v2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204902>

Certain characters such as "?" can be present in a CVS tag name, but
git does not allow these characters in tags. If git-cvsimport
encounters a CVS tag that git cannot handle, cvsimport will error and
refuse to continue the import beyond that point.

When importing CVS tags, strip all the inappropriate strings from the
tag names as we translate them to git tag names.

Provide more debugging information to the user if we've altered the
tag and the "git tag" command still fails. Also, warn the user if we
end up skipping an (unusable) tag altogether.

Signed-off-by: Ken Dreyer <ktdreyer@ktdreyer.com>
---

Thanks Andreas for catching that "ref.c" in the comments ought to be
"refs.c". I've corrected that in this latest version of the patch.

 git-cvsimport.perl | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 8d41610..8032f23 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -889,10 +889,37 @@ sub commit {
 		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
 		$xtag =~ tr/_/\./ if ( $opt_u );
 		$xtag =~ s/[\/]/$opt_s/g;
-		$xtag =~ s/\[//g;
 
-		system('git' , 'tag', '-f', $xtag, $cid) == 0
-			or die "Cannot create tag $xtag: $!\n";
+		# See refs.c for these rules.
+		# Tag cannot contain bad chars. (See bad_ref_char in refs.c.)
+		$xtag =~ s/[ ~\^:\\\*\?\[]//g;
+		# Other bad strings for tags:
+		# (See check_refname_component in refs.c.)
+		1 while $xtag =~ s/
+			(?: \.\.        # Tag cannot contain '..'.
+			|   \@{         # Tag cannot contain '@{'.
+			| ^ -           # Tag cannot begin with '-'.
+			|   \.lock $    # Tag cannot end with '.lock'.
+			| ^ \.          # Tag cannot begin...
+			|   \. $        # ...or end with '.'
+			)//xg;
+		# Tag cannot be empty.
+		if ($xtag eq '') {
+			warn("warning: ignoring tag '$tag'",
+			" with invalid tagname\n");
+			return;
+		}
+
+		if (system('git' , 'tag', '-f', $xtag, $cid) != 0) {
+			# We did our best to sanitize the tag, but still failed
+			# for whatever reason. Bail out, and give the user
+			# enough information to understand if/how we should
+			# improve the translation in the future.
+			if ($tag ne $xtag) {
+				print "Translated '$tag' tag to '$xtag'\n";
+			}
+			die "Cannot create tag $xtag: $!\n";
+		}
 
 		print "Created tag '$xtag' on '$branch'\n" if $opt_v;
 	}
-- 
1.7.11.4
