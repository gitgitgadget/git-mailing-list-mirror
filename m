From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: [PATCH v3] Thunderbird: fix appp.sh format problems
Date: Fri, 31 Aug 2012 09:59:22 +0200
Message-ID: <50406EDA.2050505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 10:06:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7MFa-00040E-9n
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 10:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107Ab2HaIGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 04:06:07 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52353 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab2HaIF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 04:05:59 -0400
Received: by bkwj10 with SMTP id j10so1143413bkw.19
        for <git@vger.kernel.org>; Fri, 31 Aug 2012 01:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=FUiLlSnUM0GfnPtvUdhAqwZXtXIudWc9+zA9LfTdmCs=;
        b=dI95FzUPLcy3ygMrJg2Fn1cH3VTfcDaOhSOE6AeeJeBCP8eif0WYOX/SFYmEG4pXjl
         8vaw6ABEf24sl5rlLcDlHRZlJZ1wg5DiBQEMGZ9M5GBAkpjsQNZfyaMJwvAKAuFjQdSl
         c1yRpp0ADJ/oAdIWu5O37GcVwCtFZTzzpZ7jIs667nOVsMA7XrfJQkZ7ErtHQI5pnrnF
         PxlEe8hVZBlXZ7QpcyK2TouyeBCsDycdIUNBIqhOaNTiBqpiTzUjzbnYjsAA/IuJqpYm
         aLuxNMLz2BkxXhNZdssBuZUInY4l60UYQp/XA+0pTRLLDSzxh2pPcN9W1rsSZxLhkmA/
         qWDg==
Received: by 10.205.117.141 with SMTP id fm13mr3787325bkc.125.1346400358503;
        Fri, 31 Aug 2012 01:05:58 -0700 (PDT)
Received: from [82.49.192.78] (host78-192-dynamic.49-82-r.retail.telecomitalia.it. [82.49.192.78])
        by mx.google.com with ESMTPS id 25sm2781483bkx.9.2012.08.31.01.05.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 31 Aug 2012 01:05:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120601 Thunderbird/13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204582>

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

v3: parse only To: and Cc: in the email header, fix some comments
v2: changed the commit message to reflect better the script implementation
v1: first draft

 contrib/thunderbird-patch-inline/appp.sh |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
index 5eb4a51..9325366 100755
--- a/contrib/thunderbird-patch-inline/appp.sh
+++ b/contrib/thunderbird-patch-inline/appp.sh
@@ -6,6 +6,9 @@
 
 # ExternalEditor can be downloaded at http://globs.org/articles.php?lng=en&pg=2
 
+# NOTE: You must change some words in this script according to the language
+# used by Mozilla Thunderbird, as <Subject>, <To>, <Don't remove this line>.
+
 CONFFILE=~/.appprc
 
 SEP="-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-"
@@ -26,17 +29,27 @@ fi
 cd - > /dev/null
 
 SUBJECT=`sed -n -e '/^Subject: /p' "${PATCH}"`
-HEADERS=`sed -e '/^'"${SEP}"'$/,$d' $1`
 BODY=`sed -e "1,/${SEP}/d" $1`
 CMT_MSG=`sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}"`
 DIFF=`sed -e '1,/^---$/d' "${PATCH}"`
+MAILHEADER=`sed '/^$/q' "${PATCH}"`
+
+export MAILHEADER
+CCS=`perl -e 'local $/=undef; $text=$ENV{'MAILHEADER'};
+$cc = $1 if $text =~ /Cc: (.*?(,\n .*?)*)\n/s; $cc =~ s/\n//g;
+print $cc;'`
 
-CCS=`echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
-	-e 's/^Signed-off-by: \(.*\)/\1,/gp'`
+TO=`perl -e 'local $/=undef; $text=$ENV{'MAILHEADER'};
+$to = $1 if $text =~ /To: (.*?(,\n .*?)*)\n/s; $to =~ s/\n//g;
+print $to;'`
 
+# Change Subject: before next line according to Thunderbird language
+# for example to translate in Italian:
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
