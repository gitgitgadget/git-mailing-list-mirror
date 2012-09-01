From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Sat, 01 Sep 2012 09:52:55 +0200
Message-ID: <5041BED7.201@gmail.com>
References: <5040C59A.6090303@gmail.com> <7v3933oupe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <luksan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 10:00:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7ich-0003od-TG
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 10:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624Ab2IAH7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 03:59:35 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:35706 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab2IAH7e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 03:59:34 -0400
Received: by weyx8 with SMTP id x8so2055767wey.19
        for <git@vger.kernel.org>; Sat, 01 Sep 2012 00:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=q9aAHgRBtIyW/2HN1y9J/FCiRzJUlL9XOvzf0K28O1g=;
        b=q7a6cF5wxzIGGmA4nrlHuPHTgAm2Mw3/XiYwJpoRhLzo6YjvRiBWmqOaH40h8B1I0g
         fVxWl1w3Wso8yarvhrHmfTIgGSTHsnw7ot1kUUmYLZwbETMtCSUoksN5JbHoD1mtOOpS
         RX7xqEz2Z7r+oMwyQ/rqJH9e7hRmKqcgAWcv3U1ZeS6k1x0GkAX0LwVqeeL8axNoLY29
         QTpP+eU1L8vBpbXl7GzitX27UfCWG170eyfB92DFNch5tFP61xO6VKzYW8nGnVuAXc2z
         ZoK5Hy894/IzLTu6Ih/+ECz9Zfz066KHN289/lUG+ma0LN3WOqiX7P8/lNEGwS1SWnE7
         CD1A==
Received: by 10.216.234.231 with SMTP id s81mr1454049weq.34.1346486372783;
        Sat, 01 Sep 2012 00:59:32 -0700 (PDT)
Received: from [80.183.108.16] (host16-108-dynamic.183-80-r.retail.telecomitalia.it. [80.183.108.16])
        by mx.google.com with ESMTPS id fb20sm8141096wid.1.2012.09.01.00.59.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Sep 2012 00:59:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <7v3933oupe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204621>

Il 31/08/2012 19:08, Junio C Hamano ha scritto:
> Marco Stornelli <marco.stornelli@gmail.com> writes:
>
>> The current script has got the following problems:
>>
>> 1) It doesn't work if the language used by Thunderbird is not english;
>> 2) The field To: filled by format-patch is not evaluated;
>> 3) The field Cc: is loaded from Cc used in the commit message
>> instead of using the Cc field filled by format-patch in the email
>> header.
>>
>> Added comments for point 1), added parsing of To: for point 2) and
>> added parsing of Cc: in the email header for point 3), removing the
>> Cc: parsing from commit message.
>>
>> Signed-off-by: Marco Stornelli <marco.stornelli@gmail.com>
>> ---
>
> Thanks. [+cc Lukas].
>
> A few new issues your patch introduced:
>
>   - MAILHEADER is only set once to read from sed, and then used once
>     to be echoed to another file.  Just send sed output to the file.
>
>   - The "s/Subject/Oggetto/g" bit in my previous review.
>
> (find the fix-up at the end).
>
>>
>> v4: create a tmp file to allow correct perl parsing
>> v3: parse only To: and Cc: in the email header, fix some comments
>> v2: changed the commit message to reflect better the script implementation
>> v1: first draft
>>
>>   contrib/thunderbird-patch-inline/appp.sh |   26 ++++++++++++++++++++++----
>>   1 files changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
>> index 5eb4a51..0daeb29 100755
>> --- a/contrib/thunderbird-patch-inline/appp.sh
>> +++ b/contrib/thunderbird-patch-inline/appp.sh
>> @@ -6,6 +6,9 @@
>>
>>   # ExternalEditor can be downloaded at http://globs.org/articles.php?lng=en&pg=2
>>
>> +# NOTE: You must change some words in this script according to the language
>> +# used by Mozilla Thunderbird, as <Subject>, <To>, <Don't remove this line>.
>> +
>>   CONFFILE=~/.appprc
>>
>>   SEP="-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-"
>> @@ -26,17 +29,32 @@ fi
>>   cd - > /dev/null
>>
>>   SUBJECT=`sed -n -e '/^Subject: /p' "${PATCH}"`
>> -HEADERS=`sed -e '/^'"${SEP}"'$/,$d' $1`
>>   BODY=`sed -e "1,/${SEP}/d" $1`
>>   CMT_MSG=`sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}"`
>>   DIFF=`sed -e '1,/^---$/d' "${PATCH}"`
>> +MAILHEADER=`sed '/^$/q' "${PATCH}"`
>> +PATCHTMP="${PATCH}.tmp"
>> +
>> +echo $MAILHEADER > $PATCHTMP
>> +
>> +export PATCHTMP
>> +CCS=`perl -e 'local $/=undef; open FILE, $ENV{'PATCHTMP'}; $text=<FILE>;
>> +close FILE; $addr = $1 if $text =~ /Cc: (.*?(,\n .*?)*)\n/s; $addr =~ s/\n//g;
>> +print $addr;'`
>> +
>> +TO=`perl -e 'local $/=undef; open FILE, $ENV{'PATCHTMP'}; $text=<FILE>;
>> +close FILE; $addr = $1 if $text =~ /To: (.*?(,\n .*?)*)\n/s; $addr =~ s/\n//g;
>> +print $addr;'`
>>
>> -CCS=`echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
>> -	-e 's/^Signed-off-by: \(.*\)/\1,/gp'`
>> +rm -rf $PATCHTMP
>>
>> +# Change Subject: before next line according to Thunderbird language
>> +# for example:
>> +# SUBJECT=`echo $SUBJECT | sed -e 's/Subject/Oggetto/g'`
>>   echo "$SUBJECT" > $1
>> +# Change To: according to Thunderbird language
>> +echo "To: $TO" >> $1
>>   echo "Cc: $CCS" >> $1
>> -echo "$HEADERS" | sed -e '/^Subject: /d' -e '/^Cc: /d' >> $1
>>   echo "$SEP" >> $1
>>
>>   echo "$CMT_MSG" >> $1
>
>
> I also wonder what would happen if To: and Cc: in the input were
> split into continuation lines, but that was already present in the

Do you mean To: <mail1>,.....<mailN>\nCc: <mail1>,.....<mailN>?

> version before your patch, so the attached fix-up won't touch that
> part, but you may want to think about it.

Actually I'm trying the script in two ways: with --to and --cc of git 
format patch => multilines, and with a little script (see below) to have 
automatically Cc: from other script, in this case get_maintainer.pl from 
Linux kernel source tree, and it works perfectly. In the last case Cc: 
mail addresses are on the same line.
Maybe we can add even this script, but maybe it's too kernel-specific.


#!/bin/bash

if [[ ! $# -eq 1 ]]
then
         echo "Usage: command <PATH>, where PATH contains kernel and 
patches"
         exit
fi

PATCHPATH=${1%/}
for i in `ls $PATCHPATH/*.patch`
do

         CCN=`grep "Cc:" $i | wc -l`
         if [ $CCN -ge 1 ]
         then
                 echo "Cc: list already present, skip..."
         else

                 CCLIST=`$PATCHPATH/scripts/get_maintainer.pl 
--norolestats --no-git --separator , $i`

                 sed -n -e "/^$/,9999999 ! p" $i > $i.new
                 echo "Cc: $CCLIST" >> $i.new
                 sed -n -e "/^$/,9999999 p" $i >> $i.new
                 mv $i.new $i
         fi
done
