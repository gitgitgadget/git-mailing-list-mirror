From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/4] streaming filter: ident filter and filter cascading
Date: Sat, 21 May 2011 23:25:06 +0200
Message-ID: <4DD82DB2.8000101@lsrfire.ath.cx>
References: <1305961127-26540-1-git-send-email-gitster@pobox.com> <1305961127-26540-5-git-send-email-gitster@pobox.com> <4DD82931.6000101@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 23:25:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNtg3-0003JR-JM
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 23:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564Ab1EUVZ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 17:25:28 -0400
Received: from india601.server4you.de ([85.25.151.105]:46686 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755356Ab1EUVZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 17:25:27 -0400
Received: from [192.168.2.106] (p579BE3D8.dip.t-dialin.net [87.155.227.216])
	by india601.server4you.de (Postfix) with ESMTPSA id 7F3E42F8086;
	Sat, 21 May 2011 23:25:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <4DD82931.6000101@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174176>

Am 21.05.2011 23:05, schrieb Ren=E9 Scharfe:
> Am 21.05.2011 08:58, schrieb Junio C Hamano:
>> Add support for "ident" filter on the output codepath. Because we no=
w have
>> more than one filter active, also add support to cascade them togeth=
er.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>
>>  * There is one known issue in this "ident" filter implementation. I=
f the
>>    input data ends while the filter is still in the "SKIPPING" state=
, it
>>    should go to the "DRAINING" codepath using the same logic that tr=
iggers
>>    when it gets to the end of line, copying out what was already que=
ued.
>>    However, the API does not offer an explicit way for the input sid=
e to
>>    say "that's all". We probably need to make a zero-byte input to t=
he
>>    filter function as an explicit EOF signal or something---currentl=
y I
>>    think it will loop forever, but it is getting late, so I will not=
 be
>>    further touching this code tonight.
>=20
> AFAIU it will leave skipping mode once there is no input data anymore
> instead of looping forever.  The accumulated stuff will be discarded.
>=20
> The test suite is passed, by the way, even though t0021 seems to cont=
ain
> a test for this issue (NoTerminatingSymbolAtEOF).  It uses echo to
> create the files so there will be a terminating newline before the en=
d
> of the file, though, so this subtest probably needs to be changed.

-- >8 --
Subject: t0021-conversion.sh: fix NoTerminatingSymbolAtEOF test

The last line of the test file "expanded-keywords" ended in a newline,
which is a valid terminator for ident.  Use printf instead of echo to o=
mit
it and thus really test if a file that ends unexpectedly in the middle =
of
an ident tag is handled properly.

Also take the oppertunity to calculate the expected ID dynamically
instead of hardcoding it into the test script.  This should make future
changes easier.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t0021-conversion.sh |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 9078b84..275421e 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -66,25 +66,26 @@ test_expect_success expanded_in_repo '
 		echo "\$Id:NoSpaceAtEitherEnd\$"
 		echo "\$Id: NoTerminatingSymbol"
 		echo "\$Id: Foreign Commit With Spaces \$"
-		echo "\$Id: NoTerminatingSymbolAtEOF"
+		printf "\$Id: NoTerminatingSymbolAtEOF"
 	} > expanded-keywords &&
=20
+	git add expanded-keywords &&
+	git commit -m "File with keywords expanded" &&
+	id=3D$(git rev-parse --verify :expanded-keywords) &&
+
 	{
 		echo "File with expanded keywords"
-		echo "\$Id: fd0478f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
-		echo "\$Id: fd0478f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
-		echo "\$Id: fd0478f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
-		echo "\$Id: fd0478f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
-		echo "\$Id: fd0478f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
-		echo "\$Id: fd0478f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
+		echo "\$Id: $id \$"
+		echo "\$Id: $id \$"
+		echo "\$Id: $id \$"
+		echo "\$Id: $id \$"
+		echo "\$Id: $id \$"
+		echo "\$Id: $id \$"
 		echo "\$Id: NoTerminatingSymbol"
 		echo "\$Id: Foreign Commit With Spaces \$"
-		echo "\$Id: NoTerminatingSymbolAtEOF"
+		printf "\$Id: NoTerminatingSymbolAtEOF"
 	} > expected-output &&
=20
-	git add expanded-keywords &&
-	git commit -m "File with keywords expanded" &&
-
 	echo "expanded-keywords ident" >> .gitattributes &&
=20
 	rm -f expanded-keywords &&
--=20
1.7.5.2
