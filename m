From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 1/4] git-am foreign patch support: introduce patch_format
Date: Tue, 26 May 2009 02:38:07 +0200
Message-ID: <1243298290-5909-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1243298290-5909-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 02:39:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8kh9-0004qX-Jb
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 02:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbZEZAiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 20:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbZEZAiS
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 20:38:18 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:40776 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbZEZAiP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 20:38:15 -0400
Received: by mail-fx0-f168.google.com with SMTP id 12so1678631fxm.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 17:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MVa/2+F6SuDuL94S59FKqtmYr3EYyViZK1j8WFDMNak=;
        b=Pp77M7SMa4E1zvozTOCPw6kokG4ZlQjmcOEsQXW6kap1qrhlQE343KFn78q8wzsWcr
         kU00yI5Bpz0x7oEZbuw2p7DrQmeyQJmehj3cyZohEg+8+EaP6Z2m3V3r0ioUyroeQhb7
         dT3gua4lpkFjll2qavMt1cF8k0EGsskMeWt9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=f6fP21EmE5TKqjPAyUNjmH2jfrBmNGcEyWSf31m8eayjrgQq8Vdm/62e7LxgGWAOLv
         uTTVNd2p1wEeaco5aavIBqCGCINmDk/fT2IWiTqSULX8c7FZAwiEcLj1eZMMuAN3hIwY
         UHzI3csqLO7Ln7S9dzAu1k+aq8nCQDEEcHHkU=
Received: by 10.103.244.10 with SMTP id w10mr4021784mur.71.1243298297511;
        Mon, 25 May 2009 17:38:17 -0700 (PDT)
Received: from localhost (host-78-15-9-104.cust-adsl.tiscali.it [78.15.9.104])
        by mx.google.com with ESMTPS id u9sm1156072muf.37.2009.05.25.17.38.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 17:38:16 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.248.gb44be
In-Reply-To: <1243298290-5909-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119985>

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
1.6.3.1.248.gb44be
