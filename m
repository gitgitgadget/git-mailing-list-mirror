From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 1/3] connect.c: Improve parsing of literal IPV6 addresses
Date: Thu, 22 Jan 2015 23:05:29 +0100
Message-ID: <54C17429.1090403@web.de>
References: <54BD3D14.90309@web.de> <20150122200702.GA96498@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?B?VG9yc3Rl?= =?UTF-8?B?biBCw7ZnZXJzaGF1c2Vu?= 
	<tboegi@web.de>, git@vger.kernel.org, lists@hcf.yourweb.de
X-From: git-owner@vger.kernel.org Thu Jan 22 23:05:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEPsh-0000Bk-CN
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 23:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbbAVWFf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jan 2015 17:05:35 -0500
Received: from mout.web.de ([212.227.17.12]:65373 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855AbbAVWFe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 17:05:34 -0500
Received: from macce.local ([78.68.171.36]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MOixm-1YKRlE1ot4-0068NZ; Thu, 22 Jan 2015 23:05:30
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150122200702.GA96498@vauxhall.crustytoothpaste.net>
X-Provags-ID: V03:K0:JqNOTyhxpTsBlwKC2k/H7A+16Ze2PxVDi+AOVRUC6UZyzTwndyG
 JfY40fm0y7Z4f8FyHrta0VOmPmVaIpyFka6Yl8d2BqXY6DthxKTKUm+OTy5Fm7JsKSp+Fln
 FRvgFPqv4Jh0IqJPkLfH1S5Tx9Ta/nC6rmrh8lVm/PZIRVfBRHGBcGxYfZRT6CLzeMQJ6eM
 N6qXxqRLT7OkUB/HjSk+g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262876>

On 2015-01-22 21.07, brian m. carlson wrote:
> On Mon, Jan 19, 2015 at 06:21:24PM +0100, Torsten B=C3=B6gershausen w=
rote:
>> When parsing an URL, older Git versions did handle
>> URLs like ssh://2001:db8::1/repo.git the same way as
>> ssh://[2001:db8::1]/repo.git
>>
>> Commit 83b058 broke the parsing of IPV6 adresses without "[]":
>> It was written in mind that the fist ':' in a URL was the beginning =
of a
>> port number, while the old code was more clever:
>> Literal IPV6 addresses have always at least two ':'.
>> When the "hostandport" had a ':' and the rest of the hostandport str=
ing
>> could be parsed into an integer between 0 and 65536, then it was use=
d
>> as a port number, like "host:22".
>> Otherwise the first ':' was assumed to be part of a literal IPV6 add=
ress,
>> like "ssh://[2001:db8::1]/repo.git" or "ssh://[::1]/repo.git".
>>
>> Re-introduce the old parsing in get_host_and_port().
>>
>> Improve the parsing to handle URLs which have a user name and a lite=
ral
>> IPV6 like "ssh://user@[2001:db8::1]/repo.git".
>> (Thanks to Christian Taube <lists@hcf.yourweb.de> for reporting this=
 long
>> standing issue)
>>
>> Another regression was introduced in 83b058:
>> A non-RFC conform URL like "[localhost:222]" could be used in older =
versions
>> of Git to connect to run "ssh -p 222 localhost".
>> The new stricter parsing did not allow this any more.
>> See even 8d3d28f5dba why "[localhost:222]" should be declared a feat=
ure.
>=20
> I'm not sure this is a very good idea.  While this may have worked in=
 the past, it's also completely inconsistent with the way all non-SSH U=
RLs work in Git:
>=20
>  vauxhall ok % git push https://bmc@2001:470:1f05:79::1/git/bmc/homed=
ir.git master
>  fatal: unable to access 'https://bmc@2001:470:1f05:79::1/git/bmc/hom=
edir.git/': IPv6 numerical address used in URL without brackets
>=20
>  vauxhall no % git push https://bmc@[castro.crustytoothpaste.net]/git=
/bmc/homedir.git master
>  fatal: unable to access 'https://bmc@[castro.crustytoothpaste.net]/g=
it/bmc/homedir.git/': Could not resolve host: [castro.crustytoothpaste.=
net]
>=20
>  vauxhall no % git push https://bmc@[castro.crustytoothpaste.net:443]=
/git/bmc/homedir.git master
>  fatal: unable to access 'https://bmc@[castro.crustytoothpaste.net:44=
3]/git/bmc/homedir.git/': Could not resolve host: [castro.crustytoothpa=
ste.net
>=20
> I would argue that people using IPv6 literals in URLs should already =
know how to do it correctly, and the consistency between SSH and HTTPS =
URLs is a feature, not a bug.  In the non-URL SSH form, you still have =
to use the bracketed form to deal with the case in which somebody creat=
es a directory called "1" in their home directory and writes:
>=20
We want to support ssh://bmc@2001:470:1f05:79::1/git/bmc/homedir.git/
   because e.g. the Git shipped with Debian (1.7.10.4) (and a lot of ot=
her installations) supports it.

We want to support ssh://bmc@[2001:470:1f05:79::1]/git/bmc/homedir.git/
    because that is what other people may expect to work as well:
 ssh://bmc@[2001:470:1f05:79::1]:4444/git/bmc/homedir.git/
=20
>  git push 2001:470:1f05:79::1:1 master
> when they mean
>=20
>  git push [2001:470:1f05:79::1]:1 master
That I don't understand this, where is the path name in your example ?

Everything after the first ':' is the path in the short form:
bmc@hostxx:/git/bmc/homedir.git/

If you really want to use a literal IPV6 with the short form, you must =
use the brackets:
bmc@[2001:470:1f05:79::1]:/git/bmc/homedir.git/
(And you can not have a port number here)


Nobody forces somebody to use any specific form.
