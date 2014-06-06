From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] replace: add --graft option
Date: Fri, 06 Jun 2014 09:59:18 -0700
Message-ID: <xmqqegz2q8ih.fsf@gitster.dls.corp.google.com>
References: <20140604194118.23903.3019.chriscool@tuxfamily.org>
	<20140604194353.23903.89933.chriscool@tuxfamily.org>
	<xmqqfvjjrpq9.fsf@gitster.dls.corp.google.com>
	<CAP8UFD3k98_6Uh+noJgt4xqEooATVMAEf58FFkuy6rHBnP10zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 18:59:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsxUH-0002Cc-K3
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 18:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbaFFQ7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 12:59:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50033 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175AbaFFQ7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 12:59:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 636111B670;
	Fri,  6 Jun 2014 12:59:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z8n5H17HYoKaa+QE/Z/c5TsijKk=; b=VafQws
	vR5tkVVrpfiV1HHAKKRDgWGMy3shTHEp0Tydd4awe7nQAHm6p/UVnl2ciYKkXU2J
	THj8QJPPCXIYHJzrdd+jvBIeJwpxf9FdksZWWyng8TiA5Gp1wtszR7XbCdLst/g6
	XN4SqCYDd1Ft9q6mJ7ziR/16l04aYmZ+jgBTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lbsCO/tzUN2/ZJi+hRgShQhD8NNmTL7F
	VHACQxqEtv0EVOMAGx+FXDxYSkFriCQMUp9K+NZOkg9y+SGiypQkEPaadK0p/NaS
	8riddCRYrcn6g2De/sl6S1ESOZiCezNY0LFWmoYkYwBAuMZES2YHvzDHpETb395i
	W4EJwMuu52k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 576651B66F;
	Fri,  6 Jun 2014 12:59:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 336001B66C;
	Fri,  6 Jun 2014 12:59:20 -0400 (EDT)
In-Reply-To: <CAP8UFD3k98_6Uh+noJgt4xqEooATVMAEf58FFkuy6rHBnP10zw@mail.gmail.com>
	(Christian Couder's message of "Fri, 6 Jun 2014 17:29:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E7056A30-ED9B-11E3-A269-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250949>

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, Jun 5, 2014 at 11:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Christian Couder <chriscool@tuxfamily.org> writes:
>>
>>> +static int create_graft(int argc, const char **argv, int force)
>>> +{
>>> +     unsigned char old[20], new[20];
>>> +     const char *old_ref = argv[0];
>>> +     struct commit *commit;
>>> +     struct strbuf buf = STRBUF_INIT;
>>> +     struct strbuf new_parents = STRBUF_INIT;
>>> +     const char *parent_start, *parent_end;
>>> +     int i;
>>> +
>>> +     if (get_sha1(old_ref, old) < 0)
>>> +             die(_("Not a valid object name: '%s'"), old_ref);
>>> +     commit = lookup_commit_or_die(old, old_ref);
>>
>> Not a problem with this patch, but the above sequence somehow makes
>> me wonder if lookup-commit-or-die is a good API for this sort of
>> thing.  Wouldn't it be more natural if it took not "unsigned char
>> old[20]" but anything that would be understood by get_sha1()?
>>
>> It could be that this particular caller is peculiar and all the
>> existing callers are happy, though.  I didn't "git grep" to spot
>> patterns in existing callers.
>
> lookup_commit_or_die() looked like a good API to me because I saw that
> it checked a lot of things and die in case of problems, which could
> make the patch shorter.

Perhaps I was vague.  "find the commit object and die if that object
is not properly formed" is a good thing.  I was referring to the
fact that you

    - first had to do get-sha1 yourself to turn the extended sha1
      you got from the user into a binary object name, and die with
      your own error message if the user input was malformed.

    - and then had to call lookup-commit-or-die to do the checking
      and let it die.

It would have been simpler for *this* particular codepath if we had
another helper function you can use like so:

	commit = lookup_commit_with_extended_sha1_or_die(old_ref);

which did the two-call sequence you handrolled above, and I was
wondering if other existing callers to lookup-commit-or-die wished
the same thing.
