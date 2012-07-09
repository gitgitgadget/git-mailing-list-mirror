From: Max Horn <max@quendi.de>
Subject: Re: [PATCH] Change configure to check if pthreads are usable without any extra flags
Date: Mon, 9 Jul 2012 17:39:26 +0200
Message-ID: <C56B4151-8912-4B3A-8A97-E769A878AE68@quendi.de>
References: <1341529386-11589-1-git-send-email-max@quendi.de> <7vk3ydkmzq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1280)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 17:39:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoG3j-0000jj-U3
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 17:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869Ab2GIPja convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jul 2012 11:39:30 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:56999 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751569Ab2GIPja convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 Jul 2012 11:39:30 -0400
Received: from 77-22-67-26-dynip.superkabel.de ([77.22.67.26] helo=kaitain-wlan.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1SoG3b-000747-ON; Mon, 09 Jul 2012 17:39:27 +0200
In-Reply-To: <7vk3ydkmzq.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1280)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1341848370;230bebd1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201210>


On 09.07.2012, at 16:50, Junio C Hamano wrote:

> Max Horn <max@quendi.de> writes:
>=20
>> The configure script checks whether certain flags / libraries are
>> required to use pthreads. But so far it did not consider the possibi=
lity
>> that no extra compiler flags are needed (as is the case on Mac OS X)=
=2E As
>> a result, configure would always add "-mt" to the list of flags. Thi=
s in
>> turn triggered a warning in clang about an unknown argument.
>> To solve this, we now first check if pthreads work without extra fla=
gs.
>>=20
>> Signed-off-by: Max Horn <max@quendi.de>
>> ---
>> configure.ac | 2 +-
>> 1 Datei ge=E4ndert, 1 Zeile hinzugef=FCgt(+), 1 Zeile entfernt(-)
>>=20
>> diff --git a/configure.ac b/configure.ac
>> index 4e9012f..d767ef3 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -1002,7 +1002,7 @@ if test -n "$USER_NOPTHREAD"; then
>> # -D_REENTRANT' or some such.
>> elif test -z "$PTHREAD_CFLAGS"; then
>>   threads_found=3Dno
>> -  for opt in -mt -pthread -lpthread; do
>> +  for opt in "" -mt -pthread -lpthread; do
>=20
> Hmph.  Would it work to append the new empty string at the end of
> the existing list, as opposed to prepending it?

No, because that loop aborts on the first match that "works". Since no =
flags are necessary on OS X, but adding "-mt" to the flags "works" in t=
he sense that it does nothing (except triggering a warning about an unk=
nown argument), we need to check the empty string before "-mt" that.=20

>  I'd prefer a
> solution that is order independent, or if the change is order
> dependent, then a comment to warn others from changing it later.

Well, such checks are normally always order dependant, too (looking at =
many other autoconf tests out there). OK, so we could first test all fo=
ur possibilities, recording for each whether it works or not. But after=
 doing that, we still need to establish an order, in case more than one=
 "works" according to the linker test. Simply using the order is the ea=
siest way for that and works well in practice. And it avoid unnecessary=
, time consuming checks ;).

Regardless of all that, of course I can add a comment emphasising that =
the order here is important. (Although IMHO that should be self-evident=
 for an autoconf test.)



>=20
>>      old_CFLAGS=3D"$CFLAGS"
>>      CFLAGS=3D"$opt $CFLAGS"
>>      AC_MSG_CHECKING([Checking for POSIX Threads with '$opt'])
>=20
> Perhaps "for linking with POSIX Threads" would make it clearer, as
> CFLAGS (rather, PTHREAD_CFLAGS) has been checked earlier separately.

Well, talking about clarity, looking at line 188 it says
   AC_MSG_NOTICE([Will try -pthread then -lpthread to enable POSIX Thre=
ads])

which is also bad: It is out-of-date (even before my patch, as it doesn=
't mention -mt), will easily get out of sync with reality again, and in=
 any case contains information that normally shouldn't be printed anywa=
y.=20

Beyond that, the pthread code checks only for -pthread and -lpthread, t=
hus leaving many systems out. Indeed, it might be worth a thought dropp=
ing the custom pthread detection code in git's configure.ac and instead=
 using AX_PTHREAD <http://www.gnu.org/software/autoconf-archive/ax_pthr=
ead.html>, which covers many more systems out of the box.=20

But for now, I really would just want to make this simple trivial fix t=
hat avoids tons of pointless warnings when compiling git on Mac OS X 10=
=2E7 ... ;).


Cheers,
Max
