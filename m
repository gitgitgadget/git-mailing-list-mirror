From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 3/3] git-mergetool--lib: Make vimdiff retain the current directory
Date: Sun, 22 May 2011 02:57:09 -0700
Message-ID: <1306058229-93800-3-git-send-email-davvid@gmail.com>
References: <7vwrhjxn4t.fsf@alter.siamese.dyndns.org>
 <1306058229-93800-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 22 11:57:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QO5Ph-0000m7-CW
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 11:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167Ab1EVJ5X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2011 05:57:23 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47799 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249Ab1EVJ5T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 05:57:19 -0400
Received: by pwi15 with SMTP id 15so2281257pwi.19
        for <git@vger.kernel.org>; Sun, 22 May 2011 02:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=tJWQOYqAN3HIwHZQIWIk9+ct6ZMXNk+6la+9/+/DewA=;
        b=O6rNekMnPAWWtauzNSrnfPSrgbmROtSBBV1QGu7DIgs6arFIrZkEsf4CHLRP7l8ARk
         5uxJKlDc0LLxnrnqPxYF66t8gK3g1spMezs8Dg0U/8Z0Kjc7xiwa3GX/GvMZkIXdQ7Rp
         z3xDYfEftYIMADaCdtCbQUlV2gorBRbCAnYWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wB2EM1oJD8xYJ709IWLZTFdHsWLB+IXS5Ggt0gF5kTFqQrwqIDYY+zOdJzmxb4JhxG
         0s8FyQEUVB+6C0zko3OBx4VoK4/ohSX/KxfUbRN8aGG5udKVw0AoeFKME1SxVMzhCcGp
         jZfvsNtUnEqhOIHdvWSVgR8945xfIexkZYvh4=
Received: by 10.142.240.14 with SMTP id n14mr612601wfh.360.1306058239092;
        Sun, 22 May 2011 02:57:19 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 25sm4866325wfb.22.2011.05.22.02.57.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 May 2011 02:57:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.2.317.g391b14
In-Reply-To: <1306058229-93800-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174187>

When using difftool with vimdiff it can be unexpected that
the current directory changes to the root of the project.
Tell vim to chdir to the value of $GIT_PREFIX to fix this.

Care is taken to quote the variable so that vim expands it.
This avoids problems when directory names contain spaces.

Signed-off-by: David Aguilar <davvid@gmail.com>
Reported-by: Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.com=
>
---
 git-mergetool--lib.sh |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 4db9212..ece6a08 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -187,7 +187,9 @@ run_merge_tool () {
 			fi
 			check_unchanged
 		else
+			resolve_git_prefix
 			"$merge_tool_path" -R -f -d -c "wincmd l" \
+				-c 'cd $GIT_PREFIX' \
 				"$LOCAL" "$REMOTE"
 		fi
 		;;
@@ -198,7 +200,9 @@ run_merge_tool () {
 				"$LOCAL" "$MERGED" "$REMOTE"
 			check_unchanged
 		else
+			resolve_git_prefix
 			"$merge_tool_path" -R -f -d -c "wincmd l" \
+				-c 'cd $GIT_PREFIX' \
 				"$LOCAL" "$REMOTE"
 		fi
 		;;
@@ -437,3 +441,12 @@ get_merge_tool () {
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
1.7.5.2.317.g391b14
