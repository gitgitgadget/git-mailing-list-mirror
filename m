From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 0/3] Generalized "string function" syntax
Date: Tue, 20 Oct 2009 01:07:03 +0200
Message-ID: <4ADCF117.2030905@lsrfire.ath.cx>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com> <4ADA3153.7070606@lsrfire.ath.cx> <7v63ad5o8p.fsf@alter.siamese.dyndns.org> <4ADAD0D2.504@lsrfire.ath.cx> <7vr5t0nwu8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 01:07:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N01Jv-00057c-PW
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 01:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757906AbZJSXHD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Oct 2009 19:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757838AbZJSXHC
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 19:07:02 -0400
Received: from india601.server4you.de ([85.25.151.105]:37836 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755582AbZJSXHB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 19:07:01 -0400
Received: from [10.0.1.101] (p57B7E7B1.dip.t-dialin.net [87.183.231.177])
	by india601.server4you.de (Postfix) with ESMTPSA id A570C2F8059;
	Tue, 20 Oct 2009 01:07:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vr5t0nwu8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130742>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Which other text functions are we going to add which would break thi=
s
>> model?  The only thing I can think of right now is nesting such
>> functions themselves, e.g. when indenting a list in an indented
>> sub-paragraph in an indented paragraph.  Useful?
>=20
> I was more worried about painting ourselves now in a corner we cannot=
 get
> out of easily later.  Even if my answer to question "what are we goin=
g to
> add" may be "nothing I can think of right now", it does not make me h=
appy.

If wrapping wasn't implemented as a nested function, nesting could stil=
l
be introduced independently and used for other things -- once these
other things arrive.

> Something off the top of my head are combinations like these.
>=20
>     %[toupper()%cD%] =3D> 'SUN, 18 OCT 2009 12:34:56 -0700'
>     %[substr(7,3)%[toupper()%cD%]] =3D> 'OCT'
>=20
>     %[sanitize()%s%] =3D=3D=3D %f (i.e. format-patch filename)
>     %[sanitize()%[substr(0,7)%[toupper()%aN%]%]%s] (with upcased auth=
or name)

Interesting examples, I particular like sanitize().

> By the way, I think that date formatting can be helped by introducing=
 a
> strftime() function that takes %ct/%at as input, e.g. %aD would becom=
e
>=20
>     %[strftime(%a, %d %b %Y %H:%M:%S %z)%at]
>=20
> and we do not have to worry about keep adding random %[ac]X formats a=
nd
> running out of X.  Right now we use d/D/r/i and there were talks of a=
dding
> a shortened 8601 format without time or something we did not implemen=
t.

The number of date formats is scary, but this could be solved e.g. by
introducing "%aT(<date format specifiers etc.>)", without nesting.

> Also, if we had this %[func() any string%] mechanism, we probably wou=
ldn't
> have had to add distinction between n/N and e/E after %a and %c.

Yeah, the place holders multiplied, and some of that growth could have
been avoided by providing ways to change the change the output instead
of providing the processed results.

However, I think that nesting is such a big addition that it warrants
further planning.  It turns the simple "see place holder, fill in value=
"
interpolator into more of a programming language.  Is that really
needed?  And if yes, do we want to keep all these percent signs around
or is it better to invent a nicer syntax?  Or borrow it from somewhere
else?  Or perhaps I'm just afraid of change and complexity.

Anyway, all of the functions that accept strings need to be able to ski=
p
over escape codes, which includes all of those mentioned above except
perhaps strftime.  This is ugly.  Or one could forbid colour codes in
function arguments.

I'm more in favour of adding ways to customize the shape of the element=
s
rather than adding string functions.  %S(width=3D76,indent=3D4) over
%[wrap(76,4)%s%].

I feel I need to think a bit more about this; currently I'm a bit scare=
d
by %[...%].  But first to catch some sleep..

Ren=C3=A9
