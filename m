From: Ken Dreyer <ktdreyer@ktdreyer.com>
Subject: [PATCH] cvsimport: strip all inappropriate tag strings
Date: Wed,  5 Sep 2012 15:39:54 -0600
Message-ID: <1346881194-19076-1-git-send-email-ktdreyer@ktdreyer.com>
References: <1346827469.1137.22.camel@umgah.localdomain>
Cc: gitster@pobox.com, Ken Dreyer <ktdreyer@ktdreyer.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 23:40:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9NKg-00018J-Pb
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 23:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759573Ab2IEVkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 17:40:12 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50964 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759549Ab2IEVkK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 17:40:10 -0400
Received: by iahk25 with SMTP id k25so1317189iah.19
        for <git@vger.kernel.org>; Wed, 05 Sep 2012 14:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=zTlbxCdhu+hDI+hyq2iQANBRI9gkW+gOz8e7LQe8R7U=;
        b=V7pLcnqooqKgeP/0Vn/ekvkCUyiw/V22Wc6lwP4eeYPtVakL2OI/J1p5aQuKe78cON
         6P95cQP1mpTWSHwotKLexTCyzV7ZzS+BamHHAvJ9RHPNYXFWnCKBoEPYDaALD+1LORRv
         AX2p6du3pihvdFwR6FliACsmxCNcN1wOZf+n79PDIiL5SPFJneCw5BBUtzBzuA19jX+1
         HdO8nJNeJJXQispZxStkh1hmodLhmk3+mOoH3++fyOwyxVHIfuX9tx+EL44xIYMCw7el
         UJMkpkojeUo6JdX6DVc5GYcxLgfrzPwRclTpTDcWxqB/NAUKgLWCeIxHCqAea+q+MatS
         arkw==
Received: by 10.42.151.71 with SMTP id d7mr22257339icw.18.1346881209218;
        Wed, 05 Sep 2012 14:40:09 -0700 (PDT)
Received: from phos.ktdreyer.com (c-67-190-20-168.hsd1.co.comcast.net. [67.190.20.168])
        by mx.google.com with ESMTPS id cu10sm349907igc.9.2012.09.05.14.40.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Sep 2012 14:40:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.4
In-Reply-To: <1346827469.1137.22.camel@umgah.localdomain>
X-Gm-Message-State: ALoCoQkn8Ul3h8/W7zGgYWp/kJp93W2cOYvJ79TLYkpfieXsKRfGwdHr+AdeTCYrSo+XBtTdWQam
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204849>

Certain characters such as "?" can be present in a CVS tag name, but
git does not allow these characters in tags. If git-cvsimport
encounters a CVS tag that git cannot handle, cvsimport will error and
refuse to continue the import beyond that point.

When importing CVS tags, strip all the inappropriate strings from the
tag names as we translate them to git tag names.

Signed-off-by: Ken Dreyer <ktdreyer@ktdreyer.com>
---

Thanks Junio and Alex for your review and comments. I've implemented
both of your suggestions in this patch.

 git-cvsimport.perl | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 8d41610..dda8a6d 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -889,7 +889,23 @@ sub commit {
 		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
 		$xtag =~ tr/_/\./ if ( $opt_u );
 		$xtag =~ s/[\/]/$opt_s/g;
-		$xtag =~ s/\[//g;
+
+		# See ref.c for these rules.
+		# Tag cannot contain bad chars. See bad_ref_char in ref.c.
+		$xtag =~ s/[ ~\^:\\\*\?\[]//g;
+		# Other bad strings for tags:
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
+			return;
+		}
 
 		system('git' , 'tag', '-f', $xtag, $cid) == 0
 			or die "Cannot create tag $xtag: $!\n";
-- 
1.7.11.4
