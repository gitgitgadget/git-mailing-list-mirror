From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] t3910: show failure of core.precomposeunicode with decomposed
 filenames
Date: Tue, 29 Apr 2014 09:39:53 +0200
Message-ID: <535F5749.1060500@web.de>
References: <20140428161630.GA9435@sigill.intra.peff.net> <xmqqbnvlqn5j.fsf@gitster.dls.corp.google.com> <20140428193502.GD25993@sigill.intra.peff.net> <535EB167.4030804@web.de> <20140428200326.GA2961@sigill.intra.peff.net> <535EBEDA.5070207@web.de> <20140429032347.GB11979@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 29 09:41:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf2eu-0006iC-SQ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 09:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711AbaD2Hkx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Apr 2014 03:40:53 -0400
Received: from mout.web.de ([212.227.15.14]:62203 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727AbaD2Hkw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 03:40:52 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MNcIg-1WXsj43zoY-007DVx; Tue, 29 Apr 2014 09:40:49
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131104 Icedove/17.0.10
In-Reply-To: <20140429032347.GB11979@sigill.intra.peff.net>
X-Provags-ID: V03:K0:+I1FY3YwHzsdZ1NSuPgvsoR9lt6Q1dxMF/JbowsjeqySyvteOBx
 WPSsJooR6o0XXvFObtrRzkdWu0+/tCNWoqPPpDfS76Ew+hBTQqgLEff33gAF59Uy5yiqqJA
 hF8ehahb0fplGEcr6WQZODD+7Lp0biPsltjtZrtsdHTEFNqWtXf8kMhrwe72ayt63QbhLxQ
 DuMUqJMm1Qz+A7u+/k6Qw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247526>

On 04/29/2014 05:23 AM, Jeff King wrote:
> On Mon, Apr 28, 2014 at 10:49:30PM +0200, Torsten B=C3=B6gershausen w=
rote:
>
>> OK, thanks for the description.
>> In theory we can make Git "composition ignoring" by changing
>> index_file_exists() in name-hash.c.
>> (Both names must be precomposed first and compared then)
> Yeah, we could perhaps get away without storing the extra precomposed
> form if we just stored the entries under their precomposed hash, and
> then taught same_name to use a slower precompose-aware comparison. Bu=
t I
> also see that we do binary searches in index_name_pos (called by
> index_name_is_other). I don't know if we'd have to deal with this
> problem there, too.
Just loud thinking:
We precompose whenever we read file names from disc, that's done in=20
readdir()
We precompose whenever we get an argv into Git, that's done in=20
precompose_argv()
We precompose every time we read file names from the index file on=20
disc(?) into memory.
That we don't do today, and my suggestion to hack name-hash.c isn't a=20
good one.

Probably we need to go into read-cache.c, or more places. I'm not an=20
expert here knowing
all Git internal details.
Basically all places where strings containing file names are put into=20
memory are effected,
and I wouldn't be too concerned about CPU cycles.

>> I don't know how much people are using Git before 1.7.12 (the
>> first version supporting precomposed unicode).
>>
>> Could we simply ask them to upgrade ?
> I'm not sure what you mean here. Upgrading won't help, because the
> values are baked into existing history created with the old versions
> forever. Any time I "git checkout v1.0" on the broken project, a mode=
rn
> git will complain about the ghost untracked file.
It depends if all file names in a certain repo are stored decomposed,
(in this case everybody can set core.precomposeunicode false)
or if there is a mixture having precomposed and decomposed
in different comits/directories...
In this case we can normalize the master branch.
=46or older commit the users need to wait for an updated Git version,
until that they need to live with the ghosts as good as they can.

>
>> The next problem is that people need to agree if the repo should sto=
re
>> names in pre- or decomposed form.
>> (My voice is for precomposed)
>> Unfortunatly the core.precomposeunicode is repo-local, so everybody
>> needs to "agree globally" and "configure locally".
> Yeah, that was sort of my "point 1" from the patch. I'm a bit worried
> that it creates problems for people on other systems, though. Linux
> people do not need to care about precomposed/decomposed at all, and a=
ny
> attempt we make to automatically handle it is going to run afoul of
> non-utf8 encodings. Not to mention that it does not solve the "git
> checkout v1.0" problem above.
Not sure what is meant by non-utf8 encodings.
Mac OS X can only handle Unicode filenames,
and a single ISO-8859-1 will be returned as "%XY" from readdir().
So if you want to share a repo with Mac OS X (and/or Windows)
Unicode should be used.
Are you saying that there is a Linux station feeding in file names in =20
e.g. 8859-1, EUC ?
My experience/knowledge is that you can not do that (in a useful way).


>> Side note:
>> I which we had this config variable travelling with the repo, like .=
gitattributes does
>> for text dealing with CRLF-LF.
> Yeah, I guess if we wanted to enforce it everywhere, you would have t=
o
> use .gitattributes since we cannot safely turn on such a feature by
> default.
>
>> I don't know how many reports you have, reading all this it feels as=
 if the effected users
>> could "normalize" their repos and run "git config core.precomposeuni=
code true", followed
>> by "git config --global core.precomposeunicode true".
>> Does that sound like a possible way forward ?
> I have just a handful of reports. Maybe 3-4? I didn't dig them all up
> today, as it would be a non-trivial effort. But I have no idea how go=
od
> a sampling that is.
The following could help, may be:
git -c core.quotepath=3Dfalse ls-files | iconv -f UTF-8-MAC -t UTF-8 >e=
xpected
git -c core.quotepath=3Dfalse ls-files >actual
diff expected actual
>
> -Peff
