From: Kang-min Liu <gugod@gugod.org>
Subject: Re: Git's Perl scripts can fail if user is configured for perlbrew
Date: Tue, 30 Dec 2014 00:09:12 +0100
Message-ID: <m2iogujbon.fsf@gugod.org>
References: <54A085D1.8060407@blackperl.com> <CACBZZX4qKyfRcbowYnM-KsrbKZ2=9RXr+HEgrOU1jaCsSX53QA@mail.gmail.com> <54A1C29C.4090100@blackperl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Randy J. Ray" <rjray@blackperl.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
	<avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>,
	Kang-min Liu <gugod@gugod.org>
X-From: git-owner@vger.kernel.org Tue Dec 30 00:09:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5jRG-0001oh-EA
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 00:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbaL2XJT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Dec 2014 18:09:19 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:59516 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbaL2XJS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2014 18:09:18 -0500
Received: from mfilter21-d.gandi.net (mfilter21-d.gandi.net [217.70.178.149])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 1797B172071;
	Tue, 30 Dec 2014 00:09:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter21-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter21-d.gandi.net (mfilter21-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 4+k6lyVjMedP; Tue, 30 Dec 2014 00:09:15 +0100 (CET)
X-Originating-IP: 77.163.137.207
Received: from localhost (ip4da389cf.direct-adsl.nl [77.163.137.207])
	(Authenticated sender: gugod@gugod.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id D3163172081;
	Tue, 30 Dec 2014 00:09:13 +0100 (CET)
In-reply-to: <54A1C29C.4090100@blackperl.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261895>



> On 12/29/14, 7:21 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> [CC'd the perlbrew author]
>>
>> This is a bit of a tricky issue.
>>
>> Using whatever perl is defined in the environment is just as likely =
to
>> break, in general the build process tries to pick these assets at
>> compile-time. Imagine you're experimenting with some custom perl
>> version and now Git inexplicably breaks.
>>
>> It's better if Git detects a working perl when you compile it and
>> sticks with that, which is why we use /usr/bin/perl by default.

With "perl" being an external dependency, sticking with whatever at the
compile time basically means these should stick:

- `which perl`, and the same $Config options
- Every module contained in PERL5LIB
- Other external executable dependencies of some .pm files that lives
  somewhere in PATH

We could of course build an app bundle dir like a lightweight container=
=2E
to mitigate this... but that would'nt be usefull without tweaking the
shebang line of the scripts -- to point to the perl script (shim or
real) that should be compatible with the newly built git.

I'd argue that trying to compile git (or other stuff in general) agains=
t
a perlbrew-managed perl is something that "perlbrew" executable cannot
manage. Because it is both valid that the user is doing this
intentionally and want the outcome, or the user is doing this
unintentionally. And even if we have a shim "perl" script, it would'nt
help as long as it is the "whatever perl" in PATH -- which might just b=
e
incompitble.

I wonder if disabling perlbrew per-building can deal with this:

    'perlbrew off'

If this end up changing the shebang line then maybe, if not then it'll
still intefere after perlbrew is re-activated.

The other option to minimize perlbrew interferince is of course to
completely deprecate the global env var approach and make them project
local. But that's another story.

--=20
Cheers,
Kang-min Liu
