From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
Date: Mon, 03 Sep 2012 11:57:48 -0700
Message-ID: <7v627vexxv.fsf@alter.siamese.dyndns.org>
References: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de>
 <7vr4qqzsbe.fsf@alter.siamese.dyndns.org>
 <002201cd86ce$285841b0$7908c510$@schmitz-digital.de>
 <7vfw74s3oy.fsf@alter.siamese.dyndns.org>
 <003d01cd8827$34e90180$9ebb0480$@schmitz-digital.de>
 <7vpq64f935.fsf@alter.siamese.dyndns.org>
 <000d01cd89b6$d5ba6c30$812f4490$@schmitz-digital.de>
 <5044F3DB.9060908@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joachim Schmitz <jojo@schmitz-digital.de>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Sep 03 20:58:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8bqQ-0001jA-RW
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 20:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479Ab2ICS5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 14:57:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753468Ab2ICS5v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 14:57:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 570008CA8;
	Mon,  3 Sep 2012 14:57:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s4oLV9rU/C5U+A4vDWguHq+42is=; b=R4Ehdc
	0CXs9bZMZCLHOTQRoSm6SOsqVsdNF//IbvNdmdcEjvrXF4bTsG9HEqVR6w4YMhuU
	fsBjB5xovJm/qbyCqhQ/njbkgomaEVe8h318q0nVAbn8y9d7wjsTa0s3skVBVsSF
	I9gvoXElP+st8380fwk4euWq3KI7zlwHssnwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V3Ua0D/1r2Dodf9uwDS7IqAGNcxy76Jl
	NoAQcaQuK9IUupMzs9JeXG0MF/QbAIvPzdBArZEL63gAkTlEkbU6v37gkKk6i9rO
	8wnLnVGPXuyLj8Z78droxRX4S5adVgXAJI0wG8yhbWtLv0Ayd8uEAZcrxhW6y/wJ
	UkjWvTAOoHA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 451D58CA7;
	Mon,  3 Sep 2012 14:57:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A69938CA6; Mon,  3 Sep 2012
 14:57:49 -0400 (EDT)
In-Reply-To: <5044F3DB.9060908@kdbg.org> (Johannes Sixt's message of "Mon, 03
 Sep 2012 20:15:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41C4AD6A-F5F9-11E1-B970-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204704>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 03.09.2012 11:31, schrieb Joachim Schmitz:
>> 
>> Hmm, I see that there the errors are handled differently, like this:
>> 
>>         if (ovalue != NULL)
>>                 return errno = EINVAL,
>>                         error("setitimer param 3 != NULL not implemented");
>> 
>> Should this be done in my setitimer() too? Or rather be left to the caller?
>> I tend to the later.
>
> The error message is really just a reminder that the implementation is
> not complete. Writing it here has the advantage that it is much more
> accurate than a generic "invalid argument" or "operation not supported"
> error that the caller would be able to write.

Joachim quoted irrelevant (to you) part and made comments on it, but
the issue I raised by Ccing you was about diagnosing NULL passed in
newvalue parameter, which Joachim's code did like this:

    > int git_setitimer(int which, const struct itimerval *value,
    > 				struct itimerval *ovalue)
    > {
    > 	int ret = 0;
    >
    > 	if (!value ) {
    > 		errno = EFAULT;
    > 		return -1;

    EFAULT is good ;-)

    The emulation in mingw.c 6072fc3 (Windows: Implement setitimer() and
    sigaction()., 2007-11-13) may want to be tightened in a similar way.

but mingw.c doesn't seem to.
