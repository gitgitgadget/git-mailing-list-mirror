From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add interpret-trailers builtin
Date: Tue, 05 Nov 2013 11:09:02 -0800
Message-ID: <xmqqli12acoh.fsf@gitster.dls.corp.google.com>
References: <20131103211731.15716.95056.chriscool@tuxfamily.org>
	<CALKQrgdJ6d2SVWNQGa6d-eLYPAL-C21=tCyJczCDExLQRfq=jA@mail.gmail.com>
	<xmqqfvrcyoaj.fsf@gitster.dls.corp.google.com>
	<CALKQrgcweo+B8JKH85-4-SOHsAi6SAxstnXhRWCst_qEyXYmhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git mailing list <git@vger.kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Nov 05 20:09:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vdm02-0005yc-0u
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 20:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087Ab3KETJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Nov 2013 14:09:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45410 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752906Ab3KETJH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Nov 2013 14:09:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D39514DED6;
	Tue,  5 Nov 2013 14:09:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6Y1uIhtU8E5igIVr0IKPeQat4sU=; b=vwaYUA
	vhhzeLASxxzkIQZ6B0P8+DJSmAdCaoD7zAe8E7RxsBhyDqO0fM3XFpyIoy7aNPHK
	I1v4RxZBepTzC0nDEuqZI4Sc3p5Dkhr92OKJkDQE2UabiMYE/cVe2iZfXwruq/bg
	eH3jf5N8BKIrHRZc6mhhA85MhGBtDesToQvPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h/m2QyPlUsODXzCDyKUhF+sXR4ifxPUc
	vFWjUGcYRrbPuC/mY73SHlljFS8RGv0V/PYyScsucqSrghPDD6a7QqNk5Evdc0Gh
	sMqPi0SSmIKeeV+EXg77rPt2eN4YfhAWSDF21/bqkJWyR1j++sl8lheMc1qaSeU9
	XWG61bjEooM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C33A14DED2;
	Tue,  5 Nov 2013 14:09:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 166FB4DECA;
	Tue,  5 Nov 2013 14:09:04 -0500 (EST)
In-Reply-To: <CALKQrgcweo+B8JKH85-4-SOHsAi6SAxstnXhRWCst_qEyXYmhA@mail.gmail.com>
	(Johan Herland's message of "Tue, 5 Nov 2013 03:45:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BC8CF962-464D-11E3-BE47-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237334>

Johan Herland <johan@herland.net> writes:

> On Mon, Nov 4, 2013 at 8:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johan Herland <johan@herland.net> writes:
>>>> +{
>>>> +       char *end = strchr(arg, '=');
>>>> +       if (!end)
>>>> +               end = strchr(arg, ':');
>>>
>>> So both '=' (preferred) and ':' are accepted as field/value
>>> separators. That's ok for the command-line, I believe.
>>
>> Why?
>>
>> Sometimes you have to be loose from the beginning _if_ some existing
>> uses and established conventions make it easier for the users, but
>> if you do not have to start from being loose, it is almost always a
>> mistake to do so.  The above code just closed the door to use ":"
>> for some other useful purposes we may later discover, and will make
>> us regret for doing so.
>
> Although I agree with the principle, I think there are (at least) two
> established conventions that will be commonly used from the start, and
> that we should support:
>
>  - Using short forms with '=', e.g. "ack=Peff". There is already a
> convention on how we specify <name> + <value> pairs on the command
> line, e.g. "git -c foo=bar ..."

I do not have much problem with this.

>  - Copy-pasting footers from existing commit messages. These will have
> the same format as the expected output of this command, and not
> accepting the same format in its input seems silly, IMHO.

I am not sure about this, but syntactically, it is very similar to

    --message "CC: Johan Herland <j@h.net>"

so probably it is OK, but then we do not even have to limit it to
colon, no?  E.g. appending an arbitrary footer, with its literal
value, may be done with something like:

    --footer "CC: Johan Herland <j@h.net>"
    --footer "Closes #12345"

>> Also, there is a distinction between fields with the same field name
>> appearing twice and fields with the same field name and the same
>> field value appearing twice. Some headers do want to have them, some
>> do not.
>
> True. This complexity is partly why I initially wanted to leave this
> whole thing up to hooks, but I guess now we have to deal with it...

If we are adding anything, it has to be able to express what we
already do for Signed-off-by: line, so we cannot start from
somewhere any simpler than this, I am afraid.
