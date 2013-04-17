From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git log - crash and core dump
Date: Wed, 17 Apr 2013 19:59:28 +0200
Message-ID: <516EE300.7020200@lsrfire.ath.cx>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com> <516D93C4.1000100@lsrfire.ath.cx> <7v61zml0ow.fsf@alter.siamese.dyndns.org> <516DBE2E.4060201@lsrfire.ath.cx> <7vzjwyi0ba.fsf@alter.siamese.dyndns.org> <7vli8hhgmn.fsf@alter.siamese.dyndns.org> <20130417063942.GA27703@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ivan Lyapunov <dront78@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 17 19:59:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USWe0-0005C7-2m
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 19:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936259Ab3DQR7h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 13:59:37 -0400
Received: from india601.server4you.de ([85.25.151.105]:48192 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936191Ab3DQR7f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 13:59:35 -0400
Received: from [192.168.2.105] (p579BE374.dip.t-dialin.net [87.155.227.116])
	by india601.server4you.de (Postfix) with ESMTPSA id B5B841E3;
	Wed, 17 Apr 2013 19:59:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130417063942.GA27703@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221557>

Am 17.04.2013 08:39, schrieb Jeff King:
> On Tue, Apr 16, 2013 at 10:26:40PM -0700, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>>>
>>>> How about making split_ident_line() a bit friendlier be letting it
>>>> provide the epoch as default time stamp instead of NULL?
>>>
>>> Two knee-jerk concerns I have without going back to the callers:
>>>
>>>   * Would that "0" ever be given to the approxidate parser, which
>>>     rejects ancient dates in numbers-since-epoch format without @
>>>     prefix?
>>>
>>>   * Does any existing caller use the NULL as a sign to see the inpu=
t
>>>     was without date and act on that information?
>>
>> I looked at all the callers (there aren't that many), and none of
>> them did "Do this on a person-only ident, and do that on an ident
>> with timestamp".  So for the callers that ignore timestamp, your
>> patch will be a no-op, and for others that assume there is a
>> timestamp, it will turn a crash/segv into output with funny
>> timestamp.
>
> What about sane_ident_split in builtin/commit.c? It explicitly reject=
s a
> NULL date. The logic in determine_author_info is a little hard to fol=
low
> (it assembles the ident line with fmt_ident and then reparses it), bu=
t I
> believe it should be catching a bogus line from "commit -c", or from
> GIT_AUTHOR_DATE in the environment.

Right, so let's keep the NULLs and fix the individual cases.  A quick
"git grep -W -e date_begin -e date_end -e tz_begin -e tz_end" reveals
that there are only the ones we talked about: blame, pretty, commit
and -- of course -- ident.  And only the first two need fixing.

> As a side note, when determine_author_info sees a bogus ident, it
> appears to just silently ignore it, which is probably a bad thing.
> Shouldn't we by complaining?  Or am I mis-reading the code?

The code looks complicated, but I just tried it: fmt_ident() dies if yo=
u=20
give it an invalid date.

Ren=C3=A9
