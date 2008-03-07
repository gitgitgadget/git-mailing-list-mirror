From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9001: set TERM=dumb to prevent ANSI output
Date: Thu, 06 Mar 2008 21:23:51 -0800
Message-ID: <7v7igf5cpk.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803061752340.3941@racer.site>
 <7vmypb8muj.fsf@gitster.siamese.dyndns.org>
 <200803070541.15793.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 06:24:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXV4h-0000TN-L8
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 06:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932782AbYCGFYK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2008 00:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757079AbYCGFYJ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 00:24:09 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932782AbYCGFYH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2008 00:24:07 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0D7603975;
	Fri,  7 Mar 2008 00:24:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C2FDC3973; Fri,  7 Mar 2008 00:23:59 -0500 (EST)
In-Reply-To: <200803070541.15793.chriscool@tuxfamily.org> (Christian Couder's
 message of "Fri, 7 Mar 2008 05:41:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76461>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le vendredi 7 mars 2008, Junio C Hamano a =C3=A9crit :
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> > At least on one of my machines, Term::ReadLine tries to be clever =
and
>> > sends \x1b\x5b1034h at the end of the script when TERM is set to
>> > 'xterm'.
>> >
>> > To prevent that, force TERM=3Ddumb just for the test.
>>
>> We try to set up a pretty vanilla environment for test repeatability=
 in
>> t/test-lib.sh, and I suspect we would simply want to do this over th=
ere.
>>
>> Wouldn't this make more sense?
>>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 87a5ea4..7f6331a 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -7,8 +7,9 @@
>>  LANG=3DC
>>  LC_ALL=3DC
>>  PAGER=3Dcat
>> +TERM=3Ddumb
>>  TZ=3DUTC
>> -export LANG LC_ALL PAGER TZ
>> +export LANG LC_ALL PAGER TERM TZ
>>  EDITOR=3D:
>>  VISUAL=3D:
>>  unset GIT_EDITOR
>
> This may not work well with colored output.
> In test-lib.sh line 62 there is :
>
> [ "x$TERM" !=3D "xdumb" ] &&
> 	[ -t 1 ] &&
> 	tput bold >/dev/null 2>&1 &&
> 	tput setaf 1 >/dev/null 2>&1 &&
> 	tput sgr0 >/dev/null 2>&1 &&
> 	color=3Dt

Ahh.  Sorry about that.

 t/test-lib.sh |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c0c5e21..8a8b33e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -3,12 +3,23 @@
 # Copyright (c) 2005 Junio C Hamano
 #
=20
+# Grab if the true terminal is capable of color before resetting
+# TERM to dumb for repeatability
+
+[ "x$TERM" !=3D "xdumb" ] &&
+	[ -t 1 ] &&
+	tput bold >/dev/null 2>&1 &&
+	tput setaf 1 >/dev/null 2>&1 &&
+	tput sgr0 >/dev/null 2>&1 &&
+	color=3Dt
+
 # For repeatability, reset the environment to known value.
 LANG=3DC
 LC_ALL=3DC
 PAGER=3Dcat
 TZ=3DUTC
-export LANG LC_ALL PAGER TZ
+TERM=3Ddumb
+export LANG LC_ALL PAGER TERM TZ
 EDITOR=3D:
 VISUAL=3D:
 unset GIT_EDITOR
@@ -59,13 +70,6 @@ esac
 # '
 # . ./test-lib.sh
=20
-[ "x$TERM" !=3D "xdumb" ] &&
-	[ -t 1 ] &&
-	tput bold >/dev/null 2>&1 &&
-	tput setaf 1 >/dev/null 2>&1 &&
-	tput sgr0 >/dev/null 2>&1 &&
-	color=3Dt
