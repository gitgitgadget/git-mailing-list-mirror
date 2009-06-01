From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 (resend) 3/4] git-am foreign patch support: StGIT support
Date: Tue,  2 Jun 2009 01:10:40 +0200
Message-ID: <1243897841-8923-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1243897841-8923-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1243897841-8923-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1243897841-8923-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 01:11:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBGf2-0003zM-IQ
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 01:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbZFAXK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 19:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755992AbZFAXKz
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 19:10:55 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:48984 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135AbZFAXKw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 19:10:52 -0400
Received: by mail-bw0-f222.google.com with SMTP id 22so7792812bwz.37
        for <git@vger.kernel.org>; Mon, 01 Jun 2009 16:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MSbYRstnf/V/6dY49H/66Nw+e19LLIqGx+3H212KGJw=;
        b=A6ML19c91zkwYvN+Aui7TJqA4HZs37GQ9LC2jGVGvxQjEHID1GQZAsqJvgZf7dbufH
         W56PqWrFmRlOMYA9VkQTo3pc/z4S6G5A4KUe9q++jhZE6SLAhGw+6tLEB36fGmJvj47P
         Ll2PV7j95oR7nAOE7jfty8GfugIaYk6D080uk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kMHTT5jyi2bCCAZzOJbUe+yH2UDgAxNYzszmOHGRQgg9Vy8UttWSrl0EcVfqF2Byba
         BeMR9GWFttGzmjV/jdWiOOMg60eZYh8cFuZuP6FiX/mzhf0ArhYQJ46kfDbZmRjoy2SQ
         46hEPctutOpUVboN3Jhyj2eMLd/j0MWokTfCM=
Received: by 10.204.112.1 with SMTP id u1mr6220188bkp.37.1243897854794;
        Mon, 01 Jun 2009 16:10:54 -0700 (PDT)
Received: from localhost (host-78-13-53-56.cust-adsl.tiscali.it [78.13.53.56])
        by mx.google.com with ESMTPS id k29sm7895528fkk.17.2009.06.01.16.10.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 16:10:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.282.g9f93
In-Reply-To: <1243897841-8923-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120489>

Support StGIT patches by implementing a simple perl-based converter
mimicking StGIT's own parse_patch. Also support StGIT patch series by
'exploding' the index into a list of files and re-running the mail
splitting with patch_format set to stgit.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-am.sh |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 8519701..d05c9b4 100755
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
1.6.3.1.282.g9f93
