From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/18] fsck: Allow demoting errors to warnings via receive.fsck.warn = <key>
Date: Wed, 21 Jan 2015 13:47:10 -0800
Message-ID: <xmqqa91bx0v5.fsf@gitster.dls.corp.google.com>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
	<cover.1421682369.git.johannes.schindelin@gmx.de>
	<3fd56573b263f2a4551c9a363d1a44728573a1c6.1421682369.git.johannes.schindelin@gmx.de>
	<xmqqlhkwy0my.fsf@gitster.dls.corp.google.com>
	<07b285ef702031fdebcf9def59528b9c@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 22:47:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE37P-00087q-5Z
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 22:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbbAUVrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 16:47:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51252 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751993AbbAUVrO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 16:47:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 10E03313F8;
	Wed, 21 Jan 2015 16:47:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/PogDv1siuDDZw2+myUogfBTnj0=; b=e7zLO9
	0Uz5c98Xvdj+JqPZKZJFmt897sQAiGWXRv6YSlseFlAXLunyeyfJrAMisYVWNI9E
	y10QgdDjj9RDy64XdA92Y5WHxoQxf+3uBQ04AHxKzd71fl114R6OkCBCIWz8JtIf
	6uJd6lbFVfMP1ffRnicf5m6M+/dxQdrwj7etA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OFZUkP+MBlzJjKbDOmmUa+LMl+dBS36z
	WCsW9yhrh4E6WdWaCDHoHemu2CqjdEg3rM3z4Lm7R1wOoBFC+37Qa67K62IRXrbf
	Vy0FLmyMR/EIXM5NQA9UGZIoHss5hUmIjetd0dhiRfGL2T4aqzQ1hdwdyKS85Fr3
	kh3tDA4W16Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 08DB5313F7;
	Wed, 21 Jan 2015 16:47:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B3FF1313F6;
	Wed, 21 Jan 2015 16:47:11 -0500 (EST)
In-Reply-To: <07b285ef702031fdebcf9def59528b9c@www.dscho.org> (Johannes
	Schindelin's message of "Wed, 21 Jan 2015 19:01:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0E35E11E-A1B7-11E4-B6BF-2D68A042C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262772>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>>> @@ -1488,8 +1501,13 @@ static const char *unpack(int err_fd, struct shallow_info *si)
>>>
>>>  		argv_array_pushl(&child.args, "index-pack",
>>>  				 "--stdin", hdr_arg, keep_arg, NULL);
>>> -		if (fsck_objects)
>>> -			argv_array_push(&child.args, "--strict");
>>> +		if (fsck_objects) {
>>> +			if (fsck_severity.len)
>>> +				argv_array_pushf(&child.args, "--strict=%s",
>>> +					fsck_severity.buf);
>>> +			else
>>> +				argv_array_push(&child.args, "--strict");
>>> +		}
>> 
>> Hmm.  The above two hunks look suspiciously similar.  Would it be
>> worth to give them a single helper function?
>
> Hmm. Not sure. I see what you mean, but for now I found
>
> +                       argv_array_pushf(&child.args, "--strict%s%s",
> +                               fsck_severity.len ? "=" : "",
> +                               fsck_severity.buf);
>
> to be more elegant than to add a fully-fledged new function. But if
> you feel strongly, I will gladly implement a separate function; I
> would appreciate suggestions as to the function name...

Peff first introduced that trick elsewhere in our codebase, I think,
but I find it a bit too ugly.

As you accumulate fsck_severity strbuf like this anyway:

	strbuf_addf(&fsck_severity, "%s%s=%s",
        	fsck_severity.len ? "," : "", var, value);

to flip what to prefix each element on the list with, I wonder if it
is simpler to change that empty string to "=", which will allow you
to say this:

	argv_array_pushf(&child.args, "--strict%s", fsck_severity.buf);

Or even this:

	strbuf_addf(&fsck_strict_arg, "%s%s=%s",
        	fsck_strict_arg.len ? "," : "--strict=", var, value);

and then the child.args stuff can become

	if (fsck_strict_arg.len)
		argv_array_push(&child.args, fsck_strict_arg.buf);

In any case, I tend to agree with you that it is overkill to add a
helper function for just to add a single element to the argument
list.

Thanks.

	
