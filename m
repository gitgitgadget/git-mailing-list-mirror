From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 5/5] pretty describe: add %ds, %dn, %dd placeholders
Date: Sun, 04 Nov 2007 15:42:03 +0100
Message-ID: <472DDA3B.4090100@lsrfire.ath.cx>
References: <472DB1B0.1050904@lsrfire.ath.cx> <Pine.LNX.4.64.0711041356330.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 04 15:42:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoggO-0003hA-01
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 15:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364AbXKDOmW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 09:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755836AbXKDOmV
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 09:42:21 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:42029
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755098AbXKDOmV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 09:42:21 -0500
Received: from [10.0.1.201] (p57B7F8A7.dip.t-dialin.net [87.183.248.167])
	by neapel230.server4you.de (Postfix) with ESMTP id BB348873BA;
	Sun,  4 Nov 2007 15:42:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0711041356330.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63412>

Johannes Schindelin schrieb:
> Hi,
>=20
> On Sun, 4 Nov 2007, Ren? Scharfe wrote:
>=20
>> The new placeholders %ds (description string, git-describe style), %=
dn=20
>> (the name part) and %dd (the depth part) are added.
>>
>> To avoid imposing the significant cost of running describe_commit() =
on=20
>> every format string, even if none of the new placeholders are used, =
a=20
>> new function, interp_count(), is introduced.  It is a stripped down=20
>> version of interpolate(), that simply counts the placeholders in a=20
>> format string.  If the describe placeholders are not found, setting =
up=20
>> the corresponding replacements is skipped.
>=20
> The way I read this, those are two really quite independent patches=20
> squashed into one.

Busted!  I didn't want to introduce a performance regression with the
%ds parsing code, but I also didn't want to add a function without
users.  Patch 6 was then glued on as an afterthought -- the rest of the
series was ready when I saw Paul's mail.

So, a better way might be to move patch 6 to the head of the series and
introduce interp_count() in it, too.

>> +	unsigned long occurs[ARRAY_SIZE(table)];
>=20
> You do not ever use the counts.  So, longs are overkill.  Even ints m=
ight=20
> be overkill, but probably the most convenient.  I would have gone wit=
h=20
> chars.  If I knew how to memset() an array of unsigned:1 entries to a=
ll=20
> zero, I would even have gone with that, but the runtime cost of this =
is=20
> probably higher than the chars.

Well, it isn't used in format_commit_message() currently, but it could
be.  Multiply the count and and the length of each substitution (minus
the length of the placeholder) and you get the number of bytes you need
to allocate.  interpolate() wouldn't need to be called twice anymore.

> But the even more fundamental problem is that you count the needed=20
> interpolations _every_ single time you output a commit message.
>=20
> A much better place would be get_commit_format().  Yes that means=20
> restructuring the code a bit more, but I would say that this definite=
ly=20
> would help.  My preference would even be introducing a new source fil=
e for=20
> the user format handling (commit-format.[ch]).

Counting the interpolations is easier than actually interpolating.
Wherever the code goes, the calls to interpolate() and interp_count()
should stay together.

>> +
>> +/*
>> + * interp_count - count occurences of placeholders
>> + */
>> +void interp_count(unsigned long *result, const char *orig,
>> +                  const struct interp *interps, int ninterps)
>> +{
>> +	const char *src =3D orig;
>=20
> You do not ever use orig again.  So why not just use that variable in=
stead=20
> of introducing a new one?

I simply copied interpolate() and then chopped off the parts not needed
for counting, to make it easy to see that this is the smaller brother.

>=20
>> +	const char *name;
>> +	unsigned long namelen;
>> +	int i;
>> +	char c;
>> +
>> +	for (i =3D 0; i < ninterps; i++)
>> +		result[i] =3D 0;
>=20
> memset()?

In earlier versions there was a memset() there.  I replaced it to make
the intent even more clear, but I guess not using memset() is simply
superstition..

>=20
>> +
>> +	while ((c =3D *src)) {
>> +		if (c =3D=3D '%') {
>> +			/* Try to match an interpolation string. */
>> +			for (i =3D 0; i < ninterps; i++) {
>> +				name =3D interps[i].name;
>> +				namelen =3D strlen(name);
>> +				if (strncmp(src, name, namelen) =3D=3D 0)
>=20
> prefixcmp()?

Copied from interpolate()..

>> +					break;
>> +			}
>> +
>> +			/* Check for valid interpolation. */
>> +			if (i < ninterps) {
>=20
> This is ugly.  You already had a successful if() for that case earlie=
r.

Dito..

>=20
>> +				result[i]++;
>> +				src +=3D namelen;
>> +				continue;
>> +			}
>> +		}
>> +		src++;
>> +	}
>> +}
>=20
> I'd rewrite this whole loop as
>=20
> 	while ((c =3D *(orig++)))
> 		if (c =3D=3D '%')
> 			/* Try to match an interpolation string. */
> 			for (i =3D 0; i < ninterps; i++)
> 				if (prefixcmp(orig, interps[i].name)) {
> 					result[i] =3D 1;
> 					orig +=3D strlen(interps[i].name);
> 					break;
> 				}

Cleanups are sure possible, but they should be done on top, and to both
interpolate() and interp_count().  Let's first see how far we get with
dumb code-copying and reusing the result in new ways. :)

Thanks,
Ren=E9
