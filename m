From: Ken Dreyer <ktdreyer@ktdreyer.com>
Subject: [PATCH] cvsimport: strip all inappropriate tag strings
Date: Wed,  5 Sep 2012 23:42:58 -0600
Message-ID: <1346910178-13902-1-git-send-email-ktdreyer@ktdreyer.com>
References: <7vipbr6c4q.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Ken Dreyer <ktdreyer@ktdreyer.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 07:43:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9Us0-00019f-NJ
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 07:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab2IFFnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 01:43:08 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58225 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004Ab2IFFnG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 01:43:06 -0400
Received: by iahk25 with SMTP id k25so1678763iah.19
        for <git@vger.kernel.org>; Wed, 05 Sep 2012 22:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=9ZnaFFzXKgMMi5DgLIimaaQIkJ/tsa354hUzH++n84Y=;
        b=F49BObLEqAvOOpfp5qlsIFaiiDHo0Tg23cvWj2FUGKS65QmvbfZfValG1nlTbwG/Af
         Tly0j1D9v+9cYRd21JfgFdB91k9cR3bya3OzXuVistyRzkV1n+DfbfAwC0K4IvZ2w6mw
         7ibQId9gQSB2BTDqx927EI3S1RWy312xZ5InoMPfadu8u6g4Y8Nq2qpJ0cUqKHqtJ/y6
         opNfwd0Kup4ftEAhAYE29OAE15mZTpD2JdouQa2te95o194Ern5a6jZqfwBMTPmmeM0h
         Hwxm5Oy3c6zd6qWEWEhBDuH2umVChn4Rp5L0K8V7QcYxSIKdHohM3r7FBqJjDdtc7GTE
         D0Sw==
Received: by 10.42.180.201 with SMTP id bv9mr708681icb.43.1346910185984;
        Wed, 05 Sep 2012 22:43:05 -0700 (PDT)
Received: from phos.ktdreyer.com (c-67-190-20-168.hsd1.co.comcast.net. [67.190.20.168])
        by mx.google.com with ESMTPS id wm7sm3032718igb.6.2012.09.05.22.43.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Sep 2012 22:43:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.4
In-Reply-To: <7vipbr6c4q.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQlzrjosRBX8kAHYv8Lsxch/RundCgMGs7CLcZPJUBuQvIAVNvNRctO/JGIYRVw+BWAHsBmL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204865>

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

Thanks Junio for your suggestion about diagnosis messages. I've
implemented your suggestion by adding a warning statement if we skip a
tag altogether, and I also added some output if we've translated a tag
and the system() call still fails.

 git-cvsimport.perl | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 8d41610..3a30754 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -889,10 +889,36 @@ sub commit {
 		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
 		$xtag =~ tr/_/\./ if ( $opt_u );
 		$xtag =~ s/[\/]/$opt_s/g;
-		$xtag =~ s/\[//g;
 
-		system('git' , 'tag', '-f', $xtag, $cid) == 0
-			or die "Cannot create tag $xtag: $!\n";
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
