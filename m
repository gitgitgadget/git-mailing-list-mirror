From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 3/4] git-am foreign patch support: StGIT support
Date: Wed, 27 May 2009 11:25:18 +0200
Message-ID: <1243416319-31477-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1243416319-31477-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1243416319-31477-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1243416319-31477-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 11:26:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9FOk-0007o4-02
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 11:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758895AbZE0JZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 05:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758492AbZE0JZg
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 05:25:36 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:36076 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758254AbZE0JZe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 05:25:34 -0400
Received: by fxm12 with SMTP id 12so2679843fxm.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 02:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=22OcaVzim2/bYNBzNHdSiFyX3d6zLE4lGPCLiKjSnP4=;
        b=fqbrjAK+PpZvh0XGiUI7shSuNGetdo8USc+vaCKLCAmdsMUIGG2UmRwxO6hnuwBFx5
         buOR3mucht1uEc1jxsKcJsi0B+ro5I9YUwcINhN00Twf9k9IAyx0FT4xBcdjI5vUYE53
         I0u5oYRDrXtFINUSozn2zcdb9b+ag+5C2bgLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=k8E1hU9ROsiA1Aj4yb0FwGR7ZSHjiHBfUJmtwmXnJTkdvC48MDjXsTP6B9AvizMW0r
         eOfzJQtvJ6kj5UDNlwC4yfJqKaYj+fCYVC3RKbs9nkG/mUZzjhqqliWuvxQ9MJg9VOq1
         BYHpN73LAYSC44VQ2gr3AavrLBUU0e/r/Aqu4=
Received: by 10.103.181.2 with SMTP id i2mr4930788mup.20.1243416334765;
        Wed, 27 May 2009 02:25:34 -0700 (PDT)
Received: from localhost (host-78-15-9-104.cust-adsl.tiscali.it [78.15.9.104])
        by mx.google.com with ESMTPS id 25sm558612mul.29.2009.05.27.02.25.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 02:25:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.274.gd2e8.dirty
In-Reply-To: <1243416319-31477-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120053>

Support StGIT patches by implementing a simple perl-based converter
mimicking StGIT's own parse_patch. Also support StGIT patch series by
'exploding' the index into a list of files and re-running the mail
splitting with patch_format set to stgit.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-am.sh |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 192ad1e..3757269 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -191,6 +191,63 @@ split_patches () {
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
+			# Perl version of StGIT parse_patch. The first nonemptyline
+			# not starting with Author, From or Date is the
+			# subject, and the body starts with the next nonempty
+			# line not starting with Author, From or Date
+			perl -ne 'BEGIN { $subject = 0 }
+				if ($subject > 1) { print ; }
+				elsif (/^\s+$/) { next ; }
+				elsif (/^Author:/) { print s/Author/From/ ; }
+				elsif (/^(From|Date)/) { print ; }
+				elsif ($subject) {
+					$subject = 2 ;
+					print "\n" ;
+					print ;
+				} else {
+					print "Subject: ", $_ ;
+					$subject = 1;
+				}
+			' < "$stgit" > "$dotest/$msgnum" || {
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
1.6.3.1.274.gd2e8.dirty
