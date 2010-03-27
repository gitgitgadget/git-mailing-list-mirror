From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t0005: add test for trap handling from deeply nested
 function calls
Date: Fri, 26 Mar 2010 19:24:20 -0500
Message-ID: <AgB5UDyfK4zUe0xzr08eZFJO1S5IvcsZv3v3AjCYT2qtRDoguqnJ3w@cipher.nrlssc.navy.mil>
References: <vm2zHZjrZOha7LnIM_9fAEAvwVZrJtZlAI9f2XI_VUsdqr51ihAMW68a5BT9tvMdRDSqk6GYlSE@cipher.nrlssc.navy.mil> <201003262119.45110.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Mar 27 01:24:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvJpL-000240-KL
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 01:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782Ab0C0AY3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Mar 2010 20:24:29 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34901 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262Ab0C0AY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 20:24:28 -0400
Received: by mail.nrlssc.navy.mil id o2R0OLa1027813; Fri, 26 Mar 2010 19:24:21 -0500
In-Reply-To: <201003262119.45110.j6t@kdbg.org>
X-OriginalArrivalTime: 27 Mar 2010 00:24:20.0682 (UTC) FILETIME=[D82D22A0:01CACD43]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143306>

On 03/26/2010 03:19 PM, Johannes Sixt wrote:
> On Freitag, 26. M=E4rz 2010, Brandon Casey wrote:
>> +test_expect_success 'trap triggered in deeply nested function works
>> correctly' ' +	(atrap () { exit 0; }
>> +	 func3 () { exit 1; }
>> +	 func2 () { func3; }
>> +	 func1 () { trap atrap EXIT; func2; }
>> +	 func1)
>> +'
>=20
> What do you want to achieve with this test? That /usr/xpg4/bin/sh is =
not used=20
> on Solaris?

Yeah, pretty much.  At least until bisect is rewritten in c.

> If git-bisect triggers this bug in /usr/xpg4/bin/sh and if this is ou=
r shell=20
> of choice on Solaris,

It's not currently git's shell of choice on Solaris.  The Makefile stil=
l sets
SHELL_PATH =3D /bin/bash in the SunOS section.

> wouldn't it be better to work around it in git-bisect?

Yes.  You and Junio are giving the same advice, but I don't know how to=
 work
around it.  I don't think there is anything wrong or tricky about what
bisect does.  I just think the shell is broken with respect to this
behavior.

This shell ignores traps that are set in the second function level away=
 from
where the trap was set (I found this difficult to describe in my commit
message).  So even if the trap in my test above was set at the top leve=
l of
the script, it would not be executed after a call to exit from func3 or=
 from
func2.

Take a look at this script:

--- >8 ---
#!/bin/ksh

(atrap () { exit 0; }
 func3 () { exit 1; }
 func2 () { func3; }
 func1 () { trap atrap EXIT; func2; }
 func1) &&
 echo 'SUCCESS: Trap set in function catches exit two levels deeper' ||
 echo 'FAILURE: Trap set in function fails to catch exit two levels dee=
per'

(atrap () { exit 0; }
 func2 () { exit 1; }
 func1 () { trap atrap EXIT; func2; }
 func1) &&
 echo 'SUCCESS: Trap set in function catches exit one level deeper' ||
 echo 'FAILURE: Trap set in function fails to catch exit one level deep=
er'

(atrap () { exit 0; }
 func3 () { exit 1; }
 func2 () { func3; }
 func1 () { func2; }
 trap atrap EXIT
 func1) &&
 echo 'SUCCESS: Trap set at top-level catches exit three levels deeper'=
 ||
 echo 'FAILURE: Trap set at top-level fails to catch exit three levels =
deeper'

(atrap () { exit 0; }
 func2 () { exit 1; }
 func1 () { func2; }
 trap atrap EXIT
 func1) &&
 echo 'SUCCESS: Trap set at top-level catches exit two levels deeper' |=
|
 echo 'FAILURE: Trap set at top-level fails to catch exit two levels de=
eper'

(atrap () { exit 0; }
 func1 () { exit 1; }
 trap atrap EXIT
 func1) &&
 echo 'SUCCESS: Trap set at top-level catches exit one level deeper' ||
 echo 'FAILURE: Trap set at top-level fails to catch exit one level dee=
per'
--- >8 ---

On Linux or IRIX with bash or ksh, it prints
SUCCESS: Trap set in function catches exit two levels deeper
SUCCESS: Trap set in function catches exit one level deeper
SUCCESS: Trap set at top-level catches exit three levels deeper
SUCCESS: Trap set at top-level catches exit two levels deeper
SUCCESS: Trap set at top-level catches exit one level deeper

Using Solaris's /usr/xpg4/bin/sh it prints:
=46AILURE: Trap set in function fails to catch exit two levels deeper
SUCCESS: Trap set in function catches exit one level deeper
=46AILURE: Trap set at top-level fails to catch exit three levels deepe=
r
=46AILURE: Trap set at top-level fails to catch exit two levels deeper
SUCCESS: Trap set at top-level catches exit one level deeper

=46unny enough, Solaris's /bin/sh works correctly.

So, I don't see any way to catch a termination by signal in the scripts
that are currently using trap and which may make a function call from
within another function.

The explicit exit's within the script could be handled without a trap
though.  Maybe that is enough.  We'll see how ugly it is...

-brandon
