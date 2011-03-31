From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: 195b7ca6 breaks t9010 at current master
Date: Thu, 31 Mar 2011 11:11:25 -0500
Message-ID: <YHiIPkNCiU3RcX-PxtGuaAPfpIMSLtDzcuGX-pUHbb_4SC5aAQu_WQ@cipher.nrlssc.navy.mil>
References: <AANLkTik0CNXY9bKGOa9Xmai_OPQgExfLsFs1yN2pCVr8@mail.gmail.com> <20110329042446.GB25693@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?IsOYeXZpbmQgQS4gSG9sbSI=?= <sunny@sunbase.org>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 18:22:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5KdY-0000Wu-HM
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 18:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758592Ab1CaQWP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 12:22:15 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50428 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab1CaQWN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 12:22:13 -0400
X-Greylist: delayed 629 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Mar 2011 12:22:13 EDT
Received: by mail.nrlssc.navy.mil id p2VGBQ8T003076; Thu, 31 Mar 2011 11:11:26 -0500
In-Reply-To: <20110329042446.GB25693@elie>
X-OriginalArrivalTime: 31 Mar 2011 16:11:26.0070 (UTC) FILETIME=[492CF960:01CBEFBE]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170503>


[removed Junio from cc]

On 03/28/2011 11:24 PM, Jonathan Nieder wrote:
> Hi,
>=20
> =C3=98yvind A. Holm wrote:
>=20
>> When running "make test" at current master (v1.7.4.2-406-gbe919d5),
>> t9010-svn-fe.sh fails. Bisecting shows that 195b7ca6 ("vcs-svn: hand=
le
>> log message with embedded NUL") breaks the test.
>=20
> Could you try with the following patch applied?  It comes from
> squashing the last two patches from the svn-fe branch:
>=20
> * tests: make sure input to sed is newline terminated
> * vcs-svn: add missing cast to printf argument
>=20
> Sorry for the breakage.
> ---
> diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
> index 478c860..6f6175a 100755
> --- a/t/t9010-svn-fe.sh
> +++ b/t/t9010-svn-fe.sh
> @@ -407,7 +407,7 @@ test_expect_success 'NUL in log message, file con=
tent, and property name' '
>  	OBJID
>  	:000000 100644 OBJID OBJID A	greeting
>  	EOF
> -	printf "\n%s" "something with an ASCII NUL (Q)" >expect.message &&
> +	printf "\n%s\n" "something with an ASCII NUL (Q)" >expect.message &=
&
>  	printf "%s\n" "helQo" >expect.hello1 &&
>  	printf "%s\n" "link hello" >expect.hello2 &&
>  	{
> @@ -465,7 +465,11 @@ test_expect_success 'NUL in log message, file co=
ntent, and property name' '
>  		git diff-tree --root --stdin |
>  		sed "s/$_x40/OBJID/g"
>  	} >actual &&
> -	git cat-file commit HEAD | nul_to_q | sed -ne "/^\$/,\$ p" >actual.=
message &&
> +	{
> +		git cat-file commit HEAD | nul_to_q &&
> +		echo
> +	} |
> +	sed -ne "/^\$/,\$ p" >actual.message &&
>  	git cat-file blob HEAD^:greeting | nul_to_q >actual.hello1 &&
>  	git cat-file blob HEAD:greeting | nul_to_q >actual.hello2 &&
>  	test_cmp expect actual &&

I was just about to send a patch for this, when I noticed it has
already been worked around in master by the above.

I'll still share my one-liner for informational purposes which uses per=
l
and in my opinion is a little simpler:

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 478c860..0dcffaa 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -465,7 +465,7 @@ test_expect_success 'NUL in log message, file conte=
nt, and property name' '
                git diff-tree --root --stdin |
                sed "s/$_x40/OBJID/g"
        } >actual &&
-       git cat-file commit HEAD | nul_to_q | sed -ne "/^\$/,\$ p" >act=
ual.message &&
+       git cat-file commit HEAD | nul_to_q | perl -ne "print if (/^$/.=
=2Eeof())" >actual.message &&
        git cat-file blob HEAD^:greeting | nul_to_q >actual.hello1 &&
        git cat-file blob HEAD:greeting | nul_to_q >actual.hello2 &&
        test_cmp expect actual &&

-Brandon
