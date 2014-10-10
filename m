From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] mergetool: use more conservative temporary filenames
Date: Fri, 10 Oct 2014 21:54:29 +0200
Message-ID: <54383975.9080803@kdbg.org>
References: <1412929187-57936-1-git-send-email-davvid@gmail.com> <5437C0CC.7030102@gmail.com> <20141010184834.GB78117@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sergio Ferrero <sferrero@ensoftcorp.com>,
	Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 21:54:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcgGz-0005qt-CV
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 21:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbaJJTyf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Oct 2014 15:54:35 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:17508 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703AbaJJTyf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 15:54:35 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jF0NM21yrz5tlC;
	Fri, 10 Oct 2014 21:54:11 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B996719F48A;
	Fri, 10 Oct 2014 21:54:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <20141010184834.GB78117@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.10.2014 um 20:48 schrieb David Aguilar:
> On Fri, Oct 10, 2014 at 01:19:40PM +0200, Jakub Nar=C4=99bski wrote:
>> David Aguilar wrote:
>>> Avoid filenames with multiple dots so that overly-picky tools do
>>> not misinterpret their extension.
>>>
>>> Previously, foo/bar.ext in the worktree would result in e.g.
>>>
>>> 	./foo/bar.ext.BASE.1234.ext
>>>
>>> This can be improved by having only a single .ext and using
>>> underscore instead of dot so that the extension cannot be
>>> misinterpreted.  The resulting path becomes:
>>>
>>> 	./foo/bar_BASE_1234.ext
>>>
>>> Suggested-by: Sergio Ferrero <sferrero@ensoftcorp.com>
>>> Helped-by: Junio C Hamano <gitster@pobox.com>
>>> Signed-off-by: David Aguilar <davvid@gmail.com>
>>> ---
>>
>>> +	if BASE=3D$(expr "$MERGED" : '\(.*\)\.[^/]*$')
>>> +	then
>>> +		ext=3D$(expr "$MERGED" : '.*\(\.[^/]*\)$')
>>> +	else
>>> +		BASE=3D$MERGED
>>> +		ext=3D
>>> +	fi
>>
>> Why use expr and not POSIX shell parameter substitution?
>>
>> BASE=3D${MERGED%.*}
>> ext=3D.${MERGED##*.}
>>
>> Or something like that...
>=20
> Thanks for the sug.
>=20
> My POSIX shell parameter expansion-fu is not super advanced, but
> if you can help me rework it I'd be happy to reroll.
>=20
> It does seem simple and robust with expr, though.  Extending the
> parameter expansion approach to work in all cases may end up
> with more complexity than with the expr method, it seems.
>=20
> Here are the use cases:
>=20
> 	$ MERGED=3Dfoo.bar.baz && echo ${MERGED%.*} ${MERGED##*.}
> 	foo.bar baz
>=20
> Good.
>=20
> 	$ MERGED=3Dfoo && echo ${MERGED%.*} ${MERGED##*.}
> 	foo foo
>=20
> Bad.
> There's no extension and the substitution doesn't handle it.
>=20
> 	$ MERGED=3Dfoo.bar/baz && echo ${MERGED%.*} ${MERGED##*.}
> 	foo bar/baz
>=20
> Bad.
> There's no extension but the substitution thinks the parent directory=
's
> extension-less name is the basename, and thinks that bar/baz is the e=
xtension.
>=20
> I am curious to know whether there's a nice and elegant way to do it
> with shell expansions.  Let me know what you think.

It's not exactly elegant to do it:

=46irst, you extract the last path part:

	file=3D${MERGED##*/}

Then the directory including the trailing slash:

	dir=3D${MERGED%"$file"}

Then the basename without an extension:

	base=3D${file%.*}

=46inally the extension including the dot:

	ext=3D${file#"$base"}

Beware of empty $base and $dir (e.g., for files named .gitignore or so)

-- Hannes
