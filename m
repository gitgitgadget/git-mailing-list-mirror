From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rerere: fix memory leak if rerere images can't be read
Date: Tue, 23 Feb 2010 14:53:24 -0800
Message-ID: <7vd3zv7ee3.fsf@alter.siamese.dyndns.org>
References: <1266955913-4943-1-git-send-email-bert.wesarg@googlemail.com>
 <alpine.DEB.1.00.1002232225480.3980@intel-tinevez-2-302>
 <36ca99e91002231356u189b80ebka7ae8caf89ab9c10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 23:54:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk3dZ-0002TZ-ND
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 23:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628Ab0BWWxj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 17:53:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56577 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381Ab0BWWxi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2010 17:53:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D1179C9E1;
	Tue, 23 Feb 2010 17:53:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nI4w6hhdJ7Co
	JLayU7ArMhhFMvE=; b=h6JgpsJ4Q53eajNdcUlXUlmmyfHKp/XLK+LfXZMSv7X2
	eJ2WB1NkBUrRmHdXpwT/DAWdYQ6I3He7Ls98OowJqIeUtxOQdPfjMiRBY913vMYL
	RKU1N0/hWvizJw84hyRu7L71UD8lhiCQd+nrrnM6g5b9SiPE2Bmzun2hNtvgpoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bt5TvD
	3hWItw1GLb0PFyZL444X90UTYwnWrimfpuwWyK3Hajk30ADlmWPEyPE1UIHnIcmu
	sFWvNbSaCFg7p8jAHAeUSZzjhFb2cS3uCnLm6vs5FnTAF5+PEaiL7AAhEz8G1TYz
	+YS+z5h0sSkFst6LqZoemvqdmODMGXhZMOrSQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B8479C9E0;
	Tue, 23 Feb 2010 17:53:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1803B9C9D7; Tue, 23 Feb
 2010 17:53:25 -0500 (EST)
In-Reply-To: <36ca99e91002231356u189b80ebka7ae8caf89ab9c10@mail.gmail.com>
 (Bert Wesarg's message of "Tue\, 23 Feb 2010 22\:56\:20 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 439CDE62-20CE-11DF-9748-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140861>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> On Tue, Feb 23, 2010 at 22:26, Johannes Schindelin
>>> diff --git a/rerere.c b/rerere.c
>>> index d1d3e75..9ca4cb8 100644
>>> --- a/rerere.c
>>> +++ b/rerere.c
>>> @@ -364,16 +364,17 @@ static int find_conflict(struct string_list *=
conflict)
>>> =C2=A0static int merge(const char *name, const char *path)
>>> =C2=A0{
>>> =C2=A0 =C2=A0 =C2=A0 int ret;
>>> - =C2=A0 =C2=A0 mmfile_t cur, base, other;
>>> + =C2=A0 =C2=A0 mmfile_t cur =3D {NULL, 0}, base =3D {NULL, 0}, oth=
er =3D {NULL, 0};
>>> =C2=A0 =C2=A0 =C2=A0 mmbuffer_t result =3D {NULL, 0};
>>>
>>> =C2=A0 =C2=A0 =C2=A0 if (handle_file(path, NULL, rerere_path(name, =
"thisimage")) < 0)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
>>>
>>> + =C2=A0 =C2=A0 ret =3D 1;
>>
>> This initialization can come earlier, at declaration time.

Yes it can, but I do not think it makes it any easier to read.

> I thought about it, but I think it is clearer to put just in front of
> the condition which may fail.

And I do not think yours is much easier to follow, either.

The function looks like:

	static int merge()
        {
        	int ret; /* uninitialized */
                ...

		if (something)
                	return 1; /* error */

		if (some thing
                    that does allocation and is
                    fairly large)
			return 1; /* error */
		ret =3D operation_that_return_status();
                free resources
                return ret;
	}

If you initialize ret early, it might make "ret" always defined, but it
also makes the first "return 1" give you "huh, why not use ret?".

	static int merge()
        {
        	int ret =3D 1; /* assume bad things will happen */
                ...

		if (something)
                	return 1; /* error */

		if (some thing
                    that does allocation and is
                    fairly large)
			goto out; /* error */
		ret =3D operation_that_return_status();
	out:
                free resources
                return ret;
	}

Also it makes clearing of assumed error harder to spot.

Bert's version is not much better.  That "set ret to positive before go=
ing
to the exit codepath" logically belongs to the error case.  IOW:

	static int merge()
        {
        	int ret; /* uninitialized */
                ...

		if (something)
                	return 1; /* error */

		if (some thing
                    that does allocation and is
                    fairly large) {
			ret =3D 1;
			goto out; /* error */
		}
		ret =3D operation_that_return_status();
	out:
                free resources
                return ret;
	}

We could initialize ret to 0 at the beginning, to signal the people who
might be tempted to touch the code later that you are supposed to flip =
it
to non-zero when you find an error and jump to out.  An immediate follo=
w
up to such a change would be to do something like:

	static int merge()
        {
        	int ret =3D 0; /* no error yet */
                ...

		if (something) {
                	ret =3D 1;
                        goto out; /* error */
		}

		if (some thing
                    that does allocation and is
                    fairly large) {
			ret =3D 1;
			goto out; /* error */
		}
		ret =3D operation_that_return_status();
	out:
                free resources
                return ret;
	}

but the first condition hasn't even allocated anything to be freed, so
there isn't much point doing this either.
