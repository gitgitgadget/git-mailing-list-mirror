From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 5/5] pretty describe: add %ds, %dn, %dd placeholders
Date: Sun, 04 Nov 2007 18:27:39 +0100
Message-ID: <472E010B.5070602@lsrfire.ath.cx>
References: <472DB1B0.1050904@lsrfire.ath.cx> <Pine.LNX.4.64.0711041356330.4362@racer.site> <472DDA3B.4090100@lsrfire.ath.cx> <Pine.LNX.4.64.0711041518130.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 04 18:28:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IojGk-0000sP-0v
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 18:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbXKDR16 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 12:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbXKDR16
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 12:27:58 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:48867
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753063AbXKDR15 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 12:27:57 -0500
Received: from [10.0.1.201] (p57B7F8A7.dip.t-dialin.net [87.183.248.167])
	by neapel230.server4you.de (Postfix) with ESMTP id 0AF1E873BA;
	Sun,  4 Nov 2007 18:27:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0711041518130.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63421>

Johannes Schindelin schrieb:
> Hi,
>=20
> On Sun, 4 Nov 2007, Ren? Scharfe wrote:
>=20
>> Johannes Schindelin schrieb:
>>
>>> On Sun, 4 Nov 2007, Ren? Scharfe wrote:
>>>
>>>> +	unsigned long occurs[ARRAY_SIZE(table)];
>>> You do not ever use the counts.  So, longs are overkill.  Even ints=
=20
>>> might be overkill, but probably the most convenient.  I would have=20
>>> gone with chars.  If I knew how to memset() an array of unsigned:1=20
>>> entries to all zero, I would even have gone with that, but the runt=
ime=20
>>> cost of this is probably higher than the chars.
>> Well, it isn't used in format_commit_message() currently, but it cou=
ld=20
>> be.  Multiply the count and and the length of each substitution (min=
us=20
>> the length of the placeholder) and you get the number of bytes you n=
eed=20
>> to allocate.  interpolate() wouldn't need to be called twice anymore=
=2E
>=20
> The better change, of course, would be to migrate interpolate() to st=
rbuf. =20
> Then you do not have to play clever tricks anymore.
>
>>> But the even more fundamental problem is that you count the needed=20
>>> interpolations _every_ single time you output a commit message.
>>>
>>> A much better place would be get_commit_format().  Yes that means=20
>>> restructuring the code a bit more, but I would say that this defini=
tely=20
>>> would help.  My preference would even be introducing a new source f=
ile for=20
>>> the user format handling (commit-format.[ch]).
>> Counting the interpolations is easier than actually interpolating.=20
>> Wherever the code goes, the calls to interpolate() and interp_count(=
)=20
>> should stay together.
>=20
> No.
>=20
> The purpose of calling interp_count() is to know what placeholders ha=
ve to=20
> be filled with substitutes.  As a consequence, the _logical_ thing to=
 do=20
> is call interp_count() _once_.
>=20
> It makes absolutely no sense to call the function over and over again=
,=20
> only to end up with the same result over and over again.

To allow this optimization, you need to make the (not yet filled)
interpolation table available to the new callsite of interp_count().
And you need to somehow pass the result of interp_count() from every
caller of it to the setup code in format_commit_message().

To see if it's worthwhile, I've just replaced the array "occurs" and th=
e
call to interp_count() with a static array, and measured the runtime.
The speed difference was lost in the noise.

>>>> +
>>>> +/*
>>>> + * interp_count - count occurences of placeholders
>>>> + */
>>>> +void interp_count(unsigned long *result, const char *orig,
>>>> +                  const struct interp *interps, int ninterps)
>>>> +{
>>>> +	const char *src =3D orig;
>>> You do not ever use orig again.  So why not just use that variable =
instead=20
>>> of introducing a new one?
>> I simply copied interpolate() and then chopped off the parts not nee=
ded
>> for counting, to make it easy to see that this is the smaller brothe=
r.
>=20
> It is not.  It does not do any substitution.  It is a pure helper for=
 the=20
> process of filling the interpolation table.

Sure.  It's important, though, that it reports the same number of
substitutions as interpolate() later actually performs.  Correctness
trumps cleanliness, and its easier to check that a copy is correct, eve=
n
if certain pieces are missing.

>>> I'd rewrite this whole loop as
>>>
>>> 	while ((c =3D *(orig++)))
>>> 		if (c =3D=3D '%')
>>> 			/* Try to match an interpolation string. */
>>> 			for (i =3D 0; i < ninterps; i++)
>>> 				if (prefixcmp(orig, interps[i].name)) {
>>> 					result[i] =3D 1;
>>> 					orig +=3D strlen(interps[i].name);
>>> 					break;
>>> 				}
>> Cleanups are sure possible, but they should be done on top, and to b=
oth=20
>> interpolate() and interp_count().  Let's first see how far we get wi=
th=20
>> dumb code-copying and reusing the result in new ways. :)
>=20
> Code copying is one of the primary sources for bad code.  Let's not e=
ven=20
> start.
>=20
> IMHO there have to be _very_ good reasons to commit something that yo=
u=20
> plan to fix later anyway.

Code copying can be bad if one copies bugs.  But code copying allows a
strange feat: new code can inherit maturity.  If you copy known good
code and then change it in trivial ways (keeping the structure etc.) to
make it do new things, then the chance of a bug creeping in is lower
than if you wrote that piece of code anew.

> One such good reason would be that it is too hard to do in one go. =20
> Another good reason would be that you think the fix is not even neede=
d=20
> (like I did when I wrote format: in the first place; I am quite surpr=
ised=20
> that after _that_ long a time people complain -- I'd have expected=20
> complaints right away or never).

Not everybody is as fast as you, Dscho. ;-)

Another idea that I was kicking around, but didn't get time to
implement: a performance regression test suite, i.e. make test for
timings and memory usages.

> In this case, I see no reason why we should go for suboptimal code fi=
rst.
>=20
> But hey, if you do not want to do it, I'll do it.  Just say so.

Busted again!  I wanted to see if someone else would pick up the
janitorial work for me. :-)

In any case, interpolate.c needs some attention, with or without my
patch.  I agree that a native strbuf version would be nice.  How about
an interface like that:

	typedef const char *(*expand_fn_t)
		(const char *placeholder, void *context);
	void strbuf_addexpand(struct strbuf *sb, const char *format,
	                      const char **placeholders,
	                      expand_fn_t fn, void *context);

strbuf_addexpand() would call fn() when it recognizes a placeholder,
avoiding unneeded setup code.  It could cache the result, so that fn()
gets called at most a single time for each given placeholder.  context
would be passed through to fn(), e.g. a struct commit in case of
format_commit_message().  Makes sense?

Thanks,
Ren=E9
