From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: [MinGW port] Unable to repack on Clearcase dynamic views
Date: Wed, 30 May 2007 10:42:53 -0400
Message-ID: <fcaeb9bf0705300742u22b54c78vccbc037fb553141f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 30 16:43:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtPOI-0002dd-5R
	for gcvg-git@gmane.org; Wed, 30 May 2007 16:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbXE3OnB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 10:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753419AbXE3OnB
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 10:43:01 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:54646 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbXE3OnA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 10:43:00 -0400
Received: by an-out-0708.google.com with SMTP id d31so698730and
        for <git@vger.kernel.org>; Wed, 30 May 2007 07:42:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pqq7I0bpFvKIv9dT1nA5pTcD+Ni7i8H1d9YlnNajtJphcKdIMoiHlXSoHbTL63/Pj3hHntg6sTJDPnzHI+u67dMoGef9mhG1HjRD4sNbYbTWdQQQtC/VCrk9zKqgdbYxPA4VsbeAYCRD4uy8HOX3QIMDqLRsuXg3ESJH8PcnHfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OYIn7W13sCc8dfAbkriz/WEeFf8bPDTdUMt47joi7Z33vaXZQcKoGTyMY+7AIghJUK3c/qoemGj7Uq5iR4QYnREZLdrbPNg8lTS8ZEEC6VAoC07/KbKlUjQnSijslnfo/qfL1zGrTi+qqZyjTOyxADhI6mBmwVHS02FKe0aaPNQ=
Received: by 10.100.142.12 with SMTP id p12mr6044251and.1180536173334;
        Wed, 30 May 2007 07:42:53 -0700 (PDT)
Received: by 10.100.127.2 with HTTP; Wed, 30 May 2007 07:42:53 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48763>

Hi,

On clearcase dynamic views (kind of virtual drives), "mv -f a b" won't
work if "a" is read-only. Because git-repack.sh removes all write
permission before moving packs, it fails on clearcase dynamic views.

My approach is rather ugly. Does anyone have a better solution?

diff --git a/git-repack.sh b/git-repack.sh
index acb78ba..76a9525 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -86,10 +86,22 @@ else
 	mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" &&
 	test -f "$PACKDIR/pack-$name.pack" &&
 	test -f "$PACKDIR/pack-$name.idx" || {
-		echo >&2 "Couldn't replace the existing pack with updated one."
-		echo >&2 "The original set of packs have been saved as"
-		echo >&2 "old-pack-$name.{pack,idx} in $PACKDIR."
-		exit 1
+		# Clearcase dynamic views do not allow to move file without write permission
+		# Try the second time with write allowed
+		chmod u+w "$PACKTMP-$name.pack"
+		chmod u+w "$PACKTMP-$name.idx"
+
+		mv -f "$PACKTMP-$name.pack" "$PACKDIR/pack-$name.pack" &&
+		mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" &&
+		test -f "$PACKDIR/pack-$name.pack" &&
+		test -f "$PACKDIR/pack-$name.idx" || {
+			echo >&2 "Couldn't replace the existing pack with updated one."
+			echo >&2 "The original set of packs have been saved as"
+			echo >&2 "old-pack-$name.{pack,idx} in $PACKDIR."
+			exit 1
+		}
+		chmod a-w "$PACKDIR/pack-$name.pack"
+		chmod a-w "$PACKDIR/pack-$name.idx"
 	}
 	rm -f "$PACKDIR/old-pack-$name.pack" "$PACKDIR/old-pack-$name.idx"
 fi


-- 
Duy
