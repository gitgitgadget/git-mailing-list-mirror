From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Fri, 31 Aug 2012 16:09:30 +0200
Message-ID: <5040C59A.6090303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 16:16:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7S1D-0005d7-Jk
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 16:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167Ab2HaOQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 10:16:09 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:58407 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227Ab2HaOQI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 10:16:08 -0400
Received: by wgbfm10 with SMTP id fm10so875660wgb.1
        for <git@vger.kernel.org>; Fri, 31 Aug 2012 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=9OSTqRz5B66dNXpU72HuNLZfudFWHHSjql/sXy9rk8o=;
        b=s3/cAB+OYO8tsYkHjqMPnRtwTGNfTa+jD5puUC0Pvu3Yea6mu5GuPuHS+bZt70Hzhj
         D/NH8hRIjOQQV+UttYp37KGt4Swuv5yTybe7IX7yHNXVBrRap6iP3YdPSBnDew6QOG+G
         cExb4xaLeTz6k2485i1DGn+epy11N2E+yO4ywZmuSsdH5r+2QsRMi9Jyv12FX0YJdDk3
         GZNRLuce4w8TaDHEcbkxyvvrB/6uaa3KU6lc7O+nceKy4dJY6qhEouFOybMOOTFVMZLb
         KoVXy5fDYVKHVMCd2rw48rBIz1RCuihCc3eAXUrUcfZXs9UJEIhKt3S4xLbtlwEDKGIt
         GXQw==
Received: by 10.216.119.6 with SMTP id m6mr4656536weh.215.1346422566551;
        Fri, 31 Aug 2012 07:16:06 -0700 (PDT)
Received: from [80.183.119.203] (host203-119-dynamic.183-80-r.retail.telecomitalia.it. [80.183.119.203])
        by mx.google.com with ESMTPS id t7sm1730418wix.6.2012.08.31.07.16.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 31 Aug 2012 07:16:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120601 Thunderbird/13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204585>

The current script has got the following problems:

1) It doesn't work if the language used by Thunderbird is not english;
2) The field To: filled by format-patch is not evaluated;
3) The field Cc: is loaded from Cc used in the commit message
instead of using the Cc field filled by format-patch in the email
header.

Added comments for point 1), added parsing of To: for point 2) and
added parsing of Cc: in the email header for point 3), removing the
Cc: parsing from commit message.

Signed-off-by: Marco Stornelli <marco.stornelli@gmail.com>
---

v4: create a tmp file to allow correct perl parsing
v3: parse only To: and Cc: in the email header, fix some comments
v2: changed the commit message to reflect better the script implementation
v1: first draft

 contrib/thunderbird-patch-inline/appp.sh |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
index 5eb4a51..0daeb29 100755
--- a/contrib/thunderbird-patch-inline/appp.sh
+++ b/contrib/thunderbird-patch-inline/appp.sh
@@ -6,6 +6,9 @@
 
 # ExternalEditor can be downloaded at http://globs.org/articles.php?lng=en&pg=2
 
+# NOTE: You must change some words in this script according to the language
+# used by Mozilla Thunderbird, as <Subject>, <To>, <Don't remove this line>.
+
 CONFFILE=~/.appprc
 
 SEP="-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-"
@@ -26,17 +29,32 @@ fi
 cd - > /dev/null
 
 SUBJECT=`sed -n -e '/^Subject: /p' "${PATCH}"`
-HEADERS=`sed -e '/^'"${SEP}"'$/,$d' $1`
 BODY=`sed -e "1,/${SEP}/d" $1`
 CMT_MSG=`sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}"`
 DIFF=`sed -e '1,/^---$/d' "${PATCH}"`
+MAILHEADER=`sed '/^$/q' "${PATCH}"`
+PATCHTMP="${PATCH}.tmp"
+
+echo $MAILHEADER > $PATCHTMP
+
+export PATCHTMP
+CCS=`perl -e 'local $/=undef; open FILE, $ENV{'PATCHTMP'}; $text=<FILE>;
+close FILE; $addr = $1 if $text =~ /Cc: (.*?(,\n .*?)*)\n/s; $addr =~ s/\n//g;
+print $addr;'`
+
+TO=`perl -e 'local $/=undef; open FILE, $ENV{'PATCHTMP'}; $text=<FILE>;
+close FILE; $addr = $1 if $text =~ /To: (.*?(,\n .*?)*)\n/s; $addr =~ s/\n//g;
+print $addr;'`
 
-CCS=`echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
-	-e 's/^Signed-off-by: \(.*\)/\1,/gp'`
+rm -rf $PATCHTMP
 
+# Change Subject: before next line according to Thunderbird language
+# for example:
+# SUBJECT=`echo $SUBJECT | sed -e 's/Subject/Oggetto/g'`
 echo "$SUBJECT" > $1
+# Change To: according to Thunderbird language
+echo "To: $TO" >> $1
 echo "Cc: $CCS" >> $1
-echo "$HEADERS" | sed -e '/^Subject: /d' -e '/^Cc: /d' >> $1
 echo "$SEP" >> $1
 
 echo "$CMT_MSG" >> $1
-- 
1.7.3.4
