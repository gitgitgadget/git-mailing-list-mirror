From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/23] expire_reflog(): use a lock_file for rewriting the reflog file
Date: Fri, 05 Dec 2014 12:55:55 -0800
Message-ID: <xmqqk325q0is.fsf@gitster.dls.corp.google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
	<1417734515-11812-8-git-send-email-mhagger@alum.mit.edu>
	<20141205002331.GJ16345@google.com>
	<20141205191829.GB16682@google.com>
	<xmqqoarhq4dc.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbf_Ze6JR33Y6-N3JZTUQqTyqc-feQZ-__h7JkeUTzUvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 21:56:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwzv3-000253-KW
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 21:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbaLEU4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 15:56:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750779AbaLEUz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 15:55:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E294B24CA8;
	Fri,  5 Dec 2014 15:55:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o7Nj4WkILSV0fotu0w/KYg42ZIE=; b=RDShs7
	UWf6I+MwPpyzQQk/e0YzDoaAPKn3KhmCnrHRWOI5aCWkWkNWaqW+iA4ETk+3ouoI
	a9ROZpat+sULABJ50AB1T+nK68Fp8huC38vBLrFCr7PptjUAeM/mpfPsAyPJ+5KK
	1+5OUzfGEbpbp5wna+0WuLpcKIonXg5l5n+RY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DJSuMGv+Kd0PS6xN0JsiW3TDjRm+DcIN
	r6Mb3hDqbmkICcvJXjC5k87g2o7eg2im6jmNId+vOr3a7hBab+mN22ZmPEICqoRM
	baNzTfl8cvNs5qjTsGtuxz4dhNmhFCCcnJxvSLn1jkz8KBYDJP3gttO9QuDz/OMY
	Fifmh2JPfR0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D875D24CA7;
	Fri,  5 Dec 2014 15:55:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4DA0424CA6;
	Fri,  5 Dec 2014 15:55:57 -0500 (EST)
In-Reply-To: <CAGZ79kbf_Ze6JR33Y6-N3JZTUQqTyqc-feQZ-__h7JkeUTzUvg@mail.gmail.com>
	(Stefan Beller's message of "Fri, 5 Dec 2014 11:41:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C4D21A6-7CC1-11E4-A718-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260891>

Stefan Beller <sbeller@google.com> writes:

>>> After the series completes, this lock is only used in reflog_expire.
>>> So I'd rather move it inside the function? Then we could run the reflog_expire
>>> function in parallel for different locks in theory?
>>
>> I am not sure about the "parallel" part, but I would imagine that it
>> is an essential prerequisite to move this outside the "client" code
>> if we want to later replace the backing storage of refs and reflogs
>> outside the filesystem, so from that point of view,  I think the
>> suggestion makes sense.
>>
>> Thanks.
>>
>
> Sorry for the confusion. With parallel I mean,...

There is no confusion.  I understand exactly what you meant.

What I said was not sure was if "parallel" is a practical enough
possiblity to include into the set of value propositions the
suggested change to move the lock out of the "client" may give us.

In other words, "With this change, doing a parallel will become a
lot easier"---"Really?  It probably is not one of the harder part of
the problem if you really want to go parallel" was the discourse I
had in my mind.

;-)
