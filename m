From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3bis 2/4] git-am foreign patch support: autodetect some patch formats
Date: Wed, 27 May 2009 23:20:12 +0200
Message-ID: <1243459212-6074-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <1243416319-31477-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 23:20:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9QY6-0003P9-Ix
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 23:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757187AbZE0VUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 17:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756168AbZE0VUT
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 17:20:19 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:37964 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286AbZE0VUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 17:20:16 -0400
Received: by bwz22 with SMTP id 22so4997998bwz.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 14:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8TZuTy6UwvKWtwXNP2nL3e5IOrIIxV/4I6kuA07AaSM=;
        b=F3lBw/BzUut2m/3PyD9L8a0FXeqQ7unL2Yw3zqV7RhrCbvM/DEyhnINugJnGvbQeoa
         j+RdVX9YftThxJO7Fmv3VNOI8aedI0om9oukLCR7XKEHTxrvFPUdUjJXN3r8a/zEfqEr
         TM0u3ZMbSfGnSDc0FTBAjhqK5jlCTrqXu28X0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cWIp6TKTY5I3txuJf2STqlNFACWjiylr/GiON0JNX0iwQIUyyDuW7TiIvvQabb0tYd
         tf6EBWP3vR751O6l47KK9GBP+TP9WoJ+RPISU5I0VoXrK8C7WXolL1oto+4+w1uYXk3/
         mcMi5eB5oHxCWlsOe0caeZ4ESKJ7bsAEFm2FM=
Received: by 10.103.241.15 with SMTP id t15mr359680mur.85.1243459217381;
        Wed, 27 May 2009 14:20:17 -0700 (PDT)
Received: from localhost (host-78-15-9-104.cust-adsl.tiscali.it [78.15.9.104])
        by mx.google.com with ESMTPS id u26sm7579204mug.52.2009.05.27.14.20.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 14:20:16 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.274.gd2e8.dirty
In-Reply-To: <1243416319-31477-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120109>

Default to mbox format if input is from stdin. Otherwise, look at the
first few lines of the first patch to try to guess its format.

Include checks for mailboxes, stgit patch series, stgit single patches
and hg patches.
---
 git-am.sh |   40 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index da160de..8519701 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -142,7 +142,45 @@ check_patch_format () {
 	then
 		return 0
 	fi
-	patch_format=mbox
+
+	# we default to mbox format if input is from stdin and for
+	# directories
+	if test $# = 0 || test "x$1" = "x-" || test -d "$1"
+	then
+		patch_format=mbox
+		return 0
+	fi
+
+	# otherwise, check the first few lines of the first patch to try
+	# to detect its format
+	{
+		read l1
+		read l2
+		read l3
+		case "$l1" in
+		"From "*|"From: "*)
+			patch_format=mbox
+			;;
+		'# This series applies on GIT commit'*)
+			patch_format=stgit-series
+			;;
+		"# HG changeset patch")
+			patch_format=hg
+			;;
+		*)
+			# if the second line is empty and the third is
+			# a From, Author or Date entry, this is very
+			# likely an StGIT patch
+			case "$l2,$l3" in
+			,"From: "*|,"Author: "*|,"Date: "*)
+				patch_format=stgit
+				;;
+			*)
+				;;
+			esac
+			;;
+		esac
+	} < "$1"
 }
 
 split_patches () {
-- 
1.6.3.1.274.gd2e8.dirty
