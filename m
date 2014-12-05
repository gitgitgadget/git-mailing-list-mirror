From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: error: core.autocrlf=input conflicts with core.eol=crlf
Date: Fri, 05 Dec 2014 16:55:51 +0100
Message-ID: <5481D587.2050103@web.de>
References: <20141205054205.GA71681@scout.stangl.us> <54816863.90208@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Alex Stangl <alex@stangl.us>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 16:56:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwvEq-0006Fs-CZ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 16:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbaLEP4I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Dec 2014 10:56:08 -0500
Received: from mout.web.de ([212.227.15.14]:60319 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907AbaLEP4H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 10:56:07 -0500
Received: from [192.168.209.17] ([78.72.72.190]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MCeX4-1Y6JAX01XW-009OOD; Fri, 05 Dec 2014 16:55:55
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <54816863.90208@web.de>
X-Provags-ID: V03:K0:50R3zxOVuXt+G1uua7cQuzc8LoGKsGT/+7Syuw0OZSguSfWCkg5
 j35gdv+O4dHBP1dIOfOs49KFPkYgWUaT1PIEn+/uG2Bb9fmKe1B9YTN1o8u1vh6EzMHf9Uo
 vJy9hox2/3bYT63vO6xBJJT9V85PFzFKbYKCCKisNx8JpVsw9bXHym9NiSi1SQ7OZ7rLpU/
 WBQCmN1KiqBlWPWdcTu8w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260873>

On 12/05/2014 09:10 AM, Torsten B=F6gershausen wrote:
> On 05.12.14 06:42, Alex Stangl wrote:
>> Hi,
>>
>> There seems to be problems with the checks in the git code for confl=
icts
>> between config values of core.autocrlf and core.eol. Because the var=
ious
>> config files are read in separate passes, and the conflict check hap=
pens
>> on the fly, it creates a situation where the order of the config fil=
e
>> entries matters. This seems like a bug or at least a POLA violation =
--
>> ordering of lines within a section of a config file is not usually
>> significant.
>>
>> Example: User has core.autocrlf=3Dinput in his ~/.gitconfig. In his
>> project-level .git/config he wants to set core.autocrlf=3Dfalse and
>> core.eol=3Dcrlf. If the core.autocrlf=3Dfalse comes first, then all =
is
>> well and no conflict is reported. If the core.eol=3Dcrlf line comes
>> first, then at the time this line is getting parsed, core.autocrlf
>> is still set at "input" from ~/.gitconfig, and execution aborts:
>>
>> error: core.autocrlf=3Dinput conflicts with core.eol=3Dcrlf
>>
>> It seems like the conflict check should be made at the end of the
>> config file parsing, not on the fly. I was tempted to create a patch=
,
>> however I am unfamilar with the codebase, and didn't understand all
>> the places where the config file parsing is called, so I'm not sure
>> of the ramifications of any proposed change. A benefit of the curren=
t
>> approach is that it reports the line number where it aborted in the
>> config file. Trying to retain this and at the same time defer the
>> check until the end could get complicated.
>>
>> Besides interaction between multiple levels of config files, the
>> same sort of ordering issue can arise in conjunction with command-li=
ne
>> config overrides.
>>
>> Example: User has core.autocrlf=3Dinput in his project-level .git/co=
nfig.
>> This command works fine:
>> $ git -c core.autocrlf=3Dfalse -c core.eol=3Dcrlf status
>> This command blows up with conflict error:
>> $ git -c core.eol=3Dcrlf -c core.autocrlf=3Dfalse status
>>
>> I tested with git versions 1.9.3 and 2.1.0.
>>
Yes, this is a bug, if someone has a patch: it is welcome.
Or a test case showing the problem is welcome too.

Beside that, I am working on a patch to remove this restriction complet=
ely.
I think that it is a legal combination to have a .gitattributes file li=
ke this:

*.txt text

And then set

core.autocrlf=3Dinput # to avoid CRLF in the repo for e.g. *.c files,
and core.eol=3Dcrlf # to have *.txt in CRLF in the working tree



Which means do not touch any files,
