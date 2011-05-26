From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 3/3] git-mergetool--lib: Make vimdiff retain the current directory
Date: Wed, 25 May 2011 23:21:01 -0700
Message-ID: <1306390861-57054-1-git-send-email-davvid@gmail.com>
References: <1306387776-14593-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 08:21:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPTwu-0004Vg-9M
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 08:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886Ab1EZGVJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2011 02:21:09 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36512 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab1EZGVI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 02:21:08 -0400
Received: by pzk9 with SMTP id 9so169433pzk.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 23:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=n4IuhOb2pEhqkv905PCOQGOajwhVXIfYGlB+iqzIzZ8=;
        b=vSISswKkqG62/BPK8wVAqQDRGEdqDb5J73I/xhhMVhW/fbLVcgf0Cp5edwhS5ujNMe
         SWMHlejlvNQq7aoBwYxm7eAmhnvkGMazFP0gzZZIXjR8EgNrs79XDfmnHVSVT0JlTK/M
         ZfJChxOeKtaj8uE/iUKg2DWBeKTkxdo0qdITM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=x8OTBqHLmQJfiqKitrww/UwWPsZRIenv6eBEWWwmtkouhDmgoeaJQLFT1PML+o8vh7
         e2a9oMcILlBRj1jshsNW//gacKMQfqTUEO68V/HMVXN5Pd2q+yiK4unQkEbObUXtqDes
         wAoaTiJ4T3Ad2uGlOUUzVkhORMRgzQzvlNDHA=
Received: by 10.68.29.130 with SMTP id k2mr152994pbh.514.1306390867777;
        Wed, 25 May 2011 23:21:07 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id o8sm760597pbh.45.2011.05.25.23.21.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 23:21:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.2.660.g9f46
In-Reply-To: <1306387776-14593-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174497>

When using difftool with vimdiff it can be unexpected that
the current directory changes to the root of the project.
Tell vim to chdir to the value of $GIT_PREFIX to fix this.

Care is taken to quote the variable so that vim expands it.
This avoids problems when directory names contain spaces.

Signed-off-by: David Aguilar <davvid@gmail.com>
Reported-by: Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.com=
>
---
How embarassing.  I'm going to bed now.  This one works.

 git-mergetool--lib.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 4db9212..91f90ac 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -86,6 +86,11 @@ get_merge_tool_cmd () {
 }
=20
 run_merge_tool () {
+	# If GIT_PREFIX is empty then we cannot use it in tools
+	# that expect to be able to chdir() to its value.
+	GIT_PREFIX=3D${GIT_PREFIX:-.}
+	export GIT_PREFIX
+
 	merge_tool_path=3D"$(get_merge_tool_path "$1")" || exit
 	base_present=3D"$2"
 	status=3D0
@@ -188,6 +193,7 @@ run_merge_tool () {
 			check_unchanged
 		else
 			"$merge_tool_path" -R -f -d -c "wincmd l" \
+				-c 'cd $GIT_PREFIX' \
 				"$LOCAL" "$REMOTE"
 		fi
 		;;
@@ -199,6 +205,7 @@ run_merge_tool () {
 			check_unchanged
 		else
 			"$merge_tool_path" -R -f -d -c "wincmd l" \
+				-c 'cd $GIT_PREFIX' \
 				"$LOCAL" "$REMOTE"
 		fi
 		;;
--=20
1.7.5.2.663.gfcb11.dirty
