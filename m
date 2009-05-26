From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 2/4] git-am foreign patch support: autodetect some patch formats
Date: Tue, 26 May 2009 02:38:08 +0200
Message-ID: <1243298290-5909-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1243298290-5909-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1243298290-5909-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 02:39:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8khA-0004qX-7H
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 02:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbZEZAiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 20:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753133AbZEZAiV
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 20:38:21 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:54869 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbZEZAiT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 20:38:19 -0400
Received: by bwz22 with SMTP id 22so3441077bwz.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 17:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QEDJqMspCNo9SA87NPjf0eJzTOJJcmVzKznhbEst3dw=;
        b=lstcRn/y5Xqe3xrrmvxi8gPIqGEFz/gW7Kfs5Mg3ZAuBDp3SxjepkTFQ4/1MS0/o2U
         cBZ+XTTgo65kHyhG0K4+XVNT5KHH7VwXaTbooFqVCP9AfsvvmTLFpzq/itXSSMeWWrTs
         jj5eP/BCFwkHvaNrfwXAReyeXguJAFpetAFGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BiIBg/tK1bBaAoKMvbg1dece4iHgtVIgAV+YgTgufJ6gxBD+qC2DB2VV94a7fxk1mR
         1JPLpxDiTu6oci0nbC5ZERM6VmZCi55v8NZx4Q3pK556Ds7xDk0uuwdr4Kdh/GpUM684
         uKKlp10yux7oxL0ck3Epx+PRoquyqP9PmrBkE=
Received: by 10.103.244.10 with SMTP id w10mr4021802mur.71.1243298300087;
        Mon, 25 May 2009 17:38:20 -0700 (PDT)
Received: from localhost (host-78-15-9-104.cust-adsl.tiscali.it [78.15.9.104])
        by mx.google.com with ESMTPS id t10sm1404799muh.0.2009.05.25.17.38.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 17:38:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.248.gb44be
In-Reply-To: <1243298290-5909-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119987>

Default to mbox format if input is from stdin. Otherwise, look at the
first few lines of the first patch to try to guess its format.

Include checks for mailboxes, stgit patch series, stgit single patches
and hg patches.
---
 git-am.sh |   52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index da160de..4cf66aa 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -142,7 +142,57 @@ check_patch_format () {
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
+			From\ *)
+				patch_format=mbox
+				;;
+			From:\ *)
+				patch_format=mbox
+				;;
+			'# This series applies on GIT commit'*)
+				patch_format=stgit-series
+				;;
+			"# HG changeset patch")
+				patch_format=hg
+				;;
+			*)
+				# if the second line is empty and the third is
+				# a From, Author or Date entry, this is very
+				# likely an StGIT patch
+				if test "x$l2" = x
+				then
+					case "$l3" in
+						From:\ *)
+							patch_format=stgit
+							;;
+						Author:\ *)
+							patch_format=stgit
+							;;
+						Date:\ *)
+							patch_format=stgit
+							;;
+						*)
+							;;
+					esac
+				fi
+				;;
+		esac
+	} < "$1"
 }
 
 split_patches () {
-- 
1.6.3.1.248.gb44be
