From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 3/3] git-mergetool--lib: Make vimdiff retain the current directory
Date: Wed, 25 May 2011 20:37:14 -0700
Message-ID: <1306381034-44190-3-git-send-email-davvid@gmail.com>
References: <1306381034-44190-1-git-send-email-davvid@gmail.com>
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
X-From: git-owner@vger.kernel.org Thu May 26 05:37:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPRO6-0003ma-GX
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 05:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756650Ab1EZDh0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 23:37:26 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:60894 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756334Ab1EZDhY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 23:37:24 -0400
Received: by pxi16 with SMTP id 16so185449pxi.4
        for <git@vger.kernel.org>; Wed, 25 May 2011 20:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=1A9rboQbWCjc2wf2xxZXv0M8YLHzM0ZRMGH70odpAkI=;
        b=Rh6Vn2wcaOmllxp45jM7XqyS+SvceED+0+37muR9WoTGReRjGpLUs2okOZASOvth0s
         BKlPzfjMG9PS0j+dWB1ZwhT68CT0etCeCjk8+wQLOtC+AlsDLJxlA/xqmtlsafdlz+Pz
         c4XOllylwA/+zogC16zm5R0vHx2TBX8fho6Bk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=tSWclwQ0bQJ4Mzqep033ViACxFXLU0vPTgrt0nmw3r3MYJpcB8X0XuzCDABAxlU4iZ
         A1ZJxja27nyzlfVS8qpjgDDlM6EPOy9vQ7BQCWnR05ddwBfx1XvimV+rl5La3dDgbYsf
         wKm0i79IeYoP0o9tC3UQwN9O2kHaatBBeQmz4=
Received: by 10.68.32.10 with SMTP id e10mr109246pbi.408.1306381044090;
        Wed, 25 May 2011 20:37:24 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id y3sm577909pbg.16.2011.05.25.20.37.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 20:37:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.2.660.g9f46
In-Reply-To: <1306381034-44190-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174490>

When using difftool with vimdiff it can be unexpected that
the current directory changes to the root of the project.
Tell vim to chdir to the value of $GIT_PREFIX to fix this.

Care is taken to quote the variable so that vim expands it.
This avoids problems when directory names contain spaces.

Signed-off-by: David Aguilar <davvid@gmail.com>
Reported-by: Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.com=
>
---

This version of the patch resolves GIT_PREFIX unconditionally.
We did not do so before.

 git-mergetool--lib.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 4db9212..2cef8a2 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -89,6 +89,7 @@ run_merge_tool () {
 	merge_tool_path=3D"$(get_merge_tool_path "$1")" || exit
 	base_present=3D"$2"
 	status=3D0
+	resolve_git_prefix
=20
 	case "$1" in
 	araxis)
@@ -188,6 +189,7 @@ run_merge_tool () {
 			check_unchanged
 		else
 			"$merge_tool_path" -R -f -d -c "wincmd l" \
+				-c 'cd $GIT_PREFIX' \
 				"$LOCAL" "$REMOTE"
 		fi
 		;;
@@ -199,6 +201,7 @@ run_merge_tool () {
 			check_unchanged
 		else
 			"$merge_tool_path" -R -f -d -c "wincmd l" \
+				-c 'cd $GIT_PREFIX' \
 				"$LOCAL" "$REMOTE"
 		fi
 		;;
@@ -437,3 +440,12 @@ get_merge_tool () {
 	fi
 	echo "$merge_tool"
 }
+
+resolve_git_prefix() {
+	# If GIT_PREFIX is empty then we cannot use it in tools
+	# that expect to be able to chdir() to its value.
+	if test -z "$GIT_PREFIX"; then
+		GIT_PREFIX=3D.
+		export GIT_PREFIX
+	fi
+}
--=20
1.7.5.2.660.g9f46
