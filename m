From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] attribute "coding": specify blob encoding
Date: Thu, 03 Jan 2008 13:54:58 -0800
Message-ID: <7vejcyo9ql.fsf@gitster.siamese.dyndns.org>
References: <20080102.082014.02281301.tshibata@ab.jp.nec.com>
	<7v1w904x29.fsf@gitster.siamese.dyndns.org>
	<7vsl1gy2si.fsf@gitster.siamese.dyndns.org>
	<200801032128.m03LSIn2022902@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tsugikazu Shibata <tshibata@ab.jp.nec.com>, git@vger.kernel.org
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 22:55:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAY2W-0004fP-0l
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 22:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbYACVzN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2008 16:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbYACVzN
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 16:55:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbYACVzL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jan 2008 16:55:11 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DC64635E9;
	Thu,  3 Jan 2008 16:55:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EBCFB35E4;
	Thu,  3 Jan 2008 16:55:05 -0500 (EST)
In-Reply-To: <200801032128.m03LSIn2022902@mi0.bluebottle.com>
	(nanako3@bluebottle.com's message of "Fri, 04 Jan 2008 06:23:25
	+0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69541>

=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93  <nanak=
o3@bluebottle.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>=20
>> This teaches "diff hunk header" function about custom character
>> encoding per path via gitattributes(5) so that it can sensibly
>> chomp a line without truncating a character in the middle.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>
>>  * This is not intended for serious inclusion, but was done more
>>    as a demonstration of the concept, hence [3/2].
>
> Why not?  It looks a useful addition for us Japanese people.

    (offtopic) I was once told that "us Japanese people" is a
    bad thing to say in public because it sets an unfriendly
    tone by creating a psychological divide between "us" and
    "others".  After all I am one of you ;-)

The reason I do not like the patch as-is is because I have
doubts about the way "coding" acts in the patch.

There already is clean/smudge filter mechanism.  Even if your
work tree has files in euc-jp or Shift_JIS, you could choose to
internally use UTF-8 at git object level.  Then the part that
deals with diff hunk headers (the topic of the patch we are
discussing) would have to work only on UTF-8 data.

	Side note: when getting the data from a file in the work
	tree, we convert into internal representation before
	running diff (see diff.c::diff_populate_filespec()), but
	we do not convert it back to external representation by
	running the smudge filter on the diff output.  We might
	optionally want to but if somebody is going to do this,
	the patch accepting side also needs to be modified to
	reverse the conversion.

The solution with clean/smudge is not applicable to everybody.
It needs to be agreed upon project-wide what encoding is used as
the canonical encoding for the project, and when the project
chooses to use UTF-8, the above would become a cleaner and
workable approach.

If the project, on the other hand, chooses to use a non UTF-8
encoding (e.g. euc-jp) as the canonical representation,
something like my patch may be necessary.

Between these two ways to skin the cat, I do not want to close
the door for either one of them too early, although I am
somewhat partial to "internally everything is UTF-8" approach.

Maybe we would want to use "coding" (short, sweet and nice name
for an attribute) to mean a canned smudge/clean filter pair that
runs to/from UTF-8 iconv, making the "internally, everything is
UTF-8" approach a more officially supported option.  If we
choose to go that route, the way "coding" attribute was used in
the patch directly conflicts with that design, as the world view
my "coding" patch takes is "whatever coding project chooses is
used internally, and the attribute is used to teach coding
specific actions to the underlying logic".

>> +static struct {
>> +	const char *coding;
>> +	sane_truncate_fn fn;
>> +} builtin_truncate_fn[] =3D {
>> +	{ "euc-jp", truncate_euc_jp },
>> +	{ "utf-8", NULL },
>> +};
>
>Can you also do JIS and Shift JIS?  I ask because many of my
>old notes are in Shift JIS and I think it is the same for many
>other people.=20

I guess somebody else could (hint, hint,...).  Shift_JIS should
be more or less straightforward to add.

With the current code structure, however, ISO-2022 (you said
"JIS" -- Japanese often use that word to mean 7-bit ISO-2022 and
so did you in this context) is a bit cumbersome to handle, as
you cannot just truncate but also have to add a few escape bytes
to go back to ASCII at the end of line.
