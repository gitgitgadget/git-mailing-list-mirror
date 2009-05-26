From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 3/4] git-am foreign patch support: StGIT support
Date: Tue, 26 May 2009 02:38:09 +0200
Message-ID: <1243298290-5909-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1243298290-5909-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1243298290-5909-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1243298290-5909-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 02:39:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8khA-0004qX-R9
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 02:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbZEZAiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 20:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752839AbZEZAiW
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 20:38:22 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:40776 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbZEZAiV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 20:38:21 -0400
Received: by mail-fx0-f168.google.com with SMTP id 12so1678631fxm.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 17:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=FNkAvlJgNdvpC1Wpjuei7jHQqGAbrx8fC5q4h8i7/DI=;
        b=WkiJuR2sCst9lF30zSz+K3/Ak5CQ4ul0bqNAy2bwVEXMiTHHMU+jqvQIKGZZUEW4mP
         LMs+4JgCXAlKW6HOBkgFIlsdaHkIv++BwEcV42PcDWAmVIBYc0o5FsAHD0/GqxZ3wndr
         Toyz7AtCYijOwDG2wx8tsPmQe75iO//sDuHCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FvVhX2JqYXdsaATHXsxHJaR8a9fP9yCaGABWdhRD/nNp0TewlExIzzaQrYMQJXbA4n
         Vu4CnFcE2YUan/JmafXyzz8/F5A1DSKocybYxnigFA/0xFYzcRvIkwQFG8YvzdRFKChv
         BgL/XJ0/HnpfjIZqh5Qw31IEOhI+Akgd6s3zo=
Received: by 10.103.172.9 with SMTP id z9mr4040786muo.58.1243298302461;
        Mon, 25 May 2009 17:38:22 -0700 (PDT)
Received: from localhost (host-78-15-9-104.cust-adsl.tiscali.it [78.15.9.104])
        by mx.google.com with ESMTPS id j10sm193692mue.41.2009.05.25.17.38.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 17:38:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.248.gb44be
In-Reply-To: <1243298290-5909-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119990>

Support StGIT patches by implementing a simple awk-based converter
mimicking StGIT's own parse_patch. Also support StGIT patch series by
'exploding' the index into a lif of files and re-running the mail
splitting with patch_format set to stgit.
---
 git-am.sh |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 4cf66aa..1a00830 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -203,6 +203,66 @@ split_patches () {
 			exit 1
 		}
 		;;
+	stgit-series)
+		if test $# -ne 1
+		then
+			echo "Only one StGIT patch series can be applied at once"
+			exit 1
+		fi
+		series_dir=`dirname "$1"`
+		series_file="$1"
+		shift
+		{
+			set x
+			while read filename
+			do
+				set "$@" "$series_dir/$filename"
+			done
+			# remove the safety x
+			shift
+			# remove the arg coming from the first-line comment
+			shift
+		} < "$series_file"
+		# set the patch format appropriately
+		patch_format=stgit
+		# now handle the actual StGIT patches
+		split_patches "$@"
+		;;
+	stgit)
+		this=0
+		for stgit in "$@"
+		do
+			this=`expr "$this" + 1`
+			msgnum=`printf "%0${prec}d" $this`
+			touch "$dotest/$msgnum"
+			# Awk version of StGIT parse_patch. The first nonemptyline
+			# not starting with Author, From or Date is the
+			# subject, and the body starts with the next nonempty
+			# line not starting with Author, From or Date
+			awk 'BEGIN { subject=0 }
+			{
+				if (subject > 1)
+					print ;
+				else if (/^$/) next ;
+				else if (/^Author:/) print sub("Author", "From"), $ORS ;
+				else if (/^(From|Date)/) print ;
+				else if (subject) {
+					subject = 2 ;
+					print "" ;
+					print ;
+				} else {
+					print "Subject:", $0 ;
+					subject = 1;
+				}
+			}' "$stgit" > "$dotest/$msgnum" || {
+				echo "Failed to import $patch_format patch $stgit"
+				exit 1
+			}
+		done
+		echo "$this" > "$dotest/last"
+		this=
+		msgnum=
+		;;
 	*)
 		echo "Patch format $patch_format is not supported."
 		exit 1
-- 
1.6.3.1.248.gb44be
