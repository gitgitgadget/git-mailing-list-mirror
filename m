From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: fix compilation of test programs under MinGW
 environment
Date: Sat, 27 Feb 2010 14:15:29 -0800
Message-ID: <7vmxyupbpa.fsf@alter.siamese.dyndns.org>
References: <1267304969-1924-1-git-send-email-michael.lukashov@gmail.com>
 <7vy6ietlf7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 23:15:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlUwq-0003Y8-NO
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 23:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936331Ab0B0WPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 17:15:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936308Ab0B0WPh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 17:15:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ED6859D143;
	Sat, 27 Feb 2010 17:15:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7p7u8cfwNSORGk76kvTr7Fp/Jhc=; b=foVUJw
	BRTOpuPU+QooVAgmVFxL266rvbSZi/Ds9qDt59MC0YjMqsvAJInBBQr191Y6fCZt
	eweqULgA7h5UwhuMB+CzrHuO99Fj9q4MjCForysrXJyKWlHMV4iku+qHqyEj36WU
	cJWuBvbvpuuRDZEDekGR64+TwAZF+NPmPWG0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MpEhMPER+t1oziQFWIdumQpakG00Fb2r
	Pamvrr4IDBP2GT+VwutFAIagn+dm6ZmitwkPVwbjrd+qypczAQHUuE+RKf14VoqA
	oTZQCSNNMoWpKmVdT5Yjw7qhEzGAjWslZdc++hTMU3pCbQdf+Yrg01Wjun7zCH0E
	+WlGVH3GiNM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C8DDA9D142;
	Sat, 27 Feb 2010 17:15:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C78C9D140; Sat, 27 Feb
 2010 17:15:30 -0500 (EST)
In-Reply-To: <7vy6ietlf7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 27 Feb 2010 13\:31\:56 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9FB21006-23ED-11DF-A33C-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141234>

Junio C Hamano <gitster@pobox.com> writes:

> Michael Lukashov <michael.lukashov@gmail.com> writes:
>
>> Commit 225f78c8 (Merge branch 'master' of git://repo.or.cz/alt-git
>> into jn/autodep, 2010-01-26) changed Makefile in such a way that
>> the following error occurs when trying to compile Git under MinGW environment:
>>
>>   make: *** No rule to make target `test-chmtime', needed by `all'.  Stop.
>>
>> Under Linux it seems there's no difference between two variants.
>
>> -TEST_PROGRAMS := $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
>> +TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
>
> If the difference were on the RHS of this definition, which does involve
> $X that is different between the two platforms, I would understand, but
> your patch looks like it is addressing difference between := vs =, and
> that is more like a difference of other parts of the Makefile than
> difference between Linux and mingw compilation environment.

Ok, I think I know what happend.

We used to have the definition of TEST_PROGRAMS way later than where we
currently have it, and it was for a reason.  X is to be defined to be .exe
in the platform specific section for MinGW (and probably Cygwin as well).

But because the definition of TEST_PROGRAMS was moved way up, it needs to
be recursively expanded.

TEST_OBJS also uses $X in simple expansion (i.e. sets with := not with =),
so I expect that it has the same issue.  Can you check and verify?
