From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetool--lib: specialize diff options for emerge and ecmerge
Date: Sat,  2 May 2009 01:57:21 -0700
Message-ID: <1241254641-54338-1-git-send-email-davvid@gmail.com>
Cc: charles@hashpling.org, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: gitster@pobox.com, markus.heidelberg@web.de,
	marcin.zalewski@gmail.com
X-From: git-owner@vger.kernel.org Sat May 02 10:57:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0B2f-0007QK-9s
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 10:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbZEBI5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 04:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbZEBI5o
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 04:57:44 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:10893 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbZEBI5m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 04:57:42 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1496957wah.21
        for <git@vger.kernel.org>; Sat, 02 May 2009 01:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=m/Y3vZ0CJ2mixbpgHuF/K/B9IKySAvilw4umzTpb7vk=;
        b=BxvIplBpA5RgY6VacZLyqytM3JSO8lT540lbYTksH8Q4rdB/GbT5gV4xnON4G+pB+M
         prfPudcfH3BIJxZYSfdXc+xWQp5GoV7/xUDY3i0Z65pjbpVKCo9jPaThERVm7IOtXgIS
         rD+mYiV+bzM2hwXoffBTu2HBbMhlQRvfTx4gg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xqAOnIzYzYMfALe/UStLrNp4SlOGw+8rwgitfOpq/IPni4G9x1MB7FS+sppNkFc1DK
         9zTLhjM95m41b8edUx6yTkU18cfEznC67rS9OeIjpLHtKe3L3D+HOD/NOFrpaU97FrnO
         owT/EvnkBm+VXfU5yN/j8vV1xQSIpeI08YOuI=
Received: by 10.114.192.17 with SMTP id p17mr2687225waf.196.1241254661820;
        Sat, 02 May 2009 01:57:41 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n9sm5398189wag.34.2009.05.02.01.57.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 May 2009 01:57:41 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc3.40.g75b44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118125>

The ecmerge documentation mentions the following form:

	ecmerge --mode=diff2 $1 $2

Since git-difftool is about diffing, we should use that
instead of --mode=merge2.  Likewise, this drops the
$MERGED argument to emerge, as discussed on the git list
($gmane/117930).

Signed-off-by: David Aguilar <davvid@gmail.com>
---

I tested the emacs (emerge) bit, but I'm not an emacs
user and I didn't really see any difference with or
without the patch.  Dropping $MERGED seems like the
right thing to do nonetheless.

In emerge/emacs mode, we still end up seeing the
merge pane.  My emacs-fu is not sophisticated
enough to know how to inhibit the merge pane
(if that's even something we'd want to do).


Regarding ecmerge:  I found the --mode=diff2
flag by reading their documenation:

http://www.elliecomputing.com/OnlineDoc/ecmerge_EN/52335623.asp

I don't have ecmerge installed at all, so I'm just
going by the book on this one.  It *looks* correct,
and probably is, but let it be known that I
haven't tested the ecmerge snippet myself.

 git-mergetool--lib.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index a16a279..8b5e6a8 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -228,8 +228,8 @@ run_merge_tool () {
 			fi
 			check_unchanged
 		else
-			"$merge_tool_path" "$LOCAL" "$REMOTE" \
-				--default --mode=merge2 --to="$MERGED"
+			"$merge_tool_path" --default --mode=diff2 \
+				"$LOCAL" "$REMOTE"
 		fi
 		;;
 	emerge)
@@ -248,7 +248,7 @@ run_merge_tool () {
 			status=$?
 		else
 			"$merge_tool_path" -f emerge-files-command \
-				"$LOCAL" "$REMOTE" "$(basename "$MERGED")"
+				"$LOCAL" "$REMOTE"
 		fi
 		;;
 	tortoisemerge)
-- 
1.6.3.rc3.40.g75b44
