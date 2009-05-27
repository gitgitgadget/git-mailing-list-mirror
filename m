From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 1/4] git-am foreign patch support: introduce patch_format
Date: Wed, 27 May 2009 11:25:16 +0200
Message-ID: <1243416319-31477-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1243416319-31477-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 11:25:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9FOF-0007YH-0n
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 11:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756410AbZE0JZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 05:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755967AbZE0JZ3
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 05:25:29 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:34862 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756238AbZE0JZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 05:25:27 -0400
Received: by mail-fx0-f168.google.com with SMTP id 12so2679773fxm.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 02:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VaihQHdpnciMgoY4uY2JkP7rEjqCbQBN146o9cCo3hQ=;
        b=se6MbgAnGBQGSfmaCcYYN9BpGK3ggoJOMUG0cV9s8sW+cKVNcHNHFQb+1aNWUTSODG
         fDTQGVPqKSWH1+9WYEXbFwx0DuCiVVrrYSR+CmU9VEJAa3dvc6vebYwNijPoNNIlHMOi
         laIulnSWk76b0styXIEJZf9s4aiHl4fOzM1Hg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=m9Z4EbXht3P9V4FdytFIZSZchL8TwOdywg8oLUPVAYaFA/ys53zLPl16erRPpp24r8
         APNxqVLcS3t9CgpT98zShK/RUK4bDLjuOY9OPj3lckHz1BWCoemUPYAC+j15u0jPx70l
         /4XzRP3SdkMOXIztnpe+imDLoVaWBg8y7fzw8=
Received: by 10.103.169.18 with SMTP id w18mr4944751muo.101.1243416329532;
        Wed, 27 May 2009 02:25:29 -0700 (PDT)
Received: from localhost (host-78-15-9-104.cust-adsl.tiscali.it [78.15.9.104])
        by mx.google.com with ESMTPS id j9sm1605463mue.21.2009.05.27.02.25.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 02:25:28 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.274.gd2e8.dirty
In-Reply-To: <1243416319-31477-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120051>

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
1.6.3.1.274.gd2e8.dirty
