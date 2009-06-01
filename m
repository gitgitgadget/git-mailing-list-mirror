From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 (resend) 1/4] git-am foreign patch support: introduce patch_format
Date: Tue,  2 Jun 2009 01:10:38 +0200
Message-ID: <1243897841-8923-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1243897841-8923-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 01:11:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBGf1-0003zM-9P
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 01:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722AbZFAXKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 19:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753341AbZFAXKu
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 19:10:50 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:34237 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577AbZFAXKt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 19:10:49 -0400
Received: by bwz22 with SMTP id 22so7792820bwz.37
        for <git@vger.kernel.org>; Mon, 01 Jun 2009 16:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=d1N7N89EJUA1zvEO/l0WCYRjJ2Bb56CWc1u6mYiLtyc=;
        b=mjnzyEZBfHHVJmcKNwlvFAFtdehg67/Tm5NVZoAnjDwSJu2R30AjQteJwHKFGQlDhc
         obkbiLNV+h1f2JSl6KRgL1Kg+GCLkSZjoEiouutSf1NUVCqdVKR6sEMsKU0D96492ky2
         Q9+uW4YzRuk8OBPp9R/3C6kxJHILGE60/J39Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mO5Bmdi99Zfj3B0y+fodlmeSop2dzMNxA55uQFPMtw1eryTU8kkI7BTbvw/2ohTzef
         K0nw3gqCZptUQO1KdjN7PyP1MkefHtDrUfG3WC2uw+6wrlXuJYZLZ2V2XXP5GXA/U4dM
         xJt4Gg9nyRERMd5vr91iGLar8Lrax0ltjW97g=
Received: by 10.204.120.70 with SMTP id c6mr6176278bkr.144.1243897849997;
        Mon, 01 Jun 2009 16:10:49 -0700 (PDT)
Received: from localhost (host-78-13-53-56.cust-adsl.tiscali.it [78.13.53.56])
        by mx.google.com with ESMTPS id 1sm103821fkt.57.2009.06.01.16.10.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 16:10:49 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.282.g9f93
In-Reply-To: <1243897841-8923-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120486>

Set up a framework to allow git-am to support patches which are not in
mailbox format. Introduce a patch_format variable that presently can
only be set from the command line, defaulting to 'mbox' (the only
supported format) if not specified.
---
 git-am.sh |   37 +++++++++++++++++++++++++++++++++----
 1 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 578780b..da160de 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -18,6 +18,7 @@ whitespace=     pass it through git-apply
 directory=      pass it through git-apply
 C=              pass it through git-apply
 p=              pass it through git-apply
+patch-format=   format the patch(es) are in
 reject          pass it through git-apply
 resolvemsg=     override error message when patch failure occurs
 r,resolved      to be used after a patch failure
@@ -133,6 +134,32 @@ It does not apply to blobs recorded in its index."
     unset GITHEAD_$his_tree
 }
 
+patch_format=
+
+check_patch_format () {
+	# early return if patch_format was set from the command line
+	if test -n "$patch_format"
+	then
+		return 0
+	fi
+	patch_format=mbox
+}
+
+split_patches () {
+	case "$patch_format" in
+	mbox)
+		git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" ||  {
+			rm -fr "$dotest"
+			exit 1
+		}
+		;;
+	*)
+		echo "Patch format $patch_format is not supported."
+		exit 1
+		;;
+	esac
+}
+
 prec=4
 dotest="$GIT_DIR/rebase-apply"
 sign= utf8=t keep= skip= interactive= resolved= rebasing= abort=
@@ -175,6 +202,8 @@ do
 		git_apply_opt="$git_apply_opt $(sq "$1=$2")"; shift ;;
 	-C|-p)
 		git_apply_opt="$git_apply_opt $(sq "$1$2")"; shift ;;
+	--patch-format)
+		shift ; patch_format="$1" ;;
 	--reject)
 		git_apply_opt="$git_apply_opt $1" ;;
 	--committer-date-is-author-date)
@@ -274,10 +303,10 @@ else
 		done
 		shift
 	fi
-	git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" ||  {
-		rm -fr "$dotest"
-		exit 1
-	}
+
+	check_patch_format "$@"
+
+	split_patches "$@"
 
 	# -s, -u, -k, --whitespace, -3, -C and -p flags are kept
 	# for the resuming session after a patch failure.
-- 
1.6.3.1.282.g9f93
