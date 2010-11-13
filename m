From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2] Use reflog in 'pull --rebase . foo'
Date: Sat, 13 Nov 2010 23:58:22 +0100
Message-ID: <1289689102-3507-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, santi@agolina.net,
	schwab@linux-m68k.org
X-From: git-owner@vger.kernel.org Sun Nov 14 06:05:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHUm6-0005j4-UM
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 06:05:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab0KNE7N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Nov 2010 23:59:13 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46664 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689Ab0KNE7M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Nov 2010 23:59:12 -0500
Received: by qwh5 with SMTP id 5so730832qwh.19
        for <git@vger.kernel.org>; Sat, 13 Nov 2010 20:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=DwvgmLxUZHEqBkh4WZOkVYOw2mLGa3snqrFj33ZS+7c=;
        b=f8xUFh0kPPwmVCFJZIBETb2Mn6sLwrwaefehqJrl5jjhc/0E4EC50hpG9w3Uqh7P8Z
         0kNuNXCNppdHMDsoUqAmgE3uTmS+28sfQaMTOC+jZHCZ7SJW2eHUUtP+2kxPeKeTugLx
         nH//+1oEg8aUruI7Zzyx0V/FsKRAgO3j8pQsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=q2DaLBzqkk3Jht7pxyVkJbs/mIslRZdsRft3f7RvjpQh6uFeg7zOSkszpZD4CVHdr0
         PFj1roa8h4jJQAORz/IUsDTA4hFbB7zZsk0pSgj8y3oHVcPCsCgTiGMwQNt2C3fTYShO
         LORL4MCEP/TqmUQOOB/Vay6KF5Ctgk+lcKvTY=
Received: by 10.224.178.131 with SMTP id bm3mr3807036qab.386.1289710751883;
        Sat, 13 Nov 2010 20:59:11 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id n7sm4174048qcu.28.2010.11.13.20.59.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Nov 2010 20:59:11 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.167.ga361b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161405>

Since c85c792 (pull --rebase: be cleverer with rebased upstream
branches, 2008-01-26), "git pull --rebase" has used the reflog to try t=
o
rebase from the old upstream onto the new upstream.

Make this work if the local repository is explicitly passed on the
command line as in 'git pull --rebase . foo'.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Acked-by: Santi B=C3=A9jar <santi@agolina.net>
---
Changes since v1: Removed some stuff that I should not have included in
the first place. (Thanks Santi and Andreas.)

 git-parse-remote.sh |   10 ++++++++--
 t/t5520-pull.sh     |    7 +++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 5f47b18..375a0ba 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -89,7 +89,13 @@ get_remote_merge_branch () {
 	    refs/heads/*) remote=3D${remote#refs/heads/} ;;
 	    refs/* | tags/* | remotes/* ) remote=3D
 	    esac
-
-	    [ -n "$remote" ] && echo "refs/remotes/$repo/$remote"
+	    [ -n "$remote" ] && case "$repo" in
+		.)
+		    echo "refs/heads/$remote"
+		    ;;
+		*)
+		    echo "refs/remotes/$repo/$remote"
+		    ;;
+	    esac
 	esac
 }
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 0b489f5..0470a81 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -222,4 +222,11 @@ test_expect_success 'git pull --rebase does not re=
apply old patches' '
 	)
 '
=20
+test_expect_success 'git pull --rebase against local branch' '
+	git checkout -b copy2 to-rebase-orig &&
+	git pull --rebase . to-rebase &&
+	test "conflicting modification" =3D "$(cat file)" &&
+	test file =3D "$(cat file2)"
+'
+
 test_done
--=20
1.7.3.2.167.ga361b
