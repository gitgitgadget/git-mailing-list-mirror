From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v1] travis-ci: build documentation
Date: Mon, 25 Apr 2016 21:32:04 +0200
Message-ID: <vpqwpnlpjrf.fsf@anie.imag.fr>
References: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com>
	<vpq37qeovu4.fsf@anie.imag.fr>
	<xmqqinz9pl3l.fsf@gitster.mtv.corp.google.com>
	<EDD0757C-2BD3-476F-B703-147D35BB1FAC@gmail.com>
	<xmqqh9epmxtj.fsf@gitster.mtv.corp.google.com>
	<xmqq37q9ldd9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 21:32:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aumFD-0000Vs-CD
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 21:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbcDYTcN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 15:32:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43802 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933381AbcDYTcL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 15:32:11 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u3PJW2M7020383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 25 Apr 2016 21:32:02 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3PJW4uG022463;
	Mon, 25 Apr 2016 21:32:04 +0200
In-Reply-To: <xmqq37q9ldd9.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 25 Apr 2016 12:03:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 25 Apr 2016 21:32:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3PJW2M7020383
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1462217524.39167@9VXKHFjVlxdktrj0sp2D3A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292549>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>
>>>> There also are existing instances of "useless ;" that would want t=
o
>>>> be cleaned up regardless of portability issues.
>>> Unfortunately it seems to be required. Travis CI generates a shell =
script
>>> out of the yml file and I think they don't respect newlines or some=
thing...
>>
>> If they squash all the lines into a single long line before
>> executing, these semicolons do indeed become necessary (we have to
>> write a logical single line shell script in our Makefiles with ';',
>> and I'd imagine Travis's scriptlets are done similarly).

Actually, it's not Travis, but just the Yaml syntax:

  http://docs.ansible.com/ansible/YAMLSyntax.html
 =20
  Values can span multiple lines using | or >. Spanning multiple lines
  using a | will include the newlines. Using a > will ignore newlines;
  it=E2=80=99s used to make what would otherwise be a very long line ea=
sier to
  read and edit

So, a simpler solution would be to apply something like this:

--- a/.travis.yml
+++ b/.travis.yml
@@ -33,7 +33,7 @@ env:
     - GIT_SKIP_TESTS=3D"t9810 t9816"
=20
 before_install:
-  - >
+  - |
     case "${TRAVIS_OS_NAME:-linux}" in
     linux)
       mkdir --parents custom/p4
@@ -81,7 +81,7 @@ before_script: make --jobs=3D2
 script: make --quiet test
=20
 after_failure:
-  - >
+  - |
     : '<-- Click here to see detailed test output!                    =
                     =20
            ';                                                         =
                    =20
     for TEST_EXIT in t/test-results/*.exit;
     do

(untested)

Actually, this may also be a motivation to move anything non-trivial ou=
t
of .travic.yml and to start using separate scripts (to avoid writting
shell within a Yaml syntax).

> ... but the above does not quite explain it.  The newlines are
> mostly honoured as logical end-of-line in existing .travis.yml e.g.
> we do not see a semicolon before "pushd".
>
>             case "${TRAVIS_OS_NAME:-linux}" in
>             linux)
>               mkdir --parents custom/p4
>               pushd custom/p4

I'm tempted to think that these lines create directories pushd/ and
custom/p4/, but that doesn't quite explain it either. There's more magi=
c
somewhere ...

> Puzzled...

Likewise.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
