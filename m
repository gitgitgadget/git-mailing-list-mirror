From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/apply.c: use iswspace() to detect line-ending-like chars
Date: Mon, 24 Mar 2014 21:54:38 -0700
Message-ID: <7vd2haq3n5.fsf@alter.siamese.dyndns.org>
References: <1395344384-7975-1-git-send-email-g3orge.app@gmail.com>
	<532C1EFA.3000109@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: George Papanikolaou <g3orge.app@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 25 05:54:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSJN8-0004kK-Q7
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 05:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbaCYExY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 00:53:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60008 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbaCYExX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 00:53:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14E3367707;
	Tue, 25 Mar 2014 00:53:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8Ug9u+yyZTTF+5neh6FBTHJnd2E=; b=PHVrm5
	PYIJSnZAewnu1Q2twZjEgu8xMMu5AENsajHwkCv2zfph3X7DSxiAzq4JLx/Usqim
	B8SVHKwI6Yjc/DDxH/FQ76FaFKVzMlH2Ufj+vgSh/r2OCDQyfuwKFrcqm7kSnpui
	7qQYh0Q3VZovX2Hb9vXHr/9VVlsBba/Fdk80I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lz8F0ZfpNQk376IdVfTr/hntS+3uSatY
	tBMIcLwfS+zEOX9k2lGkzDyvfM8Dje359eqOtH3wYIpSUUn0DEHNpkMVYLigVLil
	Q5lE49gXs6AMsQLUkoKGAL7hEgIsPG/nS6LCpcwXoNOwBgfHbdVEL6H9hlRsaMDd
	mupAQ3h3O/U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 038DF67706;
	Tue, 25 Mar 2014 00:53:23 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33D3B67703;
	Tue, 25 Mar 2014 00:53:22 -0400 (EDT)
In-Reply-To: <532C1EFA.3000109@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 21 Mar 2014 12:14:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 643CE3CC-B3D9-11E3-AA59-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244901>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> -	while ((*last1 == '\r') || (*last1 == '\n'))
>> +	while (iswspace(*last1))
>>  		last1--;
>> -	while ((*last2 == '\r') || (*last2 == '\n'))
>> +	while (iswspace(*last2))
>>  		last2--;
>>  
>>  	/* skip leading whitespace */
>> 
>
> In addition to Eric's comments...
>
> What happens if the string consists *only* of whitespace?

Also, why would casting char to wchar_t without any conversion be
safe and/or sane?

I would sort-of understand if the change were to use isspace(), but
I do not think that is a correct conversion, either.  Isn't a pair
of strings "a bc" and "a bc " supposed not to match?

My understanding is that two strings that differ only at places
where they have runs of whitespaces whose length differ are to
compare the same, e.g. "a_bc__" and "a__bc_" (SP replaced with _ to
make them stand out).  Ignoring whitespace change is very different
from ignoring all whitespaces (the latter of which would make "a b"
and "ab" match).

As a tangent, I have a suspicion that the current implementation may
be wrong at the beginning of the string.  Wouldn't it match " abc"
and "abc", even though these two strings shouldn't match?
