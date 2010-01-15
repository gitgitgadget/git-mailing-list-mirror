From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Test t5560: Fix test when run with dash
Date: Fri, 15 Jan 2010 10:18:18 -0800
Message-ID: <7vljfzz0yd.fsf@alter.siamese.dyndns.org>
References: <7vfx69hyd5.fsf@alter.siamese.dyndns.org>
 <1263537842-5792-1-git-send-email-tarmigan+git@gmail.com>
 <4B5027B8.2090507@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tarmigan Casebolt <tarmigan+git@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 19:18:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVqkm-0005KD-Hf
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 19:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757989Ab0AOSSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 13:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757984Ab0AOSSc
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 13:18:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757987Ab0AOSSb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 13:18:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E269E919CE;
	Fri, 15 Jan 2010 13:18:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=tOV9RQF4eopDc68gC/HndT8oTnc=; b=SdciUCkHAAZCSjQYvWOa+oe
	pmox5nK+9r0T/f0iXZb4WQnDIyzHmqnfTKXjvixgUW6Fo+OMP0nsv5SbLPKKPAnx
	rkzmjkB5fkK+OGR2HKFZJfhjeYDddSuY8OKTTNueL9dVyfu1BvwW4Sq1lDsHayRA
	HdZfF4yIZzQEWmQt1Io0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Ua/eLirbHU69xLp85t5tNglD93XaFF2w8b7lEnNkRDJ6MyK+x
	b6iVWfu60dZW+cFEqAYUPHQE9J5ZrUCHYOpjJrT+Py0lPkGWLUtPW1U+wZYnU532
	iAj/YaEfeWzAQjy4KmJaJKi/19Eoyppc40KghfSo4grUqtZmeLp3FXCiZg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 790E1919CD;
	Fri, 15 Jan 2010 13:18:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AE52919C6; Fri, 15 Jan
 2010 13:18:19 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5F302340-0202-11DF-A988-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137095>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Tarmigan Casebolt schrieb:
>>         REQUEST_METHOD="GET" some_shell_function
>
>> I can't tell from my reading of the POSIX spec whether my usage was
>> wrong or if dash is wrong,
>
> According to POSIX, variables set as shown above for shell functions are
> not exported and retain their value after the function returns.

I actually looked for this yesterday, but didn't find a relevant
definition.  But "2.9.5 Function Definition Command" [*1*] seems to
address the issue: "When a function is executed, it shall have the
syntax-error and variable-assignment properties described for special
built-in utilities...".

And "2.14 Special Built-in Utilities" section [*2*] says "2. Variable
assignments specified with special built-in utilities remain in effect
after the built-in completes...".  Taking both together, it seems that
the assignment should be in effect after the function returns.

Does my reading match yours, or do you have more definitive descriptions
you can point at in POSIX.1, so that the log message can be improved to
help people avoid this issue in the future?

Yesterday, I saw rebase--interactive has a few codepaths where "output"
shell function was used with the single-shot export; perhaps they need to
also be fixed.

[References]

*1* http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_05
*2* http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_14
