From: Vicent Marti <tanoku@gmail.com>
Subject: [PATCH 13/16] repack: consider bitmaps when performing repacks
Date: Tue, 25 Jun 2013 01:23:10 +0200
Message-ID: <1372116193-32762-14-git-send-email-tanoku@gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Cc: Vicent Marti <tanoku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 01:24:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrG7f-0003eB-Mo
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 01:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193Ab3FXXYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 19:24:16 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:57301 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144Ab3FXXYK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 19:24:10 -0400
Received: by mail-wi0-f174.google.com with SMTP id k10so182498wiv.7
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 16:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4W6i9sUpzeMO4CZ4KgId++hk8sy1g1girY/7UC3esi4=;
        b=Majyp9Ddg8F6OLDl/qufqo7hcRnYz+ZbvCf8pbZKRsWFfoPggts2G1TR/vzY0O2BrT
         c330txqUP/r3497373ju8nn1CB9V81JL+cQntLldzwukWAoSrPSDaDSkzYIFI8IEsu9C
         53ZmfJdEl0jaGR4/GyE+Ai1Sw2ldPXQO2nfsaivHSmaoxOr7cchO57Kr95o50xT4oYFF
         YKZ6C3y2wN40keGweAUj0CdALjXhEXE/PrPxbpOJkiiBqAWnmNfnUf9LphExtPodhEFA
         21IFJKDWGJ0mCwFKafqZDbwd8wE0isHahmrDxTJgScMaXuM8gty2zaM3cAfhQfMIphT1
         aHog==
X-Received: by 10.180.36.205 with SMTP id s13mr7418693wij.31.1372116248931;
        Mon, 24 Jun 2013 16:24:08 -0700 (PDT)
Received: from localhost.localdomain (212.Red-81-32-36.dynamicIP.rima-tde.net. [81.32.36.212])
        by mx.google.com with ESMTPSA id x13sm593766wib.3.2013.06.24.16.24.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 16:24:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228933>

Since `pack-objects` will write a `.bitmap` file next to the `.pack` and
`.idx` files, this commit teaches `git-repack` to consider the new
bitmap indexes (if they exist) when performing repack operations.

This implies moving old bitmap indexes out of the way if we are
repacking a repository that already has them, and moving the newly
generated bitmap indexes into the `objects/pack` directory, next to
their corresponding packfiles.

Since `git repack` is now capable of handling these `.bitmap` files,
a normal `git gc` run on a repository that has `pack.usebitmaps` set
to true in its config file will generate bitmap indexes as part of the
garbage collection process.
---
 git-repack.sh |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 7579331..d5355ae 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -108,7 +108,7 @@ rollback=
 failed=
 for name in $names
 do
-	for sfx in pack idx
+	for sfx in pack idx bitmap
 	do
 		file=pack-$name.$sfx
 		test -f "$PACKDIR/$file" || continue
@@ -156,6 +156,11 @@ do
 	fullbases="$fullbases pack-$name"
 	chmod a-w "$PACKTMP-$name.pack"
 	chmod a-w "$PACKTMP-$name.idx"
+
+	test -f "$PACKTMP-$name.bitmap" &&
+	chmod a-w "$PACKTMP-$name.bitmap" &&
+	mv -f "$PACKTMP-$name.bitmap" "$PACKDIR/pack-$name.bitmap"
+
 	mv -f "$PACKTMP-$name.pack" "$PACKDIR/pack-$name.pack" &&
 	mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" ||
 	exit
@@ -166,6 +171,7 @@ for name in $names
 do
 	rm -f "$PACKDIR/old-pack-$name.idx"
 	rm -f "$PACKDIR/old-pack-$name.pack"
+	rm -f "$PACKDIR/old-pack-$name.bitmap"
 done
 
 # End of pack replacement.
@@ -180,7 +186,7 @@ then
 		  do
 			case " $fullbases " in
 			*" $e "*) ;;
-			*)	rm -f "$e.pack" "$e.idx" "$e.keep" ;;
+			*)	rm -f "$e.pack" "$e.idx" "$e.keep" "$e.bitmap" ;;
 			esac
 		  done
 		)
-- 
1.7.9.5
