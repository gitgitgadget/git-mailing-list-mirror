From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Makefile: Fix compilation of windows resource file
Date: Tue, 21 Jan 2014 15:48:48 -0800
Message-ID: <xmqqk3dssxpb.fsf@gitster.dls.corp.google.com>
References: <52DD857C.6060005@ramsay1.demon.co.uk>
	<xmqqy529t5bb.fsf@gitster.dls.corp.google.com>
	<xmqqppnlt3u3.fsf@gitster.dls.corp.google.com>
	<52DEF9F2.1000905@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jan 22 00:48:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5l3y-0004ID-La
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 00:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbaAUXsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 18:48:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35427 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753851AbaAUXsy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 18:48:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CC2566596;
	Tue, 21 Jan 2014 18:48:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yUOaa1+5KHNOjGvJfr8oFe4MWGQ=; b=sV2U7e
	J7dk+ROEJkxOLeioVeh2MIRqNDiBy8jcCIUQpP0VDfJ/Dde1PPT0iU5KlL8fvQ/4
	v4l/0FW3PrV4jlWMwKohISGc3ubTdzPDZnhlkFXxfvw46N3XiggTGrvb8auYU27A
	y8COLdf4+MChMZHD3A10uY+gY3sZJE3nUTQNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xvVYW0aFQj5mu/YMAVaHG2hItXf40klk
	tnCap/rD2o2aEHRCIO0fSaVSIbrV6mu/cU97QL5Rgp7jFCjGQWUWqLzqZE8ZFjvt
	/UfkPMSeHVZ+ZYfilu8sG7I8ySlIP0pXli1B2XsUBnQ+1h9lmncybEw1gDnTR4qI
	oueP4HKBqi8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ACE766595;
	Tue, 21 Jan 2014 18:48:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C8CA66593;
	Tue, 21 Jan 2014 18:48:51 -0500 (EST)
In-Reply-To: <52DEF9F2.1000905@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Tue, 21 Jan 2014 22:51:30 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 947A2FD6-82F6-11E3-8829-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240804>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

>> Note that I am merely guessing that "short-digit" version numbers
>> are acceptable by now after seeing
>> 
>>     https://sourceware.org/ml/binutils/2012-07/msg00199.html
>
> Ah, nice find!
>
> I will test your patch (below) and let you know soon, but it looks
> good to me. (I can't test it tonight, unfortunately.)

One thing to note is that I don't know why the existing code dropped
the fourth digit from the maintenance series.  The updated one will
give you "1,8,5,3,0" (because I just have a hardcoded ",0" at the
end for no good reason there), and if the missing fourth digit in
the original was a deliberate workaround for this file having an
upper limit of the number of digits (like "four"), this change will
break it, so if that is the case, you may have to count and stop the
loop early, perhaps like...

>> diff --git a/gen-version-string.sh b/gen-version-string.sh
>> new file mode 100755
>> index 0000000..00af718
>> --- /dev/null
>> +++ b/gen-version-string.sh
>> @@ -0,0 +1,13 @@
>> +#!/bin/sh
>> +
>> +IFS=.- result=

Add

	num_digits=0

here, and...

>> +for v in $1
>> +do
>> +	if expr "$v" : '[0-9][0-9]*$' >/dev/null
>> +	then
>> +		result=$result${result:+,}$v

... insert these here.

                num_digits=$(( $num_digits + 1 ))
                if test $num_digits = 4
                then
                        break
                fi

>> +	else
>> +		break
>> +	fi
>> +done
>> +echo "$result"
>> diff --git a/git.rc b/git.rc
>> index bce6db9..6f2a8d2 100644
>> --- a/git.rc
>> +++ b/git.rc
>> @@ -1,6 +1,6 @@
>>  1 VERSIONINFO
>> -FILEVERSION     MAJOR,MINOR,PATCH,0
>> -PRODUCTVERSION  MAJOR,MINOR,PATCH,0
>> +FILEVERSION     VERSIONSTRING,0
>> +PRODUCTVERSION  VERSIONSTRING,0
>>  BEGIN
>>    BLOCK "StringFileInfo"
>>    BEGIN
>> .
>> 
