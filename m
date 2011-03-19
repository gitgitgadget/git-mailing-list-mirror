From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] repack: find -> /usr/bin/find, as for cygwin
Date: Sat, 19 Mar 2011 16:50:24 +0100
Message-ID: <4D84D0C0.7080808@lsrfire.ath.cx>
References: <AANLkTimHof_MNSGbU2KGX=7Q3MQpjkzXK+xyGGVjbngR@mail.gmail.com> <AANLkTimPbz2s=Maafhqg-7wOk_TT4fFSh7AQ-3rWY0A3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?cnllbnVzIOKXhw==?= <ryenus@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 16:50:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0yQT-0002E2-Ur
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 16:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466Ab1CSPui convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 11:50:38 -0400
Received: from india601.server4you.de ([85.25.151.105]:58240 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab1CSPuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 11:50:37 -0400
Received: from [192.168.2.103] (p4FFDB4FC.dip.t-dialin.net [79.253.180.252])
	by india601.server4you.de (Postfix) with ESMTPSA id CEDCB2F8067;
	Sat, 19 Mar 2011 16:50:35 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <AANLkTimPbz2s=Maafhqg-7wOk_TT4fFSh7AQ-3rWY0A3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169441>

Am 19.03.2011 13:18, schrieb Nguyen Thai Ngoc Duy:
> On Sat, Mar 19, 2011 at 7:08 PM, ryenus =E2=97=87<ryenus@gmail.com>  =
wrote:
>> -               for e in `cd "$PACKDIR"&&  find . -type f -name '*.p=
ack' \
>> +               for e in `cd "$PACKDIR"&&  /usr/bin/find . -type f
>=20
> I'd rather have something like in test-lib.sh (with conditions)
>=20
> find() {
> /usr/bin/find "$@"
> }
>=20
> Even better, rewrite this script to C.

That's a good idea, but it's a lot more involved than the original
patch.

Do we need to support pack files in subdirectories of $PACKDIR?  If
not -- and I don't immediately see why, except that the current code
does with its find call -- then the following patch might be a quick
bandaid.  Untested, please be careful.

Ren=C3=A9


 git-repack.sh |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 624feec..4e49079 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -64,15 +64,16 @@ case ",$all_into_one," in
 ,t,)
 	args=3D existing=3D
 	if [ -d "$PACKDIR" ]; then
-		for e in `cd "$PACKDIR" && find . -type f -name '*.pack' \
-			| sed -e 's/^\.\///' -e 's/\.pack$//'`
-		do
-			if [ -e "$PACKDIR/$e.keep" ]; then
-				: keep
-			else
-				existing=3D"$existing $e"
-			fi
-		done
+		existing=3D$(
+			cd "$PACKDIR" &&
+			for e in *.pack
+			do
+				if test -f "$e" -a ! -e "${e%.pack}.keep"
+				then
+					echo "${e%.pack}"
+				fi
+			done
+		)
 		if test -n "$existing" -a -n "$unpack_unreachable" -a \
 			-n "$remove_redundant"
 		then
