From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: [PATCH] Thunderbird: fix appp.sh format problems
Date: Thu, 30 Aug 2012 10:31:34 +0200
Message-ID: <503F24E6.3060506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 10:38:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T70GY-0006Hp-3w
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 10:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740Ab2H3IiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 04:38:11 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45126 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944Ab2H3IiK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 04:38:10 -0400
Received: by bkwj10 with SMTP id j10so666774bkw.19
        for <git@vger.kernel.org>; Thu, 30 Aug 2012 01:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=w27+WlNfYTeRzKYVqcK+lVkjnHvXAIrPfzDRO+gtB6o=;
        b=vgCGy0cM45OYe/pwC1JdKNBbrV3MDnepvtL/huznIV2nZqR4/8P8JsoCiN5TpkjiN+
         FjXWFt1JqevoUBp0tDZedZWbfZdE1qg25Vg+OuP8rBImysdVxnG2BjzetuYAqkeDtfh8
         r+s3HsuANn+xM9I4Xi03KiC/wiYYHGSSgj2YPu8bmtIHLAkuw6h/c0Et2DJoYkNVAjtY
         dqBasFSP+zu3oGhmuLoJto4efJDI72gD55Cz9szfTBCrTUK6M8mhrUAR21HJvM6hpt24
         rIILMgTBou76mUdYm96WnGEeK49531je+h5vsEokKpYuYEums4tunUyc1Wu5g6F719Fd
         4BpQ==
Received: by 10.205.130.17 with SMTP id hk17mr2353398bkc.76.1346315888874;
        Thu, 30 Aug 2012 01:38:08 -0700 (PDT)
Received: from [82.49.176.139] (host139-176-dynamic.49-82-r.retail.telecomitalia.it. [82.49.176.139])
        by mx.google.com with ESMTPS id n5sm522552bkv.14.2012.08.30.01.38.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 30 Aug 2012 01:38:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120601 Thunderbird/13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204528>

The current script has got the following problems:

1) It doesn't work if the language used by Thunderbird is not English;
2) The field To: filled by format-patch is not evaluated;
3) The field Cc: is loaded from Cc used in the commit message
instead of using the Cc field filled by format-patch in the email
header. In addition, in the commit message we can find several tags
(acked-by, tested-by, reported-by...), so it'd better to use only the
information provided by format-patch.

Added comments for point 1). Fixed point 2) and 3).

Signed-off-by: Marco Stornelli <marco.stornelli@gmail.com>
---
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
