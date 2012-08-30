From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: [PATCH v2] Thunderbird: fix appp.sh format problems
Date: Thu, 30 Aug 2012 10:48:14 +0200
Message-ID: <503F28CE.2090400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 10:55:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T70Wi-0003KP-TJ
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 10:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370Ab2H3Iyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 04:54:54 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41209 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab2H3Iyx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 04:54:53 -0400
Received: by wgbdr13 with SMTP id dr13so1354733wgb.1
        for <git@vger.kernel.org>; Thu, 30 Aug 2012 01:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=+jlb0O8U6dGd75PG5CNUYRkt3JbS86ftPSxtMtPqfaQ=;
        b=YyO2mrx9riD3kF5NRwhOL1o2SD314U8kDf9YPRjfvtvJ6+Wa+SJQVWgg+REwW6fEV+
         Zfv5qnPJL/sbi+Vibrq2ORVRhc87maUiC+OOnB+aXK5waFuLOS4vcmcLC+VhFjuasH5T
         ogvB+iPXOHhYKILvbA7QWNoZCk4EakV6/1TvBR8Kxj4pbLGmv7lP6l6tbGTxQiedImzK
         0xzflFloLGUqJL37XwHe+55WpOuNocrtHpw8su4XKaDhFAoBsCjgEmCuiT2Z9uRlvuCq
         dKwTfWSawLpmkJlcB3WxDQ9R60mJZCpX6VHl5KzKNQGIIJw4zu3jaxmUdFJVWhxAFmD/
         +elw==
Received: by 10.216.194.102 with SMTP id l80mr2683981wen.19.1346316892328;
        Thu, 30 Aug 2012 01:54:52 -0700 (PDT)
Received: from [82.49.176.139] (host139-176-dynamic.49-82-r.retail.telecomitalia.it. [82.49.176.139])
        by mx.google.com with ESMTPS id k2sm3278416wiz.7.2012.08.30.01.54.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 30 Aug 2012 01:54:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120601 Thunderbird/13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204529>

The current script has got the following problems:

1) It doesn't work if the language used by Thunderbird is not English;
2) The field To: filled by format-patch is not evaluated;
3) The field Cc: is loaded only from Cc used in the commit message
instead of using even the Cc field filled by format-patch in the email
header.

Added comments for point 1). Fixed point 2) and 3).

Signed-off-by: Marco Stornelli <marco.stornelli@gmail.com>
---
v2: changed the commit message to reflect better the script implementation

 contrib/thunderbird-patch-inline/appp.sh |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
index 5eb4a51..e6e1b85 100755
--- a/contrib/thunderbird-patch-inline/appp.sh
+++ b/contrib/thunderbird-patch-inline/appp.sh
@@ -6,6 +6,9 @@
 
 # ExternalEditor can be downloaded at http://globs.org/articles.php?lng=en&pg=2
 
+# NOTE: You must change some words in this script according to the language
+# used by Mozilla Thunderbird, as <Subject>, <To>, <Don't remove this line>.
+
 CONFFILE=~/.appprc
 
 SEP="-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-"
@@ -26,17 +29,24 @@ fi
 cd - > /dev/null
 
 SUBJECT=`sed -n -e '/^Subject: /p' "${PATCH}"`
-HEADERS=`sed -e '/^'"${SEP}"'$/,$d' $1`
 BODY=`sed -e "1,/${SEP}/d" $1`
 CMT_MSG=`sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}"`
 DIFF=`sed -e '1,/^---$/d' "${PATCH}"`
 
-CCS=`echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
-	-e 's/^Signed-off-by: \(.*\)/\1,/gp'`
+export PATCH
+CCS=`perl -e 'local $/=undef; open FILE, $ENV{'PATCH'}; $text=<FILE>;
+close FILE; $cc = $1 if $text =~ /Cc: (.*?(,\n .*?)*)\n/s; $cc =~ s/\n//g;
+print $cc;'`
+
+TO=`perl -e 'local $/=undef; open FILE, $ENV{'PATCH'}; $text=<FILE>;
+close FILE; $to = $1 if $text =~ /To: (.*?(,\n .*?)*)\n/s; $to =~ s/\n//g;
+print $to;'`
 
+# Change <Subject> before next line according to Thunderbird language
 echo "$SUBJECT" > $1
+# Change <To> according to Thunderbird language
+echo "To: $TO" >> $1
 echo "Cc: $CCS" >> $1
-echo "$HEADERS" | sed -e '/^Subject: /d' -e '/^Cc: /d' >> $1
 echo "$SEP" >> $1
 
 echo "$CMT_MSG" >> $1
-- 
1.7.3.4
