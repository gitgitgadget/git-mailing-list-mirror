From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: [PATCH v5] Thunderbird: fix appp.sh format problems
Date: Sat, 01 Sep 2012 09:58:55 +0200
Message-ID: <5041C03F.8090706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: luksan@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 01 10:06:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7ij5-00030Q-3Q
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 10:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292Ab2IAIFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 04:05:38 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56979 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab2IAIFd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 04:05:33 -0400
Received: by wgbdr13 with SMTP id dr13so3135104wgb.1
        for <git@vger.kernel.org>; Sat, 01 Sep 2012 01:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=fd2W+Rxd/M1fMJUac4Hk24Y6IkNoSw/vXv4GMtMHHCU=;
        b=tC+99TxBb97YK8GMAy1aOgn7YwU1oP6Uvw4b4MSF0ehBHlnbcFhJhjR+thFCm6X85i
         W08VybSpSbVg2y7E1bVPerLoNfd0IC4bvcCO8SzJkOJTka5P4j841QCRAXHih0R2Xsbu
         yHEzSc58o26EVPn/XmqqMlOKP+ZW2qJZrWdgk4VQuNcixNplL1Ial4m6sdp+JqgbCvj+
         yrtJD4Ejt2lGTQFISoHqIJwWT76qgbkvIfr25NH6ykq4qDp+Ujl7yuDu7FTtm+Lpo1ax
         qdBg22V21mUjhvVLoo8Mb0YqV47gdg5y3tMFOncM/ZAL1WAYNHPd55ECCodH8jfGlj8y
         xKDQ==
Received: by 10.216.255.148 with SMTP id j20mr5874006wes.106.1346486731743;
        Sat, 01 Sep 2012 01:05:31 -0700 (PDT)
Received: from [80.183.108.16] (host16-108-dynamic.183-80-r.retail.telecomitalia.it. [80.183.108.16])
        by mx.google.com with ESMTPS id t7sm8160395wix.6.2012.09.01.01.05.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Sep 2012 01:05:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120601 Thunderbird/13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204622>

The current script has got the following problems:

1) It doesn't work if the language used by Thunderbird is not English;
2) The field To: filled by format-patch is not evaluated;
3) The field Cc: is loaded from Cc used in the commit message
instead of using the Cc field filled by format-patch in the email
header.

Added comments for point 1), added parsing of To: for point 2) and
added parsing of Cc: in the email header for point 3), removing the
Cc: parsing from commit message.

Signed-off-by: Marco Stornelli <marco.stornelli@gmail.com>
---

v5: fixed comments by Junio C Hamano
v4: create a tmp file to allow correct perl parsing
v3: parse only To: and Cc: in the email header, fix some comments
v2: changed the commit message to reflect better the script implementation
v1: first draft

 contrib/thunderbird-patch-inline/appp.sh |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
index 5eb4a51..5e4e892 100755
--- a/contrib/thunderbird-patch-inline/appp.sh
+++ b/contrib/thunderbird-patch-inline/appp.sh
@@ -6,6 +6,9 @@
 
 # ExternalEditor can be downloaded at http://globs.org/articles.php?lng=en&pg=2
 
+# NOTE: You must change some words in this script according to the language
+# used by Mozilla Thunderbird, as <Subject>, <To>, <Don't remove this line>.
+
 CONFFILE=~/.appprc
 
 SEP="-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-"
@@ -26,17 +29,31 @@ fi
 cd - > /dev/null
 
 SUBJECT=`sed -n -e '/^Subject: /p' "${PATCH}"`
-HEADERS=`sed -e '/^'"${SEP}"'$/,$d' $1`
 BODY=`sed -e "1,/${SEP}/d" $1`
 CMT_MSG=`sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}"`
 DIFF=`sed -e '1,/^---$/d' "${PATCH}"`
+PATCHTMP="${PATCH}.tmp"
+
+sed '/^$/q' "${PATCH}" > "${PATCHTMP}"
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
+rm -f ${PATCHTMP}
 
+# Change Subject: before next line according to Thunderbird language
+# for example to translate in Italian:
+# SUBJECT=`echo $SUBJECT | sed -e 's/^Subject:/Oggetto:/g'`
 echo "$SUBJECT" > $1
+# Change To: according to Thunderbird language
+echo "To: $TO" >> $1
 echo "Cc: $CCS" >> $1
-echo "$HEADERS" | sed -e '/^Subject: /d' -e '/^Cc: /d' >> $1
 echo "$SEP" >> $1
 
 echo "$CMT_MSG" >> $1
-- 
1.7.3.4
