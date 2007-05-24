From: Dana How <danahow@gmail.com>
Subject: [PATCH] Split packs from git-repack should have descending timestamps
Date: Thu, 24 May 2007 15:33:50 -0700
Message-ID: <465612CE.4080605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 00:34:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrLsc-0002cq-Mu
	for gcvg-git@gmane.org; Fri, 25 May 2007 00:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbXEXWdz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 18:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbXEXWdz
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 18:33:55 -0400
Received: from nz-out-0506.google.com ([64.233.162.237]:41109 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXEXWdy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 18:33:54 -0400
Received: by nz-out-0506.google.com with SMTP id n1so152831nzf
        for <git@vger.kernel.org>; Thu, 24 May 2007 15:33:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=JbdiREKhTHS1OBhgxYchJnEdf/4/T3RXq4yuWahtAJclPZ+grp9T/k+bG9W2LrX0nWbfHLpxK7klot7f6+lMuEkuvIn9qW7Pw0zisUuDs/IYW8WC1u6irN4n7U6BIMpPI50/s4LgNw9pVR4BMNEkAI4u8PT/rMLHtUV7OSlj7Yc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=rZc+YbF07umKvc4TJKu9bnjSnWtOmEbEWEgebtWXv0ElgJBd0RsqfXbhSxaGw15UY9nEOP+HUr2dOGjwgG5QsfyxbVsxeVhCsapm7MsvrBwvJNXGSHlGUiGSMkVIFBOe/IQ9GH1fy11THpC/Ubyc+fckqE/GXhBN/6HgrxOPkXc=
Received: by 10.114.52.1 with SMTP id z1mr1159233waz.1180046032779;
        Thu, 24 May 2007 15:33:52 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id m28sm1453528poh.2007.05.24.15.33.51;
        Thu, 24 May 2007 15:33:51 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48315>


If git-repack produces multiple split packs because
--max-pack-size was in effect,  the first pack written
should have the latest timestamp because:
(1) sha1_file.c:rearrange_packed_git() puts more recent
    pack files at the beginning of the search list;  and
(2) the most recent objects are written out first
    while packing.

This is based on next rather than master to avoid merge
conflicts with changes already in git-repack.sh due to
the --max-pack-size patchset.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 git-repack.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 4ea6e5b..953de4a 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -68,6 +68,7 @@ names=$(git-pack-objects --non-empty --all --reflog $args </dev/null "$PACKTMP")
 if [ -z "$names" ]; then
 	echo Nothing new to pack.
 fi
+restamp=
 for name in $names ; do
 	chmod a-w "$PACKTMP-$name.pack"
 	chmod a-w "$PACKTMP-$name.idx"
@@ -94,8 +95,12 @@ for name in $names ; do
 		exit 1
 	}
 	rm -f "$PACKDIR/old-pack-$name.pack" "$PACKDIR/old-pack-$name.idx"
+	restamp="$PACKDIR/pack-$name.pack $restamp"
 done
 
+# for split packs,  the first created should have most recent timestamp
+for file in $restamp ; do touch $file ; sleep 2; done &
+
 if test "$remove_redundant" = t
 then
 	# We know $existing are all redundant.
-- 
1.5.2.762.gd8c6-dirty
