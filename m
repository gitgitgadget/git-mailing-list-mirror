From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t/t3700: convert two uses of negation operator '!' to
 use 	test_must_fail
Date: Tue, 20 Jul 2010 11:32:33 -0500
Message-ID: <fVE942wHC3SFihkQG8AthPTKiTZtYJ9zmR2TT7F5OlkGD4IA9xPcMA@cipher.nrlssc.navy.mil>
References: <tMTpk3TmiYV54AYDiNJMBdnlXhSooJQQ1gRoAEsSwmcSwJ9ROgOpr75wpEQNx6_kZkqBtD71_QU@cipher.nrlssc.navy.mil> <AANLkTil9jA8Dva_KqW67c1ZgWk9_a5S1rBViui8Jn0Os@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	Brandon Casey <drafnel@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 18:33:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObFlG-0005zK-Pr
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 18:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761348Ab0GTQdg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 12:33:36 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52300 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab0GTQdg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 12:33:36 -0400
Received: by mail.nrlssc.navy.mil id o6KGWm33020127; Tue, 20 Jul 2010 11:32:48 -0500
In-Reply-To: <AANLkTil9jA8Dva_KqW67c1ZgWk9_a5S1rBViui8Jn0Os@mail.gmail.com>
X-OriginalArrivalTime: 20 Jul 2010 16:32:48.0724 (UTC) FILETIME=[30C5F140:01CB2829]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151327>

On 07/20/2010 10:55 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, Jul 20, 2010 at 15:24, Brandon Casey <casey@nrlssc.navy.mil> =
wrote:
>=20
>> These two lines use the negation '!' operator to negate the result o=
f a
>> simple command.  Since these commands do not contain any pipes or ot=
her
>> complexities, the test_must_fail function can be used and is preferr=
ed
>> since it will additionally detect termination due to a signal.
>=20
> Maybe I'm missing something, but unless `git add --dry-run` is specia=
l
> in being killed due to a signal this seems misguided. We actually
> prefer to use !, from t/README:
>=20
>  - test_must_fail <git-command>
>=20
>    Run a git command and ensure it fails in a controlled way.  Use
>    this instead of "! <git-command>" to fail when git commands
>    segfault.

I think you have misunderstood the explanation of test_must_fail.  The
paragraph you quoted actually recommends using test_must_fail instead
of "! <git-command>".

It says:

   Use this instead of "! <git-command>" to fail when git commands
   segfault.

Or with a slight rewording:

   Use test_must_fail instead of "! <git-command>" since test_must_fail
   will fail when <git-command> segfaults.

See, if "! <git-command>" is used, then if "<git-command>" is terminate=
d
due to some flaw in git (like a segfault), then the statement will stil=
l
be interpreted as a success.  When test_must_fail is used, termination
due to segfault or other signal is detected, and the statement will
fail.

>> This was noticed because the second use of '!' does not include a sp=
ace
>> between the '!' and the opening parens.  Ksh interprets this as foll=
ows:
>>
>>   !(pattern-list)
>>      Matches anything except one of the given patterns.
>>
>> Ksh performs a file glob using the pattern-list and then tries to ex=
ecute
>> the first file in the list.  If a space is added between the '!' and=
 the
>> open parens, then Ksh will not interpret it as a pattern list, but i=
n this
>> case, it is preferred to use test_must_fail, so lets do so.
>=20
> Isn't this a completely seperate thing? Was this test really the only
> bit in the test suite that did "!foo" instead of "! foo" ?

This was the only instance of "!()" that was failing for me.  I didn't
look before, but now that I have, there is another instance of "!()" in
t5541 that should be fixed.  t5541 hasn't caused a problem for me becau=
se
GIT_TEST_HTTPD must be set in order to enable it, and I haven't done so=
=2E

> Does the test pass for you if you just:

Yes.

>     @@ -281,7 +281,7 @@ add 'track-this'
>      EOF
>=20
>      test_expect_success 'git add --dry-run --ignore-missing of
> non-existing file' '
>     -       !(git add --dry-run --ignore-missing track-this
> ignored-file >actual 2>&1) &&
>     +       ! (git add --dry-run --ignore-missing track-this
> ignored-file >actual 2>&1) &&
>            test_cmp expect actual
>      '
>=20
> ?
