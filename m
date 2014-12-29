From: "Randy J. Ray" <rjray@blackperl.com>
Subject: Re: Git's Perl scripts can fail if user is configured for perlbrew
Date: Mon, 29 Dec 2014 15:07:40 -0600
Message-ID: <54A1C29C.4090100@blackperl.com>
References: <54A085D1.8060407@blackperl.com> <CACBZZX4qKyfRcbowYnM-KsrbKZ2=9RXr+HEgrOU1jaCsSX53QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Kang-min Liu <gugod@gugod.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 22:08:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5hXl-0004kB-L8
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 22:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbaL2VH5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Dec 2014 16:07:57 -0500
Received: from shell1.rawbw.com ([198.144.192.42]:62140 "EHLO shell1.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbaL2VH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 16:07:56 -0500
Received: from ventrue.local ([12.69.179.130])
	(authenticated bits=0)
	by shell1.rawbw.com (8.14.9/8.14.9) with ESMTP id sBTL7hAs049787
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 29 Dec 2014 13:07:49 -0800 (PST)
	(envelope-from rjray@blackperl.com)
X-Authentication-Warning: shell1.rawbw.com: Host [12.69.179.130] claimed to be ventrue.local
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACBZZX4qKyfRcbowYnM-KsrbKZ2=9RXr+HEgrOU1jaCsSX53QA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261877>

On 12/29/14, 7:21 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> [CC'd the perlbrew author]
>
> This is a bit of a tricky issue.
>
> Using whatever perl is defined in the environment is just as likely t=
o
> break, in general the build process tries to pick these assets at
> compile-time. Imagine you're experimenting with some custom perl
> version and now Git inexplicably breaks.
>
> It's better if Git detects a working perl when you compile it and
> sticks with that, which is why we use /usr/bin/perl by default.

These are good points. I'm not sure when this stopped working for me...=
=20
I don't use the -i or -p options to "git add" very often. So I can't sa=
y=20
at what point it stopped working with the current configuration, only=20
that it "used to work".

> When you're setting PERL5LIB you're indicating to whatever perl
> interpreter you're going to run that that's where they it should pick
> up its modules. IMO they way perlbrew does this is broken, instead of
> setting PATH + PERL5LIB globally for your login shell it should set
> the PATH, and then the "perl" in that path should be a pointer to som=
e
> small shellscript that sets PERL5LIB for *its* perl.

That would be for the perlbrew author to consider, of course.

> I don't know what the right tradeoff here is, but I think it would be
> just as sensible to unset PERL5LIB in our own perl scripts + modules,
> it would make live monkeypatching when you wanted to harder, but we
> could always add a GITPERL5LIB or something...

You would have to have a shell script that un-set PERL5LIB and then=20
invoked the given git script, because by the time script execution has=20
begun, the contents of PERL5LIB have already been added to the head of=20
the list of search paths. One approach I tried was to set the=20
environment variable GITPERLLIB (which you already use and recognize, s=
o=20
there is no need for GITPERL5LIB), but that did not help. The base=20
problem still remained: The content of PERL5LIB (which pointed to=20
5.20.1-compiled extensions) took priority over the default @INC content=
s=20
(which were for a 5.16.2 perl).

I don't know the right trade-off, either. I started out reporting this=20
as an issue against the homebrew project's recipe for git, because they=
=20
actually add more explicit library paths to @INC than a vanilla=20
build/install of git does. But the problem is really in the interaction=
=20
between /usr/bin/perl and a PERL5LIB set for an alternate perl. So the=20
solution, if there is one, will lay here in git somewhere...

Randy
--=20
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""=
""""""""
Randy J. Ray      Sunnyvale, CA      http://www.dereferenced.com
rjray@blackperl.com
twitter.com/rjray
Silicon Valley Scale Modelers: http://www.svsm.org
