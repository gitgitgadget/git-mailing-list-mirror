From: "Lars Hjemli" <hjemli@gmail.com>
Subject: [PATCH 2/5] git-submodule: remember to checkout after clone
Date: Mon, 11 Jun 2007 02:01:04 +0200
Message-ID: <op.ttqcz2oo9pspc6@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 01:58:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxXIw-0000M5-OS
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 01:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760591AbXFJX6h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 19:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760710AbXFJX6h
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 19:58:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:18525 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760591AbXFJX6g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2007 19:58:36 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1357437ugf
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 16:58:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:subject:from:content-type:mime-version:content-transfer-encoding:date:message-id:user-agent;
        b=GRNDIPnYeqB55rLafihZdOCAOP0Dn0oR6sE82V4rHqFV97SzrTuePDNAROxHYDcHdjWFKwaUNlhl9vePuVenxaRQV2dSCcFlMaJeTQKPZY0XE2qSnLs/VAPkO5Q/4kh4nF5Dxgfwgqmawwfurk4vjMRfCt/cl6wcxg+eutoOgJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:subject:from:content-type:mime-version:content-transfer-encoding:date:message-id:user-agent;
        b=Xxhq00yBUY2t9tjsA7zAz5TUrf6kIeEP5c/U/qPQHPsmmxNb8uf6Gj1sume5yCBtfeVPh/Nm9Ys1RnWvErGFRoFE02j+f19CqpC79B2tyLkWfNozT4ZOHEs/sq78hnYkO0iKV7pyRbQDEDO9u9Kx6iUyePxdlD/KAWqlwJLpIT4=
Received: by 10.67.22.14 with SMTP id z14mr4692180ugi.1181519915551;
        Sun, 10 Jun 2007 16:58:35 -0700 (PDT)
Received: from localhost ( [88.88.169.227])
        by mx.google.com with ESMTP id c24sm12470397ika.2007.06.10.16.58.33
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Jun 2007 16:58:34 -0700 (PDT)
User-Agent: Opera Mail/9.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49797>

After the initial clone of a submodule, no files would be checked out in
the submodule directory if the submodule HEAD was equal to the SHA-1
specified in the index of the containing repository. This fixes the problem
by simply ignoring submodule HEAD for a fresh clone.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
  git-submodule.sh |    9 +++++----
  1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8bdd99a..4a6d64d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -100,12 +100,13 @@ modules_update()
  		if ! test -d "$path"/.git
  		then
  			module_clone "$path" "$url" || exit
+			subsha1=
+		else
+			subsha1=$(unset GIT_DIR && cd "$path" &&
+				git-rev-parse --verify HEAD) ||
+			die "Unable to find current revision of submodule '$path'"
  		fi

-		subsha1=$(unset GIT_DIR && cd "$path" &&
-			git-rev-parse --verify HEAD) ||
-		die "Unable to find current revision of submodule '$path'"
-
  		if test "$subsha1" != "$sha1"
  		then
  			(unset GIT_DIR && cd "$path" && git-fetch &&
-- 
1.5.2.1.914.gbd3a7
