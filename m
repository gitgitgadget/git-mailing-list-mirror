From: Rogan Dawes <rogan@dawes.za.net>
Subject: [PATCH] Allow git-mergetool to handle paths with a leading space
Date: Mon, 07 Jan 2008 09:37:38 +0200
Message-ID: <4781D6C2.9060305@dawes.za.net>
References: <47809E7E.2090708@dawes.za.net>	<7vodbz5ka9.fsf@gitster.siamese.dyndns.org>	<4780B2BD.6020109@dawes.za.net> <7v3atb5g5o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080602010200040800000405"
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 08:39:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBmZh-0001NP-H4
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 08:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269AbYAGHim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 02:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752940AbYAGHim
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 02:38:42 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:46705 "EHLO
	spunkymail-a14.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752042AbYAGHim (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jan 2008 02:38:42 -0500
Received: from [192.168.201.100] (dsl-243-111-44.telkomadsl.co.za [41.243.111.44])
	by spunkymail-a14.g.dreamhost.com (Postfix) with ESMTP id DB77C190E32;
	Sun,  6 Jan 2008 23:38:40 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7v3atb5g5o.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69768>

This is a multi-part message in MIME format.
--------------080602010200040800000405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Signed-off-by: Rogan Dawes <rogan@dawes.za.net>
---
Junio C Hamano wrote:
> Rogan Dawes <rogan@dawes.za.net> writes:
> 
>>>> I am working on a project which has the root directory constructed
>>>> with a leading space. i.e. ./ dir/. "read" skips the leading space
>>>> char, and ends up with an incorrect filename, which can then not be
>>>> found. Setting IFS=\n solves this problem.
>>> Does the project have a file that has letter 'n' (en) in its name?
>>> Have you tested your patch while having a conflict in that file?
>> Yes, it works correctly.
> 
> I am curious and puzzled...
> 
>         $ echo 'ann1' | (IFS=\n read i; echo "<$i>")
>         <ann1>
>         $ echo 'ann1' | (IFS=\n read i j; echo "<$i>")
> 	<a>
>         $ echo 'n1' | (IFS=\n read i j; echo "<$i>")
> 	<>
> 
> Ok, "\n" is a funny way to say IFS does not matter as long as it
> is set to a non whitespace letter.
> 
> It is VERY misleading as it looks as if the issue is fixed by
> setting IFS to a single LF alone (excluding SP and HT from the
> usual set), but that is not the patch is doing.  It is setting
> it to a single 'n'.

Yes, you are right. Maybe setting IFS to the empty string is better?

$ printf " ann 1\n ann 2\n" | while IFS="" read i j k ; do echo "<$i> 
<$j> <$k>"; done
< ann 1> <> <>
< ann 2> <> <>
$

Admittedly, there are still problems with my version, as you say, 
backslashes and newlines will not be handled correctly. My Perl-fu is 
weak, however, and my revised solution (IFS="") works for me :-)

Rogan

P.S. Quoting "$files" stops the spaces from being eaten in the preceding 
echo line.

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 2f31fa2..facfbc8 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -393,8 +393,8 @@ if test $# -eq 0 ; then
                 echo "No files need merging"
                 exit 0
         fi
-       echo Merging the files: $files
-       git ls-files -u | sed -e 's/^[^ ]*      //' | sort -u | while read i
+       echo Merging the files: "$files"
+       git ls-files -u | sed -e 's/^[^ ]*      //' | sort -u | while 
IFS="" read i
         do
                 printf "\n"
                 merge_file "$i" < /dev/tty > /dev/tty

--------------080602010200040800000405
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 2f31fa2..facfbc8 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -393,8 +393,8 @@ if test $# -eq 0 ; then
 		echo "No files need merging"
 		exit 0
 	fi
-	echo Merging the files: $files
-	git ls-files -u | sed -e 's/^[^	]*	//' | sort -u | while read i
+	echo Merging the files: "$files"
+	git ls-files -u | sed -e 's/^[^	]*	//' | sort -u | while IFS="" read i
 	do
 		printf "\n"
 		merge_file "$i" < /dev/tty > /dev/tty

--------------080602010200040800000405--
