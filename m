From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] git-mergetool: check return value from read
Date: Mon, 19 Sep 2011 19:40:52 -0400
Message-ID: <1316475652-35188-1-git-send-email-jaysoffian@gmail.com>
References: <7vaaa09skn.fsf@alter.siamese.dyndns.org>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 01:41:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5nSR-0007LV-9Q
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 01:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756892Ab1ISXk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 19:40:58 -0400
Received: from mail-vw0-f52.google.com ([209.85.212.52]:41576 "EHLO
	mail-vw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666Ab1ISXk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 19:40:57 -0400
Received: by vws10 with SMTP id 10so49421vws.11
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 16:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=loPEfbrOvA+iP8mMGhtrFDRHBipn74YevKkGFPBriVo=;
        b=sJ0x0Jy2Mr+ba6WR4PXf4e+jj8iPqINFAwX6awmm0V9aHdSbVg5q5thUoWtE0nRLX7
         Ls0ZDoqJfki6+ghiSup3IhEEI1did36AOYb/sn2Sdp90sshhFjFoOGuiOWFP4eT5Fz6p
         JT9DF2nb58WEVNjlCN0RaiY4/ba5z2WWluQ/4=
Received: by 10.52.175.233 with SMTP id cd9mr88881vdc.152.1316475656934;
        Mon, 19 Sep 2011 16:40:56 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com. [174.97.218.168])
        by mx.google.com with ESMTPS id ch14sm16171241vdb.9.2011.09.19.16.40.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Sep 2011 16:40:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc2.2.gdf97720
In-Reply-To: <7vaaa09skn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181720>

Mostly fixed already by 6b44577 (mergetool: check return value
from read, 2011-07-01). Catch two uses it missed.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
On Mon, Sep 19, 2011 at 4:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> We still seem to miss one "read" unchecked in resolve_symlink_merge(),
> even with this patch.
> [...]
> I suspect that it would be more consistent with 6b44577 (mergetool: check
> return value from read, 2011-07-01), which this patch is a follow-up to,
> to do:
>
> 	read answer || return 1
>
> here.

Thanks, sorry I missed that.

 git-mergetool--lib.sh |    2 +-
 git-mergetool.sh      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 8fc65d0400..ed630b208a 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -21,7 +21,7 @@ check_unchanged () {
 		do
 			echo "$MERGED seems unchanged."
 			printf "Was the merge successful? [y/n] "
-			read answer
+			read answer || return 1
 			case "$answer" in
 			y*|Y*) status=0; break ;;
 			n*|N*) status=1; break ;;
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 3c157bcd26..b6d463f0d0 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -72,7 +72,7 @@ describe_file () {
 resolve_symlink_merge () {
     while true; do
 	printf "Use (l)ocal or (r)emote, or (a)bort? "
-	read ans
+	read ans || return 1
 	case "$ans" in
 	    [lL]*)
 		git checkout-index -f --stage=2 -- "$MERGED"
-- 
1.7.7.rc2.2.gdf97720
