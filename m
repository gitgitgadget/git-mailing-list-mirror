From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/2] am: preliminary support for hg patches
Date: Mon, 29 Aug 2011 18:44:06 +0200
Message-ID: <1314636247-26125-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1314636247-26125-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 18:44:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy4x6-0000C8-61
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 18:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab1H2Qoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 12:44:38 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39775 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873Ab1H2Qog (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 12:44:36 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so5919990wwf.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 09:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LuCcTcq/uyYWU+v2pH/4JnRAj1lx4L5xadPPEubpK0Y=;
        b=NLK+V5xRbcAzw8qBnu4ZMc/CTpmr33Zkth4IMQQauT3GQv1mufJJnL0Hwivv4/nn/W
         I5KFrSezD4jUhiWiWW/yTHbg9n5NdXRUzQJtPs1Vwx6TG6cnhicolqxUXdt/Wg6bEqjt
         evhcHg4PPFac6JCozQ+gjt6ZAriG+FAeirWoI=
Received: by 10.216.167.5 with SMTP id h5mr4674078wel.96.1314636275721;
        Mon, 29 Aug 2011 09:44:35 -0700 (PDT)
Received: from localhost ([151.54.153.147])
        by mx.google.com with ESMTPS id q19sm473728wec.42.2011.08.29.09.44.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Aug 2011 09:44:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.331.g25483.dirty
In-Reply-To: <1314636247-26125-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180317>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-am.sh |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 4fff195..729ee51 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -311,6 +311,40 @@ split_patches ()
 		this=
 		msgnum=
 		;;
+	hg)
+		this=0
+		for hg in "$@"
+		do
+			this=`expr "$this" + 1`
+			msgnum=`printf "%0${prec}d" $this`
+			# hg stores changeset metadata in #-commented lines preceding
+			# the commit message and diff(s). The only metadata we care about
+			# are the User and Date (Node ID and Parent are hashes which are
+			# only relevant to the hg repository and thus not useful to us)
+			# Since we cannot guarantee that the commit message is in git-friendly
+			# format, we put no Subject: line and just consume all of the message
+			# as the body
+			perl -M'POSIX qw(strftime)' -ne 'BEGIN { $subject = 0 }
+				if ($subject) { print ; }
+				elsif (/^\# User /) { s/\# User/From:/ ; print ; }
+				elsif (/^\# Date /) {
+					my ($hashsign, $str, $time, $tz) = split ;
+					$tz = sprintf "%+05d", (0-$tz)/36;
+					print "Date: " .
+					      strftime("%a, %d %b %Y %H:%M:%S ",
+						       localtime($time))
+					      . "$tz\n";
+				} elsif (/^\# /) { next ; }
+				else {
+					print "\n", $_ ;
+					$subject = 1;
+				}
+			' < "$hg" > "$dotest/$msgnum" || clean_abort
+		done
+		echo "$this" > "$dotest/last"
+		this=
+		msgnum=
+		;;
 	*)
 		if test -n "$patch_format" ; then
 			clean_abort "$(eval_gettext "Patch format \$patch_format is not supported.")"
-- 
1.7.7.rc0.331.g25483.dirty
