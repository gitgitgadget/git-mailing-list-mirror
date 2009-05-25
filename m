From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/2] git-am foreign patch support: format autodetection
Date: Mon, 25 May 2009 21:14:05 +0200
Message-ID: <1243278846-14120-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1243278846-14120-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 21:14:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8fcx-0002ls-NU
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 21:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbZEYTOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 15:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752794AbZEYTOO
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 15:14:14 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:47103 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbZEYTOM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 15:14:12 -0400
Received: by mail-fx0-f168.google.com with SMTP id 12so1539209fxm.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 12:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tgIjAXgn1RxpD+Z6NvNxCGmPCQptXZTUlO5eVqpUomE=;
        b=Z+g0/4+Bo8m2FuNMNnt5Owe0VNDhhZTzMGVZs1gaJRyGdcb0Fgx35Tv6OkTuzpRpZt
         Y1VBlG1mw3FOOiZEVpVrzHZ92j2OSwj3VeBZ1iLh2bjQCi0kTiV/yt8Kc0KoYTjKFItN
         IpdBZO1hAM7W0lezhnVvAC2DoxiKEsJu0WhWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pnA8TH3uftHAsLiclREy2nrLZJ9UgDK72HAQ9K0TeubyGp5qBda0DGdjYKl71ys7l4
         RT3WQdqh0YDCabkZfZwmYB0coMV7uSuOt5DLD0M78iXDAozW9Y3vmG8mNfCMFZA9icl9
         e8mNl+VwMiXtZ21LBfSAdKgS4+JNby1F8BDuI=
Received: by 10.103.161.16 with SMTP id n16mr3864943muo.79.1243278854044;
        Mon, 25 May 2009 12:14:14 -0700 (PDT)
Received: from localhost (host-78-15-9-104.cust-adsl.tiscali.it [78.15.9.104])
        by mx.google.com with ESMTPS id j10sm9350532muh.15.2009.05.25.12.14.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 12:14:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.245.g4529.dirty
In-Reply-To: <1243278846-14120-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119955>

This patch is the first step towards the introduction of a framework to
allow git-am to import patches not in mailbox format.

Currently detected formats are
  * the mailbox format itself, which is assumed by default if input is
    form stdin
  * Mercurial's output from 'hg export'
  * Stacked Git's output from 'stg export' with the default export
    template; StGIT patch series are also detected and expanded.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-am.sh |  108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 578780b..3508b7e 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -274,10 +274,112 @@ else
 		done
 		shift
 	fi
-	git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" ||  {
-		rm -fr "$dotest"
+
+	# format of the patch(es) to be processed. we assume they are all
+	# of the same kind
+	patch_format=none
+
+	# from stdin we only accept mboxes, because peeking at stdin
+	# to detect the format is destructive
+	case $# in
+	0)
+		patch_format=mbox
+		;;
+	1)
+		if test x"$1" = x"-"
+		then
+			# stdin, so assume mbox
+			patch_format=mbox
+		else
+# a single non-stdin argument was passed, check if it's a StGit patch series
+# index by checking if the first line begins with '# This series'
+			{
+				read l1
+				case "$l1" in
+				'# This series '*)
+# replace the argument list with the files listed in the series index,
+# prefixing them with the series index dirname, skipping comment lines
+					series_dir=`dirname "$1"`
+					while read filename
+					do
+						set "$@" "$series_dir/$filename"
+					done
+					# remove the series index name
+					shift
+					# set the patch format appropriately
+					patch_format=stgit
+					;;
+				*)
+					;;
+				esac
+			} < "$1"
+		fi
+		;;
+	*)
+		;;
+	esac
+
+	# if the format is not defined yet, we can look at the first patch
+	# (which is not stdin) to try to understand the format.
+	if test $patch_format = none
+	then
+		echo "$patch_format"
+		# if it's a directory, assume mbox format
+		# TODO we could suppot StGIT patch series here too
+		if test -d "$1"
+		then
+			patch_format=mbox
+		else
+			# read the first four lines
+			{
+				read l1
+				read l2
+				read l3
+				read l4
+			} < "$1"
+			case "$l1" in
+			"# HG changeset patch")
+				patch_format=hg
+				;;
+			From\ *)
+				patch_format=mbox
+				;;
+			From:\ *)
+				patch_format=mbox
+				;;
+			*)
+				# if the second and fourth lines are empty,
+				# this might be an StGIT patch
+				if test x"$l2$l4" = x
+				then
+					case "$l3" in
+						From:\ *)
+							patch_format=stgit
+							;;
+						Author:\ *)
+							patch_format=stgit
+							;;
+						*)
+							;;
+					esac
+				fi
+				;;
+			esac
+		fi
+	fi
+
+	case "$patch_format" in
+	mbox)
+		git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" ||  {
+			rm -fr "$dotest"
+			exit 1
+		}
+		;;
+	*)
+		echo "Patch format $patch_format is not currently handled, sorry"
 		exit 1
-	}
+		;;
+	esac
 
 	# -s, -u, -k, --whitespace, -3, -C and -p flags are kept
 	# for the resuming session after a patch failure.
-- 
1.6.3.1.245.g4529.dirty
