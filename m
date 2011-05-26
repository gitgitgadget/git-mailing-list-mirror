From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] git-mergetool--lib: Make vimdiff retain the current directory
Date: Wed, 25 May 2011 22:29:36 -0700
Message-ID: <1306387776-14593-1-git-send-email-davvid@gmail.com>
References: <1306381034-44190-3-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 07:35:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPTE9-000071-Pr
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 07:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746Ab1EZFfO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2011 01:35:14 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39720 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab1EZFfN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 01:35:13 -0400
Received: by pvg12 with SMTP id 12so158077pvg.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 22:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=QSsnRDT5oDC0aWAURjoKkRVdTKAomRIjiGOyZcsrEXI=;
        b=WpgRc/W5C1YPQ7aQuNXCkXjq0f3C6SDVspXT85kZdt+UgUMU+c4XCd+GBjb/6BkQUV
         6i972M0oQY8l1eLNF9vRMumqOlecxkoz49zpqU+ifoh24mB7eKMUj/Lbff3eyQoQu1cx
         e/mLQwS14ZS2Rcbye1SSs7bPIsTeYiL9dlJKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=SmDa6U9U8V3Vr4UsWL2Yu4I2vjgiSeb+u5SI/O4YiXGuOFC904LgoBqgHAblkfgMaJ
         uo7mEclVK6yGZlubC3Qny03RFxKS4dJWnWuWBbpj7uqNWBc5Lp9FHrMDAMS2C0+f4i0D
         kn7OTEIGCVTVYO5UxDFNJjIyFjbJnDroLtchU=
Received: by 10.142.196.12 with SMTP id t12mr50559wff.449.1306388111874;
        Wed, 25 May 2011 22:35:11 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id k6sm708431pbd.27.2011.05.25.22.35.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 22:35:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.2.663.g529a
In-Reply-To: <1306381034-44190-3-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174495>

When using difftool with vimdiff it can be unexpected that
the current directory changes to the root of the project.
Tell vim to chdir to the value of $GIT_PREFIX to fix this.

Care is taken to quote the variable so that vim expands it.
This avoids problems when directory names contain spaces.

Signed-off-by: David Aguilar <davvid@gmail.com>
Reported-by: Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.com=
>
---
Replacement for the last patch: uses ${GIT_PREFIX:-.}

 git-mergetool--lib.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 4db9212..43a9a28 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -86,6 +86,10 @@ get_merge_tool_cmd () {
 }
=20
 run_merge_tool () {
+	# If GIT_PREFIX is empty then we cannot use it in tools
+	# that expect to be able to chdir() to its value.
+	: GIT_PREFIX=3D${GIT_PREFIX:-.}
+
 	merge_tool_path=3D"$(get_merge_tool_path "$1")" || exit
 	base_present=3D"$2"
 	status=3D0
@@ -188,6 +192,7 @@ run_merge_tool () {
 			check_unchanged
 		else
 			"$merge_tool_path" -R -f -d -c "wincmd l" \
+				-c 'cd $GIT_PREFIX' \
 				"$LOCAL" "$REMOTE"
 		fi
 		;;
@@ -199,6 +204,7 @@ run_merge_tool () {
 			check_unchanged
 		else
 			"$merge_tool_path" -R -f -d -c "wincmd l" \
+				-c 'cd $GIT_PREFIX' \
 				"$LOCAL" "$REMOTE"
 		fi
 		;;
--=20
1.7.5.2.660.g9f46c
