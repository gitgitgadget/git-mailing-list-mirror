From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Fri, 31 Aug 2012 10:08:29 -0700
Message-ID: <7v3933oupe.fsf@alter.siamese.dyndns.org>
References: <5040C59A.6090303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>
To: Marco Stornelli <marco.stornelli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 19:08:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7Uhz-00070y-Tr
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 19:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab2HaRIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 13:08:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47382 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754365Ab2HaRIc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 13:08:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDD3F8934;
	Fri, 31 Aug 2012 13:08:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EyK74JbAJ+ssrfh3qGCSCr8rkFk=; b=g5//nC
	um4r/4APAVedqbcEQg2dGv/xsSt5SQEGYsYt67pva7JubmKia+thTwI1Jof0GN4M
	oGpq2TkCjMlpcJhEdhQu5sKrIeCzuPTfibckJ5VnxgNEXNQ3q2T7qCFgZraKmEON
	0QoIb7U3cXfLdRjBzhs9GJFBxjwkJtCYy68EI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zay6/4d56h162DiE9DkrTKumiSrNfKvg
	+u5mIRq+Cdc8juSkWDYNd0W+WgjboONcoMtaVobnOET54DffB59U12RSFzrZEK2L
	YWSFqRVsX9HB/Fsa9TiVo5i2l566t5TRpQWhFjOVsYD9pSM2DokH1aDgLoUrfwJ1
	24DL/2HyzX0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D36058933;
	Fri, 31 Aug 2012 13:08:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A9D48932; Fri, 31 Aug 2012
 13:08:30 -0400 (EDT)
In-Reply-To: <5040C59A.6090303@gmail.com> (Marco Stornelli's message of "Fri,
 31 Aug 2012 16:09:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D46AB4E-F38E-11E1-9B08-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204593>

Marco Stornelli <marco.stornelli@gmail.com> writes:

> The current script has got the following problems:
>
> 1) It doesn't work if the language used by Thunderbird is not english;
> 2) The field To: filled by format-patch is not evaluated;
> 3) The field Cc: is loaded from Cc used in the commit message
> instead of using the Cc field filled by format-patch in the email
> header.
>
> Added comments for point 1), added parsing of To: for point 2) and
> added parsing of Cc: in the email header for point 3), removing the
> Cc: parsing from commit message.
>
> Signed-off-by: Marco Stornelli <marco.stornelli@gmail.com>
> ---

Thanks. [+cc Lukas].

A few new issues your patch introduced:

 - MAILHEADER is only set once to read from sed, and then used once
   to be echoed to another file.  Just send sed output to the file.

 - The "s/Subject/Oggetto/g" bit in my previous review.

(find the fix-up at the end).

>
> v4: create a tmp file to allow correct perl parsing
> v3: parse only To: and Cc: in the email header, fix some comments
> v2: changed the commit message to reflect better the script implementation
> v1: first draft
>
>  contrib/thunderbird-patch-inline/appp.sh |   26 ++++++++++++++++++++++----
>  1 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
> index 5eb4a51..0daeb29 100755
> --- a/contrib/thunderbird-patch-inline/appp.sh
> +++ b/contrib/thunderbird-patch-inline/appp.sh
> @@ -6,6 +6,9 @@
>  
>  # ExternalEditor can be downloaded at http://globs.org/articles.php?lng=en&pg=2
>  
> +# NOTE: You must change some words in this script according to the language
> +# used by Mozilla Thunderbird, as <Subject>, <To>, <Don't remove this line>.
> +
>  CONFFILE=~/.appprc
>  
>  SEP="-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-"
> @@ -26,17 +29,32 @@ fi
>  cd - > /dev/null
>  
>  SUBJECT=`sed -n -e '/^Subject: /p' "${PATCH}"`
> -HEADERS=`sed -e '/^'"${SEP}"'$/,$d' $1`
>  BODY=`sed -e "1,/${SEP}/d" $1`
>  CMT_MSG=`sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}"`
>  DIFF=`sed -e '1,/^---$/d' "${PATCH}"`
> +MAILHEADER=`sed '/^$/q' "${PATCH}"`
> +PATCHTMP="${PATCH}.tmp"
> +
> +echo $MAILHEADER > $PATCHTMP
> +
> +export PATCHTMP
> +CCS=`perl -e 'local $/=undef; open FILE, $ENV{'PATCHTMP'}; $text=<FILE>;
> +close FILE; $addr = $1 if $text =~ /Cc: (.*?(,\n .*?)*)\n/s; $addr =~ s/\n//g;
> +print $addr;'`
> +
> +TO=`perl -e 'local $/=undef; open FILE, $ENV{'PATCHTMP'}; $text=<FILE>;
> +close FILE; $addr = $1 if $text =~ /To: (.*?(,\n .*?)*)\n/s; $addr =~ s/\n//g;
> +print $addr;'`
>  
> -CCS=`echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
> -	-e 's/^Signed-off-by: \(.*\)/\1,/gp'`
> +rm -rf $PATCHTMP
>  
> +# Change Subject: before next line according to Thunderbird language
> +# for example:
> +# SUBJECT=`echo $SUBJECT | sed -e 's/Subject/Oggetto/g'`
>  echo "$SUBJECT" > $1
> +# Change To: according to Thunderbird language
> +echo "To: $TO" >> $1
>  echo "Cc: $CCS" >> $1
> -echo "$HEADERS" | sed -e '/^Subject: /d' -e '/^Cc: /d' >> $1
>  echo "$SEP" >> $1
>  
>  echo "$CMT_MSG" >> $1


I also wonder what would happen if To: and Cc: in the input were
split into continuation lines, but that was already present in the
version before your patch, so the attached fix-up won't touch that
part, but you may want to think about it.

 contrib/thunderbird-patch-inline/appp.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git c/contrib/thunderbird-patch-inline/appp.sh w/contrib/thunderbird-patch-inline/appp.sh
index 0daeb29..18d8bfa 100755
--- c/contrib/thunderbird-patch-inline/appp.sh
+++ w/contrib/thunderbird-patch-inline/appp.sh
@@ -11,6 +11,7 @@
 
 CONFFILE=~/.appprc
 
+# Change "Dont' remove this line" to what Thunderbird writs for your language
 SEP="-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-"
 if [ -e "$CONFFILE" ] ; then
 	LAST_DIR=`grep -m 1 "^LAST_DIR=" "${CONFFILE}"|sed -e 's/^LAST_DIR=//'`
@@ -32,10 +33,8 @@ SUBJECT=`sed -n -e '/^Subject: /p' "${PATCH}"`
 BODY=`sed -e "1,/${SEP}/d" $1`
 CMT_MSG=`sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}"`
 DIFF=`sed -e '1,/^---$/d' "${PATCH}"`
-MAILHEADER=`sed '/^$/q' "${PATCH}"`
 PATCHTMP="${PATCH}.tmp"
-
-echo $MAILHEADER > $PATCHTMP
+sed '/^$/q' "${PATCH}" >"$PATCHTMP"
 
 export PATCHTMP
 CCS=`perl -e 'local $/=undef; open FILE, $ENV{'PATCHTMP'}; $text=<FILE>;
@@ -50,7 +49,7 @@ rm -rf $PATCHTMP
 
 # Change Subject: before next line according to Thunderbird language
 # for example:
-# SUBJECT=`echo $SUBJECT | sed -e 's/Subject/Oggetto/g'`
+# SUBJECT=`echo $SUBJECT | sed -e 's/Subject:/Oggetto:/'`
 echo "$SUBJECT" > $1
 # Change To: according to Thunderbird language
 echo "To: $TO" >> $1
