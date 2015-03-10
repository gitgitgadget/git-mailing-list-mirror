From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Surprising interaction of "binary" and "eol" gitattributes
Date: Tue, 10 Mar 2015 21:26:30 +0100
Message-ID: <54FF5376.7070500@web.de>
References: <54F88684.3020905@alum.mit.edu> <xmqqwq2v14iv.fsf@gitster.dls.corp.google.com> <54F9422D.2020800@web.de> <54F9E907.4040703@alum.mit.edu> <54FA1C7B.3040906@web.de> <54FF450F.7040506@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	=?windows-1252?Q?Torsten_B?= =?windows-1252?Q?=F6gershausen?= 
	<tboegi@web.de>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 21:26:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVQjl-0001B3-US
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 21:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbbCJU0l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2015 16:26:41 -0400
Received: from mout.web.de ([212.227.15.4]:64549 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984AbbCJU0l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 16:26:41 -0400
Received: from birne.local ([217.211.68.12]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MK233-1YU3gg21Cf-001TiQ; Tue, 10 Mar 2015 21:26:31
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <54FF450F.7040506@alum.mit.edu>
X-Provags-ID: V03:K0:V4x8noFLCYvRmk9Hg7n4/qWVGUxFVW8YkIRXiyMzlD94lOC0Dkh
 rwoWgjBCZyk6Xad9fk2ZmKlf4T3UDfBeNwG1CzozheUf6cZnMCPoteEPLN9+/406Qnk8592
 dKGANih4Yo6YcEt1LCsHHsaLkXOxgZqnJmG6Q8y0NLhHzNdBg7t0VV8XCZCCINw6jsPC5Ck
 O0Urw3tD5qDHH5Vy5ITQg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265261>

On 10.03.15 20:25, Michael Haggerty wrote:
> On 03/06/2015 10:30 PM, Torsten B=F6gershausen wrote:
>>
>>> Oops, I misunderstood an internal bug report. In seems that it is t=
he
>>> following scenario that is incorrect:
>>>
>>>     *.png text=3Dauto eol=3Dcrlf
>> Hm, I don't know if we support this combination at all.
>=20
> The user can specify this combination in a .gitattributes file and we
> have to react to it *some way*. Theoretically we could document that
> this combination is undefined and/or emit an error if we see this
> combination, but we don't do so.
>=20
>> The current logic supports auto-detection of text/binary,
>> * text=3Dauto
>> (the files will get the line ending from core.eol or core.autocrlf)
>>
>> or the  the setting of a line ending:
>> *.sh eol=3Dlf
>> *.bat eol=3Dcrlf
>>
>>
>> Is there a special use-case, which needs the combination of both ?
>=20
> I'm still trying to infer the spirit of the current behavior, so cave=
ats
> here.
>=20
> This comes from a real-life scenario where a user, somewhere early in
> .gitattributes, had
>=20
>     * text
>     * eol=3Dcrlf
>=20
> and then later (this could be in a subdirectory) tried to carve out
> exceptions to this rule by using
>=20
>     *.png binary
>     * text=3Dauto
Hm,
I can see 2 problems here:
the "binary" attribute does not exist at all.

I sometimes which we had it, but we don't.
There is "text" and "-text", and that is it.

The other problem is the order of the lines, which is fully
intuitive for each person who has ever written a "matching parser".

The parser matches each file namr on it's own, depending on the matchin=
g:

*.png -text
* text=3Dauto
means that all png files are binary, and ALL files are "auto".

Guess what happens to the png's ?

The second rule wins, as it is the last rule processed.

git check-attr text *
A.png: text: auto
B.txt: text: auto
---
If we reverse the order in .gitattributes, things look better:
* text=3Dauto
*.png -text

git check-attr text *
A.png: text: unset
B.txt: text: auto


--------------------
This is not very intuitive or even surprising, at least for many people=
=2E

Unless I mis-understand the problem, it may be that the documentation m=
ay be updated ?

The general rule for writing .gitattributes=20
is to specify the "wider" rules first, and then the more specific rules=
 after that.

It could be that=20
Documentation/gitattributes.txt
should mention this instead:
------------------------
*		-text
*.txt		text
*.vcproj	eol=3Dcrlf
*.sh		eol=3Dlf
------------------------


The other thing is to promote/mention the command=20
"git  check-attr text *"

at a prominent place.

> Intuitively it *feels* like either of the later lines should suppress
> EOL translation in PNG files (assuming the PNG file has a NUL byte in
> the first 8k, which this one did).
>=20
> It seems to me that setting "text=3Dauto" should mean that Git uses i=
ts
> heuristic to guess whether a particular file is text or not, and then
> treats the file as if it had "text" or "-text" set. If the latter, th=
en
> EOL translation should be suppressed.
>=20
> It also seems to me that "binary" should imply "-eol".
>=20
> Michael
>=20
