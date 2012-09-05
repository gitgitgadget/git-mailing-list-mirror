From: Ken Dreyer <ktdreyer@ktdreyer.com>
Subject: [PATCH] cvsimport: strip all inappropriate tag strings
Date: Tue,  4 Sep 2012 22:26:04 -0600
Message-ID: <1346819164-8116-1-git-send-email-ktdreyer@ktdreyer.com>
References: <7vsjax6trn.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Ken Dreyer <ktdreyer@ktdreyer.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 06:26:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T97C6-0006QL-Dg
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 06:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999Ab2IEE0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 00:26:19 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56220 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab2IEE0S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 00:26:18 -0400
Received: by ieje11 with SMTP id e11so218713iej.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2012 21:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=vTGl5FgdvWyoatkouU8mGjd9utV1Ul/rgjfII45HlT4=;
        b=lzWNgAzyjL7KTfi/GmIXAbhGkjFp1hJwpxS/J7Wy77JLqQjJFAwhnOEUpH2YH3j5CO
         oFQnqoP8dkGAiI+m6JxRh2AfHZ3VXtCyCnFUd5Sr2FkQG5E8Y8oCTH5qXx9YTdK9Duy3
         DjtPpfwe2SsLNzTuO7dOxFczWvYRzc0T8Q99PeU8hz1s1TdnbUQFIv0AT9DqL1x2GdGl
         GmhieeT1US2cV5K9/cQJeDtWfbJyx7XXFlgJCDt1pUqjDmRA0wFjIvPtdq4oBw+XSUmb
         iFmEuL5Dxmy37XaUbHLV7Q5wGPNk77lpsMJ4M/iQntJfIFg4RswZto4kCpwCGTamXBNf
         FEpA==
Received: by 10.43.106.147 with SMTP id du19mr7089350icc.56.1346819177894;
        Tue, 04 Sep 2012 21:26:17 -0700 (PDT)
Received: from phos.ktdreyer.com (c-67-190-20-168.hsd1.co.comcast.net. [67.190.20.168])
        by mx.google.com with ESMTPS id qp6sm887450igc.0.2012.09.04.21.26.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Sep 2012 21:26:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.4
In-Reply-To: <7vsjax6trn.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQlAq9/1S9dUKn32+QKF75JIA8bXGDNFSoLQDbcTIJLZ9JthedFqpnZ1CRv3RumDKUyYVMAa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204797>

Certain characters such as "?" can be present in a CVS tag name, but
git does not allow these characters in tags. If git-cvsimport
encounters a CVS tag that git cannot handle, cvsimport will error and
refuse to continue the import beyond that point.

When importing CVS tags, strip all the inappropriate strings from the
tag names as we translate them to git tag names.

Signed-off-by: Ken Dreyer <ktdreyer@ktdreyer.com>
---

Thank you Junio for the review. I've taken your suggestion and amended
my patch to eliminate all the bad strings in ref.c. 

 git-cvsimport.perl | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 8d41610..0dc598d 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -889,7 +889,25 @@ sub commit {
 		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
 		$xtag =~ tr/_/\./ if ( $opt_u );
 		$xtag =~ s/[\/]/$opt_s/g;
-		$xtag =~ s/\[//g;
+
+		# See ref.c for these rules.
+		# Tag cannot end with a '/' - this is already handled above.
+		# Tag cannot contain bad chars. See bad_ref_char in ref.c.
+		$xtag =~ s/[ ~\^:\\\*\?\[]//g;
+		# Tag cannot contain '..'.
+		$xtag =~ s/\.\.//g;
+		# Tag cannot contain '@{'.
+		$xtag =~ s/\@{//g;
+		# Tag cannot end with '.lock'.
+		$xtag =~ s/(?:\.lock)+$//;
+		# Tag cannot begin or end with '.'.
+		$xtag =~ s/^\.+//;
+		$xtag =~ s/\.+$//;
+		# Tag cannot consist of a single '.' - already handled above.
+		# Tag cannot be empty.
+		if ($xtag eq '') {
+			return;
+		}
 
 		system('git' , 'tag', '-f', $xtag, $cid) == 0
 			or die "Cannot create tag $xtag: $!\n";
-- 
1.7.11.4
