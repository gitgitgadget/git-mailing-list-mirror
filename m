From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Sun, 27 Jan 2013 14:13:46 +0100
Message-ID: <5105280A.80002@web.de>
References: <201301120650.46479.tboegi@web.de> <7vvcb37xfe.fsf@alter.siamese.dyndns.org> <50F28BB5.9080607@web.de> <20130113173207.GC5973@elie.Belkin> <7v4nikiu81.fsf@alter.siamese.dyndns.org> <50F5B83E.9060800@web.de> <7vk3re2ncb.fsf@alter.siamese.dyndns.org> <51037E5F.8090506@web.de> <20130127093121.GA4228@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	kraai@ftbfs.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 14:14:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzS47-0004Pk-KQ
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 14:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756720Ab3A0NOJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jan 2013 08:14:09 -0500
Received: from mout.web.de ([212.227.15.4]:59387 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756712Ab3A0NOI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 08:14:08 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0Lr2VT-1UdTyL23ZT-00edYQ; Sun, 27 Jan 2013 14:13:47
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <20130127093121.GA4228@elie.Belkin>
X-Provags-ID: V02:K0:y7oDUM5079PvmjCtjcL2iKNx7/SEbkw/ZtxXFuIWu0L
 qHcVhIo4HW4HVDet9FD/IrBg50mZ9zHlMvj2DZpjOI/vg3ayUk
 /d50+smtZNsB+qGUqb5udOnHGtx5kPVG7mnzNm5xlkWGSM1VEP
 kZeGsRuAHuaV61aFnYV8uY0uTWb4dl1Id9b81f4Mpcv8Ct1xiR
 WhS9VsaIcjP02nOjdbDig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214698>

On 27.01.13 10:31, Jonathan Nieder wrote:
> Hi,
>=20
> Torsten B=C3=B6gershausen wrote:
>> On 15.01.13 21:38, Junio C Hamano wrote:
>>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>>>> What do we think about something like this for fishing for which:
> [...]
>>>> +which () {
>>>> +       echo >&2 "which is not portable (please use type)"
>>>> +       exit 1
>>>> +}
> [...]
>>> 	if (
>>> 		which frotz &&
>>>                 test $(frobonitz --version" -le 2.0
>>> 	   )
>=20
> With the above definition of "which", the only sign of a mistake woul=
d
> be some extra output to stderr (which is quelled when running tests i=
n
> the normal way).  The "exit" is caught by the subshell and just makes
> the "if" condition false.
>=20
> That's not so terrible --- it could still dissuade new test authors
> from using "which".  The downside I'd worry about is that it provides
> a false sense of security despite not catching problems like
>=20
> 	write_script x <<-EOF &&
> 		# Use "foo" if possible.  Otherwise use "bar".
> 		if which foo && test $(foo --version) -le 2.0
> 		then
> 			...
> 		...
> 	EOF
> 	./x
>=20
> That's not a great tradeoff relative to the impact of the problem
> being solved.
>=20
> Don't get me wrong.  I really do want to see more static or dynamic
> analysis of git's shell scripts in the future.  I fear that for the
> tradeoffs to make sense, though, the analysis needs to be more
> sophisticated:
>=20
>  * A very common error in test scripts is leaving out the "&&"
>    connecting adjacent statements, which causes early errors
>    in a test assertion to be missed and tests to pass by mistake.
>    Unfortunately the grammar of the dialect of shell used in tests is
>    not regular enough to make this easily detectable using regexps.
>=20
>  * Another common mistake is using "cd" without entering a subshell.
>    Detecting this requires counting nested parentheses and noticing
>    when a parenthesis is quoted.
>=20
>  * Another common mistake is relying on the semantics of variable
>    assignments in front of function calls.  Detecting this requires
>    recognizing which commands are function calls.
>=20
> In the end the analysis that works best would probably involve a
> full-fledged shell script parser.  Something like "sparse", except fo=
r
> shell command language.
>=20
> Sorry I don't have more practical advice in the short term.
>=20
> My two cents,
> Jonathan

Jonathan,
thanks for the review.

My ambition is to get the check-non-portable-shell.pl into a shape
that we can enable it by default.

This may be with or without checking for "which".
As a first step we will hopefully see less breakage for e.g. Mac OS
caused by "echo -n" or "sed -i" usage.

On the longer run, we may be able to have something more advanced.

Back to the which:

Writing a t0009-no-which.sh like this:
--------------------
#!/bin/sh
test_description=3D'Test the which'

=2E ./test-lib.sh

which () {
       echo >&2 "which is not portable (please use type)"
       exit 1
}

test_expect_success 'which is not portable' '
	if  which frotz
	then
		say "frotz does not exist"
	else
		say "frotz does exist"
	fi

'
test_done
--------------
and running "make test" gives the following, at least in my system:

[snip]

*** t0009-no-which.sh ***
=46ATAL: Unexpected exit with code 1
make[2]: *** [t0009-no-which.sh] Error 1
make[1]: *** [test] Error 2
make: *** [test] Error 2

-----------------------
running inside t/
=2E/t0009-no-which.sh --verbose

Initialized empty Git repository in /Users/tb/projects/git/tb/t/trash d=
irectory.t0009-no-which/.git/
expecting success:=20
        if  which frotz
        then
                say "frotz does not exist"
        else
                say "frotz does exist"
        fi


which is not portable (please use type)
=46ATAL: Unexpected exit with code 1

/Torsten
