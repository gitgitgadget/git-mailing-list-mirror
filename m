From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/3] parse-options: allow positivation of options starting,
 with no-
Date: Mon, 27 Feb 2012 18:56:03 +0100
Message-ID: <4F4BC3B3.7080000@lsrfire.ath.cx>
References: <4F49317A.3080809@lsrfire.ath.cx> <4F49332E.7070003@lsrfire.ath.cx> <7vy5rpcgrk.fsf@alter.siamese.dyndns.org> <87d390smpa.fsf@thomas.inf.ethz.ch> <7v8vjob3ff.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Geoffrey Irving <irving@naml.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 18:56:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S24o4-0000Bi-F5
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 18:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985Ab2B0R4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 12:56:12 -0500
Received: from india601.server4you.de ([85.25.151.105]:38189 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab2B0R4L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 12:56:11 -0500
Received: from [192.168.2.105] (p579BEC29.dip.t-dialin.net [87.155.236.41])
	by india601.server4you.de (Postfix) with ESMTPSA id 559952F804A;
	Mon, 27 Feb 2012 18:56:09 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7v8vjob3ff.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191637>

Am 27.02.2012 18:18, schrieb Junio C Hamano:
> Thomas Rast<trast@inf.ethz.ch>  writes:
>
>> Junio C Hamano<gitster@pobox.com>  writes:
>>
>>> I would na=C3=AFvely expect that it would be sufficient to update a=
n existing
>>> definition for "--no-frotz" that uses PARSE_OPT_NONEG to instead de=
fine
>>> "--frotz" that by itself is a no-op, and "--no-frotz" would cause w=
hatever
>>> the option currently means, with an update to the help text that sa=
ys
>>> something to the effect that "--frotz by itself is meaningless and =
is
>>> always used as --no-frotz".
>>
>> Doesn't that last quote already answer your question?
>
> Yes, but only partly.  I would agree with the awkwardness in
>
>> It would be rather awkward to see, in 'git apply -h',
>>
>>    --add                 Also apply additions in the patch.  This is=
 the
>>                          default; use --no-add to disable it.
>
> but it feeels somewhat questionable that the solution to get this:
>
>>
>> Compare to the current concise wording
>>
>>    --no-add              ignore additions made by the patch
>
> is to define OPT_BOOL("no-add") that does not have any hint (other th=
an
> the fact that the option name begins with 3 character "no-") that thi=
s is
> an already negated boolean and the "no-" negation can be removed.

The parser already knows that the prefix "no-" negates an option.  It=20
currenmtly only applies this knowledge if that prefix is added, but not=
=20
if it is removed, which is inconsistent.

> This means an option "no-$foo" can never mean anything but "not foo".=
  Not
> that we would have to or necessarily want to support an option to giv=
e the
> number of foo as --no-foo=3D47, as --num-foo=3D47 is a perfectly good=
 spelling
> for such an option.

With the patch, you can define a --no-foo option that doesn't accept=20
--foo as its negation by specifying PARSE_OPT_NONEG.  That would also=20
forbid --no-no-foo, though, but that's probably a good thing.

> If it were OPT_BOOL("no-foo", OPT_ISNEG | ...) that signals the parse=
r
> that:
>
>   - the option name is already negative;
>   - the leading "no-" is to be removed to negate it; and
>   - no extra leading "no-", i.e. "--no-no-foo", is accepted.
>
> I probably wouldn't have felt this uneasy iffiness.

Teaching the parser to understand that removal of the prefix "no-"=20
negates an option on top of its existing knowledge that adding it does=20
the same just adds the other side of the same coin, which was curiously=
=20
missing.

The patch does not forbid adding "no-" to an option that already starts=
=20
with "no-".  This stricter rule would be easy to add, but since that is=
=20
currently the only way to negate such options, it would break backwards=
=20
compatibility and thus should be added in a separate patch, if at all.

With the patch, the following guidelines are followed:

	- "no-" means no, for both developers and users.
	- The user doesn't have to to say "no-no-".

The results feels simpler to me.

Ren=C3=A9
